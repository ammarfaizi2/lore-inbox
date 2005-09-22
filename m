Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbVIVGNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVIVGNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbVIVGNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:13:10 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:15507 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S965238AbVIVGNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:13:09 -0400
Date: Thu, 22 Sep 2005 10:12:59 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@twiddle.net>
Subject: Re: Kernel panic during SysRq-b on Alpha
Message-ID: <20050922101259.A29179@jurassic.park.msu.ru>
References: <43315BEB.3010909@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <43315BEB.3010909@ens-lyon.org>; from Brice.Goglin@ens-lyon.org on Wed, Sep 21, 2005 at 03:11:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 03:11:07PM +0200, Brice Goglin wrote:
> Kernel bug at kernel/printk.c:683
> swapper(0): Kernel Bug 1
> pc = [<fffffc000032706c>]  ra = [<fffffc00004352d4>]  ps = 0007    Not
> tainted
> pc is at acquire_console_sem+0x2c/0x90

Indeed, acquire_console_sem() does BUG() in interrupt context now,
as in the case of SysRq-b.

Ivan.

--- linux/arch/alpha/kernel/process.c.orig	Mon Aug 29 03:41:01 2005
+++ linux/arch/alpha/kernel/process.c	Thu Sep 22 09:51:26 2005
@@ -127,6 +127,10 @@ common_shutdown_1(void *generic_ptr)
 	/* If booted from SRM, reset some of the original environment. */
 	if (alpha_using_srm) {
 #ifdef CONFIG_DUMMY_CONSOLE
+		/* If we've gotten here after SysRq-b, leave interrupt
+		   context before taking over the console. */
+		if (in_interrupt())
+			irq_exit();
 		/* This has the effect of resetting the VGA video origin.  */
 		take_over_console(&dummy_con, 0, MAX_NR_CONSOLES-1, 1);
 #endif
