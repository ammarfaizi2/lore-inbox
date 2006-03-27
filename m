Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWC0IyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWC0IyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 03:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWC0IyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 03:54:14 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:4228 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750811AbWC0IyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 03:54:14 -0500
Message-ID: <4427A817.4060905@bull.net>
Date: Mon, 27 Mar 2006 10:53:43 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: unlock_buffer() and clear_bit()
References: <44247FAB.3040202@free.fr> <20060325040233.1f95b30d.akpm@osdl.org>
In-Reply-To: <20060325040233.1f95b30d.akpm@osdl.org>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/03/2006 10:55:59,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/03/2006 10:56:07,
	Serialize complete at 27/03/2006 10:56:07
Content-Type: multipart/mixed;
 boundary="------------080604000906000703020700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080604000906000703020700
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed

The patch is in the attached file.

Thanks,

Zoltan


Andrew Morton <akpm@osdl.org> wrote:

> Zoltan Menyhart <Zoltan.Menyhart@free.fr> wrote:
> 
>>I'm afraid "unlock_buffer()" works incorrectly
>>(at least on the ia64 architecture).
>>
>>As far As I can see, nothing makes it sure that data modifications
>>issued inside the critical section be globally visible before the
>>"BH_Lock" bit gets cleared.
>>
>>When we acquire a resource, we need the "acq" semantics, when we
>>release the resource, we need the "rel" semantics (obviously).
>>
>>Some architectures (at least the ia64) require explicit operations
>>to ensure these semantics, the ordinary "loads" and "stores" do not
>>guarantee any ordering.
>>
>>For the "stand alone" bit operations, these semantics do not matter.
>>They are implemented by use of atomic operations in SMP mode, which
>>operations need to follow either the "acq" semantics or the "rel"
>>semantics (at least the ia64). An arbitrary choice was made to use
>>the "acq" semantics.
>>
>>We use bit operations to implement buffer locking.
>>As a consequence, the requirement of the "rel" semantics, when we
>>release the resource, is not met (at least on the ia64).
>>
>>- Either an "smp_mb__before_clear_bit()" is lacking
>>   (if we want to keep the existing definition of "clear_bit()"
>>    with its "acq" semantics).
>>   Note that "smp_mb__before_clear_bit()" is a bidirectional fence
>>   operation on ia64, it is less efficient than the simple
>>   "rel" semantics.
>>
>>- Or a new bit clearing service needs to be added that includes
>>   the "rel" semantics, say "release_N_clear_bit()"
>>   (since we are actually _releasing_ a lock :-))
>>
>>Thanks,
>>
>>Zoltan Menyhart
>>
>>
>>
>>buffer.c:
>>
>>void fastcall unlock_buffer(struct buffer_head *bh)
>>{
>>	clear_buffer_locked(bh);
>>	smp_mb__after_clear_bit();
>>	wake_up_bit(&bh->b_state, BH_Lock);
>>}
>>
>>
>>asm-ia64/bitops.h:
>>
>>/*
>>  * clear_bit() has "acquire" semantics.
>>  */
>>#define smp_mb__before_clear_bit()	smp_mb()
>>#define smp_mb__after_clear_bit()	do { /* skip */; } while (0)
>>
>>/**
>>  * clear_bit - Clears a bit in memory
>>  * @nr: Bit to clear
>>  * @addr: Address to start counting from
>>  *
>>  * clear_bit() is atomic and may not be reordered.  However, it does
>>  * not contain a memory barrier, so if it is used for locking purposes,
>>  * you should call smp_mb__before_clear_bit() and/or 
>>smp_mb__after_clear_bit()
>>  * in order to ensure changes are visible on other processors.
>>  */
> 
> 
> alpha and powerpc define both of these as smp_mb().  sparc64 is similar,
> but smarter.
> 
> 
> atomic_ops.txt says:
> 
> 	/* All memory operations before this call will
> 	 * be globally visible before the clear_bit().
> 	 */
> 	smp_mb__before_clear_bit();
> 	clear_bit( ... );
> 
> 	/* The clear_bit() will be visible before all
> 	 * subsequent memory operations.
> 	 */
> 	 smp_mb__after_clear_bit();
> 
> So it would appear that to make all the modifications which were made to
> the buffer visible after the clear_bit(), yes, we should be using
> smp_mb__before_clear_bit();
> 
> unlock_page() does both...




--------------080604000906000703020700
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="buffer.diff"
Content-Disposition: inline;
 filename="buffer.diff"

--- save/fs/buffer.c	2006-03-27 10:39:53.000000000 +0200
+++ linux-2.6.16/fs/buffer.c	2006-03-27 10:40:46.000000000 +0200
@@ -78,6 +78,7 @@ EXPORT_SYMBOL(__lock_buffer);
 
 void fastcall unlock_buffer(struct buffer_head *bh)
 {
+	smp_mb__before_clear_bit();
 	clear_buffer_locked(bh);
 	smp_mb__after_clear_bit();
 	wake_up_bit(&bh->b_state, BH_Lock);

--------------080604000906000703020700--
