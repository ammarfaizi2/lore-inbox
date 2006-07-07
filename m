Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWGGSp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWGGSp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGGSp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:45:56 -0400
Received: from smtp-out.google.com ([216.239.45.12]:37717 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932193AbWGGSpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:45:55 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=qH2wN2zWPiy34xhB4sA6y7REZAbuBwoP4cOlWOXo4k5essyO4KfpWm+3rMpaGSpK+
	DVT73DXDTqhhDQ61RDtRg==
Message-ID: <44AEAB7B.1060501@google.com>
Date: Fri, 07 Jul 2006 11:44:11 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] swap over NBD
References: <1152282398.12271.30.camel@taijtu>
In-Reply-To: <1152282398.12271.30.camel@taijtu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Peter Zijlstra wrote:
> Hi,
> 
> With this patch I cannot manage to deadlock the kernel with swapping
> over NBD. That is, using the now forced NOOP io-sched for the NBD queue.

But please do not propose this patch for inclusion without learning the
real reason for the deadlock.  Does it go back to deadlocking if you run
with NOOP, but just alloc a page before the sync_page and free it after?

> If another io-sched (say CFQ) is used (even with the coalescence limited
> to PAGE_SIZE) the kernel very quickly locks up with the faulting process
> stuck in D state like so:
> 
> 08927a14:  [<0805f8fc>] switch_to_skas+0x3c/0x90
> 08927a2c:  [<0805ba59>] _switch_to+0x49/0xa0
> 08927a50:  [<081fbb02>] schedule+0x2c2/0x590
> 08927aa0:  [<081fc67e>] io_schedule+0xe/0x20
> 08927aa8:  [<080a49c9>] sync_page+0x39/0x50
> 08927ab4:  [<081fc939>] __wait_on_bit_lock+0x49/0x70
> 08927ad4:  [<080a5213>] __lock_page+0x73/0x80
> 08927b04:  [<080b40ac>] do_swap_page+0x1ac/0x300
> 08927b40:  [<080b4867>] __handle_mm_fault+0x107/0x280
> 08927b78:  [<0805e6d2>] handle_page_fault+0x142/0x280
> 08927ba8:  [<0805ea07>] segv+0x177/0x2e0
> 08927c5c:  [<0805e87f>] segv_handler+0x6f/0x80
> 08927c80:  [<080750e3>] user_signal+0x53/0x70
> 08927c98:  [<08074470>] userspace+0x1d0/0x370
> 08927cf8:  [<0805f9fb>] new_thread_handler+0xab/0xc0
> 08927d1c:  [<ffffe420>] _etext+0xf7dfe403/0x0
>         
> and occasionally other processes stuck in D state like so:
> 
> 089d7810:  [<0805f8fc>] switch_to_skas+0x3c/0x90
> 089d7828:  [<0805ba59>] _switch_to+0x49/0xa0
> 089d784c:  [<081fbb02>] schedule+0x2c2/0x590
> 089d789c:  [<081fc67e>] io_schedule+0xe/0x20
> 089d78a4:  [<0816e647>] get_request_wait+0xf7/0x120
> 089d78e8:  [<0816f24f>] __make_request+0x9f/0x430
> 089d792c:  [<0816f771>] generic_make_request+0xf1/0x180
> 089d7970:  [<0816f853>] submit_bio+0x53/0x140
> 089d79d0:  [<080bb60e>] swap_writepage+0x9e/0xd0
> 089d79f4:  [<080aed89>] pageout+0xa9/0x140
> 089d7a3c:  [<080af19a>] shrink_page_list+0x2ba/0x440
> 089d7abc:  [<080af4d4>] shrink_inactive_list+0xb4/0x310
> 089d7b50:  [<080afbfb>] shrink_zone+0x9b/0x100
> 089d7b78:  [<080b0154>] balance_pgdat+0x264/0x390
> 089d7be0:  [<080b030d>] kswapd+0x8d/0xc0
> 089d7c18:  [<08095a86>] kthread+0xb6/0xc0
> 089d7c48:  [<0806f8e7>] run_kernel_thread+0x37/0x60
> 089d7cf8:  [<0805f9e1>] new_thread_handler+0x91/0xc0
> 089d7d1c:  [<ffffe420>] _etext+0xf7dfe403/0x0
> 
> I must admit to not having figured out why the faulting process gets
> stuck on sync_page() like it does. What I initially thought was that it
> might be waiting to lock a page stuck in an elevator plug, however it
> does look like sync_page() calls __generic_unplug_device() after some
> indirection.

This is not about lock_page.  Whatever was supposed to wake up the
process sleeping in io_schedule didn't, perhaps because it was trying
to allocate memory at the time, and still is.

> Also note that with all recorded lockups the free page count is larger
> than the min watermark, and sometimes even larger than the high
> watermark.

The allocating process is probably in shrink_caches which doesn't check
the free page counts, it uses some other mystical criterea to decide
when to stop, so this in itself does not let out the possibility of a
memory allocation deadlock.

What was supposed to do the wakeup, is this supposed to be driven by
an endio completion?  Theory: the io completion wakes up something that
was supposed to wake up the process in IO wait, but which tried to
allocate memory and got blocked forever.

Above we can see what kswapd is doing, it is deadlocked as I would
expect.  Is it sometimes not deadlocked?  Sleeping instead?

> (These traces were obtained using UML, real machines give similar
> results)
> 
> Other than this as of yet unexplained behaviour, the patch does make
> sense in that:
>  - IO scheduling is best done on the server end of NBD;
>  - not coalescing requests keeps the memory needs constant.
>    (without this change one very quickly ends up in the classical
>     VM deadlock)

All true, but.  There is a special place in hell for those who make
bugs go away without knowing what caused them in the first place.  I
am not implying that you are such a person of course.

Regards,

Daniel
