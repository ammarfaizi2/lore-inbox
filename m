Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272636AbRJRKza>; Thu, 18 Oct 2001 06:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277231AbRJRKzU>; Thu, 18 Oct 2001 06:55:20 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:50306 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S272636AbRJRKzI>; Thu, 18 Oct 2001 06:55:08 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Date: Thu, 18 Oct 2001 20:53:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15310.46220.706031.942241@notabene.cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfsfh.c:nfsd_findparent lookup("..") failure fix in 2.4.4 - xfs related?
In-Reply-To: message from Peter =?iso-8859-1?Q?W=E4chtler?= on Thursday October 18
In-Reply-To: <3BCEA924.14415870@loewe-komp.de>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 18, pwaechtler@loewe-komp.de wrote:
> The following diff was made in 2.4.4.
>  
> diff -u --recursive --new-file v2.4.4/linux/fs/nfsd/nfsfh.c linux/fs/nfsd/nfsfh.c
> --- v2.4.4/linux/fs/nfsd/nfsfh.c        Fri Feb  9 11:29:44 2001
> +++ linux/fs/nfsd/nfsfh.c       Sat May 19 17:47:55 2001
> @@ -244,6 +245,11 @@
>          */
>         pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
>         d_drop(tdentry); /* we never want ".." hashed */
> +       if (!pdentry && tdentry->d_inode == NULL) {
> +               /* File system cannot find ".." ... sad but possible */
> +               dput(tdentry);
> +               pdentry = ERR_PTR(-EINVAL);
> +       }
> 
> 
> Umh. How is it possible to have a valid dentry which has no parent?
> Even "/.." is linked to "/."

Well.  The filesystem could be corrupted, and there may not be a ".."
entry in the directory.  Or the filesystem code might  be broken in
some way.  Or just maying it doesn't support "..".
No other part of the linux kernel ever asks a filesystem to do a
lookup of "..".  All other accesses are caught by the VFS layer and
converted to dentry->d_parent.
So it would not be too surprising if some filesystems didn't handle
".." properly.
isofs, for example, doesn't support ".." at all.  I think the code
appears to try, but is simply wrong.

> 
> Is this xfs related? At least it was triggered on 2.4.3-xfs with
> exported xfs filesystems.

The code was put in because problems were reported with xfs.  How ever
it is correct to have this code anyway to protect nfsd from
corrupt, incomplete, or broken filesystems.

NeilBrown


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
