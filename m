Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbVISTYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVISTYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVISTYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:24:38 -0400
Received: from urchin.mweb.co.za ([196.2.24.26]:55723 "EHLO urchin.mweb.co.za")
	by vger.kernel.org with ESMTP id S932601AbVISTYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:24:37 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: Segfaults in mkdir under high load. Software or hardware?
Date: Mon, 19 Sep 2005 21:27:33 +0200
User-Agent: KMail/1.8.91
Cc: linux-kernel@vger.kernel.org, andrew@walrond.org,
       bert.hubert@netherlabs.nl
References: <mailman.3.1127041200.14075.linux-kernel-daily-digest@lists.us.dell.com> <a06230970bf53b4a0dfad@[129.98.90.227]>
In-Reply-To: <a06230970bf53b4a0dfad@[129.98.90.227]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509192127.33611.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 September 2005 03:03, Maurice Volaski wrote:
> At 6:00 AM -0500 9/18/05,
>
> linux-kernel-daily-digest-request@lists.us.dell.com wrote:
> >>  I have been seeing a similar thing:
> >>
> >>  ./current:Sep 17 18:00:01 [kernel] mkdir[7696]: segfault at
> >>  0000000000000000 rip 000000000040184d rsp 00007fffff826350 error 4
> >>
> >>  I'm using the plain 2.6.13 (from gentoo vanilla sources), though it
> >>  was compiled with
> >>  gcc version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)
> >
> >x86_64 ? If so see http://bugzilla.kernel.org/show_bug.cgi?id=4851
>
> Dual Opteron, and this looks like my issue. It recommends echo 0 >
> /proc/sys/kernel/randomize_va_space but that has not stopped it from
> happening, so I'll probably wait for the patch to get merged.

Linus has a patch for that, which you might try. Look at 
http://bugzilla.kernel.org/show_bug.cgi?id=4851 for more details on this bug.

--- arch/x86_64/kernel/setup.c.orig     2005-09-18 07:34:36.000000000 +0200
+++ arch/x86_64/kernel/setup.c  2005-09-18 07:37:25.000000000 +0200
@@ -793,10 +793,23 @@ static void __init amd_detect_cmp(struct
 #endif
 }

+#define HWCR 0xc0010015
+
 static int __init init_amd(struct cpuinfo_x86 *c)
 {
        int r;
        int level;
+#if CONFIG_SMP
+       unsigned long value;
+       // Disable TLB flush filter by setting HWCR.FFDIS:
+       // bit 6 of msr C001_0015
+       //
+       // Errata 63 for SH-B3 steppings
+       // Errata 122 for all(?) steppings
+       rdmsrl(HWCR, value);
+       value |= 1 << 6;
+       wrmsrl(HWCR, value);
+#endif

        /* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
           3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */

