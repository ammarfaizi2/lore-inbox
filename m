Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311336AbSCLUcJ>; Tue, 12 Mar 2002 15:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311337AbSCLUcF>; Tue, 12 Mar 2002 15:32:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8966 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311336AbSCLUbs>;
	Tue, 12 Mar 2002 15:31:48 -0500
Message-ID: <3C8E6544.1AE28413@zip.com.au>
Date: Tue, 12 Mar 2002 12:29:56 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
In-Reply-To: <3C8D9999.83F991DB@zip.com.au>,
		<3C8D9999.83F991DB@zip.com.au> <E16kkID-0001qr-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On March 12, 2002 07:00 am, Andrew Morton wrote:
> >   Identifies readahead thrashing.
> >
> >     Currently, it just performs a shrink on the readahead window when thrashing
> >     occurs.  This greatly reduces the amount of pointless I/O which we perform,
> >     and will reduce the CPU load.  The idea is that the readahead window
> >     dynamically adjusts to a sustainable size.  It improves things, but not
> >     hugely, experimentally.
> 
> The question is, does it wipe out a nasty corner case?  If so then the improvement
> for the averge case is just a nice fringe benefit.  A carefully constructed test
> that triggers the corner case would be most interesting.
> 

There are many test scenarios.  The one I use is:

- 64 megs of memory.

- Process A loops across N 10-megabyte files, reading 4k from each one
  and terminates when all N files are fully read.

- Process B loops, repeatedly reading a one gig file off another disk.

The total wallclock time for process A exhibits *massive* step jumps
as you vary N.  In stock 2.5.6 the runtime jumps from 40 seconds to
ten minutes when N is increased from 40 to 60.

With my changes, the rate of increase of runtime-versus-N is lower,
and happens at later N.  But it's still very sudden and very bad.

Yes, it's a known-and-nasty corner case.  Worth fixing if the
fix is clean.  But IMO the problem is not common enough to
justify significantly compromising the common case.

-
