Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279903AbRKDLq0>; Sun, 4 Nov 2001 06:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279904AbRKDLqS>; Sun, 4 Nov 2001 06:46:18 -0500
Received: from smtp-server6.tampabay.rr.com ([65.32.1.43]:9955 "EHLO
	smtp-server6.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S279903AbRKDLqH>; Sun, 4 Nov 2001 06:46:07 -0500
Message-ID: <00a901c16526$48c64300$1a502341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: "Simon Kirby" <sim@netnation.com>, "Alexander Viro" <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011103122344.A12059@netnation.com> <Pine.GSO.4.21.0111031529490.18001-100000@weyl.math.psu.edu> <20011103131342.A15365@netnation.com>
Subject: Re: Something broken in sys_swapon
Date: Sun, 4 Nov 2001 06:46:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I see a potential problem (I'm looking at 2.4.10) in fs/namei.c.

If path_init() returns 0 in __user_walk() then err is not set to anything
(it defaults to 0)

int __user_walk(const char *name, unsigned flags, struct nameidata *nd)
{
        char *tmp;
        int err;

        tmp = getname(name);
        err = PTR_ERR(tmp);
        if (!IS_ERR(tmp)) {
                err = 0;
                if (path_init(tmp, flags, nd))
                        err = path_walk(tmp, nd);
                putname(tmp);
        }
        return err;
}

----- Original Message -----
From: "Simon Kirby" <sim@netnation.com>
To: "Alexander Viro" <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, November 03, 2001 4:13 PM
Subject: Re: Something broken in sys_swapon


> On Sat, Nov 03, 2001 at 03:31:25PM -0500, Alexander Viro wrote:
>
> > On Sat, 3 Nov 2001, Simon Kirby wrote:
> >
> > >                 kdev_t dev = swap_inode->i_rdev;
> > >                 struct block_device_operations *bdops;
> > >
> > >                 p->swap_device = dev;
> > >                 set_blocksize(dev, PAGE_SIZE);
> > >
> > > I don't know much at all about the inode structure, but doesn't this
set
> > > the block size of the originating filesystem containing the inode
rather
> > > than the block device that inode happens to be pointing to?  That
would
> >
> > man 2 stat
> >
> > i_rdev is equivalent of st_rdev, i_dev - of st_dev.
>
> Okay, would you see any other reason why my root filesystem would
> completely blow up after swapon /dev/hdb2 when /dev/hdb no longer exists?
>
> All I did was remove /dev/hdb and forget to take the swap entry out of
> /etc/fstab.  On boot I got "attempt to access beyond end of device"
> messages looping endlessly.  I tried once with / mounted rw (it looks
> like Debian still has / mounted ro when it turns on swap), and lots of
> filesystem corruption resulted.
>
> Simon-
>
> [  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
> [       sim@stormix.com       ][       sim@netnation.com        ]
> [ Opinions expressed are not necessarily those of my employers. ]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

