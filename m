Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbTAXLHE>; Fri, 24 Jan 2003 06:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbTAXLHE>; Fri, 24 Jan 2003 06:07:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:53958 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267635AbTAXLHD>;
	Fri, 24 Jan 2003 06:07:03 -0500
Date: Fri, 24 Jan 2003 03:16:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm5
Message-Id: <20030124031632.7e28055f.akpm@digeo.com>
In-Reply-To: <946253340.1043406208@[192.168.100.5]>
References: <20030123195044.47c51d39.akpm@digeo.com>
	<946253340.1043406208@[192.168.100.5]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 11:16:08.0087 (UTC) FILETIME=[FE225270:01C2C399]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel <linux-kernel@alex.org.uk> wrote:
>
> 
> 
> --On 23 January 2003 19:50 -0800 Andrew Morton <akpm@digeo.com> wrote:
> 
> >   So what anticipatory scheduling does is very simple: if an application
> >   has performed a read, do *nothing at all* for a few milliseconds.  Just
> >   return to userspace (or to the filesystem) in the expectation that the
> >   application or filesystem will quickly submit another read which is
> >   closeby.
> 
> I'm sure this is a really dumb question, as I've never played
> with this subsystem, in which case I apologize in advance.
> 
> Why not follow (by default) the old system where you put the reads
> effectively at the back of the queue. Then rather than doing nothing
> for a few milliseconds, you carry on with doing the writes. However,
> promote the reads to the front of the queue when you have a "good
> lump" of them.

That is the problem.  Reads do not come in "lumps".  They are dependent. 
Consider the case of reading a file:

1: Read the directory.

   This is a single read, and we cannot do anything until it has
   completed.

2: The directory told us where the inode is.  Go read the inode.

   This is a single read, and we cannot do anything until it has
   completed.

3: Go read the first 12 blocks of the file and the first indirect.


   This is a single read, and we cannot do anything until it has
   completed.

The above process can take up to three trips through the request queue.


In this very common scenario, the only way we'll ever get "lumps" of reads is
if some other processes come in and happen to want to read nearby sectors. 
In the best case, the size of the lump is proportional to the number of
processes which are concurrently trying to read something.  This just doesn't
happen enough to be significant or interesting.

But writes are completely different.  There is no dependency between them and
at any point in time we know where on-disk a lot of writes will be placed. 
We don't know that for reads, which is why we need to twiddle thumbs until the
application or filesystem makes up its mind.


