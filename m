Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276665AbRJKS2L>; Thu, 11 Oct 2001 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276682AbRJKS2B>; Thu, 11 Oct 2001 14:28:01 -0400
Received: from are.twiddle.net ([64.81.246.98]:35751 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S276680AbRJKS1q>;
	Thu, 11 Oct 2001 14:27:46 -0400
Date: Thu, 11 Oct 2001 11:28:10 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4.11-pre5] atomic_dec_and_lock() for alpha
Message-ID: <20011011112810.A1069@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011008194257.A705@jurassic.park.msu.ru> <20011008102412.A24348@twiddle.net> <20011009143013.A2884@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011009143013.A2884@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, Oct 09, 2001 at 02:30:13PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 02:30:13PM +0400, Ivan Kokshaysky wrote:
> OK. I prefer the latter - rewriting in assembly won't allow DEBUG_SPINLOCK
> stuff in this function. OTOH, moving the return outside an asm statement
> adds only one instruction - conditional branch that falls through in the
> fast path.

Hmm.  What about a mixture:


  asm (".text					\n\
	.global atomic_dec_and_lock		\n\
	.ent atomic_dec_and_lock		\n\
atomic_dec_and_lock:				\n\
	.prologue 0				\n\
1:	ldl_l	$1, 0($16)			\n\
	subl	$1, 1, $1			\n\
	beq	2f				\n\
	stl_c	$1, 0($16)			\n\
	beq	$1, 3f				\n\
	mb					\n\
	ret					\n\
	.align	4				\n\
3:	br	1b				\n\
2:	lda	$27, atomic_dec_and_lock_1");

	/* FALLTHRU */
	
static int
atomic_dec_and_lock_1(atomic_t *atomic, spinlock_t *lock)
{
	/* Slow path */
	spin_lock(lock);
	if (atomic_dec_and_test(atomic))
		return 1;
	spin_unlock(lock);
	return 0;
}


r~
