Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbULCD2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbULCD2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 22:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbULCD2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 22:28:44 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:16015 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261390AbULCD2X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 22:28:23 -0500
Date: Fri, 03 Dec 2004 03:28:20 +0000
From: Willem Riede <osst@riede.org>
Subject: Re: [PATCH] SCSI tape: remove use of file_count(), was Re:
 [patchset] Lockfree fd lookup 0 of 5
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>
References: <20040902062229.GB1312@vitalstatistix.in.ibm.com>
	<20040917055845.GA3468@in.ibm.com> <20040917001555.6dbee4fd.akpm@osdl.org>
	<20040917103201.GA3785@in.ibm.com>
	<Pine.LNX.4.58.0409170811300.2338@ppc970.osdl.org>
	<Pine.LNX.4.60.0409171857040.5201@spektro.metla.fi>
	<20040917201745.GD3975@in.ibm.com>
	<Pine.LNX.4.60.0409172338360.5736@spektro.metla.fi>
	<20040920143737.GC21581@in.ibm.com>
	<Pine.LNX.4.58.0409202053350.2814@kai.makisara.local>
	<20041130131150.GE23329@impedimenta.in.ibm.com>
	<Pine.LNX.4.61.0411302217120.4818@kai.makisara.local>
In-Reply-To: <Pine.LNX.4.61.0411302217120.4818@kai.makisara.local> (from
	Kai.Makisara@kolumbus.fi on Tue Nov 30 15:30:26 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1102044500l.4013l.5l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/2004 03:30:26 PM, Kai Makisara wrote:
> On Tue, 30 Nov 2004, Ravikiran G Thirumalai wrote:
> 
> > Kai, can you mail the latest version of this patch to lkml?  Willem, can
> > you make a patch similar to this for osst.c and mail it to lkml?
> > 
> OK. The patch at the end of this message modifies st so that file_count() 
> is not used. It has been used to find the last call to the st_flush() 
> method for possible writing of the final filemark and rewinding the tape. 
> While these have been in st_flush(), it has been possible to return errors 
> in the return value of close(). The patch moves these operations to
> st_release() 
> and logs the possible errors since it is not possible to return these 
> errors to the user any more. Flushing the tape drive buffer is added to  
> st_flush() to minimise the possibility of errors not reported at close().
> 
> The patch is against 2.6.10-rc2-bk13, it compiles, and is lightly tested. 
> It should not be applied unless file_count() really is removed.

Here is the equivalent patch for osst.c -- the same considerations apply.
It has been compiled, and tested, and works for me.

Signed-off-by: Willem Riede <osst@riede.org>

--- /home/wriede/kernel/linux-2.6.10-rc2/drivers/scsi/osst.c	2004-12-01
19:31:49.000000000 -0500
+++ ./osst.c	2004-12-02 18:51:55.000000000 -0500
@@ -4590,22 +4590,38 @@
 {
 	int            result = 0, result2;
 	OS_Scsi_Tape * STp  = filp->private_data;
-	struct st_modedef      * STm  = &(STp->modes[STp->current_mode]);
-	struct st_partstat  * STps = &(STp->ps[STp->partition]);
 	Scsi_Request * SRpnt = NULL;
-	char         * name = tape_name(STp);
 
-	if (file_count(filp) > 1)
-		return 0;
+	if (down_interruptible(&STp->lock))
+		return (-ERESTARTSYS);
 
-	if ((STps->rw == ST_WRITING || STp->dirty) && !STp->pos_unknown) {
+	if ((STp->ps[STp->partition].rw == ST_WRITING || STp->dirty) &&
!STp->pos_unknown) {
 		STp->write_type = OS_WRITE_DATA;
 		result = osst_flush_write_buffer(STp, &SRpnt);
 		if (result != 0 && result != (-ENOSPC))
 			goto out;
+		/* wait for writing to complete */
+		result2 = osst_flush_drive_buffer(STp, &SRpnt);
+		if (result == 0)
+			result = result2;
 	}
-	if ( STps->rw >= ST_WRITING && !STp->pos_unknown) {
+out:
+	up(&STp->lock);
+	return result;
+}
 
+
+/* Close the device and release it */
+static int os_scsi_tape_close(struct inode * inode, struct file * filp)
+{
+	int                 result = 0, result2;
+	OS_Scsi_Tape       * STp   = filp->private_data;
+	struct st_modedef  * STm   = &(STp->modes[STp->current_mode]);
+	struct st_partstat * STps  = &(STp->ps[STp->partition]);
+	Scsi_Request       * SRpnt = NULL;
+	char               * name  = tape_name(STp);
+
+	if ( STps->rw >= ST_WRITING && !STp->pos_unknown) {
 #if DEBUG
 		if (debugging) {
 			printk(OSST_DEB_MSG "%s:D: File length %ld bytes.\n",
@@ -4620,6 +4636,10 @@
 			printk(OSST_DEB_MSG "%s:D: Buffer flushed, %d EOF(s)
written\n",
 					       name, 1+STp->two_fm);
 #endif
+                if (result) {
+                        printk(KERN_ERR "%s: Writing closing filemark
failed.\n", name);
+                        STp->pos_unknown = 1;
+                }
 	}
 	else if (!STp->rew_at_close) {
 		STps = &(STp->ps[STp->partition]);
@@ -4646,11 +4666,17 @@
 			STps->drv_block = 0;
 			STps->eof = ST_FM;
 		}
+		if (result) {
+			printk(KERN_ERR "%s: Final tape positioning
failed.\n", name);
+			STp->pos_unknown = 1;
+		}
 	}
-
-out:
 	if (STp->rew_at_close) {
 		result2 = osst_position_tape_and_confirm(STp, &SRpnt,
STp->first_data_ppos);
+		if (result2 < 0) {
+			printk(KERN_ERR "%s: Auto-rewind failed.\n", name);
+			STp->pos_unknown = 1;
+		}
 		STps->drv_file = STps->drv_block = STp->frame_seq_number =
STp->logical_blk_num = 0;
 		if (result == 0 && result2 < 0)
 			result = result2;
@@ -4669,19 +4695,6 @@
 	STp->write_count = 0;
 	STp->read_count  = 0;
 
-	return result;
-}
-
-
-/* Close the device and release it */
-static int os_scsi_tape_close(struct inode * inode, struct file * filp)
-{
-	int result = 0;
-	OS_Scsi_Tape * STp = filp->private_data;
-	Scsi_Request * SRpnt = NULL;
-
-	if (SRpnt) scsi_release_request(SRpnt);
-
 	if (STp->door_locked == ST_LOCKED_AUTO)
 		do_door_lock(STp, 0);
 


