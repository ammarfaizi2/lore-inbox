Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266605AbUGKOhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266605AbUGKOhz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 10:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266607AbUGKOhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 10:37:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20880 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266605AbUGKOhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 10:37:51 -0400
Date: Sun, 11 Jul 2004 16:38:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck kernel mailing list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040711143853.GA6555@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org> <40F016D9.8070300@kolivas.org> <20040711064730.GA11254@elte.hu> <40F14E53.2030300@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <40F14E53.2030300@kolivas.org>
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


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Con Kolivas <kernel@kolivas.org> wrote:

> Ok I've done one better than that ;) I had wli help make some
> instrumentation for me to help find the remaining non preemptible
> kernel portions and set the cutoff to 2ms. Here is what I found:
> 
> 7ms non-preemptible critical section violated 2 ms preempt threshold 
> starting at reiserfs_sync_fs+0x2d/0xc2 and ending at reiser
> fs_lookup+0xe2/0x221
> 
> 9ms non-preemptible critical section violated 2 ms preempt threshold 
> starting at reiserfs_dirty_inode+0x37/0x10e and ending at r
> eiserfs_dirty_inode+0xb0/0x10e
> 
> These seem to be the two offenders. Hope this helps.

great!

meanwhile i spent an afternoon with another latency testing suite:

  http://www.alsa-project.org/~iwai/latencytest-0.5.3.tar.gz

it was reporting more accurate latencies, except that there were strange
spikes of latencies. It turned out that for whatever reason, userspace
RDTSC is not always reliable on my box (!).

I've attached two fixes against latencytest - one makes rdtsc timestamps
more reliable, the other one fixes an SMP bug in the kernel module (it
would lock up under SMP otherwise.).

here's a latencytest QuickStart: 'cd latencytest; make', then
'insmod kernel/latency-test.ko', then 'cd tests; ../bin/run_tests'.  

Assuming you have RTC and audio enabled in your kernel it should work 
fine. It produces PNGs in the same format as Benno's latencytest suite.

	Ingo

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="latencytest-fixes.diff"

--- latencytest/kernel/latencytest.c.orig	2004-07-11 12:29:30.000000000 +0200
+++ latencytest/kernel/latencytest.c	2004-07-11 16:29:48.883109752 +0200
@@ -41,7 +41,7 @@ static void my_interrupt(void *private_d
 	spin_lock(&my_lock);
 	count++;
 	if (count < irq_count)
-		return;
+		goto out_unlock;
 	count = 0;
 	if (irq_info.processed < MAX_PROC_CNTS) {
 		int i;
@@ -69,6 +69,7 @@ static void my_interrupt(void *private_d
 	}
 	irq_info.processed++;
 	wake_up(&my_sleep);
+out_unlock:
 	spin_unlock(&my_lock);
 }
 
--- latencytest/src/measure.c.orig	2004-07-11 14:20:57.000000000 +0200
+++ latencytest/src/measure.c	2004-07-11 16:25:32.375104896 +0200
@@ -35,9 +35,13 @@ static FILE *profile_fd;
 
 static inline unsigned long long int rdtsc(void)
 {
-	unsigned long long int x;
-	__asm__ volatile ("rdtsc" : "=A" (x));
-	return x;
+	unsigned long long int x, y;
+	for (;;) {
+		__asm__ volatile ("rdtsc" : "=A" (x));
+		__asm__ volatile ("rdtsc" : "=A" (y));
+		if (y - x < 1000)
+			return y;
+	}
 }
 
 static unsigned long long time_offset;

--M9NhX3UHpAaciwkO--
