Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbUK3UbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbUK3UbQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbUK3UbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:31:16 -0500
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:58319 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262302AbUK3Ua2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:30:28 -0500
Date: Tue, 30 Nov 2004 22:30:26 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Willem Riede <osst@riede.org>
Subject: [PATCH] SCSI tape: remove use of file_count(), was Re: [patchset]
 Lockfree fd lookup 0 of 5
In-Reply-To: <20041130131150.GE23329@impedimenta.in.ibm.com>
Message-ID: <Pine.LNX.4.61.0411302217120.4818@kai.makisara.local>
References: <20040902062229.GB1312@vitalstatistix.in.ibm.com>
 <20040917055845.GA3468@in.ibm.com> <20040917001555.6dbee4fd.akpm@osdl.org>
 <20040917103201.GA3785@in.ibm.com> <Pine.LNX.4.58.0409170811300.2338@ppc970.osdl.org>
 <Pine.LNX.4.60.0409171857040.5201@spektro.metla.fi> <20040917201745.GD3975@in.ibm.com>
 <Pine.LNX.4.60.0409172338360.5736@spektro.metla.fi> <20040920143737.GC21581@in.ibm.com>
 <Pine.LNX.4.58.0409202053350.2814@kai.makisara.local>
 <20041130131150.GE23329@impedimenta.in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Ravikiran G Thirumalai wrote:

> Kai, can you mail the latest version of this patch to lkml?  Willem, can
> you make a patch similar to this for osst.c and mail it to lkml?
> 
OK. The patch at the end of this message modifies st so that file_count() 
is not used. It has been used to find the last call to the st_flush() 
method for possible writing of the final filemark and rewinding the tape. 
While these have been in st_flush(), it has been possible to return errors 
in the return value of close(). The patch moves these operations to st_release() 
and logs the possible errors since it is not possible to return these 
errors to the user any more. Flushing the tape drive buffer is added to  
st_flush() to minimise the possibility of errors not reported at close().

The patch is against 2.6.10-rc2-bk13, it compiles, and is lightly tested. 
It should not be applied unless file_count() really is removed.

Signed-off-by: Kai Makisara <kai.makisara@kolumbus.fi>

-- 
Kai

--- linux-2.6.10-rc2-bk13/drivers/scsi/st.c	2004-11-30 20:43:30.000000000 +0200
+++ linux-2.6.10-rc2-bk13-k1/drivers/scsi/st.c	2004-11-30 21:20:17.000000000 +0200
@@ -17,7 +17,7 @@
    Last modified: 18-JAN-1998 Richard Gooch <rgooch@atnf.csiro.au> Devfs support
  */
 
-static char *verstr = "20041025";
+static char *verstr = "20041130";
 
 #include <linux/module.h>
 
@@ -1078,20 +1078,21 @@
 static int st_flush(struct file *filp)
 {
 	int result = 0, result2;
-	unsigned char cmd[MAX_COMMAND_SIZE];
-	struct scsi_request *SRpnt;
 	struct scsi_tape *STp = filp->private_data;
-	struct st_modedef *STm = &(STp->modes[STp->current_mode]);
 	struct st_partstat *STps = &(STp->ps[STp->partition]);
-	char *name = tape_name(STp);
+	DEB(char *name = tape_name(STp));
 
-	if (file_count(filp) > 1)
-		return 0;
+	if (down_interruptible(&STp->lock))
+		return -ERESTARTSYS;
 
 	if (STps->rw == ST_WRITING && !STp->pos_unknown) {
 		result = flush_write_buffer(STp);
 		if (result != 0 && result != (-ENOSPC))
 			goto out;
+		/* Flush to tape */
+		result = st_int_ioctl(STp, MTWEOF, 0);
+		if (result)
+			goto out;
 	}
 
 	if (STp->can_partitions &&
@@ -1100,9 +1101,27 @@
                                "%s: switch_partition at close failed.\n", name));
 		if (result == 0)
 			result = result2;
-		goto out;
 	}
 
+ out:
+	up(&STp->lock);
+	return result;
+}
+
+
+/* Close the device and release it. BKL is not needed: this is the only thread
+   accessing this tape. STp->pos_unknown is set if to block further access if
+   tape re-positioning fails. */
+static int st_release(struct inode *inode, struct file *filp)
+{
+	int result = 0, result2;
+	unsigned char cmd[MAX_COMMAND_SIZE];
+	struct scsi_tape *STp = filp->private_data;
+	struct st_modedef *STm = &(STp->modes[STp->current_mode]);
+	struct st_partstat *STps = &(STp->ps[STp->partition]);
+	struct scsi_request *SRpnt;
+	char *name = tape_name(STp);
+
 	DEBC( if (STp->nbr_requests)
 		printk(KERN_WARNING "%s: Number of r/w requests %d, dio used in %d, pages %d (%d).\n",
 		       name, STp->nbr_requests, STp->nbr_dio, STp->nbr_pages, STp->nbr_combinable));
@@ -1175,24 +1194,22 @@
 			STps->drv_block = 0;
 			STps->eof = ST_FM;
 		}
+		if (result) {
+			printk(KERN_ERR "%s: Final tape positioning failed.\n", name);
+			STp->pos_unknown = 1;
+		}
 	}
 
-      out:
+out:
 	if (STp->rew_at_close) {
 		result2 = st_int_ioctl(STp, MTREW, 1);
+		if (result2) {
+			printk(KERN_ERR "%s: Auto-rewind failed.\n", name);
+			STp->pos_unknown = 1;
+		}
 		if (result == 0)
 			result = result2;
 	}
-	return result;
-}
-
-
-/* Close the device and release it. BKL is not needed: this is the only thread
-   accessing this tape. */
-static int st_release(struct inode *inode, struct file *filp)
-{
-	int result = 0;
-	struct scsi_tape *STp = filp->private_data;
 
 	if (STp->door_locked == ST_LOCKED_AUTO)
 		do_door_lock(STp, 0);
