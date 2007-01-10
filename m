Return-Path: <linux-kernel-owner+w=401wt.eu-S964783AbXAJIVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbXAJIVI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 03:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbXAJIVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 03:21:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:33621 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964794AbXAJIUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 03:20:55 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xc6jhqcfozPOlpyHfUnM2HLN7WBKqZVbBzeAi1PrvuSEuUP+rhpy6JbnXuKyqpBOfWCJXbbzpKiRcX1MZVFV+GNOQ5tJcH4QIRNaNsTHzgIEyEUh/6Z3VnoCZIo2yYPIk4OmvYCuGBSZnQ0LwApeZaI6KeeXBu2LR3d+lTcKVFQ=
Message-ID: <6d6a94c50701100020x3dfeae91k5e78ce2793593e26@mail.gmail.com>
Date: Wed, 10 Jan 2007 16:20:53 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Hua Zhong" <hzhong@gmail.com>
Subject: Re: [PATCH] support O_DIRECT in tmpfs/ramfs
Cc: "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       torvalds@osdl.org, mjt@tls.msk.ru
In-Reply-To: <000901c73439$297f3050$6721100a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701092002350.21638@blonde.wat.veritas.com>
	 <000901c73439$297f3050$6721100a@nuitysystems.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hua Zhong,

Maybe I misunderstand your patch, but when I tried it on my blackfin
uClinux platform, I can't change anything. See below:
================================
root:/var> mount
/dev/mtdblock0 on / type ext2 (rw)
/proc on /proc type proc (rw)
ramfs on /var type ramfs (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw)
root:/var> ./t_direct
Error open t.bin to read
================================
Error is because O_DIRECT flag was set when call open(). If I remove this flag,
the test program can work ok.

Any suggestions?

Thanks,
-Aubrey

On 1/10/07, Hua Zhong <hzhong@gmail.com> wrote:
> > > Here is a simple patch that does it.
> >
> > Looks more likely to work than Ken's - which I didn't try,
> > but I couldn't see what magic prevented it from just going BUG.
> >
> > But I have to say, having seen the ensuing requests for this
> > to impose the same constraints as other implementations of
> > O_DIRECT (though NFS does not), I've veered right back to my
> > original position: this all just seems silly to me.  O_DIRECT
> > is and always has been rather an awkward hack (Linus
> > described it in stronger terms!), supported by many but not
> > all filesystems: shall we just leave it at that?
>
> So I take your word that NFS does not impose this restraint,
> which means filesystems could choose their own alignment
> requirement that makes sense. So it would not be too horrible
> if tmpfs chooses to be liberal.
>
> In fact, in the O_DIRECT man page it says:
>
>  O_DIRECT
>               [....]  Under Linux 2.4 transfer sizes, and the  alignment  of
>               user  buffer and file offset must all be multiples of the logi-
>               cal block size of the file system. Under Linux 2.6 alignment to
>               512-byte boundaries suffices.
>
> So even Linux 2.4 and 2.6 are different - 2.6 is less restrictive.
>
> My point is that as long as we don't put more restrictions, it should
> not cause real problems.
>
> And about Linus..let's put his comment aside because O_DIRECT
> is there to stay. :-) In fact, since O_DIRECT is not the most
> beaufitul piece of code in the kernel, what I try to do is just to
> make software developer's life easier by making filesystem
> behavior as close to each other as possible with the minimal
> effort.
>
> > In particular, having now looked into the code, I'm amused to
> > be reminded that one of its particular effects is to
> > invalidate the pagecache for the area directly written.
> > Well, it's hardly going to be worth replicating that
> > behaviour with tmpfs or ramfs; yet if we don't, then we stand
> > accused of it behaving misleadingly differently on them.
> >
> > I think Michael, who started off this discussion, did just the right
> > thing: used a direct_IO filesystem on a loop device on a tmpfs file.
>
> That's a rather heavy-weight workaround don't you think?
>
> > > 1. A new fs flag FS_RAM_BASED is added and the O_DIRECT
> > flag is ignored
> > >    if this flag is set (suggestions on a better name?)
> > >
> > > 2. Specify FS_RAM_BASED for tmpfs and ramfs.
> >
> > If this is pursued (not my preference, but let me stand aside
> > now), you'd want to add in at least hugetlbfs and
> > tiny-shmem.c.  And set your (renamed) FS_RAM_BASED flag in
> > ext2_aops_xip: that seems to be what they're wanting, then
> > you can remove that strange test for
> > f->f_mapping->a_ops->get_xip_page from __dentry_open.
> >
> > >
> > > 3. When EINVAL is returned only a fput is done. I changed it to go
> > >    through cleanup_all. But there is still a cleanup problem:
> >
> > Is that change correct?  Are you saying that the existing
> > code leaks some structures?  If so, please do send a patch to
> > fix just that as soon as you can.  But are you sure?
>
> Having looked at the code more closely, the change is probably
> not correct. fput(f) apparently does everything cleanup_all does,
> and more, despite it's a single call. I guess those names are
> a bit confusing at first glance. :-)
>
> > > If a new file is created and then EINVAL is returned due to
> > > O_DIRECT, the file is still left on the disk. I am not exactly
> > > sure how to fix it other than adding another fs flag so we
> > > could check O_DIRECT support at a much earlier stage.
> > > Comments on how to fix it?
> >
> > None from me, sorry.  It's untidy, but not a new issue you
> > have to fix.
>
> Well, looks like people are not in consensus to add the tmpfs
> direct-io support, but since I've looked at the code, it would be
> nice to fix this bug though.
>
> The get_xip_page thing you mentioned makes it a bit more
> complicated since XIP support is a mount option, not a
> register_filesystem time option. If we ought to add a flag somewhere,
> where is the right place? vfsmount?
>
> I can cook up a patch for this bug if people think it's worth fixing.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
