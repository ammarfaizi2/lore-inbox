Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbRGMPO1>; Fri, 13 Jul 2001 11:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267491AbRGMPOR>; Fri, 13 Jul 2001 11:14:17 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:63500 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S267490AbRGMPOG>; Fri, 13 Jul 2001 11:14:06 -0400
To: Alexander Griesser <tuxx@aon.at>
Cc: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
        linux-kernel@vger.kernel.org
Subject: Re: vfat: attempt to access beyond end of device
In-Reply-To: <20010712141653.A483@c239-1.fem.tu-ilmenau.de>
	<87hewi2bgh.fsf@devron.myhome.or.jp> <20010712231830.A17654@aon.at>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 14 Jul 2001 00:13:40 +0900
In-Reply-To: <20010712231830.A17654@aon.at>
Message-ID: <87y9pslv4r.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alexander Griesser <tuxx@aon.at> writes:

> When I try to write new files on it, I get:
> kernel: attempt to access beyond end of device
> kernel: 16:01: rw=0, want=2081231810, limit=80035798
> 
> According to his Problewm:
> Shouldn't an "int" be enough?
> 
> 2^31 = 2147483648
> And he "wants": 2081231810
> 
> Should do, or did I miss something?

kernel: attempt to access beyond end of device
kernel: 16:01: rw=0, want=2081231810, limit=80035798
kernel: dev = 16:01, ino = -2120058812
                           ^^^^^^^^^^^^
kernel: Filesystem panic (dev 16:01).

i_pos is -2120058812.

    fat_write_inode()
        i_pos = -2120058812;                      /* -2120058812 */
        fat_bread(sb, i_pos >> 4);                /* -132503676 */
    ...
    getblk()
        blocknr = block;                          /* 4162463620 */
    ...
    submit_bh()
        bh->b_rsector = bh->b_blocknr * count;
    generic_make_request()
        unsigned long sector = bh->b_rsector;

        printk(KERN_INFO "%s: rw=%d, want=%ld, limit=%d\n",
               kdevname(bh->b_rdev), rw,
               (sector + count)>>1, minorsize);   /* 2081231810 */

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

