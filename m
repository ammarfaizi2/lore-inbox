Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbULBCQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbULBCQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 21:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbULBCQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 21:16:50 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:22223 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261611AbULBCQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 21:16:36 -0500
Message-ID: <41AE7AFE.2070807@mvista.com>
Date: Wed, 01 Dec 2004 20:16:30 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: minyard@mvista.com, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IPMI: use C99 struct inits.
References: <20041201114538.195ea302.rddunlap@osdl.org>
In-Reply-To: <20041201114538.195ea302.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.  Thank you; it's one of the things I've been meaning to do.

-Corey

Randy.Dunlap wrote:

>Convert IPMI driver struct usage to C99 initializers.
>
>Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
>
>diffstat:=
> drivers/char/ipmi/ipmi_msghandler.c |    6 +++---
> drivers/char/ipmi/ipmi_poweroff.c   |   12 +++++++++---
> drivers/char/ipmi/ipmi_watchdog.c   |   24 ++++++++++++------------
> 3 files changed, 24 insertions(+), 18 deletions(-)
>
>diff -Naurp ./drivers/char/ipmi/ipmi_msghandler.c~ipmi_c99 ./drivers/char/ipmi/ipmi_msghandler.c
>--- ./drivers/char/ipmi/ipmi_msghandler.c~ipmi_c99	2004-10-18 14:54:32.000000000 -0700
>+++ ./drivers/char/ipmi/ipmi_msghandler.c	2004-12-01 10:41:59.876793120 -0800
>@@ -3126,9 +3126,9 @@ static int panic_event(struct notifier_b
> }
> 
> static struct notifier_block panic_block = {
>-	panic_event,
>-	NULL,
>-	200   /* priority: INT_MAX >= x >= 0 */
>+	.notifier_call	= panic_event,
>+	.next		= NULL,
>+	.priority	= 200	/* priority: INT_MAX >= x >= 0 */
> };
> 
> static int ipmi_init_msghandler(void)
>diff -Naurp ./drivers/char/ipmi/ipmi_poweroff.c~ipmi_c99 ./drivers/char/ipmi/ipmi_poweroff.c
>--- ./drivers/char/ipmi/ipmi_poweroff.c~ipmi_c99	2004-10-18 14:54:32.000000000 -0700
>+++ ./drivers/char/ipmi/ipmi_poweroff.c	2004-12-01 11:01:54.147236416 -0800
>@@ -381,11 +381,17 @@ struct poweroff_function {
> };
> 
> static struct poweroff_function poweroff_functions[] = {
>-	{ "ATCA",    ipmi_atca_detect, ipmi_poweroff_atca },
>-	{ "CPI1",    ipmi_cpi1_detect, ipmi_poweroff_cpi1 },
>+	{ .platform_type	= "ATCA",
>+	  .detect		= ipmi_atca_detect,
>+	  .poweroff_func	= ipmi_poweroff_atca },
>+	{ .platform_type	= "CPI1",
>+	  .detect		= ipmi_cpi1_detect,
>+	  .poweroff_func	= ipmi_poweroff_cpi1 },
> 	/* Chassis should generally be last, other things should override
> 	   it. */
>-	{ "chassis", ipmi_chassis_detect, ipmi_poweroff_chassis },
>+	{ .platform_type	= "chassis",
>+	  .detect		= ipmi_chassis_detect,
>+	  .poweroff_func	= ipmi_poweroff_chassis },
> };
> #define NUM_PO_FUNCS (sizeof(poweroff_functions) \
> 		      / sizeof(struct poweroff_function))
>diff -Naurp ./drivers/char/ipmi/ipmi_watchdog.c~ipmi_c99 ./drivers/char/ipmi/ipmi_watchdog.c
>--- ./drivers/char/ipmi/ipmi_watchdog.c~ipmi_c99	2004-10-18 14:55:28.000000000 -0700
>+++ ./drivers/char/ipmi/ipmi_watchdog.c	2004-12-01 11:43:58.154528984 -0800
>@@ -518,9 +518,9 @@ static void panic_halt_ipmi_heartbeat(vo
> 
> static struct watchdog_info ident=
> {
>-	0, /* WDIOF_SETTIMEOUT, */
>-	1,
>-	"IPMI"
>+	.options	= 0,	/* WDIOF_SETTIMEOUT, */
>+	.firmware_version = 1,
>+	.identity	= "IPMI"
> };
> 
> static int ipmi_ioctl(struct inode *inode, struct file *file,
>@@ -748,9 +748,9 @@ static struct file_operations ipmi_wdog_
> };
> 
> static struct miscdevice ipmi_wdog_miscdev = {
>-	WATCHDOG_MINOR,
>-	"watchdog",
>-	&ipmi_wdog_fops
>+	.minor		= WATCHDOG_MINOR,
>+	.name		= "watchdog",
>+	.fops		= &ipmi_wdog_fops
> };
> 
> static DECLARE_RWSEM(register_sem);
>@@ -885,9 +885,9 @@ static int wdog_reboot_handler(struct no
> }
> 
> static struct notifier_block wdog_reboot_notifier = {
>-	wdog_reboot_handler,
>-	NULL,
>-	0
>+	.notifier_call	= wdog_reboot_handler,
>+	.next		= NULL,
>+	.priority	= 0
> };
> 
> extern int panic_timeout; /* Why isn't this defined anywhere? */
>@@ -915,9 +915,9 @@ static int wdog_panic_handler(struct not
> }
> 
> static struct notifier_block wdog_panic_notifier = {
>-	wdog_panic_handler,
>-	NULL,
>-	150   /* priority: INT_MAX >= x >= 0 */
>+	.notifier_call	= wdog_panic_handler,
>+	.next		= NULL,
>+	.priority	= 150	/* priority: INT_MAX >= x >= 0 */
> };
> 
> 
>
>
>---
>  
>

