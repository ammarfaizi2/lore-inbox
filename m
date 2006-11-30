Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936350AbWK3Myh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936350AbWK3Myh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936364AbWK3Myh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:54:37 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:47215 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S936350AbWK3Myf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:54:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XcfWXKUb8y13bohd0tYzmY5TBMz+dfjFJU7ELalE3AqKVyRYKfwSK33sD/CsbI07uBHWKWmZkRQVs8oY/JcdYatiGdbKdU7M83XJjDpRNKcb6mKo1ToXqb0I8Ip+Yx5rBhBgFTLJC140dD2ivrmvSPoInaxXe9dGg78y+0kjhrA=
Message-ID: <6d6a94c50611300454g22196d2frec54e701abaebf17@mail.gmail.com>
Date: Thu, 30 Nov 2006 20:54:34 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: The VFS cache is not freed when there is not enough free memory to allocate
Cc: "Sonic Zhang" <sonic.adi@gmail.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, vapier.adi@gmail.com
In-Reply-To: <456D5347.3000208@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50611212351if1701ecx7b89b3fe79371554@mail.gmail.com>
	 <1164185036.5968.179.camel@twins>
	 <6d6a94c50611220202t1d076b4cye70dcdcc19f56e55@mail.gmail.com>
	 <456A964D.2050004@yahoo.com.au>
	 <4e5ebad50611282317r55c22228qa5333306ccfff28e@mail.gmail.com>
	 <6d6a94c50611290127u2b26976en1100217a69d651c0@mail.gmail.com>
	 <456D5347.3000208@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> That was the order-9 allocation failure. Which is not going to be
> solved properly by just dropping caches.
>
> But Sonic apparently saw failures with 4K allocations, where the
> caches weren't getting shrunk properly. This would be more interesting
> because it would indicate a real problem with the kernel.
>
I have done several test cases. when cat /proc/meminfo show MemFree < 8192KB,

1) malloc(1024 * 4),  256 times = 8MB, allocation successful.
2) malloc(1024 * 16),  64 times = 8MB, allocation successful.
3) malloc(1024 * 64),  16 times = 8MB, allocation successful.
4) malloc(1024 * 128),  8 times = 8MB, allocation failed.
5) malloc(1024 * 256),  4 times = 8MB, allocation failed.

>From those results,  we know, when allocation <=64K, cache can be
shrunk properly.
That means the malloc size of an application on nommu should be
<=64KB. That's exactly our problem. Some video programmes need a big
block which has contiguous physical address. But yes, as you said, we
must keep malloc not to alloc a big block to make the current kernel
working robust on nommu.

So, my question is, Can we improve this issue? why malloc(64K) is ok
but malloc(128K) not? Is there any existing parameters about this
issue? why not kernel attempt to shrunk cache no matter how big memory
allocation is requested?

Any thoughts?

Thanks,
-Aubrey
