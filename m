Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278517AbRJPEDo>; Tue, 16 Oct 2001 00:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278519AbRJPEDf>; Tue, 16 Oct 2001 00:03:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62620 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278517AbRJPEDV>;
	Tue, 16 Oct 2001 00:03:21 -0400
Date: Tue, 16 Oct 2001 00:03:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
In-Reply-To: <Pine.LNX.4.33.0110152032340.8668-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110152355010.11608-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Oct 2001, Linus Torvalds wrote:

> 
> On Mon, 15 Oct 2001, Linus Torvalds wrote:
> >
> > (In other words: with a structured approach you can make guarantees about
> > the stability of each entry - you just can't necessarily guarantee that
> > all entries are shown or that some entries might not be duplicated..)
> 
> Note that this can actually be important, with suid applications that
> trust /proc. It is a GoodThing(tm) to have a read() that never returns
> "mixed" output from different lines, ie even if a mount/umount happens in
> parallel with reading /proc/mounts, you never get the filenames wrong..

Already done, and yes, reasons were precisely what you've mentioned.
 
> Some stuff definitely wants more than 1 page per entry (/proc/mount
> happens to be the only one I can think of - it can have the pathname
> already be PAGE_SIZE-1, with the options being another PAGE_SIZE), so some
> interface like

Also handled - we expand the buffer if needed.

>  - "proc_read_data" data structure:
> 
> 	struct proc_read_data {
> 		struct semaphore sem;
> 		int (*fillme)(struct proc_read_data *);
> 		unsigned long this_index;
> 		unsigned long next_index;
> 		unsigned int buffer_len;
> 		char buffer[0];
> 	};

Bingo.  Except that I do separate allocation of buffer.

>  - allocate it on /proc open, de-allocate it on close, save it away in
>    filp->f_private_data or whatever...

Exactly, except that there's no reason to limit it to procfs.

> .. and that's it (except for "fillme()", which is obviously the hard part,
> and which has to fill in not only the buffer with the data for the right
> index, it also has to fill in "prd->next_index" and "prd->buffer_len".
> 
> Al, do you see any problems in this?  I bet a lot of /proc files will fit
> this model, and need only a fairly simple "fillme()" function..

It's _very_ close to what I've done.
 
> Also note that because we cache _one_ entry, we absolutely _guarantee_
> that a user that just does consecutive "read()" calls will never _ever_
> see inconsistent lines, regardless of what his size of the read buffer is.

Right.  We should never leave more than one entry in buffer - we have every
right to try and fill several, as long as we know that all but the last one
will be immediately eaten.

Check the previous mail I've sent - it contains pretty straightforward
pseudocode for seq_read().  Aside of the fact that seq_read() simply
doesn't bother with sub-record resolution, it's pretty close to your
function.

BTW, I've missed check for pread() - good thing that you've mentioned
it in your variant...

