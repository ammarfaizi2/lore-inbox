Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVH2NQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVH2NQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 09:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVH2NQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 09:16:50 -0400
Received: from magic.adaptec.com ([216.52.22.17]:49127 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750833AbVH2NQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 09:16:50 -0400
Message-ID: <43130AB9.3080805@adaptec.com>
Date: Mon, 29 Aug 2005 09:16:41 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
References: <1125159996.5159.8.camel@mulgrave>	 <20050827105355.360bd26a.akpm@osdl.org> <1125276312.5048.22.camel@mulgrave>	 <20050828175233.61cada23.akpm@osdl.org> <1125278389.5048.30.camel@mulgrave>	 <20050828183531.0b4d6f2d.akpm@osdl.org> <1125285994.5048.40.camel@mulgrave>	  <4312830C.8000308@yahoo.com.au> <1125287651.29493.3.camel@lade.trondhjem.org>
In-Reply-To: <1125287651.29493.3.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Aug 2005 13:16:44.0336 (UTC) FILETIME=[E6E14B00:01C5AC9B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/05 23:54, Trond Myklebust wrote:
> må den 29.08.2005 Klokka 13:37 (+1000) skreiv Nick Piggin:
> 
>>James Bottomley wrote:
>>
>>>On Sun, 2005-08-28 at 18:35 -0700, Andrew Morton wrote:
>>
>>>>It does make the tree higher and hence will incur some more cache missing
>>>>when descending the tree.
>>>
>>>
>>>Actually, I don't think it does:  the common user is the page tree.
>>>Obviously, I've changed nothing on 64 bits, so we only need to consider
>>>what I've done on 32 bits.  A page size is almost universally 4k on 32
>>>bit, so we need 20 bits to store the page tree index.  Regardless of
>>>whether the index size is 5 or 6, that gives a radix tree depth of 4.
>>>
>>
>>s/common/only ?
> 
> 
> grep again... I use it in the NFS client for bookkeeping requests.

Hey guys,

Take the posix-timers for example:

idr_remove() is called with spin_lock_irqsave()/spin_unlock_irqrestore(),
in release_posix_timer().

_But_, idr_pre_get() is called without any locks (as it should) which
calls alloc_layer() in the IDR code, grabbing a spinlock _internally_ (no IRQ).

If you're in the middle of idr_pre_get() inside the internally locked
section of alloc_layer(), _and_ you call idr_remove() at that same time
and (try to) enter free_layer(), you have a deadlock.

The reason no one has seen this is: _load_.  It wasn't until I started
doing mkfs simultaneously on 3 or more disks in a loop, that I saw this
problem.  I've a stack trace to show if anyone cares.

I'm not sure why no one sees this.

I'm also not sure why people are working on IDR when there is no
_pending_ need to improve this code (other than the deadlock I pointed out),
while SCSI Core has been in dire need of improvement for the last 5 years.

If SCSI Core developed in the same scheme as IDR is now: 
"no need, but its cool so I'll write it and my buddies will include the patch",
we would have a *T10 spec-ed out SCSI Core by now*.(1)

	Luben

(1) I can hear it now... "But do we need it?"
But do we need these IDR improvements when there is no bug report
or oops or architectural need to change it?  Other than the
deadlock?



