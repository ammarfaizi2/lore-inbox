Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266652AbSKOSt1>; Fri, 15 Nov 2002 13:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266654AbSKOSt1>; Fri, 15 Nov 2002 13:49:27 -0500
Received: from fmr02.intel.com ([192.55.52.25]:51683 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266652AbSKOSt0> convert rfc822-to-8bit; Fri, 15 Nov 2002 13:49:26 -0500
content-class: urn:content-classes:message
Subject: [PATCH] 2.5.47 Minor bug in non-fatal machine check
Date: Fri, 15 Nov 2002 10:56:20 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E0E2@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
X-MS-Has-Attach: 
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.5.47 Minor bug in non-fatal machine check
Thread-Index: AcKM2K9BsgsS9OxORMe2ZcgYZu/udA==
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Dave Jones" <davej@codemonkey.org.uk>, <torvalds@transmeta.com>
X-OriginalArrivalTime: 15 Nov 2002 18:56:20.0637 (UTC) FILETIME=[AF9494D0:01C28CD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A minor bug in nonfatal mcheck code. Non fatal machine check won't find any MCE faults in CONFIG_SMP and num_online_cpus==1 case, as mce_checkregs() will not be called at all. Attached patch should fix this. 

Thanks,
-Venkatesh



--- linux-2.5.47/arch/i386/kernel/cpu/mcheck/non-fatal.c.org	Wed Nov 13 13:17:57 2002
+++ linux-2.5.47/arch/i386/kernel/cpu/mcheck/non-fatal.c	Wed Nov 13 13:24:45 2002
@@ -49,7 +49,6 @@
 
 static void do_mce_timer(void *data)
 { 
-	mce_checkregs (NULL);
 	smp_call_function (mce_checkregs, NULL, 1, 1);
 } 
 
@@ -57,11 +56,10 @@
 
 static void mce_timerfunc (unsigned long data)
 {
+	mce_checkregs (NULL);
 #ifdef CONFIG_SMP
 	if (num_online_cpus() > 1) 
 		schedule_work (&mce_work); 
-#else
-	mce_checkregs (NULL);
 #endif
 	mce_timer.expires = jiffies + MCE_RATE;
 	add_timer (&mce_timer);


