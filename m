Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbTIJJgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTIJJgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:36:24 -0400
Received: from hal-4.inet.it ([213.92.5.23]:13249 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S261278AbTIJJgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:36:22 -0400
Message-ID: <01c601c3777f$97c92680$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: <arjanv@redhat.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 11:40:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yes a copy of a page is about 3000 to 4000 cycles on an x86 box in the
> uncached case. A pagetable operation (like the cpu setting the accessed
> or dirty bit) is in that same order I suspect (maybe half this, but not
> a lot less). 

Probably you don't know what you're talking about.
I don't know where you studied computer architectures, but...
Let's answer.

To set the accessed or dirty bit you use

38         __asm__ __volatile__( LOCK_PREFIX
39                 "btsl %1,%0"
40                 :"=m" (ADDR)
41                 :"Ir" (nr));

which is a ***SINGLE CLOCK CYCLE*** of cpu.
I don't think really that on any machine Firmware 
a btsl will require 4000 cycles.
Neither on Intel x86.

> Changing pagetable content is even more because all the
> tlb's and internal cpu state will need to be flushed... which is also a
> microcode operation for the cpu. 

Good. The same overhead you will find accessing a message 
after a read form a pipe. There will occur many TLB faults.
And the same apply copying the message to the pipe.
Many many TLB faults.

> And it's deadly in an SMP environment.

You say "tlb's and internal cpu state will need to be flushed".
The other cpus in an SMP environment can continue to work, indipendently.
TLBs and cpu state registers are ***PER-CPU*** resorces.

Probably, it is worse the case of copying a memory page,
because you have to hold some global lock all the time.
This is deadly in an SMP environment, 
because critical section lasts for thousand of cycles, 
instead of simply a few.
