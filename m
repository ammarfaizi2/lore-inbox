Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSI0Qr2>; Fri, 27 Sep 2002 12:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSI0Qr2>; Fri, 27 Sep 2002 12:47:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38313 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261595AbSI0Qr0>;
	Fri, 27 Sep 2002 12:47:26 -0400
Date: Fri, 27 Sep 2002 19:01:48 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <Pine.LNX.4.44.0209270940380.2013-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209271856480.15791-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Linus Torvalds wrote:

> You may want to do something clever to avoid taking the vcache lock in
> the COW path unless there is real reason to believe that you have to,
> but as far as I can tell, you can do that by simply adding a memory
> barrier to the end of the "insert vcache entry" thing.

the COW path lookup code already avoids taking the vcache lock - unless
the hash-head is non-empty.

> Because once you do that, and you make sure that the COW thing does the 
> vcache callback _after_ changing the page tables, the COW code can 
>
>  - do the hash (which is invariant and has no races, since it depends 
>    solely on the virtual address and the VM)
>  - check if the hash queue is empty
>  - only if the hash queue is non-empty does the COW code need to get the 
>    vcache lock (and obviously it needs to re-load the hash entry from the 
>    queue after it got the lock, but the hash is still valid)

yeah, this is the optimization i have described in the previous mail, and
which is in the patch.

> Maybe I'm missing something, but the locking really doesn't look all
> that problematic if we just do things in the obvious order..

i agree, first hashing the vcache should work. There are some details:  
if we first hash the vcache then we have to set up the queue in a way for
the callback function to notice that this queue is not futex-hashed (ie.  
not live) yet. Otherwise the callback function might attempt to rehash it.  
This means one more branch in the callback function, not a problem.

	Ingo

