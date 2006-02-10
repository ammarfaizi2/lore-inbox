Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWBJSBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWBJSBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 13:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWBJSBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 13:01:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932160AbWBJSBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 13:01:35 -0500
Date: Fri, 10 Feb 2006 10:01:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <43ECCF68.3010605@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org>
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
 <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org> <43ECCF68.3010605@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
> It seems very obvious to me that it is a hint. If you wer expecting
> to call msync(MS_SYNC) at some point, then you could hope that hinting
> with msync(MS_ASYNC) at some point earlier might improve its efficiency.

And it will. MS_ASYNC tells the system about dirty pages. It _should_ 
actually initiate writeback if the system decides that it has lots of 
dirty pages. Of course, if the system doesn't have a lot of dirty pages, 
the kernel will decide that no writeback is necessary.

If you (as an application) know that you will wait for the IO later (which 
is _not_ what MS_ASYNC talks about), why don't you just start it?

ie what's wrong with Andrew's patch which is what I also encourage?

I contend that "mmap + MS_ASYNC" should work as "write()". That's just 
_sensible_.

Btw, you can equally well make the argument that "write()" is a hint that 
we should start IO, so that if we do fdatasync() later, it will finish 
more quickly. It's _true_. It just isn't the whole truth. It makes things 
_slowe_ if you don't do fdatasync(), the same way you can do MS_ASYNC 
without doing MS_SYNC afterwards.

Now, if your argument is more general, aka "we should do better at 
writeback in general", I actually wouldn't disagree. We probably _should_ 
do better at write-back. The "sync every five seconds" causes pulses of 
(efficient) IO, but it also allows for lots of dirty stuff to have 
collected for no good reason, and causes bad IO latency for reads when it 
happens.

So if you were to argue _in_general_ for smoother write-back, I wouldn't 
actually object at all. I think it would potentially make much sense to 
make both "write()" _and_ things like msync(MS_ASYNC) perhaps see if the 
IO queue has been idle for a second, and if so, start trickling writes 
out.

I bet that would be lovely. I hate how un-tarring a big tree tends to have 
these big hickups, and "vmstat 1" shows that the disk isn't even writing 
all the time until half-way through the "untar".

IOW, I think you could re-phrase your argument in a more generic way, and 
I might well _agree_ with it. I just don't think it has anything to do 
with MS_ASYNC _in_particular_.

		Linus
