Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131769AbRACElV>; Tue, 2 Jan 2001 23:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132176AbRACElN>; Tue, 2 Jan 2001 23:41:13 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:18704 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131771AbRACElH>; Tue, 2 Jan 2001 23:41:07 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Date: Wed, 3 Jan 2001 15:09:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14930.42496.545862.426153@notabene.cse.unsw.edu.au>
Cc: Frank.Olsen@stonesoft.com, linux-kernel@vger.kernel.org (kernel list)
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
In-Reply-To: message from Andrzej Krzysztofowicz on Saturday December 30
In-Reply-To: <200012302043.VAA10260@green.mif.pg.gda.pl>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday December 30, ankry@green.mif.pg.gda.pl wrote:
> 
> > On Friday December 29, Frank.Olsen@stonesoft.com wrote:
> > > Hi -- could you please CC me if you reply to this mail.
> > > 
> > > A:     /exports/A                                 - Redhat 7.0
> > > B1/B2: mount /exports/A on /export/A from A       - Redhat 6.2
> > > C:     mount /exports/A on /mnt/A from B1 or B2   - Redhat 6.2
> > > 
> > > I use knfsd/nfs-utils on each machine.
> > > 
> > > bash# ls /mnt/A
> > > /mnt/A/A.txt: No such file or directory
> > 
> > This is not a supported configuration.  You cannot export NFS mounted
> > filesystems with NFS. The protocol does not cope, and it
> > implementation doesn't even try.
> > NFS is for export local filesystems only.
> 
> As I understand problem is somewhere else.
> If this is intentionally unsupported configuration - OK. So why the error
> appears ? The directory should be empty then.
> 
> If the configuration is unsupported at the moment and the  A.txt file is
> located on A, some code that attempts to read re-exported files/directories
> should be turned off (eg. #if 0).
> 
> If the A.txt file is local for B1/B2 hosts, it is (IMHO) an obvious bug.
> Sucgh a file should be hidden at the act of mounting. For both local and
> remote access.
> 
> Neil, could you tell us where the A.txt file is *really* located ?

Well.... its a long story.

The interface between knfsd and filesystems is not (currently) a clean
one.  The current interface to filesystems is dictated by the VFS
layer, and it works primarily in terms of names.
knfsd wants to work in terms of inode numbers (or something similar)
and there is no such interface.

knfsd does manage to do its job, but only by abusing part of the VFS
interface - the "iget" routine which calls s_op->read_inode.
iget is meant to be an private interface, only ever called by the
filesystem itself (typically in the lookup operation) but, for ext2 at
least, it works for knfsd, so knfsd uses it.

Basically, knfsd assumes that is a filesystem has "read_inode"
defined, then it can safely use iget.

This works for ext2, but not for nfs.

The nfs filesystem does define read_inode, but uses it quite
differently to ext2.

The net result is that when you try to map an inode number to an inode
using iget with ext2 it always works, but if you do it with nfs it only
works if the inode is already in the cache.

So, when you:
   ls /mnt/A
from C, knfsd on  B1 (or B2) tries to find the directory  'A' and
succeeds beause it is in cache.  It does a readdir on this directory
and gets a list of files including "A.txt".
But when it tries to access A.txt, iget doesn't work for it, and it
cannot find it.

So A.txt is really on A, not on B1 or B2.  But when you look at A.txt
from C through B1 or B2 you only get a blurred image.  You can see
that it is there, but not what it is.

Does that help?

NeilBrown


> 
> Regards 
>    Andrzej
> 
> BTW. AFAIR, I observed similar behaviour (files are visible but
>      inaccessible) while mounting a local filesystem at a busy directory
>      (eg.: mount /dev/fd0 .;ls -l) even in 2.2...
> 
> -- 
> =======================================================================
>   Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
>   phone (48)(58) 347 14 61
> Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
