Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWBJREF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWBJREF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWBJREF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:04:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17119 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751308AbWBJRED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:04:03 -0500
Date: Fri, 10 Feb 2006 09:03:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <43ECC13F.5080109@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
 <20060209001850.18ca135f.akpm@osdl.org> <43EAFEB9.2060000@yahoo.com.au>
 <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au>
 <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au>
 <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au>
 <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au>
 <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au>
 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au>
 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au>
 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au>
 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au>
 <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org> <43ECC13F.5080109@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
> MS_INVALIDATE does that (in Linux),

I don't actually think it does.

In _current_ linux it does. In some other versions, it will have thrown 
the dirty data away. Also, it will make subsequent accesses much much more 
expensive - and it doesn't work on locked areas.

>					 the spec is poorly worded but the
> intention seems to be that it would push dirty state back into pagecache for
> implementations such as ours.

As an application writer, you'd be absolutely crazy to depend on that.

Using "msync( .. 0)" _may_ actually work reliably under any Linux version, 
but I wouldn't bet on it, and it's quite possible that it does strange 
things on other systems. Again, an application writer that uses it would 
have to be deranged (or very much a kernel person - I could imagine doing 
it myself, but I could _not_ imagine doing it as a non-kernel developer).

> linux@horizon.com has an application (database or logging I think), which
> uses MS_SYNC to provide integrity guarantees, however it is possible to do
> useful work between the last write to memory and the commit point. MS_ASYNC
> is used to start the IO and pipeline work.

So you're saying that there is one application that knows it could use 
different semantics?

Now, please enumerate all the applications that use MS_ASYNC and prefer 
the current semantics.

When you know that, you have an argument. 

In the meantime, you have an example of an application that wants _new_ 
semantics.

> > The current MS_ASYNC behaviour is the sane one. It's the one that doesn't
> > cause the harddisk to start ticking senselessly. It's the one that allows a
> > person on a laptop to say "don't write dirty data every 5 seconds - do it
> > just every hour".
> 
> MS_INVALIDATE

Repeating something doesn't make it so.

> > In contrast, _your_ proposal is just inflexible and inconvenient.
> 
> Currently MS_ASYNC does the same as MS_INVALIDATE. But it used to start
> IO (before 2.5.something), and apparently it does in Solaris as well.

Actually, it did _not_ use to start IO.

Then, somebody made it do so, and people eventually screamed, and it was 
reverted again.

Go check Linux-2.0 or something. You'll also see the "MS_INVALIDATE means 
throw the dirty bit away" behaviour.

The _sane_ semantics are that if you say "MS_INVALIDATE" the dirty bit is 
just thrown away. If you say "MS_INVALIDATE | MS_ASYNC", the dirty bit is 
saved in the page cache and then the page is unmapped. And MS_SYNC 
obviously does the same thing, except it also waits for it.

Those are the the _logically consistent_ semantics. And it's what Linux 
historically did. The fact that we now think "MS_INVALIDATE" on its own 
should mean "save the dirty state" is because some other broken operating 
system does it, and it's sadly the _safer_ thing to do, even if it's 
clearly logically not sane. If you invalidate a mapping, you throw it 
away, you don't save it.

Gaah. 

I took the time to actually unpack 2.0.40. And yes, it does exactly what I 
remember it doing. If you pass in MS_INVALIDATE (with no *SYNC flags) it 
does:

                pte_clear(ptep);
		...
                if (!pte_dirty(pte) || flags == MS_INVALIDATE) {
                        free_page(page);
                        return 0;
                }

without ever marking anything dirty.

> > If somebody really really wants to "start flushing data now", then he can do
> > so, but that actually has absolutely zero to do with "msync()" any more. A
> > person who wants the flushing to start "now" might want to flush any random
> > dirty buffers.
> 
> I didn't quite understand what you're saying here.

I'm saying that "start flushing now" has _zero_ to do with an mmap.

It's a perfectly valid operation after a _write_ call too - even if you 
never mmaped the area at all.

So if somebody wants to start background IO, what has that got to do with 
msync()?

			Linus
