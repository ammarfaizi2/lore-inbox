Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWIOEmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWIOEmP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 00:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWIOEmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 00:42:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932068AbWIOEmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 00:42:14 -0400
Date: Thu, 14 Sep 2006 21:42:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] 8250: remove not needed NMI watchdog tickle in
 serial8250_console_write()
Message-Id: <20060914214210.9128e032.akpm@osdl.org>
In-Reply-To: <20060913205203.GC4787@cathedrallabs.org>
References: <20060913205203.GC4787@cathedrallabs.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 17:52:03 -0300
Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org> wrote:

> When touch_nmi_watchdog() was added to inside the wait loop in
> wait_for_xmitr()[1], where the long delays come from, a unneeded
> touch_nmi_watchdog() call was left in the beginning of
> serial8250_console_write() (introduced in
> 78512ece148992a5c00c63fbf4404f3cde635016) and this patch reverts it.
> 
> [1] http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/broken-out/tickle-nmi-watchdog-on-serial-output.patch
>     http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/broken-out/tickle-nmi-watchdog-on-serial-output-fix.patch
> [2] http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=78512ece148992a5c00c63fbf4404f3cde635016;hp=0ad775dbba12de3b7d25f586efe81ad995ca75a7
> 
> Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
> 
> --- mm.orig/drivers/serial/8250.c	2006-09-13 17:26:53.000000000 -0300
> +++ mm/drivers/serial/8250.c	2006-09-13 17:27:14.000000000 -0300
> @@ -2263,8 +2263,6 @@
>  	unsigned int ier;
>  	int locked = 1;
>  
> -	touch_nmi_watchdog();
> -
>  	local_irq_save(flags);
>  	if (up->port.sysrq) {
>  		/* serial8250_handle_port() already took the lock */

I disagree.

If characters are flowing out at a rate which consistently exceeds
one-per-ten-milliseconds, the touch_nmi_watchdog() in wait_for_xmitr() will
never be called.

Consequently a large interrupt-time write to the serial port (ie: sysrq-T
with serial-console enabled) will cause the NMI watchdog to trigger.

No?
