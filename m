Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbUKRTNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUKRTNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUKRTLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:11:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31952 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262907AbUKRTKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:10:33 -0500
Date: Thu, 18 Nov 2004 20:10:02 +0100
From: Jens Axboe <axboe@suse.de>
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Linux 2.6.10-rc2 OOPS on boot with 3ware + reiserfs
Message-ID: <20041118191002.GO26240@suse.de>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041117165851.GA18044@tentacle.sectorb.msk.ru> <Pine.LNX.4.58.0411170935040.2222@ppc970.osdl.org> <20041118103526.GC26240@suse.de> <20041118160248.GA5922@tentacle.sectorb.msk.ru> <20041118183920.GL26240@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118183920.GL26240@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18 2004, Jens Axboe wrote:
> On Thu, Nov 18 2004, Vladimir B. Savkin wrote:
> > On Thu, Nov 18, 2004 at 11:35:26AM +0100, Jens Axboe wrote:
> > > On Wed, Nov 17 2004, Linus Torvalds wrote:
> > > > 
> > > > Jens, did you see this one?
> > > 
> > > Vladimir, is this completely reproducable? Does -rc1 work correctly (or
> > > which was the last version you tested)? I haven't been able to spot any
> > > errors in this path so far.
> > 
> > It happens 100% when smartd tries to fetch SMART info from
> > disks connected to 3ware controller.
> > Seems like using obsolete 3ware API has something to do with this.
> > It does happen with -rc1 too.
> > Here is a complete dmesg output:
> 
> Really looks like a double requeue, bet it happens because we end up
> requeing both from the failed queuecommand return and from scsi_done().
> I'll take a look.

It is a double requeue. The SCSI path looks really messy (and buggy
there). What happens is that the host queuecommand sets DID_ERROR and
calls scsi_done() on the command, which may decide the commands need
retrying and thus requeue it. Upon return from queuecommand, the SCSI
layer initiates a requeue of the request because queuecommand returned
1. Double requeue, request list is now screwed.

James, it looks like the queuecommand returns need an overhaul so it's
clear who does what and when.

You can work around the issue with this patch (I hope, not tested), I'll
see if I can scrub the paths a little.

--- linux-2.6.10-rc2-mm1/drivers/scsi/3w-xxxx.c~	2004-11-18 20:03:27.945527140 +0100
+++ linux-2.6.10-rc2-mm1/drivers/scsi/3w-xxxx.c	2004-11-18 20:10:01.249255049 +0100
@@ -2053,6 +2053,11 @@
 			break;
 		case TW_IOCTL:
 			printk(KERN_WARNING "3w-xxxx: SCSI_IOCTL_SEND_COMMAND deprecated, please update your 3ware tools.\n");
+			tw_dev->state[request_id] = TW_S_COMPLETED;
+			tw_state_request_finish(tw_dev, request_id);
+			SCpnt->result = DID_ABORT << 16;
+			done(SCpnt);
+			reval = 0;
 			break;
 		default:
 			printk(KERN_NOTICE "3w-xxxx: scsi%d: Unknown scsi opcode: 0x%x\n", tw_dev->host->host_no, *command);

-- 
Jens Axboe

