Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWBJRNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWBJRNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWBJRNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:13:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751328AbWBJRNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:13:04 -0500
Date: Fri, 10 Feb 2006 09:12:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <43ECC69D.1010001@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0602100904330.19172@g5.osdl.org>
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
 <20060209231432.03a09dee.akpm@osdl.org> <43EC8A06.40405@yahoo.com.au>
 <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org> <43ECC69D.1010001@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
> No, you are thinking about what the kernel does. Subtle difference. A
> smart user wants to:
> 
> - start writing this
> - start writing that
> - start writing that-other-thing
> - make sure this that and the other have reached backing store
> 
> OK so in effect it is the same thing, but it is better to export the
> interface that reflects how the user interacts with pagecache.
> 
> WRITE_SYNC obviously does the "wait for them all" (aka ensure they
> hit backing store) thing too, right? It performs exactly the same
> role that WRITE_WAIT would do in the above example.

NOOOOOO!

Think about it for a second. Think about the usage case you yourself were 
quoting.

The "magic" in IO is "overlapping IO". If you don't get overlapping IO, 
your interfaces are broken. End of story.

And WRITE_SYNC _cannot_ do overlapping IO.

It's entirely possible that somebody else (or that very same program) has 
dirtied the same pages that you started write-out on earlier. And that is 
when "wait for writes to finish" and "WRITE_SYNC" _differ_. 

If you want synchronous writes, use synchronous writes. But if you want 
asynchronous writes, you do _not_ implement them as "start writes now" and 
"write synchronously". You implement them as "start writes now" and "wait 
for the writes to have finished".

There's another very specific and important difference: "wait for the 
writes" is fundamentally an interruptible and pollable operation, which 
means that it's a lot easier to integrate into any system that has to do 
other things too. In contrast, WRITE_SYNC is _neither_ easily 
interruptible nor pollable.

So WRITE_SYNC has clearly different behaviour. There's a good reason the 
kernel internally has "start write" + "wait for write", and I'll repeat: 
none of those reasons go away just because you move to user space.

> My proposal isn't really different to Andrew's in terms of functionality
> (unless I've missed something), but it is more consistent because it
> does not introduce this completely new concept to our userspace API but
> rather uses the SYNC/ASYNC distinction like everything else.

Your proposal has two _huge_ downsides:

 - it changes semantics, and you have absolutely _no_ idea of who depends 
   on the performance semantics of the old behaviour. In contrast, I can 
   tell you that we did it once before, and we reverted it.

 - it's not at all consistent. The _current_ behaviour is consistent, and 
   matches 100% the current behaviour of sync vs async write().

I really don't see the point.

		Linus
