Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268898AbRHBLgd>; Thu, 2 Aug 2001 07:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268897AbRHBLgX>; Thu, 2 Aug 2001 07:36:23 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:65159 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268896AbRHBLgK>; Thu, 2 Aug 2001 07:36:10 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <xfs@ragnark.vestdata.no>
Date: Thu, 2 Aug 2001 21:34:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15209.15033.502548.995201@notabene.cse.unsw.edu.au>
Cc: Tad Dolphay <tbd@sgi.com>, mjacob@feral.com,
        Christian Chip <chip.christian@storageapps.com>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: Busy inodes after umount
In-Reply-To: message from =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= on Tuesday July 31
In-Reply-To: <20010719165758.D50024-100000@wonky.feral.com>
	<200107200038.TAA40153@fsgi158.americas.sgi.com>
	<20010731021546.A7750@vestdata.no>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 31, xfs@ragnark.vestdata.no wrote:
> On Thu, Jul 19, 2001 at 07:38:15PM -0500, Tad Dolphay wrote:
> > > > I've now been able to reproduce:
> > > >
> > > > * make a filesystem
> > > > * mount it
> > > > * export it (nfs)
> > > > * mount on remote machine
> > > > * lock file (fcntl)
> > > > * unexport
> > > > * unmount
> > > >
> > > > Then you get the VFS message about self-destruct. Tested with both ext2
> > > > and xfs.
> > > >
> > > > The lock is still present in /proc/locks after the umount.
> > > >
> > > > With ext2 I can remount the filesystem successfully, but with XFS I get
> > > > the message about duplicate UUIDs and the mount failes. I believe this is a totally
> > > > different problem from the one you were experiencing. (and blockdev doesn't help for me)
> > > >
> > > > I suppose this is a generic kernel bug?

Yep.  It is not filesystem specific.  
nfsd does not flush locks when a filesystem is un-exported, only when
a client is removed, and that actually never happens.
In fs/nfsd/lockd.c there is a comment:

/*
 * When removing an NFS client entry, notify lockd that it is gone.
 * FIXME: We should do the same when unexporting an NFS volume.
 */

That FIXME needs to be fixed.  I need to read through some more code
before I am sure how to do it, but it shouldn't be too hard.

NeilBrown
