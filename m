Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289977AbSAOPsW>; Tue, 15 Jan 2002 10:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289490AbSAOPsO>; Tue, 15 Jan 2002 10:48:14 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:4868 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289492AbSAOPsF>; Tue, 15 Jan 2002 10:48:05 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.23828.941425.774587@laputa.namesys.com>
Date: Tue, 15 Jan 2002 19:47:16 +0300
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Hans-Peter Jansen <hpj@urpla.net>,
        linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
        "David L. Parsley" <parsley@roanoke.edu>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs
In-Reply-To: <E16QVf3-0002NG-00@charged.uio.no>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>
	<15428.12621.682479.589568@charged.uio.no>
	<15428.19063.859280.833041@laputa.namesys.com>
	<E16QVf3-0002NG-00@charged.uio.no>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust writes:
 > On Tuesday 15. January 2002 16:27, Nikita Danilov wrote:
 > 
 > > In reiserfs there is no static inode table, so we keep global generation
 > > counter in a super block which is incremented on each inode deletion,
 > > this generation is stored in the new inodes. Not that good as per-inode
 > > generation, but we cannot do better without changing disk format.
 > 
 > Am I right in assuming that you therefore cannot check that the filehandle is 
 > stale if the client presents you with the filehandle of the 'old' inode 
 > (prior to deletion)?
 > However if the client compares the 'old' and 'new' filehandle, it will find 
 > them to be different?

Sorry for being vague. Reiserfs keeps global "inode generation counter"
->s_inode_generation in a super block. This counter is incremented each
time reiserfs inode is being deleted on a disk. When new inode is
created, current value of ->s_inode_generation is stored in inode's
on-disk representation. Inode number (objectid in reiserfs parlance) is
reusable once inode was deleted. The same pair (i_ino, i_generation) can
be assigned to different inode only after ->s_inode_generation
overflows, which requires 2**32 file deletions.

So, no, reiserfs can tell stale filehandle, although not as reliable as
file systems with static inode tables.

Hans-Peter, please tell me, what reiserfs format are you using. 3.5
doesn't support NFS reliably. If you are using 3.5 you'll have to
upgrade to 3.6 format (copy data to the new file system). mount -o conv
will not eliminate this problem completely, but will make it much less
probable, so you can try this first.

 > 
 > Cheers,
 >   Trond
 > 

Nikita.
