Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266604AbUFWSpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUFWSpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266605AbUFWSpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:45:05 -0400
Received: from mail.aknet.ru ([217.67.122.194]:11271 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S266604AbUFWSo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:44:56 -0400
Message-ID: <40D9CFAC.9040609@aknet.ru>
Date: Wed, 23 Jun 2004 22:45:00 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
Cc: "'Hugh Dickins'" <hugh@veritas.com>, "'Andrew Morton'" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] expandable anonymous shared mappings
References: <054d01c45914$93435d20$1d751e0a@P105541>
In-Reply-To: <054d01c45914$93435d20$1d751e0a@P105541>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph.

Christoph Rohland wrote:
>> The trick is that I am setting the old_len arg
>> of mremap() to 0. This means that the new mapping
>> is created while the old one is *not* being
>> destroyed. So I get multiple virtual memory
>> areas referencing the same shared memory region,
>> lets call them "aliases".
> I would propose you use the posix shm API for what you want to do and leave
> anonymous shared memory as a special case of this like it is...
> Keep it simple and stupid!
Yes, I can use the posix shm API for that. But no,
this will not be simple and stupid. Anon shared
mapping - that's the thing that could really be
simple and stupid, if you ask me.
Posix shm API have some disadvantages in my eyes:
1. If you need many small SHM objects, in order
to manage them vrt resizing, you'll have to track
the addresses to the corresponding FDs, so that you
can ftruncate(). Managing multiple FDs can be avoided
by using the custom allocator on a single large pool.
But in both ways I have to duplicate some functionality
which is already in the kernel, but that I just can't
use effectively.
With the anon mapping I was hoping to avoid this
duplication. The fact that some functionality cannot
be used in an effective way, also doesn't appeal to
me.
2. posix shm API (if we are talking about shm_open()
and friends) is, AFAIK, implemented in librt. This,
in turn, will get the libpthread.so to be linked to
your program. I have problems with libpthreads. For
ages it has the severe bugs, for example it was not
possible to use sigaltstack() in the programs which
are linked with libpthreads. And I am using the
sigaltstack()... It is fixed in the very recent
glibc, but upgrading glibc can be sometimes a bit
problematic.

But no, my prog won't die without the expandable
anon shared mapping thing. I can resort to the other
matters. I can (as I do right now) to just open a
tmp file in /dev/shm and use the custom allocator.
Yes, that works, but I wanted to keep it "simple
and stupid". The anon shared mapping looked like
the good candidate to try out.
And then I thought it may be nice if the kernel
to provide this functionality. If you suggest me
to use the other mechanisms, you probably imply
that doing such a things in the kernel is not a
good idea. If this functionality is considered
bad or useless by the kernel developers, then of
course it shouldn't be integrated and I'll use other
things. But really it looks like a bug to me, as
both the file-backed shared, and the anon-private
mappings are expandable.
I also accept the Hugh's reservations and I see
integrating this may be problematic. But since he
also said he liked the idea itself, I'll wait for
a while before dropping the use of the anon shared
mapping in my prog.

