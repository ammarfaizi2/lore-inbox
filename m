Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbUKDDu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUKDDu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 22:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbUKDDu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 22:50:59 -0500
Received: from koto.vergenet.net ([210.128.90.7]:60373 "HELO koto.vergenet.net")
	by vger.kernel.org with SMTP id S261518AbUKDDut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 22:50:49 -0500
Date: Thu, 4 Nov 2004 12:31:31 +0900
From: Horms <horms@verge.net.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Siep Kroonenberg <siepo@cybercomm.nl>,
       278068@bugs.debian.org
Subject: Re: chmod messes up permissions on hfs filesystem
Message-ID: <20041104033129.GQ4511@verge.net.au>
References: <20041101043559.GA12500@verge.net.au> <Pine.LNX.4.61.0411011721560.877@scrub.home> <20041102035635.GA28481@verge.net.au> <Pine.LNX.4.61.0411031639250.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411031639250.877@scrub.home>
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 05:00:35PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Tue, 2 Nov 2004, Horms wrote:
> 
> > Thanks for the patch, though the behaviour of the umask still seems
> > rather odd. I would like to offer an updated patch which I believe
> > makes the umask behave in the expected way. It also ensures
> > that the write_lock bit is read from/written to disk correctly.
> 
> You apply the umask before updating the write bit, which is incorrect.

I tried to account for that, but perhaps I missed.

> > @@ -196,6 +197,11 @@ struct inode *hfs_new_inode(struct inode
> >  		HFS_I(inode)->cached_blocks = 0;
> >  		memset(HFS_I(inode)->first_extents, 0, sizeof(hfs_extent_rec));
> >  		memset(HFS_I(inode)->cached_extents, 0, sizeof(hfs_extent_rec));
> > +		inode->i_mode = (mode & ~0777) | (~hsb->s_file_umask & 0777);
> > +		if (mode & S_IWUSR)
> > +			inode->i_mode |= S_IWUGO;
> > +		else
> > +			inode->i_mode &= ~S_IWUGO;
> >  	}
> >  	insert_inode_hash(inode);
> >  	mark_inode_dirty(inode);
> 
> Thanks, for reminding me to fix hfs_new_inode here, but the above applies.

No problem.

> > ===== fs/hfs/super.c 1.32 vs edited =====
> > --- 1.32/fs/hfs/super.c	2004-10-26 05:06:47 +09:00
> > +++ edited/fs/hfs/super.c	2004-11-01 20:01:54 +09:00
> > @@ -149,8 +149,8 @@ static int parse_options(char *options, 
> >  	/* initialize the sb with defaults */
> >  	hsb->s_uid = current->uid;
> >  	hsb->s_gid = current->gid;
> > -	hsb->s_file_umask = 0644;
> > -	hsb->s_dir_umask = 0755;
> > +	hsb->s_file_umask = 0111;
> > +	hsb->s_dir_umask = 0000;
> >  	hsb->s_type = hsb->s_creator = cpu_to_be32(0x3f3f3f3f);	/* == '????' */
> >  	hsb->s_quiet = 0;
> >  	hsb->part = -1;
> 
> This may be closer to the mac default, where everyone can access anything, 
> but I'd rather keep a safe default.
> Below is my updated patch.

Thanks, I will give it a spin and get back to you.

-- 
Horms
