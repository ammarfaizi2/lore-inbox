Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbREOVDJ>; Tue, 15 May 2001 17:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbREOVCw>; Tue, 15 May 2001 17:02:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:27657 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261516AbREOVCe>; Tue, 15 May 2001 17:02:34 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Getting FS access events
Date: 15 May 2001 14:02:29 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9ds5h5$2i6$1@penguin.transmeta.com>
In-Reply-To: <3B018EF3.F9DF7207@transmeta.com> <Pine.GSO.4.21.0105151621350.21081-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0105151621350.21081-100000@weyl.math.psu.edu>,
Alexander Viro  <viro@math.psu.edu> wrote:
>On Tue, 15 May 2001, H. Peter Anvin wrote:
>
>> Alexander Viro wrote:
>> > >
>> > > None whatsoever.  The one thing that matters is that noone starts making
>> > > the assumption that mapping->host->i_mapping == mapping.
>> > 
>> > One actually shouldn't assume that mapping->host is an inode.
>> > 
>> 
>> What else could it be, since it's a "struct inode *"?  NULL?
>
>struct block_device *, for one thing. We'll have to do that as soon
>as we do block devices in pagecache.

No, Al. It's an inode. It was a major mistake to ever think anything
else.

I see your problem, but it's not a real problem.  What you do for block
devices (or anything like that where you might have _multiple_ inodes
pointing to the same thing, is to just create a "virtual inode", and
have THAT be the one that the mapping is associated with.  Basically
each "struct block_device *" would have an inode associated with it, to
act as a anchor for things like this. 

What is "struct inode", after all? It's just the virtual representation
of a "entity". The inodes associated with /dev/hda are not the inodes
associated with the actual _device_ - they are just on-disk "links" to
the physical device. 

[ Aside: there are good arguments to _not_ embed "struct inode" into
  "struct block_device", but instead do it the other way around - the
  same way we have filesystem-specific inode data inside "struct inode"
  we can easily have device-type specific data there.  And it makes a
  whole lot more sense to attach a mount to an inode than it makes to
  attach a mount to a "struct block_device".

  Done right, we could eventually get rid of "loopback block devices".
  They'd just be inodes that aren't of type "struct block_device", and
  the index to "struct buffer_head" would not be <block_deve *, blknr,
  size>, but <inode *, blknr, size>. See? The added level of indirection
  is one that we actually already _use_, it's just that we have this
  loopback device special case for it..

  In a "perfect" setup you could actually do "mount -t ext2 file /mnt/x"
  without having _any_ loopback setup or anything like that, simply
  because you don't _need_ it. It would be automatic. ]

		Linus
