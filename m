Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264748AbUEaTi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbUEaTi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 15:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264749AbUEaTi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 15:38:56 -0400
Received: from nacho.alt.net ([207.14.113.18]:47034 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S264748AbUEaTiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 15:38:51 -0400
Date: Mon, 31 May 2004 12:38:48 -0700 (PDT)
To: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>
Subject: Re: crashes in prune_icache() in 2.4.26
In-Reply-To: <Pine.LNX.4.44.0405302345250.12337-100000@nacho.alt.net>
Message-ID: <Pine.LNX.4.44.0405311233450.16373-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Chris Caputo <ccaputo@alt.net>
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Made a little more progress...

Turns out the infinite loop wasn't in the CONFIG_HIGMEM while() loop, but 
rather in the while() loop at the top of the code.  Sorry about that.  I 
misunderstood the disassembly until now.

So basically both types of crashes I am seeing (NULL deref and infinite
loop) are happening in the primary/top while() loop of prune_icache()  
and I suspect they are both the result of a corrupted inode_unused list.

Now I am trying to figure out where/how the inode_unused list is getting
corrupted...  If anyone has any existing code for validating list
integrity, which I could sprinkle around the code, I'd love a copy.

Thanks,
Chris

On Mon, 31 May 2004, Chris Caputo wrote:
> [CC'ed lkml in case anyone else wants to take a shot.]
> 
> A little more info...  I added some printk's to the function to highlight
> the input value of parameter 'goal' and also to show where the function
> was returning.
> 
> My understanding is these printk's all happened in rapid succession:
> 
>     entry > prune_icache(goal = 92370)
>     exit < prune_icache() at if (goal <= 0)
> 
>   Above the function completed without entering the CONFIG_HIGHMEM while
>   loop.
> 
>     entry > prune_icache(goal = 94037)
>     exit < prune_icache() - end of function
> 
>   Above the function went through the CONFIG_HIGHMEM while loop.  This was
>   the first time this happened since boot, after a number of 
>   prune_icache() calls that had returned prior to the CONFIG_HIGHMEM while 
>   loop.
> 
>     entry > prune_icache(goal = 98609)
>     Unable to handle kernel NULL pointer dereference at virtual address 00000004
> 
>   The final printk above shows the function being entered and then hitting
>   the NULL dereference.
> 
> Chris
> 
> On Sun, 30 May 2004, Chris Caputo wrote:
> > Hi.  I have been experiencing a number of crashes in fs/inode.c's
> > prune_icache() function.  I found on linux.bkbits.net that you made the
> > most recent major change to this function back in January.  With that in
> > mind I hope it is okay to write directly to you.
> > 
> > I have experienced two kinds of crashes with this function.
> > 
> > The first is in the older part of the code.  Basically the inode_unused 
> > list is somehow getting corrupt and when it does an Oops happens at:
> > 
> >     entry = entry->prev;   (line 808 of the 2.4.26 fs/inode.c)
> > 
> > I haven't yet figured out how it is getting corrupt so any tips welcome.
> > 
> > A second problem I have seen is that my system has gotten into an infinite
> > loop in the while loop in the CONFIG_HIGHMEM part of the prune_icache()
> > code.  I haven't yet figured out why.  But I am curious about the code at 
> > the beginning of the loop:
> > 
> >         while (goal-- > 0) {
> >                 if (list_empty(&inode_unused_pagecache))
> >                         break;
> >                 entry = inode_unused_pagecache.prev;
> >                 list_del(entry);
> >                 list_add(entry, &inode_unused_pagecache);
> > 
> > Is the intent of the last 3 lines to remove the entry from the end of the
> > linked-list and then add it to the front, as a way of traversing the list?  
> > Or is it intended that the add be an add to the inode_unused list as
> > opposed to the inode_unused_pagecache list?
> > 
> > I'd love to figure out the problems I am experiencing, so any advice on
> > how to proceed is welcome.  The bug happens every few days on our main
> > fileserver and I have been able to reproduce it on a test fileserver too.
> > 
> > Chris
> 
> 
> 

