Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135713AbRDXSja>; Tue, 24 Apr 2001 14:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135709AbRDXSjV>; Tue, 24 Apr 2001 14:39:21 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:39412 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135714AbRDXSjG>; Tue, 24 Apr 2001 14:39:06 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104241837.f3OIb0ii016925@webber.adilger.int>
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <Pine.GSO.4.21.0104240639580.6992-100000@weyl.math.psu.edu>
 "from Alexander Viro at Apr 24, 2001 06:54:16 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Tue, 24 Apr 2001 12:36:59 -0600 (MDT)
CC: Christoph Rohland <cr@sap.com>, David Woodhouse <dwmw2@infradead.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> Encapsulation part is definitely worth doing - it cleans the code up
> and doesn't change the result of compile. Adding allocation/freeing/
> cache initialization/cache removal and chaninging FOOFS_I() definition -
> well, it's probably worth to keep such patches around, but whether
> to switch any individual filesystem during 2.4 is a policy decision.
> Up to maintainer, indeed. Notice that these patches (separate allocation
> per se) are going to be within 3-4Kb per filesystem _and_ completely
> straightforward.

One thing to watch out for is that the current code zeros the u. struct
for us (as you pointed out to me previously), but allocating from the
slab cache will not...  This could be an interesting source of bugs for
some filesystems that assume zero'd inode_info structs.

Fortunately, it doesn't appear that my patch to clean out all of the
"duplicate" zero initializers in the fs-specific code was accepted...

> What I would like to avoid is scenario like:
> 
> Maintainers of filesystems with large private inodes: Why would we separate
> them? We would only waste memory, since the other filesystems stay in ->u
> and keep it large.

Well, if we get rid of NFS (50 x __u32) and HFS (44 * __u32) (sizes are
approximate for 32-bit arches - I was just counting by hand and not
strictly checking alignment), then almost all other filesystems are below
25 * __u32 (i.e. half of the previous size).

For large-private-inode filesystems, we are wasting memory in EVERY inode
in the slab cache, not just ones in use with the large private inode.  If
it were the most common filesystem (ext2, maybe reiser, msdos next) then
it wouldn't make much difference.

At some point reducing the union size is not efficient to have separate
slab allocations from a memory usage standpoint.

The remaining info structs are (approx. for 32-bit arch) (size in __u32):

ext2	27
affs	26
ufs	25
socket	24
shmem	22
coda	20
qnx4	18

minix	16
umsdos	15
hpfs	15
efs	14
sysv	13
reiser	12
udf	12
ntfs	11
ncp	10
msdos	9
adfs	7
smb	6
usbdev	5
proc	4
iso	4
bfs	3
romfs	2


> Maintainers of the rest of filesystems: Since there's no patches that would
> take large stuff out of ->u, why would we bother?

Maybe the size of the union can depend on CONFIG_*_FS?  There should be
an absolute minimum size (16 * __u32 or so), but then people who want
reiserfs as their primary fs do not need to pay the memory penalty of ext2.
For ext2 (the next largest and most common fs), we could make it part of
the union if it is compiled in, and on a slab cache if it is a module?

Should uncommon-but-widely-used things like socket and shmem have their
own slab cache, or should they just allocate from the generic size-32 slab?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
