Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVCVKcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVCVKcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVCVKcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:32:24 -0500
Received: from fmr23.intel.com ([143.183.121.15]:7390 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262608AbVCVK3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:29:39 -0500
Message-Id: <200503221029.j2MATNg12775@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Holger Kiehl'" <Holger.Kiehl@dwd.de>, "Andrew Morton" <akpm@osdl.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, "Moore, Eric  Dean" <emoore@lsil.com>
Subject: RE: Fusion-MPT much faster as module
Date: Tue, 22 Mar 2005 02:29:23 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUuuj4zk4Hr9m4GQuKTIz8je41DcwADChoQ
In-Reply-To: <Pine.LNX.4.61.0503220813290.17195@diagnostix.dwd.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Andrew Morton wrote:
> Holger, this problem remains unresolved, does it not?  Have you done any
> more experimentation?
>
> I must say that something funny seems to be happening here.  I have two
> MPT-based Dell machines, neither of which is using a modular driver:
>
> akpm:/usr/src/25> 0 hdparm -t /dev/sda
>
> /dev/sda:
> Timing buffered disk reads:  64 MB in  5.00 seconds = 12.80 MB/sec


Holger Kiehl wrote on Tuesday, March 22, 2005 12:31 AM
> Got the same result when compiled in, always between 12 and 13 MB/s. As
> module it is approx. 75 MB/s.


Half guess, half with data to prove: it must be the variable driver_setup
initialization.  If compiled as built-in, driver_setup is initialized to
zero for all of its member variables, which isn't the fastest setting. If
compiled as module, it gets first class treatment with shinny performance
setting.  Goofing around, this patch appears to be giving higher throughput.

Before:
/dev/sdc:
 Timing buffered disk reads:   92 MB in  3.03 seconds =  30.32 MB/sec

After:
/dev/sdc:
 Timing buffered disk reads:  174 MB in  3.02 seconds =  57.61 MB/sec


diff -Nurp linux-2.6.11/drivers/message/fusion/mptscsih.c linux-2.6.11.ken/drivers/message/fusion/mptscsih.c
--- linux-2.6.11/drivers/message/fusion/mptscsih.c	2005-03-01 23:38:37.000000000 -0800
+++ linux-2.6.11.ken/drivers/message/fusion/mptscsih.c	2005-03-22 02:18:21.000000000 -0800
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

@@ -1489,7 +1487,6 @@ mptscsih_init(void)
 		  ": Registered for IOC reset notifications\n"));
 	}

-#ifdef MODULE
 	dinitprintk((KERN_INFO MYNAM
 		": Command Line Args: dv=%d max_width=%d "
 		"factor=0x%x saf_te=%d\n",
@@ -1499,7 +1496,6 @@ mptscsih_init(void)
 	driver_setup.max_width = (width) ? 1 : 0;
 	driver_setup.min_sync_factor = factor;
 	driver_setup.saf_te = (saf_te) ? 1 : 0;;
-#endif

 	if(mpt_device_driver_register(&mptscsih_driver,
 	  MPTSCSIH_DRIVER) != 0 ) {


