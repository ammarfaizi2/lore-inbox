Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288611AbSAOQyY>; Tue, 15 Jan 2002 11:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288986AbSAOQyP>; Tue, 15 Jan 2002 11:54:15 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:65039 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288611AbSAOQyI>; Tue, 15 Jan 2002 11:54:08 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.27801.724105.557093@laputa.namesys.com>
Date: Tue, 15 Jan 2002 20:53:29 +0300
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
        "David L. Parsley" <parsley@roanoke.edu>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs
In-Reply-To: <20020115163208.785831435@shrek.lisa.de>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>
	<E16QVf3-0002NG-00@charged.uio.no>
	<15428.23828.941425.774587@laputa.namesys.com>
	<20020115163208.785831435@shrek.lisa.de>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Peter Jansen writes:
 > On Tuesday, 15. January 2002 17:47, Nikita Danilov wrote:
 > > Trond Myklebust writes:
 > >  > On Tuesday 15. January 2002 16:27, Nikita Danilov wrote:
 > >  > > In reiserfs there is no static inode table, so we keep global
 > >  > > generation counter in a super block which is incremented on each inode
 > >  > > deletion, this generation is stored in the new inodes. Not that good
 > >  > > as per-inode generation, but we cannot do better without changing disk
 > >  > > format.
 > >  >
 > >  > Am I right in assuming that you therefore cannot check that the
 > >  > filehandle is stale if the client presents you with the filehandle of
 > >  > the 'old' inode (prior to deletion)?
 > >  > However if the client compares the 'old' and 'new' filehandle, it will
 > >  > find them to be different?
 > >
 > > Sorry for being vague. Reiserfs keeps global "inode generation counter"
 > > ->s_inode_generation in a super block. This counter is incremented each
 > > time reiserfs inode is being deleted on a disk. When new inode is
 > > created, current value of ->s_inode_generation is stored in inode's
 > > on-disk representation. Inode number (objectid in reiserfs parlance) is
 > > reusable once inode was deleted. The same pair (i_ino, i_generation) can
 > > be assigned to different inode only after ->s_inode_generation
 > > overflows, which requires 2**32 file deletions.
 > 
 > Except it's in 3.5 format, which requires one deletion then?

In the same directory, yes.

 > 
 > > So, no, reiserfs can tell stale filehandle, although not as reliable as
 > > file systems with static inode tables.
 > >
 > > Hans-Peter, please tell me, what reiserfs format are you using. 3.5
 > > doesn't support NFS reliably. If you are using 3.5 you'll have to
 > > upgrade to 3.6 format (copy data to the new file system). mount -o conv
 > > will not eliminate this problem completely, but will make it much less
 > > probable, so you can try this first.
 > 
 > Bad luck for me, obviously :-(
 > 
 > <4>reiserfs: checking transaction log (device 03:09) ...
 > <4>Using r5 hash to sort names
 > <4>reiserfs: using 3.5.x disk format

[...]

 > <4>reiserfs: using 3.5.x disk format
 > <4>ReiserFS version 3.6.25
 > 
 > We're talking about 100 GB on _this_ server.

3.6. is advantageous because of many other things, like LFS, etc.

 > 
 > How big is the chance to loose data with -o conv?

There were problems with -o conv and remount (for root file system), but
they were cured in latest Marcelo's kernels.

 > 
 > Is there any paper around, which describes this conversion 
 > a bit more detailed? If I understand you correctly, the inode 
 > generation counter doesn't work at all with 3.5?

After file system is mounted with -o conv, all new files will be created
in a new format. This file system will then no longer be mountable as
3.5 (and thus, inaccessible from 2.2 kernels).

New files will store generation counters. The possibility of a stale
handle lurking undetected is when old-format file was deleted, its
objectid was reused for new format file, and super-block generation
counter at that time happens to coincide with objectid of parent
directory of the old file. Not exactly likely thing to happen, but
still.

 > 
 > >  > Cheers,
 > >  >   Trond
 > >

Nikita.

 > 
 > Cheers,
 >   Hans-Peter
 > 
