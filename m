Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281277AbRKHCMm>; Wed, 7 Nov 2001 21:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281284AbRKHCMY>; Wed, 7 Nov 2001 21:12:24 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:34574 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281277AbRKHCML>; Wed, 7 Nov 2001 21:12:11 -0500
Message-ID: <3BE9E8B6.235E16A8@zip.com.au>
Date: Wed, 07 Nov 2001 18:06:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: ext2-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
In-Reply-To: <20011107123430.D5922@lynx.no> <Pine.GSO.4.21.0111071446020.4283-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> Right now I'm doing alternative strategy for directory allocation, as soon
> as I finish that I'll put the result on usual place.

I'll be interested in seeing the algorithm.

Keith Smith has kindly directed me to the current location of
his testing workload.  This attempts to replay ten months' worth
of real file server activity.  It's described in his paper, at

	http://www.eecs.harvard.edu/~keith/usenix96

It's all set up for a 512 megabyte filesystem.  So I ran
it sixteen times in succession on sixteen different directories
at the top level of an eight-gig filesystem.  It takes about
five hours.  The filesystem ends up 76% full.

I did this on two filesystems: one with stock 2.4.14 and the other
with the `if (0 &&' change.  The patched kernel was consistently
10-15% faster at running the workload.

Now, lots of researchers seem to define lots of different ways of measuring
fragmentation and they are all rather unconvincing - they don't take into
account the extreme non-linear behaviour of modern disks.

So I simply measured how long it took to read some files.  Which doesn't
give any insight into the nature and sources of fragmentation, but it
is the bottom line.

And reading nine thousand files containing three hundred megs of
data from the filesystem which was populated with the `if (0 &&'
patch takes 1.5x to 2x as long as it does from stock 2.4.14.

So that idea is a non-starter.

This seems to be a pretty good fragmentation test and I'm inclined
to stick with it.

I suspect that the current algorithm, with some hysteresis to make it
less inclined to hop into a different block group is the way to go.

=
