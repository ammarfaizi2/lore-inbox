Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268070AbUIHO4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268070AbUIHO4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269007AbUIHOzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:55:49 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:13791 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S267737AbUIHOy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:54:28 -0400
Date: Wed, 8 Sep 2004 17:54:32 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [patch]   Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040908145432.GA12332@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de> <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il> <20040907151022.GA32287@wotan.suse.de> <20040907181641.GB2154@mellanox.co.il> <20040908065548.GE27886@wotan.suse.de> <20040908142808.GA11795@mellanox.co.il> <20040908143852.GA27411@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908143852.GA27411@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andi Kleen (ak@suse.de) "Re: [patch]   Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> On Wed, Sep 08, 2004 at 05:28:08PM +0300, Michael S. Tsirkin wrote:
> > --- linux-2.6.8.1/include/linux/fs.h	2004-09-07 19:33:43.000000000 +0300
> > +++ linux-2.6.8.1-new/include/linux/fs.h	2004-09-08 07:18:20.000000000 +0300
> > @@ -879,6 +879,8 @@ struct file_operations {
> >  	int (*readdir) (struct file *, void *, filldir_t);
> >  	unsigned int (*poll) (struct file *, struct poll_table_struct *);
> >  	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
> > +	int (*ioctl_native) (struct inode *, struct file *, unsigned int, unsigned long);
> > +	int (*ioctl_compat) (struct inode *, struct file *, unsigned int, unsigned long);
> 
> Define these as long, not int.  No need to waste 32 perfectly good bits on 
> 64bit platforms.

I was just following ioctl. 

And ioctl is the way it is because man IOCTL(2) defines ioctl as

  int ioctl(int d, int request, ...);

So I wander what goes on here- the syscall returns a long but
libc cuts the high 32 bit?

Now that I think about it,for compat if you start returning 0 in low
32 bits you are unlike to get the effect you wanted ...
The ioctl_native could be changed but that would make it impossible
for compatible ioctls to just use the same pointer in both.

So what do you think - should I make just the native ioctl a long,
or both, and document that the high 32 bit are cut in the compat call?

> The main thing missing is documentation. You need clear comments what
> the locking rules are and what compat is good for.

Would these be best fit in the header file itself, or in a new
Documentation/ file?

> And you should change the code style to follow Documentation/CodingStyle
I'll go over it again. Something specific that I missed?

> Other than that it looks ok to me.
> 
> -Andi
