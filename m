Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267957AbTBMFC1>; Thu, 13 Feb 2003 00:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267958AbTBMFC1>; Thu, 13 Feb 2003 00:02:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:18942 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267957AbTBMFC0>;
	Thu, 13 Feb 2003 00:02:26 -0500
Date: Wed, 12 Feb 2003 21:12:21 -0800
From: Andrew Morton <akpm@digeo.com>
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT foolish question
Message-Id: <20030212211221.3f73ba45.akpm@digeo.com>
In-Reply-To: <1045096579.21195.121.camel@urca.rutgers.edu>
References: <20030212140338.6027fd94.akpm@digeo.com>
	<1045088991.4767.85.camel@urca.rutgers.edu>
	<20030212224226.GA13129@f00f.org>
	<1045090977.21195.87.camel@urca.rutgers.edu>
	<20030212232443.GA13339@f00f.org>
	<1045092802.4766.96.camel@urca.rutgers.edu>
	<20030212233846.GA13540@f00f.org>
	<1045093775.21195.99.camel@urca.rutgers.edu>
	<20030212235130.GA13629@f00f.org>
	<1045094589.4767.106.camel@urca.rutgers.edu>
	<20030213001302.GA13833@f00f.org>
	<1045096579.21195.121.camel@urca.rutgers.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2003 05:12:09.0882 (UTC) FILETIME=[75CFAFA0:01C2D31E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno Diniz de Paula <diniz@cs.rutgers.edu> wrote:
>
> On Wed, 2003-02-12 at 19:13, Chris Wedgwood wrote:
> > If I had to guess, write should work more or less the same as reads
> > (ie. I should be able to write aligned-but-smaller-than-page-sized
> > blocks to the end of files).
> > 
> > Testing this however shows this is *not* the case.
> 
> This is not the case, I have also tested here and the file written has
> n*block_size always. The problem with writing is that we can't sign to
> the kernel that the actual data has finished and from that point on it
> should zero-fill the bytes. And what is worse, the information about the
> actual size is lost, since the write syscall will store what is passed
> on the 3rd argument in the inode (field st_size of stat). This means
> that after writing using O_DIRECT we can't read data correctly anymore.
> The exception is when we write together with the data information about
> the actual size and process disregarding information from stat, for
> instance.
> 
> Well, I am sure I am completely wrong because this doesn't make any
> sense for me. Someone that has already dealt with this and can bring a
> light to the discussion?
> 

For writes, I don't think it is reasonable for the kernel to be have to
handle byte-granular appends.  O_DIRECT is different.  For this case the
application should ftruncate the file back to the desired size prior to
closing it.

For the short reads at EOF, the 2.4 kernel refuses to read anything, and
returns zero.  The 2.5 kernel will return -EINVAL, which is better behaviour
(shouldn't make it just look like the file is shorter than it really is).

The ideal behaviour is that which I mistakenly described previously: we
should fill with zeroes and return the partial result.  I'll look at
converting 2.5 to do that.  As long as the changes are small - the direct-io
code does a ton of stuff, is complex, is not tested a lot and breakage tends
to be subtle.
