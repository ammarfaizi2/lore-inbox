Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261858AbREVP1E>; Tue, 22 May 2001 11:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261860AbREVP0y>; Tue, 22 May 2001 11:26:54 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:646 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261858AbREVP0o>; Tue, 22 May 2001 11:26:44 -0400
Message-Id: <5.1.0.14.2.20010522153915.00ac1630@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 22 May 2001 16:26:45 +0100
To: Alexander Viro <viro@math.psu.edu>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] struct char_device
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105221007460.15685-100000@weyl.math.psu.edu
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

At 15:18 22/05/01, Alexander Viro wrote:
[snip cool stuff]
>diff -urN S5-pre4/include/linux/fs.h S5-pre4-cdev/include/linux/fs.h
>--- S5-pre4/include/linux/fs.h  Sat May 19 22:46:36 2001
>+++ S5-pre4-cdev/include/linux/fs.h     Tue May 22 09:14:25 2001
>@@ -384,6 +384,14 @@
>         int                     gfp_mask;       /* how to allocate the 
> pages */
>  };
>
>+struct char_device {
>+       struct list_head        hash;
>+       atomic_t                count;
>+       dev_t                   dev;
>+       atomic_t                openers;
>+       struct semaphore        sem;

Why not name consistently with the struct block_device?
I.e.:
struct char_device {
         struct list_head        cd_hash;
         atomic_t                cd_count;
         dev_t                   cd_dev;
         atomic_t                cd_openers;
         struct semaphore        cd_sem;
};

>@@ -426,8 +434,10 @@
>         struct address_space    *i_mapping;
>         struct address_space    i_data;
>         struct dquot            *i_dquot[MAXQUOTAS];
>+       /* These three should probably be a union */
>         struct pipe_inode_info  *i_pipe;
>         struct block_device     *i_bdev;
>+       struct char_device      *i_cdev;

You could then use an (perhaps even unnamed if we require a high enough gcc 
version) union in the inode structure so you don't waste space having a 
pointer to both c_dev and b_dev, such as:

         union {
                 struct block_device     *i_bdev;
                 struct char_device      *i_cdev;
         };

It isn't possible that both i_bdev and i_cdev are used at the same time, is 
it? If it was my suggestion is obviously bogus...

Any reasons why my proposal would be a bad idea?

Just IMVHO.

Best regards,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

