Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSHGKgO>; Wed, 7 Aug 2002 06:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317945AbSHGKgO>; Wed, 7 Aug 2002 06:36:14 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:20701 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S317947AbSHGKgN>; Wed, 7 Aug 2002 06:36:13 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Florian Weimer <fw@deneb.enyo.de>
Date: Wed, 7 Aug 2002 20:40:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15696.63765.38094.618742@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, gam3@acm.org
Subject: Re: Problems with NFS exports
In-Reply-To: message from Florian Weimer on Wednesday August 7
References: <87eldchtr2.fsf@deneb.enyo.de>
	<87k7n3t3zm.fsf@deneb.enyo.de>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 7, fw@deneb.enyo.de wrote:
> Florian Weimer <fw@deneb.enyo.de> writes:
> 
> > I'm seeing weired errors with nfsctl():
> >
> > This works:
> >
> > nfsservctl(NFSCTL_EXPORT, "deneb.enyo.de", "/mnt/storage/2/backup/deneb/tmp", makedev(3, 66), ino 167772288, uid 65534, gid 65534) = 0
> >
> > But a subsequent call fails:
> >
> > nfsservctl(NFSCTL_EXPORT, "deneb.enyo.de", "/mnt/storage/2/backup/deneb", makedev(3, 66), ino 150995072, uid 65534, gid 65534) = -1 EINVAL (Invalid argument)
> >
> > I don't understand what makes the difference (the inode values are
> > correct).  This is kernel 2.4.18 with XFS support, and the directory
> > resides on an XFS file system.
> >
> > Any ideas?
> 
> (Full quote because of additional recipeint.)
> 
> It appears that a directory tree can only be exported once.  Is this
> intentional?  If yes, the following patch should be applied (to
> linux/fs/nfsd/export.c), so that the return value is more meaningful:

Probably better documentation in exports.5 would be just as useful.
And "BUSY" probably isn't correct ....
The rule is that you cannot export a directory and an ancestor of that
directory in the same filesystem.
/a/1 and /a/2 can both be exported, but not /a and /a/1.

Reason:  exporting "/a" means exporting that directoring and all
descendants of it in the same filesystem.
If you export /a with different flags than /a/1 it is ambiguous.

And personally, I doubt that there are very many situations where it
makes sense.

It would be possible to dis-ambiguate the ambiguity but it wouldn't be
very clean, and I really am not sure that it is worth the effort.

NeilBrown


> 
> --- export.c	2002/08/07 09:22:11	1.1
> +++ export.c	2002/08/07 09:22:28
> @@ -219,6 +219,7 @@
>  		goto finish;
>  	}
>  
> +	err = -EBUSY;
>  	if ((parent = exp_child(clp, dev, nd.dentry)) != NULL) {
>  		dprintk("exp_export: export not valid (Rule 3).\n");
>  		goto finish;
> 
> 
> After this change, the userspace tools can issue are more meaningful
> error message for this case.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
