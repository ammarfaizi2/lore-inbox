Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263545AbTCUHYL>; Fri, 21 Mar 2003 02:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263547AbTCUHYL>; Fri, 21 Mar 2003 02:24:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:46590 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263545AbTCUHYI>;
	Fri, 21 Mar 2003 02:24:08 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 21 Mar 2003 08:35:07 +0100 (MET)
Message-Id: <UTC200303210735.h2L7Z7Q26322.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, zippel@linux-m68k.org
Subject: Re: major/minor split
Cc: Joel.Becker@oracle.com, akpm@digeo.com, andrey@eccentric.mae.cornell.edu,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Roman Zippel <zippel@linux-m68k.org>

    > > There is a point I'd like to get clear: where should the
    > > 16bit<->32bit dev_t conversion happen?
    > 
    > ..., there is no conversion
    > (other than the lengthening that happens when one
    > casts an unsigned short to an unsigned int).

    Let's look at ext2:

        if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
            raw_inode->i_block[0] = cpu_to_le32(kdev_t_to_nr(inode->i_rdev));

    Should the saved device number be a 16bit or a 32bit device number?
    Has the user any control over it?

It used to be a 32-bit device number. If we want to store
a 64-bit device number then also raw_inode->i_block[1]
is used. Fortunately ext2 has lots of room there.

No, the kernel code does what it does - user space does not influence this.

    > > how can software create nodes for a specific device?
    > 
    > You do not mean using mknod?

    I mean via mknod, e.g. if the user has a major/minor number,
    how should it be converted to a dev_t number?

The proper way is using the makedev macro in <sys/sysmacros.h>.
But in times of change you have to do everything by hand.
glibc still has to be updated.
(Steal the MKDEV macro from the kernel setup.)

Since new dev_t is compatible with old dev_t you need not
recompile or upgrade glibc or so, unless you actually want
to use more than 16 bits.

Andries

