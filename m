Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269285AbUINNaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269285AbUINNaD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269382AbUINN20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:28:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:42959 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269347AbUINNYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:24:52 -0400
Date: Tue, 14 Sep 2004 15:25:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] sched: fix scheduling latencies in mtrr.c
Message-ID: <20040914132536.GA9742@elte.hu>
References: <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20040914112847.GA2804@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> fix scheduling latencies in the MTRR-setting codepath.
> Also, fix bad bug: MTRR's _must_ be set with interrupts disabled!

patch attached ...

caveat: one of the wbinvd() removals is correct i believe, but the other
one might be problematic. It doesnt seem logical to do a wbinvd() at
that point though ...

	Ingo

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-mtrr.patch"


fix scheduling latencies in the MTRR-setting codepath.
Also, fix bad bug: MTRR's _must_ be set with interrupts disabled!

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/cpu/mtrr/generic.c.orig	
+++ linux/arch/i386/kernel/cpu/mtrr/generic.c	
@@ -240,11 +240,14 @@ static void prepare_set(void)
 	/*  Note that this is not ideal, since the cache is only flushed/disabled
 	   for this CPU while the MTRRs are changed, but changing this requires
 	   more invasive changes to the way the kernel boots  */
-	spin_lock(&set_atomicity_lock);
+	/*
+	 * Since we are disabling the cache dont allow any interrupts - they
+	 * would run extremely slow and would only increase the pain:
+	 */
+	spin_lock_irq(&set_atomicity_lock);
 
 	/*  Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
 	cr0 = read_cr0() | 0x40000000;	/* set CD flag */
-	wbinvd();
 	write_cr0(cr0);
 	wbinvd();
 
@@ -266,8 +269,7 @@ static void prepare_set(void)
 
 static void post_set(void)
 {
-	/*  Flush caches and TLBs  */
-	wbinvd();
+	/*  Flush TLBs (no need to flush caches - they are disabled)  */
 	__flush_tlb();
 
 	/* Intel (P6) standard MTRRs */
@@ -279,7 +281,7 @@ static void post_set(void)
 	/*  Restore value of CR4  */
 	if ( cpu_has_pge )
 		write_cr4(cr4);
-	spin_unlock(&set_atomicity_lock);
+	spin_unlock_irq(&set_atomicity_lock);
 }
 
 static void generic_set_all(void)

--y0ulUmNC+osPPQO6--
