Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWCXXYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWCXXYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWCXXYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:24:30 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:9349 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932259AbWCXXY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:24:29 -0500
Message-ID: <44247FAB.3040202@free.fr>
Date: Sat, 25 Mar 2006 00:24:27 +0100
From: Zoltan Menyhart <Zoltan.Menyhart@free.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: unlock_buffer() and clear_bit()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm afraid "unlock_buffer()" works incorrectly
(at least on the ia64 architecture).

As far As I can see, nothing makes it sure that data modifications
issued inside the critical section be globally visible before the
"BH_Lock" bit gets cleared.

When we acquire a resource, we need the "acq" semantics, when we
release the resource, we need the "rel" semantics (obviously).

Some architectures (at least the ia64) require explicit operations
to ensure these semantics, the ordinary "loads" and "stores" do not
guarantee any ordering.

For the "stand alone" bit operations, these semantics do not matter.
They are implemented by use of atomic operations in SMP mode, which
operations need to follow either the "acq" semantics or the "rel"
semantics (at least the ia64). An arbitrary choice was made to use
the "acq" semantics.

We use bit operations to implement buffer locking.
As a consequence, the requirement of the "rel" semantics, when we
release the resource, is not met (at least on the ia64).

- Either an "smp_mb__before_clear_bit()" is lacking
   (if we want to keep the existing definition of "clear_bit()"
    with its "acq" semantics).
   Note that "smp_mb__before_clear_bit()" is a bidirectional fence
   operation on ia64, it is less efficient than the simple
   "rel" semantics.

- Or a new bit clearing service needs to be added that includes
   the "rel" semantics, say "release_N_clear_bit()"
   (since we are actually _releasing_ a lock :-))

Thanks,

Zoltan Menyhart



buffer.c:

void fastcall unlock_buffer(struct buffer_head *bh)
{
	clear_buffer_locked(bh);
	smp_mb__after_clear_bit();
	wake_up_bit(&bh->b_state, BH_Lock);
}


asm-ia64/bitops.h:

/*
  * clear_bit() has "acquire" semantics.
  */
#define smp_mb__before_clear_bit()	smp_mb()
#define smp_mb__after_clear_bit()	do { /* skip */; } while (0)

/**
  * clear_bit - Clears a bit in memory
  * @nr: Bit to clear
  * @addr: Address to start counting from
  *
  * clear_bit() is atomic and may not be reordered.  However, it does
  * not contain a memory barrier, so if it is used for locking purposes,
  * you should call smp_mb__before_clear_bit() and/or 
smp_mb__after_clear_bit()
  * in order to ensure changes are visible on other processors.
  */

