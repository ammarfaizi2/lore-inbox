Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSLBSY6>; Mon, 2 Dec 2002 13:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbSLBSY6>; Mon, 2 Dec 2002 13:24:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32019 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264705AbSLBSYz>;
	Mon, 2 Dec 2002 13:24:55 -0500
Message-ID: <3DEBA732.7000906@pobox.com>
Date: Mon, 02 Dec 2002 13:32:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] Re: [BUG]2.5.49-ac1 - more info on make error
References: <Pine.LNX.4.44.0211271540270.7715-201000@bilbo.tmr.com> <20021202182213.GC775@fs.tum.de>
In-Reply-To: <20021202182213.GC775@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------000906050701090701020701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000906050701090701020701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> On Wed, Nov 27, 2002 at 03:45:24PM -0500, Bill Davidsen wrote:
> ./drivers/net/tulip/de2104x.o(.data+0x74): undefined reference to `local 
> symbols in discarded section .exit.text'
> 
> 
> In drivers/net/tulip/de2104x.c the function de_remove_on is __exit but 
> the pointer to it is __devexit_p.
> 
> Two possible solutions:
> 
> 1. Make this driver hot-pluggable. Jeff Garzik vetoes against this 
>    solution.
> 
> 2. Change the __devexit_p to an #ifdef MODULE (it's ugly, but it lets
>    the driver compiles with all combinations of config options without
>    making it hot-pluggable):


As noted in the #warning, solution 3 (__exit_p) is the preferred one ;-)

Bill Irwin wrote up the patch to fix things The Right Way(tm).  The 
attached patch from Bill should eliminate all compile errors and warnings.

	Jeff



--------------000906050701090701020701
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"


This patch fixes tulip up by doing the following things:
(1) add __exit_p() to <linux/init.h>
(2) add the unused attributed to __exit routines for non-modules
(3) use __exit_p() to refer to de_remove_one()
(4) remove redundant timer initialization preceding variable initialization

 drivers/net/tulip/de2104x.c |    4 +---
 include/linux/init.h        |   13 ++++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)


--- linux-2.5.49-mm1/include/linux/init.h	Fri Nov 22 13:40:14 2002
+++ linux-2.5.49-mm2/include/linux/init.h	Wed Nov 27 15:32:17 2002
@@ -42,10 +42,15 @@
    discard it in modules) */
 #define __init		__attribute__ ((__section__ (".init.text")))
 #define __initdata	__attribute__ ((__section__ (".init.data")))
-#define __exit		__attribute__ ((__section__(".exit.text")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute__ ((unused,__section__ (".exitcall.exit")))
 
+#ifdef MODULE
+#define __exit		__attribute__ ((__section__(".exit.text")))
+#else
+#define __exit		__attribute__ ((unused,__section__(".exit.text")))
+#endif
+
 /* For assembly routines */
 #define __INIT		.section	".init.text","ax"
 #define __FINIT		.previous
@@ -199,6 +204,12 @@ extern struct kernel_param __setup_start
 #define __devexit_p(x) x
 #else
 #define __devexit_p(x) NULL
+#endif
+
+#ifdef MODULE
+#define __exit_p(x) x
+#else
+#define __exit_p(x) NULL
 #endif
 
 #endif /* _LINUX_INIT_H */
--- linux-2.5.49-mm1/drivers/net/tulip/de2104x.c	Fri Nov 22 13:40:56 2002
+++ linux-2.5.49-mm2/drivers/net/tulip/de2104x.c	Wed Nov 27 14:31:11 2002
@@ -2014,7 +2014,6 @@ static int __init de_init_one (struct pc
 	dev->watchdog_timeo = TX_TIMEOUT;
 
 	dev->irq = pdev->irq;
-	init_timer(&de->media_timer);
 
 	de = dev->priv;
 	de->de21040 = ent->driver_data == 0 ? 1 : 0;
@@ -2217,8 +2216,7 @@ static struct pci_driver de_driver = {
 	.name		= DRV_NAME,
 	.id_table	= de_pci_tbl,
 	.probe		= de_init_one,
-#warning only here to fix build.  should be __exit_p not __devexit_p.
-	.remove		= __devexit_p(de_remove_one),
+	.remove		= __exit_p(de_remove_one),
 #ifdef CONFIG_PM
 	.suspend	= de_suspend,
 	.resume		= de_resume,



--------------000906050701090701020701--

