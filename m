Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132267AbQK0EG2>; Sun, 26 Nov 2000 23:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132513AbQK0EGT>; Sun, 26 Nov 2000 23:06:19 -0500
Received: from u91n224.hfx.eastlink.ca ([24.222.91.224]:4100 "EHLO
        llama.nslug.ns.ca") by vger.kernel.org with ESMTP
        id <S132267AbQK0EGH>; Sun, 26 Nov 2000 23:06:07 -0500
Date: Sun, 26 Nov 2000 23:35:22 -0400
To: linux-kernel@vger.kernel.org
Subject: access() says EROFS even for device files if /dev is mounted RO
Message-ID: <20001126233522.A436@llama.nslug.ns.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 While doing some hdparm hacking, after booting with init=/bin/sh, I noticed
that open(1) doesn't work when / is mounted read only.  It complains that it
"Cannot open /dev/tty2 read/write"...

 I straced it:
 
execve("/usr/bin/open", ["open"], [/* 13 vars */]) = 0
...
brk(0x804c000)                          = 0x804c000
open("/dev/tty", O_RDWR)                = -1 ENXIO (No such device or address)
open("/dev/tty0", O_RDWR)               = 4
ioctl(4, KDGKBTYPE, 0xbffffcdb)         = 0
ioctl(4, VT_GETSTATE, 0xbffffda4)       = 0
ioctl(4, VT_OPENQRY, 0xbffffd90)        = 0
open("/dev/tty2", O_RDWR)               = 5
close(5)                                = 0


access("/dev/tty2", R_OK|W_OK)          = -1 EROFS (Read-only file system)


write(2, "Cannot open /dev/tty2 read/write"..., 57) = 57
_exit(5)                                = ?


 However, this is wrong.  You _can_ write to device files on read-only
filesystems.  (open shouldn't bother calling access(), but the kernel should
definitely give the right answer!)  Running
(bash < /dev/tty2 &>/dev/tty2 &)
will work (but for reasons unknown to me it won't do job control or handle
^C, etc.)

 I'm pretty sure the problem is in linux/fs/open.c, in sys_access():
        ...
	int res = -EINVAL;
	...
        dentry = namei(filename);
        res = PTR_ERR(dentry);
        if (!IS_ERR(dentry)) {
                res = permission(dentry->d_inode, mode);
                /* SuS v2 requires we report a read only fs too */

                if(!res && (mode & S_IWOTH) && IS_RDONLY(dentry->d_inode))

                        res = -EROFS;
	        dput(dentry);
        }
        ...
	return res;
 
 I think the  if( !res ... )  line is the problem.  I think the fix is to
add a check that the file is not a device file, socket, named pipe, or a
symlink to a file on a non-readonly FS (unless permission already follow
links?  There's probably some file type I didn't think of that needs to get
checked, too.).  

 I'm don't know what macro to use, since I don't have much kernel hacking
experience (yet ;), so I'll leave the fix for someone who knows what
they're doing :->

 BTW, this is in a 2.2.17 kernel on an IA32 machine.
 
 Please CC me on any replies, since I'm not subscribed to the list.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug. , ns.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BCE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
