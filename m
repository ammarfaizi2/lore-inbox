Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbSLXRNT>; Tue, 24 Dec 2002 12:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265321AbSLXRNT>; Tue, 24 Dec 2002 12:13:19 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:9992 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S265262AbSLXRNR>; Tue, 24 Dec 2002 12:13:17 -0500
Date: Tue, 24 Dec 2002 09:21:23 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
Message-ID: <20021224172122.GB30929@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <000d01c2a8b6$3d102e20$941e1c43@joe> <B7CC2AA8-1720-11D7-8DC6-000393950CC2@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7CC2AA8-1720-11D7-8DC6-000393950CC2@karlsbakk.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 10:18:52AM +0100, Roy Sigurd Karlsbakk wrote:
> >SHORT ANSWER: Segregating partitions reduces seek time.  Period.
> >
> >LONG ANSWER: Reads and writes tend to be grouped within a partition.  
> >For
> >example, if you're starting a program, you're going to be doing a lot 
> >of
> >reads somewhere in the /usr partition.  If the program uses temporary 
> >files,
> >you're going to do a lot of reads & writes in the /tmp partition.  If 
> >you're
> >saving a file, you're going to be doing lots of writes to the /home
> >partition.  Hence, since most disk accesses occur in groups within a
> >partition, preference should be giving to reducing seek time WITHIN a
> >partition, rather than reducing seek time BETWEEN partitions.
> 
> keep in mind that only around half of the seek time is because of the 
> partition! Taking an IBM 120GXP as an example:
> 
> Average seek:				8.5ms
> Full stroke seek:			15.0ms
> Time to rotate disk one round:	1/(7200/60)*1000 = 8.3ms

I'm afraid your math is off.

The rotational frequency should be 7200*60/sec which makes
for 2.31 us which would produce an average rotational
latency of 1.16us if such a condition even still applies.
My expectation is that the whole track is buffered starting
from the first sector that syncs thereby making the time
rotfreq + rotfreq/nsect or something similar.  In any case
the rotational latency or frequency is orders of magnitude
smaller than the seek time, even between adjacent
tracks/cylinders.

If the the stated average seek is 50% of full stroke and not
based on reality then 76% of the cost of an average seek is
attributed to distance and likewise 87% of the cost of a
full.  Based on that i'd say the seek distance is a much
bigger player than you are assuming.  If it weren't the
value of elevators would be much less.

> 
> Then, the sector you're looking for, will, by average, be half a round 
> away from where you are, and thus, giving the minimum average seek time 
> 8.3/2 = 4.15ms or something like half the seek time. Concidering this, 
> you may gain a maximum <= 50% gain in using smaller partitions.
> 
> btw. anyone that knows the zone layout on IBM drives?

Having chimed in i'll also mention that having the
filesystems right-sized and small should produce better
locality of reference for multiple files and large files
given the tendency of our filesystems to spread their
directories across the cylinders.  One big filesystem is as
likely to have the assorted files spread from one end of the
disk to the other as you will get with several smaller ones.
Witness the discussions that introduce the orlov allocator
to ext[23].

As for the repartitioning when a filesystems outgrows its
partition that is reason #1 for lvm.  Care should be taken
though because lvm can also destroy locality through
discontinuous extent allocation.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
