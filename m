Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271267AbUJVMkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271267AbUJVMkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271276AbUJVMcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:32:14 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:30896 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S271273AbUJVMZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:25:49 -0400
Date: Fri, 22 Oct 2004 14:25:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/6] s390: dcss segments cleanup.
Message-ID: <20041022122536.GD3720@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/6] s390: dcss segments cleanup.

From: Carsten Otte <cotte@de.ibm.com>
From: Gerald Schaefer <geraldsc@de.ibm.com>

Cleanup segment load/unload infrastructure.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/mm/extmem.c         |  783 +++++++++++++++++++-----------------------
 drivers/s390/block/dcssblk.c  |  119 +++---
 drivers/s390/char/monreader.c |   62 +++
 include/asm-s390/extmem.h     |   21 -
 4 files changed, 518 insertions(+), 467 deletions(-)

diff -urN linux-2.6/arch/s390/mm/extmem.c linux-2.6-patched/arch/s390/mm/extmem.c
--- linux-2.6/arch/s390/mm/extmem.c	2004-10-18 23:54:40.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/extmem.c	2004-10-22 13:51:44.000000000 +0200
@@ -1,11 +1,10 @@
 /*
- * File...........: arch/s390/mm/dcss.c
- * Author(s)......: Steven Shultz <shultzss@us.ibm.com>
- *                  Carsten Otte <cotte@de.ibm.com>
+ * File...........: arch/s390/mm/extmem.c
+ * Author(s)......: Carsten Otte <cotte@de.ibm.com>
+ * 		    Rob M van der Heij <rvdheij@nl.ibm.com>
+ * 		    Steven Shultz <shultzss@us.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
- * thanks to Rob M van der Heij
- * - he wrote the diag64 function
- * (C) IBM Corporation 2002
+ * (C) IBM Corporation 2002-2004
  */
 
 #include <linux/kernel.h>
@@ -43,18 +42,38 @@
 #define DCSS_SEGEXT     0x18
 #define DCSS_QACTV      0x0c
 
+struct qout64 {
+	int segstart;
+	int segend;
+	int segcnt;
+	int segrcnt;
+	char segout[8][6];
+};
+
+struct qin64 {
+	char qopcode;
+	char rsrv1[3];
+	char qrcode;
+	char rsrv2[3];
+	char qname[8];
+	unsigned int qoutptr;
+	short int qoutlen;
+};
+
 struct dcss_segment {
-        struct list_head list;
-        char dcss_name[8];
-        unsigned long start_addr;
-        unsigned long end;
-        atomic_t ref_count;
-        int dcss_attr;
-	int shared_attr;
+	struct list_head list;
+	char dcss_name[8];
+	unsigned long start_addr;
+	unsigned long end;
+	atomic_t ref_count;
+	int do_nonshared;
+	int vm_segtype;
 };
 
 static spinlock_t dcss_lock = SPIN_LOCK_UNLOCKED;
 static struct list_head dcss_list = LIST_HEAD_INIT(dcss_list);
+static char *segtype_string[7] = { "SW", "EW", "SR", "ER", "SN", "EN", "SC" };
+
 extern struct {
 	unsigned long addr, size, type;
 } memory_chunk[MEMORY_CHUNKS];
@@ -63,20 +82,46 @@
  * Create the 8 bytes, ebcdic VM segment name from
  * an ascii name.
  */
-static void inline dcss_mkname(char *name, char *dcss_name)
+static void inline
+dcss_mkname(char *name, char *dcss_name)
 {
-        int i;
+	int i;
 
-        for (i = 0; i <= 8; i++) {
-                if (name[i] == '\0')
-                        break;
-                dcss_name[i] = toupper(name[i]);
-        };
-        for (; i <= 8; i++)
-                dcss_name[i] = ' ';
-        ASCEBC(dcss_name, 8);
+	for (i = 0; i < 8; i++) {
+		if (name[i] == '\0')
+			break;
+		dcss_name[i] = toupper(name[i]);
+	};
+	for (; i < 8; i++)
+		dcss_name[i] = ' ';
+	ASCEBC(dcss_name, 8);
 }
 
+
+/*
+ * search all segments in dcss_list, and return the one
+ * namend *name. If not found, return NULL.
+ */
+static struct dcss_segment *
+segment_by_name (char *name)
+{
+	char dcss_name[9];
+	struct list_head *l;
+	struct dcss_segment *tmp, *retval = NULL;
+
+	BUG_ON (!spin_is_locked(&dcss_lock));
+	dcss_mkname (name, dcss_name);
+	list_for_each (l, &dcss_list) {
+		tmp = list_entry (l, struct dcss_segment, list);
+		if (memcmp(tmp->dcss_name, dcss_name, 8) == 0) {
+			retval = tmp;
+			break;
+		}
+	}
+	return retval;
+}
+
+
 /*
  * Perform a function on a dcss segment.
  */
@@ -84,337 +129,270 @@
 dcss_diag (__u8 func, void *parameter,
            unsigned long *ret1, unsigned long *ret2)
 {
-        unsigned long rx, ry;
-        int rc;
+	unsigned long rx, ry;
+	int rc;
 
-        rx = (unsigned long) parameter;
-        ry = (unsigned long) func;
-        __asm__ __volatile__(
+	rx = (unsigned long) parameter;
+	ry = (unsigned long) func;
+	__asm__ __volatile__(
 #ifdef CONFIG_ARCH_S390X
-                             "   sam31\n" // switch to 31 bit
-                             "   diag    %0,%1,0x64\n"
-                             "   sam64\n" // switch back to 64 bit
+		"   sam31\n" // switch to 31 bit
+		"   diag    %0,%1,0x64\n"
+		"   sam64\n" // switch back to 64 bit
 #else
-                             "   diag    %0,%1,0x64\n"
+		"   diag    %0,%1,0x64\n"
 #endif
-                             "   ipm     %2\n"
-                             "   srl     %2,28\n"
-                             : "+d" (rx), "+d" (ry), "=d" (rc) : : "cc" );
-        *ret1 = rx;
-        *ret2 = ry;
-        return rc;
+		"   ipm     %2\n"
+		"   srl     %2,28\n"
+		: "+d" (rx), "+d" (ry), "=d" (rc) : : "cc" );
+	*ret1 = rx;
+	*ret2 = ry;
+	return rc;
 }
 
-
-/* use to issue "extended" dcss query */
 static inline int
-dcss_diag_query(char *name, int *rwattr, int *shattr, unsigned long *segstart, unsigned long *segend)
+dcss_diag_translate_rc (int vm_rc) {
+	if (vm_rc == 44)
+		return -ENOENT;
+	return -EIO;
+}
+
+
+/* do a diag to get info about a segment.
+ * fills start_address, end and vm_segtype fields
+ */
+static int
+query_segment_info (struct dcss_segment *seg)
 {
-        int i,j,rc;
-        unsigned long  rx, ry;
+	struct qin64  *qin = kmalloc (sizeof(struct qin64), GFP_DMA);
+	struct qout64 *qout = kmalloc (sizeof(struct qout64), GFP_DMA);
 
-        typedef struct segentry {
-                char thisseg[8];
-        } segentry;
-
-        struct qout64 {
-                int segstart;
-                int segend;
-                int segcnt;
-                int segrcnt;
-                segentry segout[6];
-        };
-
-        struct qin64 {
-                char qopcode;
-                char rsrv1[3];
-                char qrcode;
-                char rsrv2[3];
-                char qname[8];
-                unsigned int qoutptr;
-                short int qoutlen;
-        };
-
-
-        struct qin64  *qinarea;
-        struct qout64 *qoutarea;
-
-        qinarea = (struct qin64*) get_zeroed_page (GFP_DMA);
-        if (!qinarea) {
-                rc =-ENOMEM;
-                goto out;
-        }
-        qoutarea = (struct qout64*) get_zeroed_page (GFP_DMA);
-        if (!qoutarea) {
-                rc = -ENOMEM;
-                free_page ((unsigned long) qinarea);
-                goto out;
-        }
-        memset (qinarea,0,PAGE_SIZE);
-        memset (qoutarea,0,PAGE_SIZE);
-
-        qinarea->qopcode = DCSS_QACTV; /* do a query for active
-                                          segments */
-        qinarea->qoutptr = (unsigned long) qoutarea;
-        qinarea->qoutlen = sizeof(struct qout64);
-
-        /* Move segment name into double word aligned
-           field and pad with blanks to 8 long.
-         */
-
-        for (i = j = 0 ; i < 8; i++) {
-                qinarea->qname[i] = (name[j] == '\0') ? ' ' : name[j++];
-        }
-
-        /* name already in EBCDIC */
-        /* ASCEBC ((void *)&qinarea.qname, 8); */
-
-        /* set the assembler variables */
-        rx = (unsigned long) qinarea;
-        ry = DCSS_SEGEXT; /* this is extended function */
+	int diag_cc, rc;
+	unsigned long dummy, vmrc;
 
-        /* issue diagnose x'64' */
-        __asm__ __volatile__(
-#ifdef CONFIG_ARCH_S390X
-                             "   sam31\n" // switch to 31 bit
-                             "   diag    %0,%1,0x64\n"
-                             "   sam64\n" // switch back to 64 bit
-#else
-                             "   diag    %0,%1,0x64\n"
-#endif
-                             "   ipm     %2\n"
-                             "   srl     %2,28\n"
-                             : "+d" (rx), "+d" (ry), "=d" (rc) : : "cc" );
-
-        /* parse the query output area */
-	*segstart=qoutarea->segstart;
-	*segend=qoutarea->segend;
-
-        if (rc > 1)
-                {
-                        *rwattr = 2;
-                        *shattr = 2;
-                        rc = 0;
-                        goto free;
-                }
-
-        if (qoutarea->segcnt > 6)
-                {
-                        *rwattr = 3;
-                        *shattr = 3;
-                        rc = 0;
-                        goto free;
-                }
-
-        *rwattr = 1;
-        *shattr = 1;
-
-        for (i=0; i < qoutarea->segrcnt; i++) {
-                if (qoutarea->segout[i].thisseg[3] == 2 ||
-                    qoutarea->segout[i].thisseg[3] == 3 ||
-                    qoutarea->segout[i].thisseg[3] == 6 )
-                        *rwattr = 0;
-                if (qoutarea->segout[i].thisseg[3] == 1 ||
-                    qoutarea->segout[i].thisseg[3] == 3 ||
-                    qoutarea->segout[i].thisseg[3] == 5 )
-                        *shattr = 0;
-        } /* end of for statement */
-        rc = 0;
- free:
-        free_page ((unsigned long) qoutarea);
-        free_page ((unsigned long) qinarea);
+	if ((qin == NULL) || (qout == NULL)) {
+		rc = -ENOMEM;
+		goto out_free;
+	}
+
+	/* initialize diag input parameters */
+	qin->qopcode = DCSS_QACTV;
+	qin->qoutptr = (unsigned long) qout;
+	qin->qoutlen = sizeof(struct qout64);
+	memcpy (qin->qname, seg->dcss_name, 8);
+
+	diag_cc = dcss_diag (DCSS_SEGEXT, qin, &dummy, &vmrc);
+
+	if (diag_cc > 1) {
+		rc = dcss_diag_translate_rc (vmrc);
+		goto out_free;
+	}
+
+	if (qout->segcnt > 1) {
+		rc = -ENOTSUPP;
+		goto out_free;
+	}
+
+	/* analyze diag output and update seg */
+	seg->start_addr = qout->segstart;
+	seg->end = qout->segend;
+
+	seg->vm_segtype = qout->segout[0][3];
+
+	rc = 0;
+
+ out_free:
+	if (qin) kfree(qin);
+	if (qout) kfree(qout);
+	return rc;
+}
+
+/*
+ * check if the given segment collides with guest storage.
+ * returns 1 if this is the case, 0 if no collision was found
+ */
+static int
+segment_overlaps_storage(struct dcss_segment *seg)
+{
+	int i;
+
+	for (i=0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
+		if (memory_chunk[i].type != 0)
+			continue;
+		if ((memory_chunk[i].addr >> 20) > (seg->end >> 20))
+			continue;
+		if (((memory_chunk[i].addr + memory_chunk[i].size - 1) >> 20)
+				< (seg->start_addr >> 20))
+			continue;
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * check if segment collides with other segments that are currently loaded
+ * returns 1 if this is the case, 0 if no collision was found
+ */
+static int
+segment_overlaps_others (struct dcss_segment *seg)
+{
+	struct list_head *l;
+	struct dcss_segment *tmp;
+
+	BUG_ON (!spin_is_locked(&dcss_lock));
+	list_for_each(l, &dcss_list) {
+		tmp = list_entry(l, struct dcss_segment, list);
+		if ((tmp->start_addr >> 20) > (seg->end >> 20))
+			continue;
+		if ((tmp->end >> 20) < (seg->start_addr >> 20))
+			continue;
+		if (seg == tmp)
+			continue;
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * get info about a segment
+ * possible return values:
+ * -ENOSYS  : we are not running on VM
+ * -EIO     : could not perform query diagnose
+ * -ENOENT  : no such segment
+ * -ENOTSUPP: multi-part segment cannot be used with linux
+ * -ENOSPC  : segment cannot be used (overlaps with storage)
+ * -ENOMEM  : out of memory
+ * 0 .. 6   : type of segment as defined in include/asm-s390/extmem.h
+ */
+int
+segment_info (char* name)
+{
+	int rc;
+	struct dcss_segment seg;
+
+	if (!MACHINE_IS_VM)
+		return -ENOSYS;
+
+	dcss_mkname(name, seg.dcss_name);
+	rc = query_segment_info (&seg);
+	if (rc < 0)
+		return rc;
+	return seg.vm_segtype;
+}
+
+/*
+ * real segment loading function, called from segment_load
+ */
+static int
+__segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long *end)
+{
+	struct dcss_segment *seg = kmalloc(sizeof(struct dcss_segment),
+			GFP_DMA);
+	int dcss_command, rc, diag_cc;
+
+	if (seg == NULL) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	dcss_mkname (name, seg->dcss_name);
+	rc = query_segment_info (seg);
+	if (rc < 0)
+		goto out_free;
+	if (segment_overlaps_storage(seg)) {
+		PRINT_WARN ("segment_load: not loading segment %s - overlaps"
+				" storage\n",name);
+		rc = -ENOSPC;
+		goto out_free;
+	}
+	if (segment_overlaps_others(seg)) {
+		PRINT_WARN ("segment_load: not loading segment %s - overlaps"
+				" other segments\n",name);
+		rc = -EBUSY;
+		goto out_free;
+	}
+	if (do_nonshared)
+		dcss_command = DCSS_LOADNSR;
+	else
+		dcss_command = DCSS_LOADNOLY;
+
+	diag_cc = dcss_diag(dcss_command, seg->dcss_name,
+			&seg->start_addr, &seg->end);
+	if (diag_cc > 1) {
+		PRINT_WARN ("segment_load: could not load segment %s - "
+				"diag returned error (%ld)\n",name,seg->end);
+		rc = dcss_diag_translate_rc (seg->end);
+		dcss_diag(DCSS_PURGESEG, seg->dcss_name,
+				&seg->start_addr, &seg->end);
+		goto out_free;
+	}
+	seg->do_nonshared = do_nonshared;
+	atomic_set(&seg->ref_count, 1);
+	list_add(&seg->list, &dcss_list);
+	rc = seg->vm_segtype;
+	*addr = seg->start_addr;
+	*end  = seg->end;
+	if (do_nonshared)
+		PRINT_INFO ("segment_load: loaded segment %s range %p .. %p "
+				"type %s in non-shared mode\n", name,
+				(void*)seg->start_addr, (void*)seg->end,
+				segtype_string[seg->vm_segtype]);
+	else
+		PRINT_INFO ("segment_load: loaded segment %s range %p .. %p "
+				"type %s in shared mode\n", name,
+				(void*)seg->start_addr, (void*)seg->end,
+				segtype_string[seg->vm_segtype]);
+	goto out;
+ out_free:
+	kfree (seg);
  out:
-        return rc;
+	return rc;
 }
 
 /*
- * Load a DCSS segment via the diag 0x64.
+ * this function loads a DCSS segment
+ * name         : name of the DCSS
+ * do_nonshared : 0 indicates that the dcss should be shared with other linux images
+ *                1 indicates that the dcss should be exclusive for this linux image
+ * addr         : will be filled with start address of the segment
+ * end          : will be filled with end address of the segment
+ * return values:
+ * -ENOSYS  : we are not running on VM
+ * -EIO     : could not perform query or load diagnose
+ * -ENOENT  : no such segment
+ * -ENOTSUPP: multi-part segment cannot be used with linux
+ * -ENOSPC  : segment cannot be used (overlaps with storage)
+ * -EBUSY   : segment can temporarily not be used (overlaps with dcss)
+ * -EPERM   : segment is currently loaded with incompatible permissions
+ * -ENOMEM  : out of memory
+ * 0 .. 6   : type of segment as defined in include/asm-s390/extmem.h
  */
-int segment_load(char *name, int segtype, unsigned long *addr,
-                 unsigned long *end)
+int
+segment_load (char *name, int do_nonshared, unsigned long *addr,
+		unsigned long *end)
 {
-        char dcss_name[8];
-        struct list_head *l;
-        struct dcss_segment *seg, *tmp;
-	unsigned long dummy;
-	unsigned long segstart, segend;
-        int rc = 0,i;
-        int rwattr, shattr;
-
-        if (!MACHINE_IS_VM)
-                return -ENOSYS;
-        dcss_mkname(name, dcss_name);
-	/* search for the dcss in list of currently loaded segments */
-        spin_lock(&dcss_lock);
-        seg = NULL;
-        list_for_each(l, &dcss_list) {
-                tmp = list_entry(l, struct dcss_segment, list);
-                if (memcmp(tmp->dcss_name, dcss_name, 8) == 0) {
-                        seg = tmp;
-                        break;
-                }
-        }
-
-        if (seg == NULL) {
-                /* find out the attributes of this
-                   shared segment */
-                dcss_diag_query(dcss_name, &rwattr, &shattr, &segstart, &segend);
-		/* does segment collide with main memory? */
-		for (i=0; i < MEMORY_CHUNKS; i++) {
-			if (memory_chunk[i].type != 0)
-				continue;
-			if (memory_chunk[i].addr > segend)
-				continue;
-			if (memory_chunk[i].addr + memory_chunk[i].size <= segstart)
-				continue;
-			spin_unlock(&dcss_lock);
-			return -ENOENT;
-		}
-		/* or does it collide with other (loaded) segments? */
-        	list_for_each(l, &dcss_list) {
-                	tmp = list_entry(l, struct dcss_segment, list);
-	                if ((segstart <= tmp->end && segstart >= tmp->start_addr) ||
-				(segend <= tmp->end && segend >= tmp->start_addr) ||
-				(segstart <= tmp->start_addr && segend >= tmp->end)) {
-				PRINT_ERR("Segment Overlap!\n");
-			        spin_unlock(&dcss_lock);
-				return -ENOENT;
-	                }
-        	}
-
-                /* do case statement on segtype */
-                /* if asking for shared ro,
-                   shared rw works */
-                /* if asking for exclusive ro,
-                   exclusive rw works */
-
-                switch(segtype) {
-                case SEGMENT_SHARED_RO:
-                        if (shattr > 1 || rwattr > 1) {
-                                spin_unlock(&dcss_lock);
-                                return -ENOENT;
-                        } else {
-                                if (shattr == 0 && rwattr == 0)
-                                        rc = SEGMENT_EXCLUSIVE_RO;
-                                if (shattr == 0 && rwattr == 1)
-                                        rc = SEGMENT_EXCLUSIVE_RW;
-                                if (shattr == 1 && rwattr == 0)
-                                        rc = SEGMENT_SHARED_RO;
-                                if (shattr == 1 && rwattr == 1)
-                                        rc = SEGMENT_SHARED_RW;
-                        }
-                        break;
-                case SEGMENT_SHARED_RW:
-                        if (shattr > 1 || rwattr != 1) {
-                                spin_unlock(&dcss_lock);
-                                return -ENOENT;
-                        } else {
-                                if (shattr == 0)
-                                        rc = SEGMENT_EXCLUSIVE_RW;
-                                if (shattr == 1)
-                                        rc = SEGMENT_SHARED_RW;
-                        }
-                        break;
-
-                case SEGMENT_EXCLUSIVE_RO:
-                        if (shattr > 0 || rwattr > 1) {
-                                spin_unlock(&dcss_lock);
-                                return -ENOENT;
-                        } else {
-                                if (rwattr == 0)
-                                        rc = SEGMENT_EXCLUSIVE_RO;
-                                if (rwattr == 1)
-                                        rc = SEGMENT_EXCLUSIVE_RW;
-                        }
-                        break;
-
-                case SEGMENT_EXCLUSIVE_RW:
-/*                        if (shattr != 0 || rwattr != 1) {
-                                spin_unlock(&dcss_lock);
-                                return -ENOENT;
-                        } else {
-*/
-                                rc = SEGMENT_EXCLUSIVE_RW;
-//                        }
-                        break;
-
-                default:
-                        spin_unlock(&dcss_lock);
-                        return -ENOENT;
-                } /* end switch */
-
-                seg = kmalloc(sizeof(struct dcss_segment), GFP_DMA);
-                if (seg != NULL) {
-                        memcpy(seg->dcss_name, dcss_name, 8);
-			if (rc == SEGMENT_EXCLUSIVE_RW) {
-				if (dcss_diag(DCSS_LOADNSR, seg->dcss_name,
-						&seg->start_addr, &seg->end) == 0) {
-					if (seg->end < max_low_pfn*PAGE_SIZE ) {
-						atomic_set(&seg->ref_count, 1);
-						list_add(&seg->list, &dcss_list);
-						*addr = seg->start_addr;
-						*end = seg->end;
-						seg->dcss_attr = rc;
-						if (shattr == 1 && rwattr == 1)
-							seg->shared_attr = SEGMENT_SHARED_RW;
-						else if (shattr == 1 && rwattr == 0)
-							seg->shared_attr = SEGMENT_SHARED_RO;
-						else
-							seg->shared_attr = SEGMENT_EXCLUSIVE_RW;
-					} else {
-						dcss_diag(DCSS_PURGESEG, seg->dcss_name, &dummy, &dummy);
-						kfree (seg);
-						rc = -ENOENT;
-					}
-				} else {
-					kfree(seg);
-					rc = -ENOENT;
-			        }
-				goto out;
-                        }
-			if (dcss_diag(DCSS_LOADNOLY, seg->dcss_name,
-                                      &seg->start_addr, &seg->end) == 0) {
-				if (seg->end < max_low_pfn*PAGE_SIZE ) {
-		                        atomic_set(&seg->ref_count, 1);
-					list_add(&seg->list, &dcss_list);
-					*addr = seg->start_addr;
-					*end = seg->end;
-					seg->dcss_attr = rc;
-					seg->shared_attr = rc;
-				} else {
-					dcss_diag(DCSS_PURGESEG, seg->dcss_name, &dummy, &dummy);
-					kfree (seg);
-					rc = -ENOENT;
-				}
-                        } else {
-                                kfree(seg);
-                                rc = -ENOENT;
-                        }
-                } else rc = -ENOMEM;
-        } else {
-		/* found */
-		if ((segtype == SEGMENT_EXCLUSIVE_RW) && (seg->dcss_attr != SEGMENT_EXCLUSIVE_RW)) {
-			PRINT_ERR("Segment already loaded in other mode than EXCLUSIVE_RW!\n");
-			rc = -EPERM;
-			goto out;
-			/* reload segment in exclusive mode */
-/*			dcss_diag(DCSS_LOADNSR, seg->dcss_name,
-				  &seg->start_addr, &seg->end);
-			seg->dcss_attr = SEGMENT_EXCLUSIVE_RW;*/
-		}
-		if ((segtype != SEGMENT_EXCLUSIVE_RW) && (seg->dcss_attr == SEGMENT_EXCLUSIVE_RW)) {
-			PRINT_ERR("Segment already loaded in EXCLUSIVE_RW mode!\n");
-			rc = -EPERM;
-			goto out;
+	struct dcss_segment *seg;
+	int rc;
+
+	if (!MACHINE_IS_VM)
+		return -ENOSYS;
+
+	spin_lock (&dcss_lock);
+	seg = segment_by_name (name);
+	if (seg == NULL)
+		rc = __segment_load (name, do_nonshared, addr, end);
+	else {
+		if (do_nonshared == seg->do_nonshared) {
+			atomic_inc(&seg->ref_count);
+			*addr = seg->start_addr;
+			*end  = seg->end;
+			rc    = seg->vm_segtype;
+		} else {
+			*addr = *end = 0;
+			rc    = -EPERM;
 		}
-                atomic_inc(&seg->ref_count);
-                *addr = seg->start_addr;
-                *end = seg->end;
-                rc = seg->dcss_attr;
-        }
-out:
-        spin_unlock(&dcss_lock);
-        return rc;
+	}
+	spin_unlock (&dcss_lock);
+	return rc;
 }
 
 /*
@@ -422,84 +400,65 @@
  * it from the address space if nobody is using it
  * any longer.
  */
-void segment_unload(char *name)
+void
+segment_unload(char *name)
 {
-        char dcss_name[8];
-        unsigned long dummy;
-        struct list_head *l,*l_tmp;
-        struct dcss_segment *seg;
-
-        if (!MACHINE_IS_VM)
-                return;
-        dcss_mkname(name, dcss_name);
-        spin_lock(&dcss_lock);
-        list_for_each_safe(l, l_tmp, &dcss_list) {
-                seg = list_entry(l, struct dcss_segment, list);
-                if (memcmp(seg->dcss_name, dcss_name, 8) == 0) {
-                        if (atomic_dec_return(&seg->ref_count) == 0) {
-                                /* Last user of the segment is
-                                   gone. */
-                                list_del(&seg->list);
-                                dcss_diag(DCSS_PURGESEG, seg->dcss_name,
-                                          &dummy, &dummy);
-				kfree(seg);
-                        }
-                        break;
-                }
-        }
-        spin_unlock(&dcss_lock);
-}
-
-/*
- * Replace an existing DCSS segment, so that machines
- * that load it anew will see the new version.
- */
-void segment_replace(char *name)
-{
-        char dcss_name[8];
-        struct list_head *l;
-        struct dcss_segment *seg;
-        int mybeg = 0;
-        int myend = 0;
-        char mybuff1[80];
-        char mybuff2[80];
-
-        if (!MACHINE_IS_VM)
-                return;
-        dcss_mkname(name, dcss_name);
-
-        memset (mybuff1, 0, sizeof(mybuff1));
-        memset (mybuff2, 0, sizeof(mybuff2));
-
-        spin_lock(&dcss_lock);
-        list_for_each(l, &dcss_list) {
-                seg = list_entry(l, struct dcss_segment, list);
-                if (memcmp(seg->dcss_name, dcss_name, 8) == 0) {
-                        mybeg = seg->start_addr >> 12;
-                        myend = (seg->end) >> 12;
-                        if (seg->shared_attr == SEGMENT_EXCLUSIVE_RW)
-                                sprintf(mybuff1, "DEFSEG %s %X-%X EW",
-                                        name, mybeg, myend);
-                        if (seg->shared_attr == SEGMENT_EXCLUSIVE_RO)
-                                sprintf(mybuff1, "DEFSEG %s %X-%X RO",
-                                        name, mybeg, myend);
-                        if (seg->shared_attr == SEGMENT_SHARED_RW)
-                                sprintf(mybuff1, "DEFSEG %s %X-%X SW",
-                                        name, mybeg, myend);
-                        if (seg->shared_attr == SEGMENT_SHARED_RO)
-                                sprintf(mybuff1, "DEFSEG %s %X-%X SR",
-                                        name, mybeg, myend);
-                        spin_unlock(&dcss_lock);
-                        sprintf(mybuff2, "SAVESEG %s", name);
-                        cpcmd(mybuff1, NULL, 80);
-                        cpcmd(mybuff2, NULL, 80);
-                        break;
-                }
+	unsigned long dummy;
+	struct dcss_segment *seg;
+
+	if (!MACHINE_IS_VM)
+		return;
+
+	spin_lock(&dcss_lock);
+	seg = segment_by_name (name);
+	if (seg == NULL) {
+		PRINT_ERR ("could not find segment %s in segment_unload, "
+				"please report to linux390@de.ibm.com\n",name);
+		goto out_unlock;
+	}
+	if (atomic_dec_return(&seg->ref_count) == 0) {
+		list_del(&seg->list);
+		dcss_diag(DCSS_PURGESEG, seg->dcss_name,
+			  &dummy, &dummy);
+		kfree(seg);
+	}
+out_unlock:
+	spin_unlock(&dcss_lock);
+}
 
-        }
-        if (myend == 0) spin_unlock(&dcss_lock);
+/*
+ * save segment content permanently
+ */
+void segment_save(char *name)
+{
+	struct dcss_segment *seg;
+	int startpfn = 0;
+	int endpfn = 0;
+	char cmd1[80];
+	char cmd2[80];
+
+	if (!MACHINE_IS_VM)
+		return;
+
+	spin_lock(&dcss_lock);
+	seg = segment_by_name (name);
+
+	if (seg == NULL) {
+		PRINT_ERR ("could not find segment %s in segment_save, please report to linux390@de.ibm.com\n",name);
+		return;
+	}
+
+	startpfn = seg->start_addr >> 12;
+	endpfn = (seg->end) >> 12;
+	sprintf(cmd1, "DEFSEG %s %X-%X %s", name, startpfn, endpfn,
+			segtype_string[seg->vm_segtype]);
+	sprintf(cmd2, "SAVESEG %s", name);
+	cpcmd(cmd1, NULL, 80);
+	cpcmd(cmd2, NULL, 80);
+	spin_unlock(&dcss_lock);
 }
 
 EXPORT_SYMBOL(segment_load);
 EXPORT_SYMBOL(segment_unload);
-EXPORT_SYMBOL(segment_replace);
+EXPORT_SYMBOL(segment_save);
+EXPORT_SYMBOL(segment_info);
diff -urN linux-2.6/drivers/s390/block/dcssblk.c linux-2.6-patched/drivers/s390/block/dcssblk.c
--- linux-2.6/drivers/s390/block/dcssblk.c	2004-10-18 23:53:43.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dcssblk.c	2004-10-22 13:51:44.000000000 +0200
@@ -140,6 +140,53 @@
 }
 
 /*
+ * print appropriate error message for segment_load()/segment_info()
+ * return code
+ */
+static void
+dcssblk_segment_warn(int rc, char* seg_name)
+{
+	switch (rc) {
+	case -ENOENT:
+		PRINT_WARN("cannot load/query segment %s, does not exist\n",
+			   seg_name);
+		break;
+	case -ENOSYS:
+		PRINT_WARN("cannot load/query segment %s, not running on VM\n",
+			   seg_name);
+		break;
+	case -EIO:
+		PRINT_WARN("cannot load/query segment %s, hardware error\n",
+			   seg_name);
+		break;
+	case -ENOTSUPP:
+		PRINT_WARN("cannot load/query segment %s, is a multi-part "
+			   "segment\n", seg_name);
+		break;
+	case -ENOSPC:
+		PRINT_WARN("cannot load/query segment %s, overlaps with "
+			   "storage\n", seg_name);
+		break;
+	case -EBUSY:
+		PRINT_WARN("cannot load/query segment %s, overlaps with "
+			   "already loaded dcss\n", seg_name);
+		break;
+	case -EPERM:
+		PRINT_WARN("cannot load/query segment %s, already loaded in "
+			   "incompatible mode\n", seg_name);
+		break;
+	case -ENOMEM:
+		PRINT_WARN("cannot load/query segment %s, out of memory\n",
+			   seg_name);
+		break;
+	default:
+		PRINT_WARN("cannot load/query segment %s, return value %i\n",
+			   seg_name, rc);
+		break;
+	}
+}
+
+/*
  * device attribute for switching shared/nonshared (exclusive)
  * operation (show + store)
  */
@@ -185,61 +232,38 @@
 	if (inbuf[0] == '1') {
 		// reload segment in shared mode
 		segment_unload(dev_info->segment_name);
-		rc = segment_load(dev_info->segment_name, SEGMENT_SHARED_RO,
+		rc = segment_load(dev_info->segment_name, SEGMENT_SHARED,
 					&dev_info->start, &dev_info->end);
 		if (rc < 0) {
-			PRINT_ERR("Segment %s not reloaded, rc=%d\n",
-					dev_info->segment_name, rc);
+			dcssblk_segment_warn(rc, dev_info->segment_name);
 			goto removeseg;
 		}
 		dev_info->is_shared = 1;
-		PRINT_INFO("Segment %s reloaded, shared mode.\n",
-			   dev_info->segment_name);
+		if (rc == SEG_TYPE_SR || rc == SEG_TYPE_ER || rc == SEG_TYPE_SC)
+			set_disk_ro(dev_info->gd, 1);
 	} else if (inbuf[0] == '0') {
 		// reload segment in exclusive mode
+		if (dev_info->segment_type == SEG_TYPE_SC) {
+			PRINT_ERR("Segment type SC (%s) cannot be loaded in "
+				  "non-shared mode\n", dev_info->segment_name);
+			up_write(&dcssblk_devices_sem);
+			return -EINVAL;
+		}
 		segment_unload(dev_info->segment_name);
-		rc = segment_load(dev_info->segment_name, SEGMENT_EXCLUSIVE_RW,
+		rc = segment_load(dev_info->segment_name, SEGMENT_EXCLUSIVE,
 					&dev_info->start, &dev_info->end);
 		if (rc < 0) {
-			PRINT_ERR("Segment %s not reloaded, rc=%d\n",
-					dev_info->segment_name, rc);
+			dcssblk_segment_warn(rc, dev_info->segment_name);
 			goto removeseg;
 		}
 		dev_info->is_shared = 0;
-		PRINT_INFO("Segment %s reloaded, exclusive (read-write) mode.\n",
-			   dev_info->segment_name);
+		set_disk_ro(dev_info->gd, 0);
 	} else {
 		up_write(&dcssblk_devices_sem);
 		PRINT_WARN("Invalid value, must be 0 or 1\n");
 		return -EINVAL;
 	}
-	dev_info->segment_type = rc;
 	rc = count;
-
-	switch (dev_info->segment_type) {
-		case SEGMENT_SHARED_RO:
-		case SEGMENT_EXCLUSIVE_RO:
-			set_disk_ro(dev_info->gd, 1);
-			break;
-		case SEGMENT_SHARED_RW:
-		case SEGMENT_EXCLUSIVE_RW:
-			set_disk_ro(dev_info->gd, 0);
-			break;
-	}
-	if ((inbuf[0] == '1') &&
-	   ((dev_info->segment_type == SEGMENT_EXCLUSIVE_RO) ||
-	    (dev_info->segment_type == SEGMENT_EXCLUSIVE_RW))) {
-		PRINT_WARN("Could not get shared copy of segment %s\n",
-				dev_info->segment_name);
-		rc = -EPERM;
-	}
-	if ((inbuf[0] == '0') &&
-	   ((dev_info->segment_type == SEGMENT_SHARED_RO) ||
-	    (dev_info->segment_type == SEGMENT_SHARED_RW))) {
-		PRINT_WARN("Could not get exclusive copy of segment %s\n",
-				dev_info->segment_name);
-		rc = -EPERM;
-	}
 	up_write(&dcssblk_devices_sem);
 	goto out;
 
@@ -292,7 +316,7 @@
 			// device is idle => we save immediately
 			PRINT_INFO("Saving segment %s\n",
 				   dev_info->segment_name);
-			segment_replace(dev_info->segment_name);
+			segment_save(dev_info->segment_name);
 		}  else {
 			// device is busy => we save it when it becomes
 			// idle in dcssblk_release
@@ -390,18 +414,17 @@
 	/*
 	 * load the segment
 	 */
-	rc = segment_load(local_buf, SEGMENT_SHARED_RO,
+	rc = segment_load(local_buf, SEGMENT_SHARED,
 				&dev_info->start, &dev_info->end);
 	if (rc < 0) {
-		PRINT_ERR("Segment %s not loaded, rc=%d\n", local_buf, rc);
+		dcssblk_segment_warn(rc, dev_info->segment_name);
 		goto dealloc_gendisk;
 	}
 	seg_byte_size = (dev_info->end - dev_info->start + 1);
 	set_capacity(dev_info->gd, seg_byte_size >> 9); // size in sectors
-	PRINT_INFO("Loaded segment %s from %p to %p, size = %lu Byte, "
-		   "capacity = %lu sectors (512 Byte)\n", local_buf,
-		   	(void *) dev_info->start, (void *) dev_info->end,
-			seg_byte_size, seg_byte_size >> 9);
+	PRINT_INFO("Loaded segment %s, size = %lu Byte, "
+		   "capacity = %lu (512 Byte) sectors\n", local_buf,
+		   seg_byte_size, seg_byte_size >> 9);
 
 	dev_info->segment_type = rc;
 	dev_info->save_pending = 0;
@@ -451,12 +474,12 @@
 	blk_queue_hardsect_size(dev_info->dcssblk_queue, 4096);
 
 	switch (dev_info->segment_type) {
-		case SEGMENT_SHARED_RO:
-		case SEGMENT_EXCLUSIVE_RO:
+		case SEG_TYPE_SR:
+		case SEG_TYPE_ER:
+		case SEG_TYPE_SC:
 			set_disk_ro(dev_info->gd,1);
 			break;
-		case SEGMENT_SHARED_RW:
-		case SEGMENT_EXCLUSIVE_RW:
+		default:
 			set_disk_ro(dev_info->gd,0);
 			break;
 	}
@@ -589,7 +612,7 @@
 	    && (dev_info->save_pending)) {
 		PRINT_INFO("Segment %s became idle and is being saved now\n",
 			    dev_info->segment_name);
-		segment_replace(dev_info->segment_name);
+		segment_save(dev_info->segment_name);
 		dev_info->save_pending = 0;
 	}
 	up_write(&dcssblk_devices_sem);
diff -urN linux-2.6/drivers/s390/char/monreader.c linux-2.6-patched/drivers/s390/char/monreader.c
--- linux-2.6/drivers/s390/char/monreader.c	2004-10-22 13:51:36.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/monreader.c	2004-10-22 13:51:44.000000000 +0200
@@ -115,6 +115,53 @@
 	ASCEBC(ebcdic_name, 8);
 }
 
+/*
+ * print appropriate error message for segment_load()/segment_info()
+ * return code
+ */
+static void
+mon_segment_warn(int rc, char* seg_name)
+{
+	switch (rc) {
+	case -ENOENT:
+		P_WARNING("cannot load/query segment %s, does not exist\n",
+			  seg_name);
+		break;
+	case -ENOSYS:
+		P_WARNING("cannot load/query segment %s, not running on VM\n",
+			  seg_name);
+		break;
+	case -EIO:
+		P_WARNING("cannot load/query segment %s, hardware error\n",
+			  seg_name);
+		break;
+	case -ENOTSUPP:
+		P_WARNING("cannot load/query segment %s, is a multi-part "
+			  "segment\n", seg_name);
+		break;
+	case -ENOSPC:
+		P_WARNING("cannot load/query segment %s, overlaps with "
+			  "storage\n", seg_name);
+		break;
+	case -EBUSY:
+		P_WARNING("cannot load/query segment %s, overlaps with "
+			  "already loaded dcss\n", seg_name);
+		break;
+	case -EPERM:
+		P_WARNING("cannot load/query segment %s, already loaded in "
+			  "incompatible mode\n", seg_name);
+		break;
+	case -ENOMEM:
+		P_WARNING("cannot load/query segment %s, out of memory\n",
+			  seg_name);
+		break;
+	default:
+		P_WARNING("cannot load/query segment %s, return value %i\n",
+			  seg_name, rc);
+		break;
+	}
+}
+
 static inline unsigned long
 mon_mca_start(struct mon_msg *monmsg)
 {
@@ -534,10 +581,21 @@
 		return -ENODEV;
 	}
 
-	rc = segment_load(mon_dcss_name, SEGMENT_SHARED_RO,
+	rc = segment_info(mon_dcss_name);
+	if (rc < 0) {
+		mon_segment_warn(rc, mon_dcss_name);
+		return rc;
+	}
+	if (rc != SEG_TYPE_SC) {
+		P_ERROR("segment %s has unsupported type, should be SC\n",
+			mon_dcss_name);
+		return -EINVAL;
+	}
+
+	rc = segment_load(mon_dcss_name, SEGMENT_SHARED,
 			  &mon_dcss_start, &mon_dcss_end);
 	if (rc < 0) {
-		P_ERROR("Segment %s not loaded, rc = %d\n", mon_dcss_name, rc);
+		mon_segment_warn(rc, mon_dcss_name);
 		return -EINVAL;
 	}
 	dcss_mkname(mon_dcss_name, &user_data_connect[8]);
diff -urN linux-2.6/include/asm-s390/extmem.h linux-2.6-patched/include/asm-s390/extmem.h
--- linux-2.6/include/asm-s390/extmem.h	2004-10-18 23:54:39.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/extmem.h	2004-10-22 13:51:44.000000000 +0200
@@ -8,12 +8,23 @@
 #ifndef _ASM_S390X_DCSS_H
 #define _ASM_S390X_DCSS_H
 #ifndef __ASSEMBLY__
-#define SEGMENT_SHARED_RW       0
-#define SEGMENT_SHARED_RO       1
-#define SEGMENT_EXCLUSIVE_RW    2
-#define SEGMENT_EXCLUSIVE_RO    3
+
+/* possible values for segment type as returned by segment_info */
+#define SEG_TYPE_SW 0
+#define SEG_TYPE_EW 1
+#define SEG_TYPE_SR 2
+#define SEG_TYPE_ER 3
+#define SEG_TYPE_SN 4
+#define SEG_TYPE_EN 5
+#define SEG_TYPE_SC 6
+
+#define SEGMENT_SHARED 0
+#define SEGMENT_EXCLUSIVE 1
+
 extern int segment_load (char *name,int segtype,unsigned long *addr,unsigned long *length);
 extern void segment_unload(char *name);
-extern void segment_replace(char *name);
+extern void segment_save(char *name);
+extern int segment_info (char* name);
+
 #endif
 #endif
