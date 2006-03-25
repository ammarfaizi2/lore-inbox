Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWCYMGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWCYMGM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWCYMGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:06:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751376AbWCYMGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:06:10 -0500
Date: Sat, 25 Mar 2006 04:02:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zoltan Menyhart <Zoltan.Menyhart@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unlock_buffer() and clear_bit()
Message-Id: <20060325040233.1f95b30d.akpm@osdl.org>
In-Reply-To: <44247FAB.3040202@free.fr>
References: <44247FAB.3040202@free.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Menyhart <Zoltan.Menyhart@free.fr> wrote:
>
> I'm afraid "unlock_buffer()" works incorrectly
> (at least on the ia64 architecture).
> 
> As far As I can see, nothing makes it sure that data modifications
> issued inside the critical section be globally visible before the
> "BH_Lock" bit gets cleared.
> 
> When we acquire a resource, we need the "acq" semantics, when we
> release the resource, we need the "rel" semantics (obviously).
> 
> Some architectures (at least the ia64) require explicit operations
> to ensure these semantics, the ordinary "loads" and "stores" do not
> guarantee any ordering.
> 
> For the "stand alone" bit operations, these semantics do not matter.
> They are implemented by use of atomic operations in SMP mode, which
> operations need to follow either the "acq" semantics or the "rel"
> semantics (at least the ia64). An arbitrary choice was made to use
> the "acq" semantics.
> 
> We use bit operations to implement buffer locking.
> As a consequence, the requirement of the "rel" semantics, when we
> release the resource, is not met (at least on the ia64).
> 
> - Either an "smp_mb__before_clear_bit()" is lacking
>    (if we want to keep the existing definition of "clear_bit()"
>     with its "acq" semantics).
>    Note that "smp_mb__before_clear_bit()" is a bidirectional fence
>    operation on ia64, it is less efficient than the simple
>    "rel" semantics.
> 
> - Or a new bit clearing service needs to be added that includes
>    the "rel" semantics, say "release_N_clear_bit()"
>    (since we are actually _releasing_ a lock :-))
> 
> Thanks,
> 
> Zoltan Menyhart
> 
> 
> 
> buffer.c:
> 
> void fastcall unlock_buffer(struct buffer_head *bh)
> {
> 	clear_buffer_locked(bh);
> 	smp_mb__after_clear_bit();
> 	wake_up_bit(&bh->b_state, BH_Lock);
> }
> 
> 
> asm-ia64/bitops.h:
> 
> /*
>   * clear_bit() has "acquire" semantics.
>   */
> #define smp_mb__before_clear_bit()	smp_mb()
> #define smp_mb__after_clear_bit()	do { /* skip */; } while (0)
> 
> /**
>   * clear_bit - Clears a bit in memory
>   * @nr: Bit to clear
>   * @addr: Address to start counting from
>   *
>   * clear_bit() is atomic and may not be reordered.  However, it does
>   * not contain a memory barrier, so if it is used for locking purposes,
>   * you should call smp_mb__before_clear_bit() and/or 
> smp_mb__after_clear_bit()
>   * in order to ensure changes are visible on other processors.
>   */

alpha and powerpc define both of these as smp_mb().  sparc64 is similar,
but smarter.


atomic_ops.txt says:

	/* All memory operations before this call will
	 * be globally visible before the clear_bit().
	 */
	smp_mb__before_clear_bit();
	clear_bit( ... );

	/* The clear_bit() will be visible before all
	 * subsequent memory operations.
	 */
	 smp_mb__after_clear_bit();

So it would appear that to make all the modifications which were made to
the buffer visible after the clear_bit(), yes, we should be using
smp_mb__before_clear_bit();

unlock_page() does both...
