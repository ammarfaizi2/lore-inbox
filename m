Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUFDJpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUFDJpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUFDJpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:45:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30087 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265691AbUFDJnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:43:09 -0400
Date: Fri, 4 Jun 2004 11:42:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040604094256.GM1946@suse.de>
References: <1085689455.7831.8.camel@localhost> <200405271928.33451.edt@aei.ca> <200406032207.25602.edt@aei.ca> <20040603193107.54308dc9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603193107.54308dc9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03 2004, Andrew Morton wrote:
> Ed Tomlinson <edt@aei.ca> wrote:
> >
> > Hi,
> > 
> > I am still getting these ide errors with 7-rc2-mm2.  I  get the errors even
> > if I mount with barrier=0 (or just defaults).  It would seem that something is 
> > sending my drive commands it does not understand...  
> > 
> > May 27 18:18:05 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > May 27 18:18:05 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> > 
> > How can we find out what is wrong?
> > 
> > This does not seem to be an error that corrupts the fs, it just slows things 
> > down when it hits a group of these.  Note that they keep poping up - they
> > do stop (I still get them hours after booting).
> 
> Jens, do we still have the command bytes available when this error hits?

It's not trivial, here's a hack that should dump the offending opcode
though.

--- linux-2.6.7-rc2-mm2/drivers/ide/ide.c~	2004-06-04 11:32:49.286777112 +0200
+++ linux-2.6.7-rc2-mm2/drivers/ide/ide.c	2004-06-04 11:41:47.338870307 +0200
@@ -438,6 +438,30 @@
 #endif	/* FANCY_STATUS_DUMPS */
 		printk("\n");
 	}
+	{
+		struct request *rq;
+		int opcode = 0x100;
+
+		spin_lock(&ide_lock);
+		rq = HWGROUP(drive)->rq;
+		spin_unlock(&ide_lock);
+		if (!rq)
+			goto out;
+		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
+			char *args = rq->buffer;
+			if (args)
+				opcode = args[0];
+		} else if (rq->flags & REQ_DRIVE_TASKFILE) {
+			ide_task_t *args = rq->special;
+			if (args) {
+				task_struct_t *tf = (task_struct_t *) args->tfRegister;
+				opcode = tf->command;
+			}
+		}
+
+		printk("ide: failed opcode was %x\n", opcode);
+	}
+out:
 	local_irq_restore(flags);
 	return err;
 }

-- 
Jens Axboe

