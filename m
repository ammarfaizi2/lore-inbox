Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318720AbSHLFC2>; Mon, 12 Aug 2002 01:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318721AbSHLFC2>; Mon, 12 Aug 2002 01:02:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32521 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318720AbSHLFC0>;
	Mon, 12 Aug 2002 01:02:26 -0400
Message-ID: <3D57449E.4FADF44@zip.com.au>
Date: Sun, 11 Aug 2002 22:16:14 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 9/21] batched addition of pages to the LRU
References: <3D56149B.C6E9414@zip.com.au> <Pine.LNX.4.44L.0208111213180.23404-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sun, 11 Aug 2002, Andrew Morton wrote:
> 
> > Also.  This whole patch series improves the behaviour of the system
> > under heavy writeback load.  There is a reduction in page allocation
> > failures, some reduction in loss of interactivity due to page
> > allocators getting stuck on writeback from the VM.  (This is still bad
> > though).
> 
> > It appears that this simply had the effect of pushing dirty, unwritten
> > data closer to the tail of the inactive list, making things worse.
> 
> This nicely points out the weak points in having the VM block
> on individual pages ... the fact that there are so damn many
> of those pages.
> 
> Every time the VM is shifting workloads we can run into the
> problem of having a significant part (or even the whole) of
> the inactive list full of dirty pages and with the inactive
> list being 1/3rd of RAM you could easily run into 200 MB of
> dirty pages.

Well let's have a statement of principles:

- Light writeback should occur via pdflush.

- Heavy writeback should be performed by the caller of write().

- If dirty pages reach the tail of the LRU, we've goofed.  Because
  the wrong process is being penalised.

I suspect the problem is a form of priority inversion.  The
heavy write() caller has filled the request queue and is nicely
asleep.  But some dirty page has reached the tail of the LRU
and some poor memory allocator tries to write it out, and gets
to go to sleep for ages because the "bad" task has gummed up
the request queue.

And it only takes one dirty block!  Any LRU page which is dirty
against a blocked queue is like a hand grenade floating
down a stream [1].  If some innocent task tries to write that
page it gets DoSed via the request queue.

I did wome work to try and fix this.  See
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.29/throttling-fairness.patch

The idea here is to split up the request queue in a new way:
when the heavy writer is writing back data (via balance_dirty_pages),
he goes to sleep whenever there are less than 50% of requests
available.  But all other writers can use 100% of the requests.

This is designed to prevent the priority inversion:  the caller
of shrink_cache can perform a non-blocking write without getting
penalised by the write() caller's consumption of all requests.

The patch helps, and at the end of the day, it may be the right
thing to do.   But first I want to find out exactly why all this
dirty data is reaching the tail of the LRU, and see if there's
some way to make the correct process write it out.


[1] OK, hand grenades don't float.  I was thinking of something
    else, but this is a family mailing list.
