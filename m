Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWC1Kkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWC1Kkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 05:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWC1Kkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 05:40:41 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:23396 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932135AbWC1Kkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 05:40:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=GhVOmrrCq7VtXUcyuX+svlrxWK0rtVLoEExONahA/AoDfjrJmocWhjxT2MlMDWQflAOlPjKOK6Ls0ZDhAu8An1CBuoB7WdTNXHLyunJo2XS4b7g5KC8IJpLUdqJHgDMPI5K8Pzg5HQFghYyZjebACWzfGvA/4NjjnxbXynx587M=  ;
Message-ID: <4428EF8B.7040202@yahoo.com.au>
Date: Tue, 28 Mar 2006 18:10:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, Zoltan.Menyhart@free.fr, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <Pine.LNX.4.64.0603271953150.7469@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603271953150.7469@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Currently unlock_buffer() contains a smb_mb__after_clear_bit() which is 
> weird because bit_spin_unlock() uses smb_mb__before_clear_bit():
> 
>>From include/linux/bit_spinlock.h:
> 
> static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
> {
>         smp_mb__before_clear_bit();
>         clear_bit(bitnum, addr);
>         preempt_enable();
>         __release(bitlock);
> }
> 
> For most architectures there is no difference because both
> smp_mb__after_clear_bit() and smp_mb__before_clear_bit() are both
> memory barriers and clear_buffer_locked() is an atomic operation.
> However, they differ under IA64.
> 
> Note that this potential race has never been seen under IA64. It was 
> discovered by inspection by Zoltan Menyhart <Zoltan.Menyhart@free.fr>. 
> 
> Regardless if this is a true race or not, I think the unlock sequence 
> needs to be the same for bit locks and unlock_buffer(). Maybe 
> unlock_buffer and lock_buffer better use bit spinlock operations?
> 
> Change unlock_buffer() to work the same way as bit_spin_unlock.
> 

OK, that's fair enough and I guess you do need a barrier there.
However, should the mb__after barrier still remain? The comment
in wake_up_bit suggests yes, and there is similar code in
unlock_page.

Let's see... I guess the race is that the waitqueue load could be
completed the clearing of the bit becomes visible, so it may
appear to be empty, but another CPU may find the bit locked after
it has added the task to the waitqueue. I think?

Also, I think there is still the issue of ia64 not having the
correct memory consistency semantics. To start with, all the bitops
and atomic ops which both modify their operand and return a value
should be full memory barriers before and after the operation,
according to Documentation/atomic_ops.txt.

Secondly, I don't think smp_mb__before/after are just defined to
have aquire or relese semantics, but should be full barriers.

> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6/fs/buffer.c
> ===================================================================
> --- linux-2.6.orig/fs/buffer.c	2006-03-27 14:09:54.000000000 -0800
> +++ linux-2.6/fs/buffer.c	2006-03-27 19:40:32.000000000 -0800
> @@ -78,8 +78,8 @@ EXPORT_SYMBOL(__lock_buffer);
>  
>  void fastcall unlock_buffer(struct buffer_head *bh)
>  {
> +	smp_mb__before_clear_bit();
>  	clear_buffer_locked(bh);
> -	smp_mb__after_clear_bit();
>  	wake_up_bit(&bh->b_state, BH_Lock);
>  }
>  
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
