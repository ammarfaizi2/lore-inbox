Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVLPMSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVLPMSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVLPMSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:18:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2065 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932276AbVLPMSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:18:04 -0500
Date: Fri, 16 Dec 2005 13:18:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Neil Brown <neilb@suse.de>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216121805.GX23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <20051215231538.GF3419@redhat.com> <20051216004740.GV23349@stusta.de> <20051216005056.GG3419@redhat.com> <17314.11514.650036.686071@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17314.11514.650036.686071@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 01:56:58PM +1100, Neil Brown wrote:
> On Thursday December 15, davej@redhat.com wrote:
> > On Fri, Dec 16, 2005 at 01:47:40AM +0100, Adrian Bunk wrote:
> > 
> >  > > [*] Plus a few XFS ones, but that's been a lost cause wrt stack usage
> >  > > for a long time -- people were reporting overflows there before we
> >  > > enabled 4K stacks.
> >  > 
> >  > I remember someone from the XFS maintainers (Nathan?) saying they 
> >  > believe having solved all XFS stack issues.
> >  > 
> >  > If there are any XFS issues left, do you have a pointer to them?
> > 
> > The last one I saw may have been actually been more related
> > to the block layer problem. iirc that was a user NFS exporting
> > XFS on a raid1 array.
> 
> Yeh, I've noticed that nfsd seems to figure often in these.  As nfsd
> lives on the same (in-kernel) stack as the filesystem and device
> drives, it will add a couple of hundred bytes to the call trace.
> 
> A typical nfsd call trace is
>  nfsd -> svc_process -> nfsd_dispatch -> nfsd3_proc_write ->
>    nfsd_write ->nfsd_vfs_write -> vfs_writev
> 
> (errr. nfsd_vfs_write is inline, large, and called twice, that ain't
> good)

The nfsd code uses inline in too many places.

gcc can figure out itself that static functions called only once should 
be inline (except currently on i386 due to no-unit-at-a-time, see 
below).

> These add up to over 300 bytes on the stack.
> Looking at each of these, I see that nfsd_write (which includes
>  nfsd_vfs_write) contributes 0x8c to stack usage itself!!
> 
> It turns out this is because it puts a 'struct iattr' on the stack so
> it can kill suid if needed.  The following patch saves about 50 bytes
> off the stack in this call path.
>...

This works currently on i386 (and only on i386) because we are using 
-fno-unit-at-a-time there.

In the medium-term, we want to get rid of no-unit-at-a-time because this 
makes the code both bigger and slower, and I'm therefore not a big fan 
of this kind of workarounds.

If this struct is really a problem (which I doubt considering it's 
size), I'd prefer it being kmalloc'ed.

> NeilBrown
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

