Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSKMVZf>; Wed, 13 Nov 2002 16:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbSKMVZe>; Wed, 13 Nov 2002 16:25:34 -0500
Received: from ns.splentec.com ([209.47.35.194]:32781 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S264714AbSKMVZU>;
	Wed, 13 Nov 2002 16:25:20 -0500
Message-ID: <3DD2C4D8.4E8B7A7D@splentec.com>
Date: Wed, 13 Nov 2002 16:32:08 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: extracting the sense key, ASC and ASCQ
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... testing the descriptor format sense data...
long story short:

This patch teaches SCSI core to use get_sense_key(),
get_asc() and get_ascq() to obtain the sense key,
ASC and ASCQ respectively, from the sense buffer.
(similarly to host_byte, driver_byte(), etc also
found in scsi.h)

A check is also made to make sure that the additional
length in the sense data spans ASC and ASCQ bytes;
Also descriptor format sense data is now supported
transparently (DESC bit in REQUEST SENSE...).

This is a cosmetic patch.

-- 
Luben

diff -Nru -X /usr/src/dontdiff linux-2.5.47/drivers/scsi/scsi.c linux/drivers/scsi/scsi.c
--- linux-2.5.47/drivers/scsi/scsi.c    Sun Nov 10 22:28:16 2002
+++ linux/drivers/scsi/scsi.c   Wed Nov 13 14:00:51 2002
@@ -2257,7 +2257,7 @@
                                       SCpnt->internal_timeout,
 
                                       SCpnt->cmnd[0],
-                                      SCpnt->sense_buffer[2],
+                                      get_sense_key(SCpnt->sense_buffer),
                                       SCpnt->result);
                        }
                }
diff -Nru -X /usr/src/dontdiff linux-2.5.47/drivers/scsi/scsi.h linux/drivers/scsi/scsi.h
--- linux-2.5.47/drivers/scsi/scsi.h    Sun Nov 10 22:28:06 2002
+++ linux/drivers/scsi/scsi.h   Wed Nov 13 13:55:52 2002
@@ -133,6 +133,33 @@
 #define sense_error(sense)  ((sense) & 0xf)
 #define sense_valid(sense)  ((sense) & 0x80);
 
+/* Support for descriptor format sense data.
+ */
+static inline u8 get_sense_key(unsigned char *sense_buf)
+{
+       return (sense_buf[0]&2) ? sense_buf[1]&0xf : sense_buf[2]&0xf;
+}
+
+static inline u8 get_asc(unsigned char *sense_buf)
+{
+       if (sense_buf[0]&2)
+               return sense_buf[2];
+       else if (sense_buf[7]>4)
+               return sense_buf[12];
+       else
+               return 0;
+}
+
+static inline u8 get_ascq(unsigned char *sense_buf)
+{
+       if (sense_buf[0]&2)
+               return sense_buf[3];
+       else if (sense_buf[7]>5)
+               return sense_buf[13];
+       else
+               return 0;
+}
+
 #define NEEDS_RETRY     0x2001
 #define SUCCESS         0x2002
 #define FAILED          0x2003
diff -Nru -X /usr/src/dontdiff linux-2.5.47/drivers/scsi/scsi_error.c linux/drivers/scsi/scsi_error.c
--- linux-2.5.47/drivers/scsi/scsi_error.c      Sun Nov 10 22:28:02 2002
+++ linux/drivers/scsi/scsi_error.c     Wed Nov 13 14:04:24 2002
@@ -299,13 +299,15 @@
  **/
 static int scsi_check_sense(Scsi_Cmnd *scmd)
 {
+       u8 sense_key = get_sense_key(scmd->sense_buffer);
+       u8 asc  = get_asc(scmd->sense_buffer);
+       u8 ascq = get_ascq(scmd->sense_buffer);
+
        if (!SCSI_SENSE_VALID(scmd)) {
                return FAILED;
        }
-       if (scmd->sense_buffer[2] & 0xe0)
-               return SUCCESS;
 
-       switch (scmd->sense_buffer[2] & 0xf) {
+       switch (sense_key) {
        case NO_SENSE:
                return SUCCESS;
        case RECOVERED_ERROR:
@@ -329,8 +331,7 @@
                 * if the device is in the process of becoming ready, we 
                 * should retry.
                 */
-               if ((scmd->sense_buffer[12] == 0x04) &&
-                       (scmd->sense_buffer[13] == 0x01)) {
+               if (asc == 0x04 && ascq == 0x01) {
                        return NEEDS_RETRY;
                }
                return SUCCESS;
diff -Nru -X /usr/src/dontdiff linux-2.5.47/drivers/scsi/scsi_ioctl.c linux/drivers/scsi/scsi_ioctl.c
--- linux-2.5.47/drivers/scsi/scsi_ioctl.c      Sun Nov 10 22:28:31 2002
+++ linux/drivers/scsi/scsi_ioctl.c     Wed Nov 13 14:06:04 2002
@@ -108,7 +108,7 @@
        SCSI_LOG_IOCTL(2, printk("Ioctl returned  0x%x\n", SRpnt->sr_result));
 
        if (driver_byte(SRpnt->sr_result) != 0)
-               switch (SRpnt->sr_sense_buffer[2] & 0xf) {
+               switch (get_sense_key(SRpnt->sr_sense_buffer)) {
                case ILLEGAL_REQUEST:
                        if (cmd[0] == ALLOW_MEDIUM_REMOVAL)
                                dev->lockable = 0;
@@ -134,10 +134,10 @@
                               dev->id,
                               dev->lun,
                               SRpnt->sr_result);
-                       printk("\tSense class %x, sense error %x, extended sense %x\n",
+                       printk("\tSense class %x, sense error %x, sense key %x\n",
                               sense_class(SRpnt->sr_sense_buffer[0]),
                               sense_error(SRpnt->sr_sense_buffer[0]),
-                              SRpnt->sr_sense_buffer[2] & 0xf);
+                              get_sense_key(SRpnt->sr_sense_buffer));
 
                }
 
diff -Nru -X /usr/src/dontdiff linux-2.5.47/drivers/scsi/scsi_lib.c linux/drivers/scsi/scsi_lib.c
--- linux-2.5.47/drivers/scsi/scsi_lib.c        Sun Nov 10 22:28:14 2002
+++ linux/drivers/scsi/scsi_lib.c       Wed Nov 13 14:14:52 2002
@@ -581,17 +581,17 @@
                        }
 #endif
                }
-               if ((SCpnt->sense_buffer[0] & 0x7f) == 0x70) {
+               if (SCSI_SENSE_VALID(SCpnt)) {
                        /*
                         * If the device is in the process of becoming ready,
                         * retry.
                         */
-                       if (SCpnt->sense_buffer[12] == 0x04 &&
-                           SCpnt->sense_buffer[13] == 0x01) {
+                       if (get_asc(SCpnt->sense_buffer) == 0x04 &&
+                           get_ascq(SCpnt->sense_buffer) == 0x01) {
                                scsi_queue_next_request(q, SCpnt);
                                return;
                        }
-                       if ((SCpnt->sense_buffer[2] & 0xf) == UNIT_ATTENTION) {
+                       if (get_sense_key(SCpnt->sense_buffer) == UNIT_ATTENTION) {
                                if (SCpnt->device->removable) {
                                        /* detected disc change.  set a bit 
                                         * and quietly refuse further access.
@@ -618,7 +618,7 @@
                 * past the end of the disk.
                 */
 
-               switch (SCpnt->sense_buffer[2]) {
+               switch (get_sense_key(SCpnt->sense_buffer)) {
                case ILLEGAL_REQUEST:
                        if (SCpnt->device->ten) {
                                SCpnt->device->ten = 0;
diff -Nru -X /usr/src/dontdiff linux-2.5.47/drivers/scsi/scsi_scan.c linux/drivers/scsi/scsi_scan.c
--- linux-2.5.47/drivers/scsi/scsi_scan.c       Sun Nov 10 22:28:29 2002
+++ linux/drivers/scsi/scsi_scan.c      Wed Nov 13 14:10:20 2002
@@ -1205,9 +1205,9 @@
 
        if (sreq->sr_result) {
                if ((driver_byte(sreq->sr_result) & DRIVER_SENSE) != 0 &&
-                   (sreq->sr_sense_buffer[2] & 0xf) == UNIT_ATTENTION &&
-                   sreq->sr_sense_buffer[12] == 0x28 &&
-                   sreq->sr_sense_buffer[13] == 0) {
+                   get_sense_key(sreq->sr_sense_buffer) == UNIT_ATTENTION &&
+                   get_asc(sreq->sr_sense_buffer) == 0x28 &&
+                   get_ascq(sreq->sr_sense_buffer) == 0) {
                        /* not-ready to ready transition - good */
                        /* dpg: bogus? INQUIRY never returns UNIT_ATTENTION */
                } else
@@ -1830,7 +1830,7 @@
                                ?  "failed" : "successful", retries,
                                sreq->sr_result));
                if (sreq->sr_result == 0
-                   || sreq->sr_sense_buffer[2] != UNIT_ATTENTION)
+                   || get_sense_key(sreq->sr_sense_buffer) != UNIT_ATTENTION)
                        break;
        }
        scsi_release_commandblocks(sdevscan);
diff -Nru -X /usr/src/dontdiff linux-2.5.47/drivers/scsi/scsiiom.c linux/drivers/scsi/scsiiom.c
--- linux-2.5.47/drivers/scsi/scsiiom.c Sun Nov 10 22:28:03 2002
+++ linux/drivers/scsi/scsiiom.c        Wed Nov 13 14:12:01 2002
@@ -1380,7 +1380,7 @@
        pSRB->AdaptStatus = 0;
        pSRB->TargetStatus = CHECK_CONDITION << 1;
 #ifdef DC390_REMOVABLEDEBUG
-       switch (pcmd->sense_buffer[2] & 0x0f)
+       switch (get_sense_key(pcmd->sense_buffer))
        {           
         case NOT_READY: printk (KERN_INFO "DC390: ReqSense: NOT_READY (Cmnd = 0x%02x, Dev = %i-%i, Stat = %i, Scan =
%i)\n",
                                 pcmd->cmnd[0], pDCB->TargetID, pDCB->TargetLUN,
@@ -1584,8 +1584,8 @@
            else printk ("\n");
 #endif
            if( (host_byte(pcmd->result) != DID_OK && !(status_byte(pcmd->result) & CHECK_CONDITION) &&
!(status_byte(pcmd->result) & BUSY)) ||
-              ((driver_byte(pcmd->result) & DRIVER_SENSE) && (pcmd->sense_buffer[0] & 0x70) == 0x70 &&
-               (pcmd->sense_buffer[2] & 0xf) == ILLEGAL_REQUEST) || host_byte(pcmd->result) & DID_ERROR )
+              ((driver_byte(pcmd->result) & DRIVER_SENSE) && SCSI_SENSE_VALID(pcmd->sense_buffer) &&
+               get_sense_key(pcmd->sense_buffer) == ILLEGAL_REQUEST) || host_byte(pcmd->result) & DID_ERROR )
            {
               /* device not present: remove */ 
               //dc390_Going_remove (pDCB, pSRB);
