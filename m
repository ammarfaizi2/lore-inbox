Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131723AbRCXRXU>; Sat, 24 Mar 2001 12:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131724AbRCXRXK>; Sat, 24 Mar 2001 12:23:10 -0500
Received: from avalon.student.liu.se ([130.236.230.76]:15091 "EHLO
	mail.student.liu.se") by vger.kernel.org with ESMTP
	id <S131723AbRCXRW7>; Sat, 24 Mar 2001 12:22:59 -0500
Date: Sat, 24 Mar 2001 18:28:53 +0100
From: Jorgen Cederlof <jorgen.cederlof@cendio.se>
To: Alexander Viro <viro@math.psu.edu>
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bug in do_mount()
Message-ID: <20010324182853.A4090@ondska>
In-Reply-To: <20010324145822.B1353@ondska> <Pine.GSO.4.21.0103240904140.11914-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.4.21.0103240904140.11914-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Mar 24, 2001 at 09:13:46AM -0500
X-god-play-dice: No
X-eric-conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >       if (list_empty(&sb->s_mounts))
> >               kill_super(sb, 0);
> > +     else
> > +             put_filesystem(fstype);
> >       goto unlock_out;
 
> Reference acquired by get_fs_type() is
> released by put_filesystem() (near fs_out), _NOT_ by kill_super().

Yes.

> kill_super() releases the reference stored in ->s_type (created
> by get_sb_...()). If superblock stays alive you should not release it.

get_sb_...() will do get_filesystem() even if superblock stays alive.

We get the filesystem twice, in get_fs_type() and get_sb_...(), but if
we goto 'fail:' and don't call kill_super(), we put the filesystem
only once (near fs_out). 

> What bug are you trying to fix?

foofs is a FS_SINGLE filesystem: 
(but the !nd.dentry->d_inode case should be no different)

# grep foofs /proc/modules 
foofs                 6736   0 (unused)
# mount NONE /mnt -t foofs
# grep foofs /proc/modules 
foofs                 6736   1
# mount NONE /mnt -t foofs
mount: NONE already mounted or /mnt busy
mount: according to mtab, NONE is already mounted on /mnt
# grep foofs /proc/modules 
foofs                 6736   2
# mount NONE /mnt -t foofs
mount: NONE already mounted or /mnt busy
mount: according to mtab, NONE is already mounted on /mnt
# grep foofs /proc/modules 
foofs                 6736   3
# umount /mnt
# grep foofs /proc/modules 
foofs                 6736   2
# umount /mnt
umount: /mnt: not mounted
# grep foofs /proc/modules 
foofs                 6736   2
# rmmod foofs
foofs: Device or resource busy

