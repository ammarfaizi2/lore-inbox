Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVFHES1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVFHES1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 00:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVFHES1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 00:18:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:11668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262090AbVFHESU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 00:18:20 -0400
Date: Tue, 7 Jun 2005 21:18:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lars Roland <lroland@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fusion MPT driver version 3.01.20 VS. version 2.03.00
Message-Id: <20050607211804.5763993b.akpm@osdl.org>
In-Reply-To: <4ad99e050506071428278c3018@mail.gmail.com>
References: <4ad99e050506071428278c3018@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Roland <lroland@gmail.com> wrote:
>
>  We have a bunch of IBM 335/336 used as email (anti-virus/spam)
>  gateways. Recently our admin changed the kernel version from version
>  2.4.24 to 2.6.8.1 - this resulted in a massive performance
>  degradation. The old system could handle 60.000 emails pr. hour the
>  new one could only handle about 30.000 emails (this was tested by
>  sampling 60.000 emails and sending them to the server).
> 
>  After poking a bit around (changing hardware and upgrading bios's) I
>  realized that the time spend for writing the files to the disk have
>  gone up (multiple small writes seams to kill it)

The driver was broken for a while in a way which caused it to run slowly if
it was linked into the kernel image, but it runs OK if loaded as a module.

<digs around>

Here's a minimal patch - it fixes it, but iirc, this isn't what was merged.
(Or you could just use 2.6.12-rc6).

--- 25/drivers/message/fusion/mptscsih.c~mpt-fusion-speedup	2005-03-22 02:43:24.000000000 -0800
+++ 25-akpm/drivers/message/fusion/mptscsih.c	2005-03-22 02:43:24.000000000 -0800
@@ -96,7 +96,6 @@ MODULE_AUTHOR(MODULEAUTHOR);
 MODULE_DESCRIPTION(my_NAME);
 MODULE_LICENSE("GPL");
 
-#ifdef MODULE
 static int dv = MPTSCSIH_DOMAIN_VALIDATION;
 module_param(dv, int, 0);
 MODULE_PARM_DESC(dv, "DV Algorithm: enhanced = 1, basic = 0 (default=MPTSCSIH_DOMAIN_VALIDATION=1)");
@@ -112,7 +111,6 @@ MODULE_PARM_DESC(factor, "Min Sync Facto
 static int saf_te = MPTSCSIH_SAF_TE;
 module_param(saf_te, int, 0);
 MODULE_PARM_DESC(saf_te, "Force enabling SEP Processor: (default=MPTSCSIH_SAF_TE=0)");
-#endif
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 
@@ -1477,7 +1475,6 @@ mptscsih_init(void)
 		  ": Registered for IOC reset notifications\n"));
 	}
 
-#ifdef MODULE
 	dinitprintk((KERN_INFO MYNAM
 		": Command Line Args: dv=%d max_width=%d "
 		"factor=0x%x saf_te=%d\n",
@@ -1487,7 +1484,6 @@ mptscsih_init(void)
 	driver_setup.max_width = (width) ? 1 : 0;
 	driver_setup.min_sync_factor = factor;
 	driver_setup.saf_te = (saf_te) ? 1 : 0;;
-#endif
 
 	if(mpt_device_driver_register(&mptscsih_driver,
 	  MPTSCSIH_DRIVER) != 0 ) {
_

