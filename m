Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265317AbRGEPF5>; Thu, 5 Jul 2001 11:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265315AbRGEPFs>; Thu, 5 Jul 2001 11:05:48 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:10743 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265326AbRGEPFh>; Thu, 5 Jul 2001 11:05:37 -0400
Message-ID: <3B44828D.C220CAE@uow.edu.au>
Date: Fri, 06 Jul 2001 01:06:53 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT please; Sybase 12.5
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com>, <3B3C4CB4.6B3D2B2F@kegel.com>; <20010705155350.O17051@athlon.random> <3B44797F.DD9EAC99@uow.edu.au>,
		<3B44797F.DD9EAC99@uow.edu.au>; from andrewm@uow.edu.au on Fri, Jul 06, 2001 at 12:28:15AM +1000 <20010705163716.R17051@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Fri, Jul 06, 2001 at 12:28:15AM +1000, Andrew Morton wrote:
> > ext3 journals data.  That's unique and it breaks things (or rather,
> > things break it).   It'd be trivial to support O_DIRECT in ext3's
> > writeback mode (metadata-only), but nobody uses that.
> 
> I thought everybody uses metadata-only to avoid killing data-write
> performance.

ext3 has three modes:

data=journal

	Data is journalled.  Yes, this slows things down
	significantly.

data=ordered

	The default mode and the most popular.  All data is written
	to disk prior to a commit.  Write throughput is good, and
	you don't have uninitialised data in your files after a
	crash.

data=writeback

	Metadata-only.   Better write throughput (in dbench, anyway),
	but only metadata integrity is preserved after a crash. ie:
	fsck says the fs is fine, but files can (and almost always do)
	contain random stuff after a crash.

Ordered data mode is really nice.  It's not magical though - for example,
if you reset the machine during a kernel build, a subsequent `make' will
fail because you have a number of .o files which have zero length.
That's the length they happened to have when the machine went down.

For ordered-data mode we need to keep track of all the buffers which
are associated with a transaction's journalled metadata and ensure that
they are written out before the transaction commits.  That is done with
a little structure which hangs off ->b_private.

> So I thought it was ok to at first support O_DIRECT only
> for metadata journaling, doing that should be a three liner as you said
> and that is what I expected.

Yup.  metadata-only journalling is all-round much, much simpler.
