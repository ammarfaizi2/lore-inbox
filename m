Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVFTPnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVFTPnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFTPnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:43:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48029 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261353AbVFTPns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:43:48 -0400
Date: Mon, 20 Jun 2005 17:33:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-mm1 compile failure on PPC64
Message-ID: <20050620153322.GA4874@elte.hu>
References: <191640000.1119281438@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191640000.1119281438@[10.10.2.4]>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> kernel/built-in.o(.init.text+0x440): In function `.sched_cacheflush':
> : undefined reference to `.cacheflush'
> make: *** [.tmp_vmlinux1] Error 1
> 06/20/05-01:28:25 Build the kernel. Failed rc = 2
> 06/20/05-01:28:25 build: kernel build Failed rc = 1
> 06/20/05-01:28:25 command complete: (2) rc=126
> Failed and terminated the run
>  Fatal error, aborting autorun
> 
> Works with some configs, but not this one:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/p570
> 
> I'm guessing :
> 
> scheduler-cache-hot-autodetect.patch

the patch below (from akpm) should fix this:

From: Andrew Morton <akpm@osdl.org>

Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/sched.c~scheduler-cache-hot-autodetect-cacheflush-fix kernel/sched.c
--- 25/kernel/sched.c~scheduler-cache-hot-autodetect-cacheflush-fix	2005-06-18 08:38:26.000000000 -0600
+++ 25-akpm/kernel/sched.c	2005-06-18 08:38:43.000000000 -0600
@@ -5288,7 +5288,7 @@ __init static void sched_cacheflush(void
 	asm ("wbinvd");
 #elif defined(CONFIG_IA64)
 	ia64_sal_cache_flush(1); // what argument does d/cache flush?
-#elif defined(CONFIG_PPC64) || defined(CONFIG_PPC)
+#elif (defined(CONFIG_PPC64) || defined(CONFIG_PPC)) && defined(CONFIG_XMON)
 	cacheflush();
 #else
 # warning implement sched_cacheflush()! Calibration results may be unreliable.
_
