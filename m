Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317953AbSFNQnO>; Fri, 14 Jun 2002 12:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317954AbSFNQnN>; Fri, 14 Jun 2002 12:43:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12553 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317952AbSFNQnM>; Fri, 14 Jun 2002 12:43:12 -0400
Date: Fri, 14 Jun 2002 09:43:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <20020614151703.GB1120@suse.de>
Message-ID: <Pine.LNX.4.44.0206140940240.2576-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jun 2002, Jens Axboe wrote:
>
> - current 2.5 bk deadlocks reading partition info off disk. Again a
>   locking problem I suppose, to be honest I just got very tired when
>   seeing it happen and didn't want to spend tim looking into it.

Hmm. There's a bug in "balance_irq()" if you are trying to run a SMP
kernel on an UP machine right now, and it _might_ be that the lockup has
nothing to do with the IDE layer, but simple with the first PCI interrupt
(as opposed to local timer interrupt) coming in.

One-liner from Zwane Mwaikambo (cut-and-paste, so space is wrong, please
apply by hand).

--- linux-2.5.19/arch/i386/kernel/io_apic.c.orig        Fri Jun 14 17:43:20 2002
+++ linux-2.5.19/arch/i386/kernel/io_apic.c     Fri Jun 14 17:42:23 2002
@@ -251,7 +251,7 @@
        irq_balance_t *entry = irq_balance + irq;
        unsigned long now = jiffies;

-       if (unlikely(entry->timestamp != now)) {
+       if ((entry->timestamp != now) && (smp_num_cpus > 1)) {
                unsigned long allowed_mask;
                int random_number;

I don't know. Might be the IDE code too, of course.

		Linus

