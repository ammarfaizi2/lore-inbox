Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUK3POJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUK3POJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUK3POJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:14:09 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:19347 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262114AbUK3PJ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:09:26 -0500
Date: Tue, 30 Nov 2004 16:09:24 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/6] s390: dcss segments.
Message-ID: <20041130150924.GD4758@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/6] s390: dcss segments.

From: Carsten Otte <cotte@de.ibm.com>

dcss segment interface changes:
 - Add check when loading segments to avoid out of range mappings.
 - Add code to check for segment_load returning -ERANGE.
 - Rename segment_info to segment_type.
 - Restore previous segment state if reload fails.
 - Add segment_modify_shared() to change shared attributes of a dcss
   segment and use it in the dcss block device driver.
 - Add support for contiguous EW/EN multipart segments.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/mm/extmem.c         |  159 +++++++++++++++++++++++++++++++++++++-----
 drivers/s390/block/dcssblk.c  |   69 ++++++++----------
 drivers/s390/char/monreader.c |    8 +-
 include/asm-s390/extmem.h     |    4 -
 4 files changed, 183 insertions(+), 57 deletions(-)

diff -urN linux-2.6/arch/s390/mm/extmem.c linux-2.6-patched/arch/s390/mm/extmem.c
--- linux-2.6/arch/s390/mm/extmem.c	2004-11-30 14:03:01.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/extmem.c	2004-11-30 14:03:19.000000000 +0100
@@ -40,14 +40,19 @@
 #define DCSS_FINDSEG    0x0c
 #define DCSS_LOADNOLY   0x10
 #define DCSS_SEGEXT     0x18
-#define DCSS_QACTV      0x0c
+#define DCSS_FINDSEGA   0x0c
+
+struct qrange {
+	unsigned int  start; // 3byte start address, 1 byte type
+	unsigned int  end;   // 3byte end address, 1 byte reserved
+};
 
 struct qout64 {
 	int segstart;
 	int segend;
 	int segcnt;
 	int segrcnt;
-	char segout[8][6];
+	struct qrange range[6];
 };
 
 struct qin64 {
@@ -67,12 +72,15 @@
 	unsigned long end;
 	atomic_t ref_count;
 	int do_nonshared;
-	int vm_segtype;
+	unsigned int vm_segtype;
+	struct qrange range[6];
+	int segcnt;
 };
 
 static spinlock_t dcss_lock = SPIN_LOCK_UNLOCKED;
 static struct list_head dcss_list = LIST_HEAD_INIT(dcss_list);
-static char *segtype_string[7] = { "SW", "EW", "SR", "ER", "SN", "EN", "SC" };
+static char *segtype_string[] = { "SW", "EW", "SR", "ER", "SN", "EN", "SC",
+					"EW/EN-MIXED" };
 
 extern struct {
 	unsigned long addr, size, type;
@@ -162,12 +170,12 @@
  * fills start_address, end and vm_segtype fields
  */
 static int
-query_segment_info (struct dcss_segment *seg)
+query_segment_type (struct dcss_segment *seg)
 {
 	struct qin64  *qin = kmalloc (sizeof(struct qin64), GFP_DMA);
 	struct qout64 *qout = kmalloc (sizeof(struct qout64), GFP_DMA);
 
-	int diag_cc, rc;
+	int diag_cc, rc, i;
 	unsigned long dummy, vmrc;
 
 	if ((qin == NULL) || (qout == NULL)) {
@@ -176,7 +184,7 @@
 	}
 
 	/* initialize diag input parameters */
-	qin->qopcode = DCSS_QACTV;
+	qin->qopcode = DCSS_FINDSEGA;
 	qin->qoutptr = (unsigned long) qout;
 	qin->qoutlen = sizeof(struct qout64);
 	memcpy (qin->qname, seg->dcss_name, 8);
@@ -188,16 +196,40 @@
 		goto out_free;
 	}
 
-	if (qout->segcnt > 1) {
+	if (qout->segcnt > 6) {
 		rc = -ENOTSUPP;
 		goto out_free;
 	}
 
+	if (qout->segcnt == 1) {
+		seg->vm_segtype = qout->range[0].start & 0xff;
+	} else {
+		/* multi-part segment. only one type supported here:
+		    - all parts are contiguous
+		    - all parts are either EW or EN type
+		    - maximum 6 parts allowed */
+		unsigned long start = qout->segstart >> PAGE_SHIFT;
+		for (i=0; i<qout->segcnt; i++) {
+			if (((qout->range[i].start & 0xff) != SEG_TYPE_EW) &&
+			    ((qout->range[i].start & 0xff) != SEG_TYPE_EN)) {
+				rc = -ENOTSUPP;
+				goto out_free;
+			}
+			if (start != qout->range[i].start >> PAGE_SHIFT) {
+				rc = -ENOTSUPP;
+				goto out_free;
+			}
+			start = (qout->range[i].end >> PAGE_SHIFT) + 1;
+		}
+		seg->vm_segtype = SEG_TYPE_EWEN;
+	}
+
 	/* analyze diag output and update seg */
 	seg->start_addr = qout->segstart;
 	seg->end = qout->segend;
 
-	seg->vm_segtype = qout->segout[0][3];
+	memcpy (seg->range, qout->range, 6*sizeof(struct qrange));
+	seg->segcnt = qout->segcnt;
 
 	rc = 0;
 
@@ -254,6 +286,19 @@
 }
 
 /*
+ * check if segment exceeds the kernel mapping range (detected or set via mem=)
+ * returns 1 if this is the case, 0 if segment fits into the range
+ */
+static inline int
+segment_exceeds_range (struct dcss_segment *seg)
+{
+	int seg_last_pfn = (seg->end) >> PAGE_SHIFT;
+	if (seg_last_pfn > max_pfn)
+		return 1;
+	return 0;
+}
+
+/*
  * get info about a segment
  * possible return values:
  * -ENOSYS  : we are not running on VM
@@ -265,7 +310,7 @@
  * 0 .. 6   : type of segment as defined in include/asm-s390/extmem.h
  */
 int
-segment_info (char* name)
+segment_type (char* name)
 {
 	int rc;
 	struct dcss_segment seg;
@@ -274,7 +319,7 @@
 		return -ENOSYS;
 
 	dcss_mkname(name, seg.dcss_name);
-	rc = query_segment_info (&seg);
+	rc = query_segment_type (&seg);
 	if (rc < 0)
 		return rc;
 	return seg.vm_segtype;
@@ -295,9 +340,15 @@
 		goto out;
 	}
 	dcss_mkname (name, seg->dcss_name);
-	rc = query_segment_info (seg);
+	rc = query_segment_type (seg);
 	if (rc < 0)
 		goto out_free;
+	if (segment_exceeds_range(seg)) {
+		PRINT_WARN ("segment_load: not loading segment %s - exceeds"
+				" kernel mapping range\n",name);
+		rc = -ERANGE;
+		goto out_free;
+	}
 	if (segment_overlaps_storage(seg)) {
 		PRINT_WARN ("segment_load: not loading segment %s - overlaps"
 				" storage\n",name);
@@ -362,6 +413,7 @@
  * -ENOTSUPP: multi-part segment cannot be used with linux
  * -ENOSPC  : segment cannot be used (overlaps with storage)
  * -EBUSY   : segment can temporarily not be used (overlaps with dcss)
+ * -ERANGE  : segment cannot be used (exceeds kernel mapping range)
  * -EPERM   : segment is currently loaded with incompatible permissions
  * -ENOMEM  : out of memory
  * 0 .. 6   : type of segment as defined in include/asm-s390/extmem.h
@@ -396,6 +448,70 @@
 }
 
 /*
+ * this function modifies the shared state of a DCSS segment. note that
+ * name         : name of the DCSS
+ * do_nonshared : 0 indicates that the dcss should be shared with other linux images
+ *                1 indicates that the dcss should be exclusive for this linux image
+ * return values:
+ * -EIO     : could not perform load diagnose (segment gone!)
+ * -ENOENT  : no such segment (segment gone!)
+ * -EAGAIN  : segment is in use by other exploiters, try later
+ * -EINVAL  : no segment with the given name is currently loaded - name invalid
+ * 0	    : operation succeeded
+ */
+int
+segment_modify_shared (char *name, int do_nonshared)
+{
+	struct dcss_segment *seg;
+	unsigned long dummy;
+	int dcss_command, rc, diag_cc;
+
+	spin_lock (&dcss_lock);
+	seg = segment_by_name (name);
+	if (seg == NULL) {
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+	if (do_nonshared == seg->do_nonshared) {
+		PRINT_INFO ("segment_modify_shared: not reloading segment %s"
+				" - already in requested mode\n",name);
+		rc = 0;
+		goto out_unlock;
+	}
+	if (atomic_read (&seg->ref_count) != 1) {
+		PRINT_WARN ("segment_modify_shared: not reloading segment %s - "
+				"segment is in use by other driver(s)\n",name);
+		rc = -EAGAIN;
+		goto out_unlock;
+	}
+	dcss_diag(DCSS_PURGESEG, seg->dcss_name,
+		  &dummy, &dummy);
+	if (do_nonshared)
+		dcss_command = DCSS_LOADNSR;
+	else
+	dcss_command = DCSS_LOADNOLY;
+	diag_cc = dcss_diag(dcss_command, seg->dcss_name,
+			&seg->start_addr, &seg->end);
+	if (diag_cc > 1) {
+		PRINT_WARN ("segment_modify_shared: could not reload segment %s"
+				" - diag returned error (%ld)\n",name,seg->end);
+		rc = dcss_diag_translate_rc (seg->end);
+		goto out_del;
+	}
+	seg->do_nonshared = do_nonshared;
+	rc = 0;
+	goto out_unlock;
+ out_del:
+	list_del(&seg->list);
+	dcss_diag(DCSS_PURGESEG, seg->dcss_name,
+		  &dummy, &dummy);
+	kfree (seg);
+ out_unlock:
+	spin_unlock(&dcss_lock);
+	return rc;
+}
+
+/*
  * Decrease the use count of a DCSS segment and remove
  * it from the address space if nobody is using it
  * any longer.
@@ -434,8 +550,9 @@
 	struct dcss_segment *seg;
 	int startpfn = 0;
 	int endpfn = 0;
-	char cmd1[80];
+	char cmd1[160];
 	char cmd2[80];
+	int i;
 
 	if (!MACHINE_IS_VM)
 		return;
@@ -448,10 +565,15 @@
 		return;
 	}
 
-	startpfn = seg->start_addr >> 12;
-	endpfn = (seg->end) >> 12;
-	sprintf(cmd1, "DEFSEG %s %X-%X %s", name, startpfn, endpfn,
-			segtype_string[seg->vm_segtype]);
+	startpfn = seg->start_addr >> PAGE_SHIFT;
+	endpfn = (seg->end) >> PAGE_SHIFT;
+	sprintf(cmd1, "DEFSEG %s", name);
+	for (i=0; i<seg->segcnt; i++) {
+		sprintf(cmd1+strlen(cmd1), " %X-%X %s",
+			seg->range[i].start >> PAGE_SHIFT,
+			seg->range[i].end >> PAGE_SHIFT,
+			segtype_string[seg->range[i].start & 0xff]);
+	}
 	sprintf(cmd2, "SAVESEG %s", name);
 	cpcmd(cmd1, NULL, 80);
 	cpcmd(cmd2, NULL, 80);
@@ -461,4 +583,5 @@
 EXPORT_SYMBOL(segment_load);
 EXPORT_SYMBOL(segment_unload);
 EXPORT_SYMBOL(segment_save);
-EXPORT_SYMBOL(segment_info);
+EXPORT_SYMBOL(segment_type);
+EXPORT_SYMBOL(segment_modify_shared);
diff -urN linux-2.6/drivers/s390/block/dcssblk.c linux-2.6-patched/drivers/s390/block/dcssblk.c
--- linux-2.6/drivers/s390/block/dcssblk.c	2004-11-30 14:03:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dcssblk.c	2004-11-30 14:03:19.000000000 +0100
@@ -140,7 +140,7 @@
 }
 
 /*
- * print appropriate error message for segment_load()/segment_info()
+ * print appropriate error message for segment_load()/segment_type()
  * return code
  */
 static void
@@ -179,6 +179,10 @@
 		PRINT_WARN("cannot load/query segment %s, out of memory\n",
 			   seg_name);
 		break;
+	case -ERANGE:
+		PRINT_WARN("cannot load/query segment %s, exceeds kernel "
+			   "mapping range\n", seg_name);
+		break;
 	default:
 		PRINT_WARN("cannot load/query segment %s, return value %i\n",
 			   seg_name, rc);
@@ -214,57 +218,50 @@
 	if (atomic_read(&dev_info->use_count)) {
 		PRINT_ERR("share: segment %s is busy!\n",
 			  dev_info->segment_name);
-		up_write(&dcssblk_devices_sem);
-		return -EBUSY;
-	}
-	if ((inbuf[0] == '1') && (dev_info->is_shared == 1)) {
-		PRINT_WARN("Segment %s already loaded in shared mode!\n",
-			   dev_info->segment_name);
-		up_write(&dcssblk_devices_sem);
-		return count;
-	}
-	if ((inbuf[0] == '0') && (dev_info->is_shared == 0)) {
-		PRINT_WARN("Segment %s already loaded in exclusive mode!\n",
-			   dev_info->segment_name);
-		up_write(&dcssblk_devices_sem);
-		return count;
+		rc = -EBUSY;
+		goto out;
 	}
 	if (inbuf[0] == '1') {
 		// reload segment in shared mode
-		segment_unload(dev_info->segment_name);
-		rc = segment_load(dev_info->segment_name, SEGMENT_SHARED,
-					&dev_info->start, &dev_info->end);
+		rc = segment_modify_shared(dev_info->segment_name,
+					   SEGMENT_SHARED);
 		if (rc < 0) {
-			dcssblk_segment_warn(rc, dev_info->segment_name);
-			goto removeseg;
+			BUG_ON(rc == -EINVAL);
+			if (rc == -EIO || rc == -ENOENT)
+				goto removeseg;
+		} else {
+			dev_info->is_shared = 1;
+			switch (dev_info->segment_type) {
+				case SEG_TYPE_SR:
+				case SEG_TYPE_ER:
+				case SEG_TYPE_SC:
+					set_disk_ro(dev_info->gd,1);
+			}
 		}
-		dev_info->is_shared = 1;
-		if (rc == SEG_TYPE_SR || rc == SEG_TYPE_ER || rc == SEG_TYPE_SC)
-			set_disk_ro(dev_info->gd, 1);
 	} else if (inbuf[0] == '0') {
 		// reload segment in exclusive mode
 		if (dev_info->segment_type == SEG_TYPE_SC) {
 			PRINT_ERR("Segment type SC (%s) cannot be loaded in "
 				  "non-shared mode\n", dev_info->segment_name);
-			up_write(&dcssblk_devices_sem);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
-		segment_unload(dev_info->segment_name);
-		rc = segment_load(dev_info->segment_name, SEGMENT_EXCLUSIVE,
-					&dev_info->start, &dev_info->end);
+		rc = segment_modify_shared(dev_info->segment_name,
+					   SEGMENT_EXCLUSIVE);
 		if (rc < 0) {
-			dcssblk_segment_warn(rc, dev_info->segment_name);
-			goto removeseg;
+			BUG_ON(rc == -EINVAL);
+			if (rc == -EIO || rc == -ENOENT)
+				goto removeseg;
+		} else {
+			dev_info->is_shared = 0;
+			set_disk_ro(dev_info->gd, 0);
 		}
-		dev_info->is_shared = 0;
-		set_disk_ro(dev_info->gd, 0);
 	} else {
-		up_write(&dcssblk_devices_sem);
 		PRINT_WARN("Invalid value, must be 0 or 1\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 	rc = count;
-	up_write(&dcssblk_devices_sem);
 	goto out;
 
 removeseg:
@@ -278,8 +275,8 @@
 	put_disk(dev_info->gd);
 	device_unregister(dev);
 	put_device(dev);
-	up_write(&dcssblk_devices_sem);
 out:
+	up_write(&dcssblk_devices_sem);
 	return rc;
 }
 
diff -urN linux-2.6/drivers/s390/char/monreader.c linux-2.6-patched/drivers/s390/char/monreader.c
--- linux-2.6/drivers/s390/char/monreader.c	2004-11-30 14:03:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/monreader.c	2004-11-30 14:03:19.000000000 +0100
@@ -116,7 +116,7 @@
 }
 
 /*
- * print appropriate error message for segment_load()/segment_info()
+ * print appropriate error message for segment_load()/segment_type()
  * return code
  */
 static void
@@ -155,6 +155,10 @@
 		P_WARNING("cannot load/query segment %s, out of memory\n",
 			  seg_name);
 		break;
+	case -ERANGE:
+		P_WARNING("cannot load/query segment %s, exceeds kernel "
+			  "mapping range\n", seg_name);
+		break;
 	default:
 		P_WARNING("cannot load/query segment %s, return value %i\n",
 			  seg_name, rc);
@@ -581,7 +585,7 @@
 		return -ENODEV;
 	}
 
-	rc = segment_info(mon_dcss_name);
+	rc = segment_type(mon_dcss_name);
 	if (rc < 0) {
 		mon_segment_warn(rc, mon_dcss_name);
 		return rc;
diff -urN linux-2.6/include/asm-s390/extmem.h linux-2.6-patched/include/asm-s390/extmem.h
--- linux-2.6/include/asm-s390/extmem.h	2004-11-30 14:03:08.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/extmem.h	2004-11-30 14:03:19.000000000 +0100
@@ -17,6 +17,7 @@
 #define SEG_TYPE_SN 4
 #define SEG_TYPE_EN 5
 #define SEG_TYPE_SC 6
+#define SEG_TYPE_EWEN 7
 
 #define SEGMENT_SHARED 0
 #define SEGMENT_EXCLUSIVE 1
@@ -24,7 +25,8 @@
 extern int segment_load (char *name,int segtype,unsigned long *addr,unsigned long *length);
 extern void segment_unload(char *name);
 extern void segment_save(char *name);
-extern int segment_info (char* name);
+extern int segment_type (char* name);
+extern int segment_modify_shared (char *name, int do_nonshared);
 
 #endif
 #endif
