Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161275AbWBUCIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbWBUCIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 21:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161277AbWBUCIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 21:08:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4570 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161275AbWBUCIj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 21:08:39 -0500
Date: Tue, 21 Feb 2006 13:04:47 +1100
From: Nathan Scott <nathans@sgi.com>
To: Sonny Rao <sonny@burdell.org>, Dave Jones <davej@redhat.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, bjd <bjdouma@xs4all.nl>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel oops: trying to mount a corrupted xfs partition (2.6.16-rc3)
Message-ID: <20060221020447.GB1588@frodo>
References: <20060216183629.GA5672@skyscraper.unix9.prv> <20060217063157.B9349752@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0602171753590.27452@yvahk01.tjqt.qr> <20060220082946.A9478997@wobbly.melbourne.sgi.com> <20060219215209.GB7974@redhat.com> <20060220070916.GA8101@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060220070916.GA8101@kevlar.burdell.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 02:09:16AM -0500, Sonny Rao wrote:
> On Sun, Feb 19, 2006 at 04:52:09PM -0500, Dave Jones wrote:
> <snip> 
> > Just for kicks, I just hacked this up..
> > 
> > #!/bin/bash
> > wget http://www.digitaldwarf.be/products/mangle.c
> > gcc mangle.c -o mangle
> > 
> > dd if=/dev/zero of=data.img count=70000
> > 
> > while [ 1 ];
> > do
> >         mkfs.xfs -f data.img >/dev/null
> > 		./mangle data.img $RANDOM
> >         sudo mount -t xfs data.img mntpt -o loop
> >         sudo ls -R mntpt
> >         sudo umount mntpt
> > done
> ...
> > 
> > xfs wins the award for 'noisiest fs in the face of corruption' :-)
> > After a few dozen backtraces from xfs_corruption_error,
> > this fell out...
> > 
> > divide error: 0000 [1] SMP
> <snip trace>
>  
> > (The kernel is based on 2.6.16rc4)
> 
> I see a similar breakage (divide error) on x86 using 2.6.15

>From a quick look at the image you sent me Sonny, I guess this is
the same problem Dave was seeing too -- a divide by zero when we're
working out some of the per-mount constants during mount(2).  There
is probably one or two other superblock fields that could use more
verification, but this will do for now.

cheers.

-- 
Nathan


Index: xfs-linux/xfs_mount.c
===================================================================
--- xfs-linux.orig/xfs_mount.c
+++ xfs-linux/xfs_mount.c
@@ -268,9 +268,12 @@ xfs_mount_validate_sb(
 	    sbp->sb_blocklog > XFS_MAX_BLOCKSIZE_LOG			||
 	    sbp->sb_inodesize < XFS_DINODE_MIN_SIZE			||
 	    sbp->sb_inodesize > XFS_DINODE_MAX_SIZE			||
+	    sbp->sb_inodelog < XFS_DINODE_MIN_LOG			||
+	    sbp->sb_inodelog > XFS_DINODE_MAX_LOG			||
+	    (sbp->sb_blocklog - sbp->sb_inodelog != sbp->sb_inopblog)	||
 	    (sbp->sb_rextsize * sbp->sb_blocksize > XFS_MAX_RTEXTSIZE)	||
 	    (sbp->sb_rextsize * sbp->sb_blocksize < XFS_MIN_RTEXTSIZE)	||
-	    sbp->sb_imax_pct > 100)) {
+	    (sbp->sb_imax_pct > 100 || sbp->sb_imax_pct < 1))) {
 		cmn_err(CE_WARN, "XFS: SB sanity check 1 failed");
 		XFS_CORRUPTION_ERROR("xfs_mount_validate_sb(3)",
 				     XFS_ERRLEVEL_LOW, mp, sbp);
