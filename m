Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269291AbUH0JY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbUH0JY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269400AbUH0JWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:22:18 -0400
Received: from aun.it.uu.se ([130.238.12.36]:22732 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S269382AbUH0JTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:19:32 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16686.64659.635469.298299@alkaid.it.uu.se>
Date: Fri, 27 Aug 2004 11:19:15 +0200
To: marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre2] more gcc34 lvalue fixes
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Here are some more fixes for broken lvalues in 2.4.28-pre2.
- drivers/net/ne2k-pci.c: cast-as-lvalue, fixes from 2.6
- drivers/scsi/53c7,8xx.c: cast-as-lvalue, new 2.4 fix since
  2.6 doesn't seem to have this code any more
- drivers/scsi/advansys.c: cast-as-lvalue, fixes from 2.6
- drivers/scsi/dpt_i2o.c: cast-as-lvalue, fixes from 2.6
- drivers/scsi/seagate.c: cast-as-lvalue, fix from 2.6
- fs/affs/super.c: conditional-as-lvalue, new 2.4 fix since
  the 2.6 code is completely different

There is a half-broken asm() in drivers/scsi/ultrastor.c,
but that problem is also not fixed in 2.6 so I'm ignoring it.

drivers/net/e100/e100.h has broken usage of __attribute__((packed))
together with typedef, but this is not a regression from previous
gcc:s (gcc-3.4 just warns). I have a patch if you want it.

/Mikael

diff -ruN linux-2.4.28-pre2/drivers/net/ne2k-pci.c linux-2.4.28-pre2.gcc34-lvalue-fixes/drivers/net/ne2k-pci.c
--- linux-2.4.28-pre2/drivers/net/ne2k-pci.c	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.28-pre2.gcc34-lvalue-fixes/drivers/net/ne2k-pci.c	2004-08-27 01:50:38.000000000 +0200
@@ -505,8 +505,12 @@
 		insl(NE_BASE + NE_DATAPORT, buf, count>>2);
 		if (count & 3) {
 			buf += count & ~3;
-			if (count & 2)
-				*((u16*)buf)++ = le16_to_cpu(inw(NE_BASE + NE_DATAPORT));
+			if (count & 2) {
+				u16 *b = (u16 *)buf;
+
+				*b++ = le16_to_cpu(inw(NE_BASE + NE_DATAPORT));
+				buf = (char *)b;
+			}
 			if (count & 1)
 				*buf = inb(NE_BASE + NE_DATAPORT);
 		}
@@ -566,8 +570,12 @@
 		outsl(NE_BASE + NE_DATAPORT, buf, count>>2);
 		if (count & 3) {
 			buf += count & ~3;
-			if (count & 2)
-				outw(cpu_to_le16(*((u16*)buf)++), NE_BASE + NE_DATAPORT);
+			if (count & 2) {
+				u16 *b = (u16 *)buf;
+
+				outw(cpu_to_le16(*b++), NE_BASE + NE_DATAPORT);
+				buf = (char *)b;
+			}
 		}
 	}
 
diff -ruN linux-2.4.28-pre2/drivers/scsi/53c7,8xx.c linux-2.4.28-pre2.gcc34-lvalue-fixes/drivers/scsi/53c7,8xx.c
--- linux-2.4.28-pre2/drivers/scsi/53c7,8xx.c	2003-11-29 00:28:13.000000000 +0100
+++ linux-2.4.28-pre2.gcc34-lvalue-fixes/drivers/scsi/53c7,8xx.c	2004-08-27 01:50:38.000000000 +0200
@@ -3926,7 +3926,7 @@
 	restore_flags (flags);
 	cmd->result = le32_to_cpu(0xffff);	/* The NCR will overwrite message
 				       and status with valid data */
-	cmd->host_scribble = (unsigned char *) tmp = create_cmd (cmd);
+	cmd->host_scribble = (unsigned char *) create_cmd (cmd);
     }
     cli();
     /*
diff -ruN linux-2.4.28-pre2/drivers/scsi/advansys.c linux-2.4.28-pre2.gcc34-lvalue-fixes/drivers/scsi/advansys.c
--- linux-2.4.28-pre2/drivers/scsi/advansys.c	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.28-pre2.gcc34-lvalue-fixes/drivers/scsi/advansys.c	2004-08-27 01:50:38.000000000 +0200
@@ -6118,8 +6118,8 @@
     } else {
         /* Append to 'done_scp' at the end with 'last_scp'. */
         ASC_ASSERT(last_scp != NULL);
-        REQPNEXT(last_scp) = asc_dequeue_list(&boardp->active,
-            &new_last_scp, ASC_TID_ALL);
+        last_scp->host_scribble = (unsigned char *)asc_dequeue_list(
+			&boardp->active, &new_last_scp, ASC_TID_ALL);
         if (new_last_scp != NULL) {
             ASC_ASSERT(REQPNEXT(last_scp) != NULL);
             for (tscp = REQPNEXT(last_scp); tscp; tscp = REQPNEXT(tscp)) {
@@ -6141,8 +6141,8 @@
     } else {
         /* Append to 'done_scp' at the end with 'last_scp'. */
         ASC_ASSERT(last_scp != NULL);
-        REQPNEXT(last_scp) = asc_dequeue_list(&boardp->waiting,
-            &new_last_scp, ASC_TID_ALL);
+        last_scp->host_scribble = (unsigned char *)asc_dequeue_list(
+			&boardp->waiting, &new_last_scp, ASC_TID_ALL);
         if (new_last_scp != NULL) {
             ASC_ASSERT(REQPNEXT(last_scp) != NULL);
             for (tscp = REQPNEXT(last_scp); tscp; tscp = REQPNEXT(tscp)) {
@@ -6394,8 +6394,8 @@
                     ASC_TID_ALL);
             } else {
                 ASC_ASSERT(last_scp != NULL);
-                REQPNEXT(last_scp) = asc_dequeue_list(&boardp->done,
-                    &new_last_scp, ASC_TID_ALL);
+                last_scp->host_scribble = (unsigned char *)asc_dequeue_list(
+			&boardp->done, &new_last_scp, ASC_TID_ALL);
                 if (new_last_scp != NULL) {
                     ASC_ASSERT(REQPNEXT(last_scp) != NULL);
                     last_scp = new_last_scp;
@@ -6466,7 +6466,7 @@
     while (scp != NULL) {
         ASC_DBG1(3, "asc_scsi_done_list: scp 0x%lx\n", (ulong) scp);
         tscp = REQPNEXT(scp);
-        REQPNEXT(scp) = NULL;
+        scp->host_scribble = NULL;
         ASC_STATS(scp->host, done);
         ASC_ASSERT(scp->scsi_done != NULL);
         scp->scsi_done(scp);
@@ -7511,7 +7511,7 @@
     tid = REQPTID(reqp);
     ASC_ASSERT(tid >= 0 && tid <= ADV_MAX_TID);
     if (flag == ASC_FRONT) {
-        REQPNEXT(reqp) = ascq->q_first[tid];
+        reqp->host_scribble = (unsigned char *)ascq->q_first[tid];
         ascq->q_first[tid] = reqp;
         /* If the queue was empty, set the last pointer. */
         if (ascq->q_last[tid] == NULL) {
@@ -7519,10 +7519,10 @@
         }
     } else { /* ASC_BACK */
         if (ascq->q_last[tid] != NULL) {
-            REQPNEXT(ascq->q_last[tid]) = reqp;
+            ascq->q_last[tid]->host_scribble = (unsigned char *)reqp;
         }
         ascq->q_last[tid] = reqp;
-        REQPNEXT(reqp) = NULL;
+        reqp->host_scribble = NULL;
         /* If the queue was empty, set the first pointer. */
         if (ascq->q_first[tid] == NULL) {
             ascq->q_first[tid] = reqp;
@@ -7643,7 +7643,7 @@
                     lastp = ascq->q_last[i];
                 } else {
                     ASC_ASSERT(lastp != NULL);
-                    REQPNEXT(lastp) = ascq->q_first[i];
+                    lastp->host_scribble = (unsigned char *)ascq->q_first[i];
                     lastp = ascq->q_last[i];
                 }
                 ascq->q_first[i] = ascq->q_last[i] = NULL;
@@ -7721,8 +7721,8 @@
              currp; prevp = currp, currp = REQPNEXT(currp)) {
             if (currp == reqp) {
                 ret = ASC_TRUE;
-                REQPNEXT(prevp) = REQPNEXT(currp);
-                REQPNEXT(reqp) = NULL;
+                prevp->host_scribble = (unsigned char *)REQPNEXT(currp);
+                reqp->host_scribble = NULL;
                 if (ascq->q_last[tid] == reqp) {
                     ascq->q_last[tid] = prevp;
                 }
diff -ruN linux-2.4.28-pre2/drivers/scsi/dpt_i2o.c linux-2.4.28-pre2.gcc34-lvalue-fixes/drivers/scsi/dpt_i2o.c
--- linux-2.4.28-pre2/drivers/scsi/dpt_i2o.c	2003-06-14 13:30:24.000000000 +0200
+++ linux-2.4.28-pre2.gcc34-lvalue-fixes/drivers/scsi/dpt_i2o.c	2004-08-27 01:50:38.000000000 +0200
@@ -434,7 +434,7 @@
 			cmd->scsi_done(cmd);
 			return 0;
 		}
-		(struct adpt_device*)(cmd->device->hostdata) = pDev;
+		cmd->device->hostdata = pDev;
 	}
 	pDev->pScsi_dev = cmd->device;
 
@@ -2194,7 +2194,7 @@
 		printk ("%s: scsi_register returned NULL\n",pHba->name);
 		return -1;
 	}
-	(adpt_hba*)(host->hostdata[0]) = pHba;
+	host->hostdata[0] = (unsigned long)pHba;
 	pHba->host = host;
 
 	host->irq = pHba->pDev->irq;;
diff -ruN linux-2.4.28-pre2/drivers/scsi/seagate.c linux-2.4.28-pre2.gcc34-lvalue-fixes/drivers/scsi/seagate.c
--- linux-2.4.28-pre2/drivers/scsi/seagate.c	2003-08-25 20:07:46.000000000 +0200
+++ linux-2.4.28-pre2.gcc34-lvalue-fixes/drivers/scsi/seagate.c	2004-08-27 01:50:38.000000000 +0200
@@ -698,7 +698,7 @@
 	done_fn = done;
 	current_target = SCpnt->target;
 	current_lun = SCpnt->lun;
-	(const void *) current_cmnd = SCpnt->cmnd;
+	current_cmnd = SCpnt->cmnd;
 	current_data = (unsigned char *) SCpnt->request_buffer;
 	current_bufflen = SCpnt->request_bufflen;
 	SCint = SCpnt;
diff -ruN linux-2.4.28-pre2/fs/affs/super.c linux-2.4.28-pre2.gcc34-lvalue-fixes/fs/affs/super.c
--- linux-2.4.28-pre2/fs/affs/super.c	2004-08-08 10:56:31.000000000 +0200
+++ linux-2.4.28-pre2.gcc34-lvalue-fixes/fs/affs/super.c	2004-08-27 01:50:38.000000000 +0200
@@ -130,7 +130,7 @@
 					printk("AFFS: Argument for set[ug]id option missing\n");
 					return 0;
 				} else {
-					(f ? *uid : *gid) = simple_strtoul(value,&value,0);
+					*(f ? uid : gid) = simple_strtoul(value,&value,0);
 					if (*value) {
 						printk("AFFS: Bad set[ug]id argument\n");
 						return 0;
