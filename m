Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311595AbSCNMFU>; Thu, 14 Mar 2002 07:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311596AbSCNMFL>; Thu, 14 Mar 2002 07:05:11 -0500
Received: from dsl-213-023-038-002.arcor-ip.net ([213.23.38.2]:18081 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311595AbSCNMEx>;
	Thu, 14 Mar 2002 07:04:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
Date: Thu, 14 Mar 2002 12:59:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C8D9999.83F991DB@zip.com.au> <E16l7Oe-0000Dk-00@starship> <3C8FAD88.1C425F9B@zip.com.au>
In-Reply-To: <3C8FAD88.1C425F9B@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16lTtI-0000OP-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 13, 2002 08:50 pm, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > That's the thrust of my current work - massaging things into a form where
> > struct page can be substituted for buffer_head as the block data handle 
> > for the mass of filesystems that use it.
> > ...
> > 
> > For me, the missing piece of the puzzle is how to recover the semantics of
> > ->b_flushtime.  The crude solution is just to put that in struct page for
> > now.  At least that's a wash in terms of size because ->buffers goes out.
> 
> I'm currently doing that in struct address_space(!).  Maybe struct inode
> would make more sense...

I don't know, when do we ever use an address_space that's not attached to an 
inode?  Hmm, swapper_space.  Though nobody does it now, it's also possible to 
have more than one address_space per inode.  This confuses the issue because 
you don't know whether to flush them together, separately, or what.  By the 
time things get this murky, its time for VM to step back and let the 
filesystem itself establish the flushing policy.  No, we don't have any model 
for how to express that, and we need one.  What you're developing here is 
a generic_flush, mainly for use by dumb filesystems, and by lucky accident, 
also suitable for Ext3.

So, hrm, the sky won't fall either places you put it.

> So the mapping records the time at which it was first dirtied.  So the
> `kupdate' function simply writes back all files which had their
> first-dirtying time between 30 and 35 seconds ago.

I guess you have to be careful to set the first-dirtying time again after
submitting all the IO, in case the inode got dirtied again while you were
busy submitting.

> That works OK, but it also needs to cope with the case of a single
> huge dirty file.  For that case, periodic writeback also terminates
> when it has written back 1/6th of all the dirty pages in the machine.

You need a way of cycling through all the inodes on the system reliably, 
otherwise you'll get nasty situations where repeated dirtying starves some 
inodes of updates.  This has to have file offset resolution, otherwise more 
flush starvation corner cases will start crawling out of the woodwork.

The 1/6th rule is an oversimplification, it should at least be based on how 
much flush IO is already in flight, and other more difficult measures we 
haven't even started to address yet, such as how much and what kind of other 
IO is competing for the same bandwidth, and how much bandwidth is available.

> This is all fairly arbitrary, and is basically designed to map onto
> the time-honoured behaviour.  I haven't observed any surprises from
> it, nor any reason to change it.

It's surprisingly resistant to flaming.  The starvation problem is going to 
get ugly, it's just as hard as the elevator starvation question and the 
crude, inode-level resolution of the flushtime makes it tricky.  But I think 
it can be beaten into some kind of shape where the corner cases are seen to 
be bounded.

I don't know, I need to think about it more.  It's both convenient and 
strange not to maintain per-block flushtime.

> We also need to discuss writeback of metadata.  For delayed allocate
> files, indirect blocks are not a problem, because I start I/O against
> them *immediately*, as soon as they're dirtied.  This is because we
> know that the indirect's associated data blocks are also under I/O.
> 
> Which leaves bitmaps and inode blocks.  These I am leaving on the
> dirty buffer LRU, so nothing has changed there.

Easy, give them an address_space.

[snip fascinating/timesucking sortie into online defrag]

-- 
Daniel
