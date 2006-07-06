Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWGFL7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWGFL7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 07:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWGFL7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 07:59:08 -0400
Received: from spirit.analogic.com ([204.178.40.4]:35593 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030213AbWGFL7G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 07:59:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 06 Jul 2006 11:59:05.0695 (UTC) FILETIME=[949556F0:01C6A0F3]
Content-class: urn:content-classes:message
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Thu, 6 Jul 2006 07:59:04 -0400
Message-ID: <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
In-Reply-To: <20060706081639.GA24179@elte.hu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] spinlocks: remove 'volatile'
thread-index: Acag85Sep/QCA7L1Q0C4FFGnmm3Ygg==
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <arjan@infradead.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Jul 2006, Ingo Molnar wrote:

>
> * Linus Torvalds <torvalds@osdl.org> wrote:
>
>> I wonder if we should remove the "volatile". There really isn't
>> anything _good_ that gcc can do with it, but we've seen gcc code
>> generation do stupid things before just because "volatile" seems to
>> just disable even proper normal working.

Then GCC must be fixed. The keyword volatile is correct. It should
force the compiler to read the variable every time it's used.

>
> yeah. I tried this and it indeed slashed 42K off text size (0.2%):
>
> text            data    bss     dec             filename
> 20779489        6073834 3075176 29928499        vmlinux.volatile
> 20736884        6073834 3075176 29885894        vmlinux.non-volatile
>
> i booted the resulting allyesconfig bzImage and everything seems to be
> working fine. Find patch below.
>
> 	Ingo
>
> ------------------>
> Subject: spinlocks: remove 'volatile'
> From: Ingo Molnar <mingo@elte.hu>
>
> remove 'volatile' from the spinlock types, it causes gcc to
> generate really bad code. (and it's pointless anyway)
>

This is not pointless. If GCC generates bad code, tell the
GCC people. The volatile keyword is essential.


> this reduces the non-debug SMP kernel's size by 0.2% (!).
>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
> include/asm-i386/spinlock_types.h   |    4 ++--
> include/asm-x86_64/spinlock_types.h |    4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
>
> Index: linux/include/asm-i386/spinlock_types.h
> ===================================================================
> --- linux.orig/include/asm-i386/spinlock_types.h
> +++ linux/include/asm-i386/spinlock_types.h
> @@ -6,13 +6,13 @@
> #endif
>
> typedef struct {
> -	volatile unsigned int slock;
> +	unsigned int slock;
> } raw_spinlock_t;
>
> #define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
>
> typedef struct {
> -	volatile unsigned int lock;
> +	unsigned int lock;
> } raw_rwlock_t;
>
> #define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
> Index: linux/include/asm-x86_64/spinlock_types.h
> ===================================================================
> --- linux.orig/include/asm-x86_64/spinlock_types.h
> +++ linux/include/asm-x86_64/spinlock_types.h
> @@ -6,13 +6,13 @@
> #endif
>
> typedef struct {
> -	volatile unsigned int slock;
> +	unsigned int slock;
> } raw_spinlock_t;
>
> #define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
>
> typedef struct {
> -	volatile unsigned int lock;
> +	unsigned int lock;
> } raw_rwlock_t;
>
> #define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
