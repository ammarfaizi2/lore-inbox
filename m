Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281926AbRLWQgY>; Sun, 23 Dec 2001 11:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282511AbRLWQgO>; Sun, 23 Dec 2001 11:36:14 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:29116 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S281926AbRLWQgG>; Sun, 23 Dec 2001 11:36:06 -0500
From: "Ashok Raj" <ashokr2@attbi.com>
To: <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: affinity and tasklets...
Date: Sun, 23 Dec 2001 08:35:49 -0800
Message-ID: <PPENJLMFIMGBGDDHEPBBKELMCAAA.ashokr2@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0112222327410.10048-100000@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#3 seems like the best fit, and we can load balance to some extent ourself.

#2: You got it right. The hw is designed to generate a fewer # of
interrupts, since the information necessary is available in other means, and
there is a lot of time saved by not taking the interrupt.

I will give #3 a try and let you folks know.

ashokr
-----Original Message-----
From: mingo@localhost.localdomain [mailto:mingo@localhost.localdomain]On
Behalf Of Ingo Molnar
Sent: Saturday, December 22, 2001 2:35 PM
To: Ashok Raj
Cc: linux-kernel@vger.kernel.org
Subject: RE: affinity and tasklets...



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

