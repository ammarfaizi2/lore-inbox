Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267981AbUHKHlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267981AbUHKHlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 03:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267982AbUHKHlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 03:41:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36802 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267981AbUHKHlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 03:41:32 -0400
Date: Wed, 11 Aug 2004 09:42:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-ID: <20040811074256.GA5298@elte.hu>
References: <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe> <20040811073149.GA4312@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811073149.GA4312@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > (jackd/12427): 10882us non-preemptible critical section violated 400
> > us preempt threshold starting at kernel_fpu_begin+0x10/0x60 and ending
> > at fast_clear_page+0x75/0xa0
> 
> to make sure this is a real latency and not some rdtsc weirdness, could
> you try the latest version of preempt-timing:
> 
>  http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc3-O5-A2
> 
> this adds jiffies-based latency values to the printout, e.g.:

could you also apply the patch below? This splits up fast_clear_page()
overhead into 3 pieces to find out where the overhead comes from. Note
that this will likely cause 'reduced' latency printouts, but those are
not real because the touch_preempt_timing() lines dont show real
preemptible points. You should still get a larger latency in one of
those regions. The kernel-FPU code (which is triggered by the MMX ops)
could be another source of overhead - but 10 msecs is so large ...

(another thing: could you turn on CONFIG_DEBUG_HIGHMEM,
CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP? Lets make sure
that what we are seeing here is not somehow caused by atomicity
violations.)

	Ingo

--- linux/arch/i386/lib/mmx.c.orig
+++ linux/arch/i386/lib/mmx.c
@@ -132,7 +132,9 @@ static void fast_clear_page(void *page)
 {
 	int i;
 
+	touch_preempt_timing();	
 	kernel_fpu_begin();
+	touch_preempt_timing();	
 	
 	__asm__ __volatile__ (
 		"  pxor %%mm0, %%mm0\n" : :
@@ -158,7 +160,9 @@ static void fast_clear_page(void *page)
 	__asm__ __volatile__ (
 		"  sfence \n" : :
 	);
+	touch_preempt_timing();	
 	kernel_fpu_end();
+	touch_preempt_timing();	
 }
 
 static void fast_copy_page(void *to, void *from)
@@ -260,8 +264,10 @@ static void fast_copy_page(void *to, voi
 static void fast_clear_page(void *page)
 {
 	int i;
-	
+
+	touch_preempt_timing();	
 	kernel_fpu_begin();
+	touch_preempt_timing();	
 	
 	__asm__ __volatile__ (
 		"  pxor %%mm0, %%mm0\n" : :
@@ -290,7 +296,9 @@ static void fast_clear_page(void *page)
 		page+=128;
 	}
 
+	touch_preempt_timing();	
 	kernel_fpu_end();
+	touch_preempt_timing();	
 }
 
 static void fast_copy_page(void *to, void *from)
