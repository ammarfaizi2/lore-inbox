Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282271AbRLVUiD>; Sat, 22 Dec 2001 15:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282276AbRLVUhx>; Sat, 22 Dec 2001 15:37:53 -0500
Received: from mx2.elte.hu ([157.181.151.9]:1963 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282271AbRLVUhj>;
	Sat, 22 Dec 2001 15:37:39 -0500
Date: Sat, 22 Dec 2001 23:35:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ashok Raj <ashokr2@attbi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: affinity and tasklets...
In-Reply-To: <PPENJLMFIMGBGDDHEPBBIEKFCAAA.ashokr2@attbi.com>
Message-ID: <Pine.LNX.4.33.0112222327410.10048-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Dec 2001, Ashok Raj wrote:

> The natual affinity of tasklet execution is really the one iam trying
> to get away from.

some form of interrupt source is needed to load-balance IRQ load to other
CPUs - some other, unrelated processor wont just start executing the
necessery function, without that CPU getting interrupted in some way.
(polling is an option too, but that's out of question for a generic
solution.)

there are a number of solutions to this problem.

0) is it truly necessery to process the 3 virtual devices in parallel? Are
they independent and is the processing needed heavy enough that it demands
distribution between CPUs?

1) the hardware could generate real IRQs for the virtual devices too,
which would get load-balanced automatically. I suspect this is not an
option in your case, right?

2) the 'hard' IRQ you generate could be broadcasted to multiple CPUs at
once. Your IRQ handler would have the target CPU number hardcoded. This is
pretty inflexible and needs some lowlevel APIC code changes.

3) upon receiving the hard-IRQ, you could also trigger execution on other
CPUs, via smp_call_function().

i think #3 is the most generic solution. You'll have to do the
load-balancing by determining the target CPU of smp_call_function().

	Ingo

