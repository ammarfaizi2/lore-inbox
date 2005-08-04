Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVHDMTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVHDMTB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVHDMSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:18:54 -0400
Received: from barclay.balt.net ([195.14.162.78]:52104 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S262499AbVHDMRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:17:35 -0400
Date: Thu, 4 Aug 2005 15:16:04 +0300
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove suspend() calls from shutdown path
Message-ID: <20050804121604.GA4659@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <1123148187.30257.55.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123148187.30257.55.camel@gaston>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ben, Andrew, 

This patch helps me if I disconnect all USB peripherals before shutting
down notebook. With connected peripherals (USB mouse, PL2303
USB<->serial converter/port) - powering off process stops right after
unmounting filesystems but before hda power off ... 

There is a bug report for this too:
http://bugzilla.kernel.org/show_bug.cgi?id=4992

Z.

On Thu, Aug 04, 2005 at 11:36:26AM +0200, Benjamin Herrenschmidt wrote:
> Hi Andrew !
> 
> This patch remove the calls to device_suspend() from the shutdown path
> that were added sometime during 2.6.13-rc*. They aren't working properly
> on a number of configs (I got reports from both ppc powerbook users and
> x86 users) causing the system to not shutdown anymore.
> 
> I think it isn't the right approach at the moment anyway. We have
> already a shutdown() callback for the drivers that actually care about
> shutdown and the suspend() code isn't yet in a good enough shape to be
> so much generalized. Also, the semantics of suspend and shutdown are
> slightly different on a number of setups and the way this was patched in
> provides little way for drivers to cleanly differenciate. It should have
> been at least a different message.
> 
> For 2.6.13, I think we should revert to 2.6.12 behaviour and have a
> working suspend back.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Index: linux-work/kernel/sys.c
> ===================================================================
> --- linux-work.orig/kernel/sys.c	2005-08-01 14:03:46.000000000 +0200
> +++ linux-work/kernel/sys.c	2005-08-04 11:32:51.000000000 +0200
> @@ -404,7 +404,6 @@
>  {
>  	notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
>  	system_state = SYSTEM_HALT;
> -	device_suspend(PMSG_SUSPEND);
>  	device_shutdown();
>  	printk(KERN_EMERG "System halted.\n");
>  	machine_halt();
> @@ -415,7 +414,6 @@
>  {
>  	notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
>  	system_state = SYSTEM_POWER_OFF;
> -	device_suspend(PMSG_SUSPEND);
>  	device_shutdown();
>  	printk(KERN_EMERG "Power down.\n");
>  	machine_power_off();
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
