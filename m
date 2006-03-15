Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWCOAVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWCOAVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 19:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWCOAVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 19:21:11 -0500
Received: from hera.kernel.org ([140.211.167.34]:24708 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751262AbWCOAVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 19:21:09 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Module Ref Counting & ibmphp
Date: Tue, 14 Mar 2006 16:21:04 -0800
Organization: OSDL
Message-ID: <20060314162104.5370b20d@localhost.localdomain>
References: <20060314224700.41242.qmail@web52612.mail.yahoo.com>
	<20060315000212.GB6533@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1142382064 5828 10.8.0.54 (15 Mar 2006 00:21:04 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 15 Mar 2006 00:21:04 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006 16:02:12 -0800
Greg KH <greg@kroah.com> wrote:

> On Wed, Mar 15, 2006 at 09:47:00AM +1100, Srihari Vijayaraghavan wrote:
> > Before (in 2.6.16-rc*):
> > $ egrep 'ibmphp' /proc/modules
> > ibmphp 67809 4294967295 - Live 0xf8910000
> >              ^^^^^^^^^^
> > 
> > After [1]:
> > ibmphp 64224 0 - Live 0xf8965000
> >              ^
> > 
> > Of course, now I'm able to successfully unload ibmphp
> > (& subsequently load it too :)) without any
> > observeable problems.
> > 
> > It'd seem, thro struct hotplug_slot_ops, module ref
> > count for ibmphp is taken care of. No?
> 
> No.  I don't think this driver likes to be unloaded due to the
> instability of the hardware if that happens.  So let's just let it not
> be unloaded, and hope that the hardware can die in peace and never get
> put into any new machines...
> 
> thanks,
> 
> greg k-h

The proper way to prevent unloading is just not to have a module exit routine,
rather than causing ref count to be off. The the module subsystem will
mark it as unsafe to unload. Unless it wants to allow unsafe forced unload.
But IMHO either it needs to be safe to unload or not allow it.

--- linux-2.6/drivers/pci/hotplug/ibmphp_core.c.orig	2006-03-14 16:18:14.000000000 -0800
+++ linux-2.6/drivers/pci/hotplug/ibmphp_core.c	2006-03-14 16:19:12.000000000 -0800
@@ -1398,10 +1398,6 @@ static int __init ibmphp_init(void)
 		goto error;
 	}
 
-	/* lock ourselves into memory with a module 
-	 * count of -1 so that no one can unload us. */
-	module_put(THIS_MODULE);
-
 exit:
 	return rc;
 
@@ -1409,14 +1405,4 @@ error:
 	ibmphp_unload();
 	goto exit;
 }
-
-static void __exit ibmphp_exit(void)
-{
-	ibmphp_hpc_stop_poll_thread();
-	debug("after polling\n");
-	ibmphp_unload();
-	debug("done\n");
-}
-
 module_init(ibmphp_init);
-module_exit(ibmphp_exit);




