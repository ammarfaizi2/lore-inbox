Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSGXXjb>; Wed, 24 Jul 2002 19:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318296AbSGXXjb>; Wed, 24 Jul 2002 19:39:31 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49282 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318295AbSGXXja>;
	Wed, 24 Jul 2002 19:39:30 -0400
Date: Wed, 24 Jul 2002 19:42:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
In-Reply-To: <UTC200207242242.g6OMglA23855.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0207241925450.14656-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Jul 2002 Andries.Brouwer@cwi.nl wrote:

> Just saw some new partition code in 2.5.28. Good!
> I like almost all I see, except for one thing:
> 
> +struct parsed_partitions {
> +       char name[40];
> +       struct {
> +               unsigned long from;
> +               unsigned long size;
> +               int flags;
> +       } parts[MAX_PART];
> +       int next;
> +       int limit;
> +};
> 
> and I object to the long instead of u64 or so.

Separate set of patches.  As it is, struct hd_struct is still there and
still not modified.  And it has unsigned long.  It will become sector_t.

Actually, I'm not all that sure that we want u64 here.  The thing being,
start_sect shouldn't be bigger than sector_t (see how it's used).  And
64bit arithmetics on 32bit boxen sucks big way.  I'm not too concerned
about adding start_sect per se - it's done once per request and it's
noise compared to the rest of work.  However, long long for sector_t
will hit in a lot of more interesting code paths.

That stuff becomes an issue for 2Tb disks.  Do we actually have something
that large attached to 32bit boxen?
 
> With 2^32 sectors one can handle up to 2^41 bytes, 2 TiB.
> Already today people want RAIDs that are larger, and
> few years from now we'll have single disks that are larger.

... and still use i386 with these disks?  ia64 is stillborn, but x86-64
promises to be more useful than Itanic.

u64 for sector_t doesn't change anything for 64bit boxen that might be
interested in really large disks and screws 32bit ones that shouldn't
have to pay for that...

