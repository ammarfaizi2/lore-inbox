Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTLPVM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTLPVLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:11:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:21162 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262652AbTLPVLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:11:33 -0500
Date: Tue, 16 Dec 2003 13:11:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>, jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
In-Reply-To: <20031216205853.GC1402@matchmail.com>
Message-ID: <Pine.LNX.4.58.0312161304390.1599@home.osdl.org>
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws>
 <3FDF1C03.2020509@aitel.hist.no> <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
 <20031216205853.GC1402@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Dec 2003, Mike Fedyk wrote:
>
> On Tue, Dec 16, 2003 at 08:42:52AM -0800, Linus Torvalds wrote:
> > My personal guess is that modern RAID0 stripes should be on the order of
> > several MEGABYTES in size rather than the few hundred kB that most people
> > use (not to mention the people who have 32kB stripes or smaller - they
> > just kill their IO access patterns with that, and put the CPU at
> > ridiculous strain).
>
> Larger stripes may help in general, but I'd suggest that for raid5 (ie, not
> raid0), the stripe size should not be enlarged as much.  On many
> filesystems, a bitmap change, or inode table update shouldn't require
> reading a large stripe from several drives to complete the pairity
> calculations.

Oh, absolutely. I only made the argument as it works for RAID0, ie just
striping.  There the only downside of a large stripe is the potential for
a lack of parallelism, but as mentioned, I don't think that downside much
exists with modern disks - the platter density and throughput (once you've
seeked to the right place) are so high that there is no point to try to
parallelise it at the data transfer point.

The thing you should try to do in parallel is the seeking, not the media
throughput. And then small stripes hurt you, because they will end up
seeking in sync.

For RAID5, you have different issues since the error correction makes
updates be read-modify-write. At that point there are latency reasons to
make the blocking be small.

			Linus
