Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSGYRre>; Thu, 25 Jul 2002 13:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSGYRrd>; Thu, 25 Jul 2002 13:47:33 -0400
Received: from hera.cwi.nl ([192.16.191.8]:30462 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315921AbSGYRra>;
	Thu, 25 Jul 2002 13:47:30 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 25 Jul 2002 19:50:11 +0200 (MEST)
Message-Id: <UTC200207251750.g6PHoBh16708.aeb@smtp.cwi.nl>
To: viro@math.psu.edu
Subject: Re: 2.5.28 and partitions
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> and I object to the long instead of u64 or so.

> Separate set of patches.

Good.
Although it is better to design the right data structures first.

> As it is, struct hd_struct is still there and still not modified.
> And it has unsigned long.  It will become sector_t.

You need two things:

(i) A faithful representation of what the partition parser says.
Partition table parsers, in the kernel or in user space, find out
how this disk is partitioned and the information found is stored
in some "parsed partition table" struct. Here offset and length
must be u64 and use byte as a unit.

(ii) A representation of offset and length suitable to use for
block I/O. During block I/O a sector number is tested against
the max to test for errors, and the partition offset is added.
These two must of course use the units the sector number is in.
So a sector_t is reasonable here.


> Actually, I'm not all that sure that we want u64 here.  The thing being,
> start_sect shouldn't be bigger than sector_t (see how it's used).  And
> 64bit arithmetics on 32bit boxen sucks big way.  I'm not too concerned
> about adding start_sect per se - it's done once per request and it's
> noise compared to the rest of work.  However, long long for sector_t
> will hit in a lot of more interesting code paths.

It will be unavoidable soon. For many applications it is needed today.

> Al, still thinking that anybody who does mkfs.<whatever> on a multi-Tb
> device should seek professional help of the kind they don't give on l-k...

I don't see how this can be relevant. If the device is large and you
make it one big partition then the size of the partition will need more
than 32 bits. If you split it up into lots of tiny 2 TB partitions
then the offsets will need more than 32 bits.

I did my partition stuff seven years ago, and at that time discussion
was possible: is it really necessary to use 64 bits?
Today no discussion is possible. Yes, u64 is needed.

Andries


[As a separate discussion:
I used a sparse setup, that is why the struct describing a partition also
had the partition number. Your version with 256 structs looks a bit clumsy.
In most setups 256 is a waste. In some it is not enough.
Sparseness is useful for user space. But of course I had a 64-bit dev_t.]
