Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135717AbRDXStl>; Tue, 24 Apr 2001 14:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135716AbRDXStb>; Tue, 24 Apr 2001 14:49:31 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:684 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135714AbRDXSt0>;
	Tue, 24 Apr 2001 14:49:26 -0400
Date: Tue, 24 Apr 2001 14:49:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Christoph Rohland <cr@sap.com>, David Woodhouse <dwmw2@infradead.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <200104241837.f3OIb0ii016925@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0104241441560.6992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Andreas Dilger wrote:

> One thing to watch out for is that the current code zeros the u. struct
> for us (as you pointed out to me previously), but allocating from the
> slab cache will not...  This could be an interesting source of bugs for
> some filesystems that assume zero'd inode_info structs.

True, but easy to catch.
 
> Well, if we get rid of NFS (50 x __u32) and HFS (44 * __u32) (sizes are
> approximate for 32-bit arches - I was just counting by hand and not
> strictly checking alignment), then almost all other filesystems are below
> 25 * __u32 (i.e. half of the previous size).

Yeah, but NFS suddenly takes 25+50 words... That's the type of complaints
I'm thinking about.
 
> Maybe the size of the union can depend on CONFIG_*_FS?  There should be
> an absolute minimum size (16 * __u32 or so), but then people who want
> reiserfs as their primary fs do not need to pay the memory penalty of ext2.
> For ext2 (the next largest and most common fs), we could make it part of
> the union if it is compiled in, and on a slab cache if it is a module?

NO. Sorry about shouting, but that's the way to madness. I can understand
code depending on SMP vs. UP and similar beasts, but presense of specific
filesystems.... <shudder>

> Should uncommon-but-widely-used things like socket and shmem have their
> own slab cache, or should they just allocate from the generic size-32 slab?

That's pretty interesting - especially for sockets. I wonder whether
we would get problems with separate allocation of these - we don't
go from inode to socket all that often, but...

