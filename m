Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314238AbSEFHFJ>; Mon, 6 May 2002 03:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314241AbSEFHFI>; Mon, 6 May 2002 03:05:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13587 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314238AbSEFHFH>;
	Mon, 6 May 2002 03:05:07 -0400
Message-ID: <3CD62BAE.BABF3831@zip.com.au>
Date: Mon, 06 May 2002 00:07:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.14..
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <20020506064716.GA8166@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> 
> On Mon, May 06, 2002 at 03:54:46AM +0000, Linus Torvalds wrote:
> 
> > releases these days, but I thought I'd point out 2.5.14, since it has some
> > interesting fundamental changes to how dirty state is maintained in the
> > VM.
> 
> I parsed this 'dirty state' sentence all wrong at first :-) Andrew, Linus -
> where does the current VM lie in between rmap-vm and aa-vm?
> 

"VM" is a broad term.  The memory allocator, page replacement, swap and
all that stuff is unaltered - it is the same as 2.4.current.  ie: Andrea's
VM from when his changes stopped going into the mainline kernel.

I made minimal changes in there to teach the page allocator that
all dirty memory is written back via pages and not sometimes-pages,
sometimes-buffers.  Also to add support for the new `clustering
writeback' which address_spaces can perform.

It's probably not as well tuned as it could be at present, but
I don't see a lot of point in fiddling with it.  As long as the
VM doesn't actually impede 2.5 development and evaulation of
2.5 performance, best to leave it alone until a VM developer
steps up to do the 2.6 VM.

The change to which Linus refers is:

In 2.4, dirty data from the write(2) system call is encapsulated
in buffer_heads and is placed on a global buffer list for writeout.
And dirty data from shared mappings is attached to its inode.

In 2.5, the buffer list went away, and dirty data from write(2)
is now managed in the same way as dirty data from mmap().

And because the kupdate and bdflush functions used to work
against the buffer LRU, replacements were introduced which do
the same thing against the inodes, instead of against the buffers.

So it's all page-oriented now.

-
