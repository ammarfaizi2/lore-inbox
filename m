Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbTBDBUu>; Mon, 3 Feb 2003 20:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbTBDBUu>; Mon, 3 Feb 2003 20:20:50 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:24746 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267089AbTBDBUt>; Mon, 3 Feb 2003 20:20:49 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Date: Tue, 4 Feb 2003 12:28:47 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15935.5967.576377.804605@notabene.cse.unsw.edu.au>
Subject: Re: 2.5.59 NFS server keeps local fs live after being stopped
In-Reply-To: message from Neil Brown on Thursday January 30
References: <15927.56648.966141.528675@harpo.it.uu.se>
	<15928.16811.851512.105997@notabene.cse.unsw.edu.au>
	<15928.20117.266542.506842@harpo.it.uu.se>
	<15929.2764.932711.81506@notabene.cse.unsw.edu.au>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday January 30, neilb@cse.unsw.edu.au wrote:
> On Wednesday January 29, mikpe@csd.uu.se wrote:
> > Neil Brown writes:
> >  > On Wednesday January 29, mikpe@csd.uu.se wrote:
> >  > > Kernel 2.5.59. A local ext2 file system is mounted at $MNTPNT
> >  > > and exported through NFS V3. A client mounts and unmounts it,
> >  > > w/o any I/O in between. The NFS server is shut down. Nothing in
> >  > > user-space refers to $MNTPNT.
> >  > > 
> >  > > The bug is that $MNTPNT now can't be unmounted. umount fails with
> >  > > "device is busy". A forced umount at shutdown fails with "device
> >  > > or resource busy" and "illegal seek", and leaves the underlying
> >  > > fs marked dirty.
....
> 
> Ok, it defaintely sounds like a leak.  I'll be back at my desk on
> Monday and I will try to reproduce it and explore the situation then.
> 
> NeilBrown

Found and fixed...  the following patch should make it work for you.

Thanks,
NeilBrown

-----------------------------
Fix problem where knfsd wouldn't release filesystem on unexport.

Problem was that the cache was being updated inplace, rather
than swapping in a new entry, so old filesystem pointers
were overwritten without being released.

 ----------- Diffstat output ------------
 ./fs/nfsd/export.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2003-02-03 16:49:49.000000000 +1100
+++ ./fs/nfsd/export.c	2003-02-03 16:49:52.000000000 +1100
@@ -691,7 +691,7 @@ exp_export(struct nfsctl_export *nxp)
 	new.ex_anon_gid = nxp->ex_anon_gid;
 	new.ex_fsid = nxp->ex_dev;
 
-	exp = svc_export_lookup(&new, 2);
+	exp = svc_export_lookup(&new, 1);
 
 	if (exp == NULL)
 		goto finish;
