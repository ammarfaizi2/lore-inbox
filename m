Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265647AbUBJFzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 00:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbUBJFzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 00:55:13 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:6571 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265647AbUBJFzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 00:55:02 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 10 Feb 2004 16:53:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16424.29172.314124.933554@notabene.cse.unsw.edu.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 4.1GB limit with nfs3, 2.6 & knfsd?
In-Reply-To: message from Andrew Morton on Monday February 9
References: <20040210043926.GG18674@srv-lnx2600.matchmail.com>
	<20040209215020.60cf2f93.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 9, akpm@osdl.org wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> >
> > Hi,
> > 
> > I was trying to tar and bzip2 some directories over the weekend and I think
> > I may have found a bug.
> > 
> > The operation would consistantly fail when the bzip2ed tar file hit 4.1GB
> > when directed at a 2.6.1-bk2-nfs-stale-file-handles knfsd server from
> > another computer running the same kernel.
> > 
> > If I try the operation against a local filesystem, or a 2.4.24 knfsd server
> > on the network there are no failures and the file is at 18GB and growing on
> > the local filesystem (not enough space on the 2.4 server...).
> > 
> > This is all from the same nfs client computer.
> > 
> > I plan on doing some more tests with dd and cat against the server after the
> > files have finished compressing.
> > 
> > Anyone have any ideas?  I know this could be userspace, but why does it work
> > against a 2.4 knfsd and on the local filesystem?
> 
> Yes, something funny does seem to be happening.
> 
> I have a simple NFS mount of an ext2 filesystem via localhost and a 6GB
> `dd' fails after 4G:
> 
> vmm:/mnt/localhost> strace dd if=/dev/zero of=foo bs=1M count=6000
> ...
> write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = -1 EINVAL (Invalid argument)
> 

This is probably fixed by the following patch that is sitting in my
queue.
While 2.4 technically needs the same patch, it isn't affected because
it completely ignores the "offset", rather than almost-completely
ignoring it.

NeilBrown

-------------------------------------------------------
off_t in nfsd_commit needs to be loff_t

From: Miquel van Smoorenburg <miquels@cistron.nl>

While I was stress-testing NFS/XFS on 2.6.1/2.6.2-rc, I found that
sometimes my "dd" would exit with:

	#  dd if=/dev/zero bs=4096 > /mnt/file
	dd: writing `standard output': Invalid argument
	1100753+0 records in
	1100752+0 records out

After adding some debug printk's to the server and client code
and some tcpdump-ing, I found that the NFSERR_INVAL was returned by
nfsd_commit on the server.

Turns out that the "offset" argument is off_t instead of loff_t.
It isn't used at all (unfortunately), but it _is_ checked for
sanity, so that's where the error came from.

 ----------- Diffstat output ------------
 ./fs/nfsd/nfs3proc.c        |    4 ++--
 ./fs/nfsd/vfs.c             |    2 +-
 ./include/linux/nfsd/nfsd.h |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff ./fs/nfsd/nfs3proc.c~current~ ./fs/nfsd/nfs3proc.c
--- ./fs/nfsd/nfs3proc.c~current~	2004-02-06 13:38:28.000000000 +1100
+++ ./fs/nfsd/nfs3proc.c	2004-02-06 13:38:28.000000000 +1100
@@ -595,10 +595,10 @@ nfsd3_proc_commit(struct svc_rqst * rqst
 {
 	int	nfserr;
 
-	dprintk("nfsd: COMMIT(3)   %s %d@%ld\n",
+	dprintk("nfsd: COMMIT(3)   %s %u@%Lu\n",
 				SVCFH_fmt(&argp->fh),
 				argp->count,
-				(unsigned long) argp->offset);
+				(unsigned long long) argp->offset);
 
 	if (argp->offset > NFS_OFFSET_MAX)
 		RETURN_STATUS(nfserr_inval);

diff ./fs/nfsd/vfs.c~current~ ./fs/nfsd/vfs.c
--- ./fs/nfsd/vfs.c~current~	2004-02-06 13:38:21.000000000 +1100
+++ ./fs/nfsd/vfs.c	2004-02-06 13:38:28.000000000 +1100
@@ -823,7 +823,7 @@ out:
  */
 int
 nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
-               off_t offset, unsigned long count)
+               loff_t offset, unsigned long count)
 {
 	struct file	file;
 	int		err;

diff ./include/linux/nfsd/nfsd.h~current~ ./include/linux/nfsd/nfsd.h
--- ./include/linux/nfsd/nfsd.h~current~	2004-02-06 13:38:24.000000000 +1100
+++ ./include/linux/nfsd/nfsd.h	2004-02-06 13:38:28.000000000 +1100
@@ -86,7 +86,7 @@ int		nfsd_create_v3(struct svc_rqst *, s
 				struct svc_fh *res, int createmode,
 				u32 *verifier, int *truncp);
 int		nfsd_commit(struct svc_rqst *, struct svc_fh *,
-				off_t, unsigned long);
+				loff_t, unsigned long);
 #endif /* CONFIG_NFSD_V3 */
 int		nfsd_open(struct svc_rqst *, struct svc_fh *, int,
 				int, struct file *);
