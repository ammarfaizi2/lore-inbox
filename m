Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135969AbRD0CvJ>; Thu, 26 Apr 2001 22:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135970AbRD0Cu7>; Thu, 26 Apr 2001 22:50:59 -0400
Received: from Scylla.Math.McGill.CA ([132.206.150.17]:12651 "EHLO
	scylla.math.mcgill.ca") by vger.kernel.org with ESMTP
	id <S135969AbRD0Cum>; Thu, 26 Apr 2001 22:50:42 -0400
Date: Thu, 26 Apr 2001 22:50:53 -0400 (EDT)
From: Sebastien LOISEL <loisel@scylla.math.mcgill.ca>
To: linux-kernel@vger.kernel.org
cc: loisel@math.mcgill.ca
Subject: FPU and exceptions
Message-ID: <Pine.SGI.3.96.1010426222127.1239514C-100000@scylla.math.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize in advance if this issue is a result of my stupidity. I would
like to know if it is. Also, this may or may not be an x86-specific
problem.

Short Version
=============

First, let me give you the short version. I have problems with FPU
exceptions on x86 Linux. I need to be able to handle them other than core
dumping. I am a skilled programmer and I can fix this myself if it hasn't
been done yet, but I need some direction. I am unfamiliar with the kernel
and I would appreciate if those who are would lend me a helping hand.

Please CC me in your replies.

Long Version
============

I am a graduate student in pure mathematics. I have a computer proof of a
theorem. This program is FPU intensive and so I've had to deal with
certain problems that others might have been able to ignore.

Occasionally, the FPU can emit exceptions. For instance, if an infinite
quantity is multiplied by zero, or if two very small quantities are
multiplied yielding something so small as to be indistinguishable from
zero, an exception is thrown.

These exceptions can, in principle, be caught (by using signal() or
sigaction()). However, I was having problems catching them: I kept core
dumping (or bus faulting? whatever.) The signals weren't being caught.

After searching on the web I found some vague reference to linuxthreads
preventing me from catching these exceptions. Is that what it is?

In my case, I am using something called an "interval arithmetic library".
(More precisely, Profil/BIAS.) This is the only way we have right now of
making computer proofs that hold water even with floating point. Each real
number is instead represented by an interval [a,b] (where a and b are
ordinary 64 bit doubles.) We do all arithmetic operations on such
intervals very carefully, so when we have the final interval, it is a
strictly conservative "proof" interval.

For instance, if we want to add [a,b]+[c,d], then we proceed as follows.
First we put the FPU into round-down mode and compute x=a+c, then we put
the FPU into round-up mode and compute y=b+d. Then we return [x,y] for the
interval of confidence. This ensures that roundoff does not destroy the
proof.

In round-up mode, instead of core dumping on FPE_FLTUND, the we should
instead return the smallest positive number that we can represent (call it
+EPSILON). In round-down mode, we should return the smallest negative
number possible (-EPSILON). Similar behavior needs to be defined for other
possible exceptions. Even certain things that look illegal can be handled
in my case. The actual, continuous version of the problem never "divides
by zero" or attempts to take the square root of negative numbers. If a
division appears to be a division by zero, the appropriate large intervals
should be returned. For instance, [1,2]/[-1,3]=[-infinity,+infinity].

Note that I've already completed a large part of the project and submitted
it for my Master's Thesis but there are some remaining parts and this is
causing me problems because I have to distribute the jobs over a large
number of machines and core dumps disrupt the computations. Manual
intervention is required to recover, especially since repeating the exact
same computations will yield a core dump again.

Thank you very much for your help,

Sebastien Loisel -- http://www.loisel.org/
Graduate Student in Mathematics -- McGill University
Graphics Architect -- Nvidia Corporation

