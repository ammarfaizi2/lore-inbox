Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135720AbRDXTN6>; Tue, 24 Apr 2001 15:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135722AbRDXTNs>; Tue, 24 Apr 2001 15:13:48 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:44020 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135720AbRDXTNg>; Tue, 24 Apr 2001 15:13:36 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104241911.f3OJB1Yf017023@webber.adilger.int>
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <Pine.GSO.4.21.0104241441560.6992-100000@weyl.math.psu.edu>
 "from Alexander Viro at Apr 24, 2001 02:49:23 pm"
To: Alexander Viro <viro@math.psu.edu>
Date: Tue, 24 Apr 2001 13:11:01 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, Christoph Rohland <cr@sap.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> > Well, if we get rid of NFS (50 x __u32) and HFS (44 * __u32) (sizes are
> > approximate for 32-bit arches - I was just counting by hand and not
> > strictly checking alignment), then almost all other filesystems are below
> > 25 * __u32 (i.e. half of the previous size).
> 
> Yeah, but NFS suddenly takes 25+50 words... That's the type of complaints
> I'm thinking about.

But then again, you are saving 50-25 words for every non-NFS inode, and I
think _most_ systems will have more local inodes than NFS inodes.  Even
NFS servers will have local inodes, only clients (AFAIK) use nfs_inode_info.

> > Maybe the size of the union can depend on CONFIG_*_FS?  There should be
> > an absolute minimum size (16 * __u32 or so), but then people who want
> > reiserfs as their primary fs do not need to pay the memory penalty of ext2.
> > For ext2 (the next largest and most common fs), we could make it part of
> > the union if it is compiled in, and on a slab cache if it is a module?
> 
> NO. Sorry about shouting, but that's the way to madness. I can understand
> code depending on SMP vs. UP and similar beasts, but presense of specific
> filesystems.... <shudder>

But then again, if the size of nfs_inode_info changes, it is the same
problem... sizeof(struct inode) may have changed (depends if slab has
some padding between inodes or not).  If we stick to a minimum size
(16 words or maybe even 8), then it will never change anymore, and we
do not have overhead for small inode_info structs.

> > Should uncommon-but-widely-used things like socket and shmem have their
> > own slab cache, or should they just allocate from the generic size-32 slab?
> 
> That's pretty interesting - especially for sockets. I wonder whether
> we would get problems with separate allocation of these - we don't
> go from inode to socket all that often, but...

I never thought of that.  I guess the socket code does not know which
fs the inode_info was allocated from, so it cannot free it from the slab
(even if it had access to these slabs, which it does not).  In that case,
each fs would have struct socket as the minimum size allocatable, which
is unfortunately one of the largest inode_info sizes.  It is smaller
than ext2, but...

Any ideas?  Do we ever get back into fs-specific clear_inode() from
a socket?  In that case, the socket would just hold a pointer to the
fs-specific inode_info inside its own struct socket until the inode
is dropped.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
