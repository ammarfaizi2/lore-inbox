Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275019AbTHFX3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275025AbTHFX3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:29:54 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:24990 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S275019AbTHFX3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:29:47 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Steve Dickson <SteveD@redhat.com>
Date: Thu, 7 Aug 2003 09:29:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16177.36701.340897.187670@gargle.gargle.HOWL>
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] kNFSd: Fixes a problem with inode clean up for vxfs
In-Reply-To: message from Steve Dickson on Wednesday August 6
References: <3F3128A4.8030305@RedHat.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 6, SteveD@redhat.com wrote:
> This a patch I've received from Veritas. Supposedly they have
> already submitted this but I can't seem to find it in any 2.4 trees..
> 
> Does anybody recognize this and are there any known issues with it?

The patch is probably ok.
Both the current code and the new code are "wrong" as they assume
something about the setting of d_op, which only the filesystem could
know.
The current code assumes it will always be NULL.
The new code assumes it will be uniform within the filesystem.

Neither of these are certain to be true, but the later covers all
filesystems that the former covers and more, so it is safer.

It is not tecnically necessary as any filesystem in free to define
their fh_to_dentry operation to return a dentry that was not
DCACHE_NFSD_DISCONNECTED, and then this code would never be called.
The easiest way to write a fh_to_dentry that did this would be to copy
slabs of code out of nfsd/nfsfh.c, but there might be GPL issues if
Veritas did that.

All this is handled quite differently in 2.6 so it isn't an issue
there.

I would say "accept the patch".  I might even submit it for 2.4.23...

NeilBrown



> 
> The Problem: The nfsd_findparent creates a dentry using d_alloc_root. 
> The d_op
> vector pointer in this dentry is not initialized. Hence filesystems that 
> supply
> the vector have a problem. nfs exports of such filesystems do not work
> correctly under memory pressure.  vxfs, vfat, ntfs are amongst the 
> filesystems
> affected by the bug.  Need redhat to fix nfsd code in their kernels. 
> Ideally
> a kernel needs to ask a filesystem to setup a d_op vector.  An entry point
> into a filesystem for doing this job doesn't exist. We can work around the
> problem by copying d_op vector pointer from the child of the dentry, whose
> d_op vector is correct.
> 
> 
> The Patch:
> 
> --- ./fs/nfsd/nfsfh.c.diff      Wed Jul  2 13:17:35 2003
> +++ ./fs/nfsd/nfsfh.c   Tue Jul 29 04:45:43 2003
> @@ -303,6 +303,7 @@ struct dentry *nfsd_findparent(struct de
>                        if (pdentry) {
>                                igrab(tdentry->d_inode);
>                                pdentry->d_flags |= 
> DCACHE_NFSD_DISCONNECTED;
> +                              pdentry->d_op = child->d_op;
>                        }
>                }
>                if (pdentry == NULL)
> 
> SteveD.
> 
