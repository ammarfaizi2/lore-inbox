Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVJNSZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVJNSZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVJNSZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:25:06 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:26899 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750833AbVJNSZE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:25:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200510141350_MC3-1-ACA0-C8C9@compuserve.com>
References: <200510141350_MC3-1-ACA0-C8C9@compuserve.com>
X-OriginalArrivalTime: 14 Oct 2005 18:24:55.0718 (UTC) FILETIME=[939AC460:01C5D0EC]
Content-class: urn:content-classes:message
Subject: Re: [patch 2.6.14-rc4] i386: spinlock optimization
Date: Fri, 14 Oct 2005 14:24:54 -0400
Message-ID: <Pine.LNX.4.61.0510141409040.4395@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.14-rc4] i386: spinlock optimization
Thread-Index: AcXQ7JOh4VGh5E27QCG2A6I6GEL2yg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "Andi Kleen" <ak@suse.de>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Ingo Molnar" <mingo@elte.hu>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Oct 2005, Chuck Ebbert wrote:

> Attempt to acquire spinlock sooner after spinning and then noticing
> it has become available.  Also adds a slight delay before testing the
> spinlock again when it's not available, reducing bus traffic.
>
> This change makes spinlocks fairer in the case where the owner drops
> the lock and then immediately tries to take it again.
>
> Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>
> ---
>
> include/asm-i386/spinlock.h |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>
> --- 2.6.14-rc4a.orig/include/asm-i386/spinlock.h
> +++ 2.6.14-rc4a/include/asm-i386/spinlock.h
> @@ -28,8 +28,8 @@
> 	"2:\t" \
> 	"rep;nop\n\t" \
> 	"cmpb $0,%0\n\t" \
> -	"jle 2b\n\t" \
> -	"jmp 1b\n" \
> +	"jg 1b\n\t" \
> +	"jmp 2b\n" \
> 	"3:\n\t"
>
> #define __raw_spin_lock_string_flags \
> -


I just noticed in linux-2.6.13.4 that the spinlocks are wrong.
You are trying to optimize a path that should have been granted
in the first place:

Somehow, these spin-locks got all screwed up.

Given: nobody has the lock. The lock variable is 0.

#define spin_lock_string \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
 	"jns 3f\n" \		# This should have been 'js'
 	"2:\t" \
 	"rep;nop\n\t" \
 	"cmpb $0,%0\n\t" \
 	"jle 2b\n\t" \
 	"jmp 1b\n" \
 	"3:\n\t"		# Got the lock, exit loop


The spin-locks should have been:

#define spin_lock_string     \
 	"\n1:\t"             \
 	"lock ; decb %0\n\t" \	# Bump the lock variable
 	"js 2f\n\t"	     \	# Good, we got the lock
 	"lock ; incb %0\n\t" \  # Release your attempt __important__
 	"rep ; nop \n\t"     \	# pause
 	"jmp 1b\n"	     \	# Try again
 	"2:\n"			# Exit the lock


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.46 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
