Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268467AbUJJUd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268467AbUJJUd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 16:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268468AbUJJUd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 16:33:28 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:28330 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S268467AbUJJUd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 16:33:26 -0400
Date: Sun, 10 Oct 2004 16:33:23 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
Message-ID: <20041010203323.GA3166@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: neroden@fastmail.fm (Nathanael Nerode)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some thread necromancy...

On Sun, 23 May 2004 02:20:58 +0000, Andrew Morton wrote:
>Willy Tarreau <willy <at> w.ods.org> wrote:
>>
>>  On Sun, May 23, 2004 at 09:13:20AM +0200, Arjan van de Ven wrote:
>>  > on first look it seems to be missing a bunch of get_user() calls and
>>  > does direct access instead....
>> 
>>  It was intentional for speed purpose. The areas are checked once with
>>  verify_area() when we need to access memory, then data is copied directly
>>  from/to memory. I don't think there's any risk, but I can be wrong.
>
>verify_area() simply checks that the address is a legal one for a userspace
>access (it's not a chunk of kernel memory).  But the kernel can still take
>a pagefault when accessing the address, so you need to use the uaccess
>functions which will handle the fault appropriately.
>
>That's put_user(), get_user(), copy_*_user(), etc.  Those functions
>internally perform verify_area(), so if you've already done a verify_area()
>you can use __put_user(), __get_user(), etc which skip the verify_area()
>but which still know how to deal with user address faults.

After reviewing the thread, this seems to be the most important reason
why this patch can't be included.  So I thought, "Hey, I'll fix that."

But put_user, get_user, etc. may sleep (of course).
They're also "user context only".

This is a hardware trap handler.  What sort of context is that?  Is
it really "user context"?  Worse, we're attempting to emulate an
*atomic* instruction (CMPXCHG).

So how do I guarantee:
(1) the original process doesn't get resumed during the sleep
(perhaps this is guaranteed by other things?)
(2) nobody else messes with the data we're messing with, so that this is
actually atomic.  (Note that we're assuming there's no SMP, because this
is an i386 and there are no known i386 SMP machines supported by Linux.
So the only problem is stuff woken during sleep.)  Basically, this means
no other process which might share the memory can be woken up during the
sleep either.  :-P

Is this possible, or hopelessly difficult?

-- 
This space intentionally left blank.
