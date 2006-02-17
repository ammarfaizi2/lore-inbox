Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWBQSpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWBQSpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 13:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWBQSpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 13:45:41 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:10124 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751123AbWBQSpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 13:45:39 -0500
Date: Fri, 17 Feb 2006 13:45:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] gdth.c: Adjustment for notifier-chain update
In-Reply-To: <20060216154609.747156a8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0602171335420.6533-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as654) adds a line to gdth.c that was removed by accident as
part of the big notifier-chain update patch series.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

On Thu, 16 Feb 2006, Andrew Morton wrote:

> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Notifier chain re-implementation (as636b): Two notifier chain callout
> > routines try to unregister themselves.  The new blocking-notifier API
> > does not support this, so this patch fixes the problem by adding a new
> > flag.
> 
> gdth.c has undergone a lot of rework due to a patch from Christoph Hellwig.
> That patch is fairly speculative, so my staging of your patch after his has
> put a perhaps unreasonable dependency on the notifier patches.
> 
> Still, I'll leave it as-is for now, but we may need to rejig things later.
> 
> Please review gdth.c in next -mm, make sure that the notifier changes in there
> still make sense (Or check the attached)

The patched source file for gdth.c you sent wasn't quite right.  The
reboot-notifier block was registered but never unregistered!  An extra
line of code got removed by mistake; this patch puts it back.

The driver has other issues -- it uses the old SCSI host model and it's 
subject to races as a result.  Really the notifier block should be 
registered when the module initializes and unregistered when the module 
exits.  But at least this will now be no worse than it was before.

Alan Stern

--- a/drivers/scsi/gdth.c	2006-02-17 13:27:28.000000000 -0500
+++ b/drivers/scsi/gdth.c	2006-02-17 13:32:29.000000000 -0500
@@ -4729,6 +4729,7 @@ static int gdth_release(struct Scsi_Host
             del_timer(&gdth_timer);
 #endif
             unregister_chrdev(major,"gdth");
+            unregister_reboot_notifier(&gdth_notifier);
         }
     }
 

