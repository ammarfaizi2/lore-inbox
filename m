Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277246AbRJ0WPb>; Sat, 27 Oct 2001 18:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277253AbRJ0WPW>; Sat, 27 Oct 2001 18:15:22 -0400
Received: from [62.225.154.5] ([62.225.154.5]:227 "EHLO btbweb.btbnet.de")
	by vger.kernel.org with ESMTP id <S277246AbRJ0WPF>;
	Sat, 27 Oct 2001 18:15:05 -0400
To: Linux-Kernel@vger.kernel.org
From: Buehler@btbnet.de
Subject: Bug in fs.h preventing boot from ramdisk
Date: Sun, 28 Oct 2001 00:18:36 +0200
Message-ID: <OFB8AA3359.3C4DD874-ONC1256AF2.007A8D6B@btbnet.de>
X-MIMETrack: Serialize by Router on BTBWeb1/BTB(Release 5.0.5 |September 22, 2000) at 28.10.2001
 00:18:47
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

***** BUG REPORT *****

Summary:     Kernel 2.4.10 crashes when used to boot from floppy disk
Description: I created a two-disk set to boot from (boot/root)
             The second disk contains a compressed root-fs.
             I am using LILO as boot-loader.
             Right after the prompt for the root-floppy and
               hitting Enter after inserting the floppy, the
               kernel crashes due to a nil pointer dereference.
Keywords:    boot, floppy
Version :    2.4.10
Rest:        not applicable since error already debugged as follows


Kernel 2.4.10 should crash with a cernel panic in Swapper if you supply the
appropriate boot parameters via LILO:

boot = /dev/fd0
install=/boot/boot.b
backup=/dev/null
compact
verbose=1

image=    /boot/vmlinuz
     root  = /dev/fd0
     label = Bootdisk
     read-write
     append = "load_ramdisk=1 prompt_ramdisk=1"
     vga = normal

The problem lives in include/linux/fs.h. The ramdisk driver (drivers/
block/rd.c) calls for read oerations into generic_file_read()
(mm/filemap.c)
which in turn calls do_generic_file_read(). The last instruction in
do_generic_file_read() should update inode's access time. To update access
times, a macro, UPDATE_ATIME, is used, which is just a wrapper for
void update_atime (struct inode *inode), which lives in fs/inode.c. And
there is the bug. Before actually updating access time, update_atime()
checks if it is legal to change atime using several macros from fs.h.

These macros originally had a sanity-check, which tests if inode's
pointer to its superblock is not NULL. This sanity-check has been removed
(since which version I cannot tell). Normally, this pointer will never
be NULL, but in case of initial loading of a root image into a ramdisk,
there is just an empty inode created, without a superblock. Here are
the macros:

// These are the macro definitions from 2.2.13 which have an additional
// sanity-check (inode)->i_sb && ...
// in case of booting and loading a compressed ramdisk there is no
superblock !!!
// So the new macros crash miserably. Maybe, it was intended that the new
// function init_special_inode should provide a superblock ??
#define __IS_FLG(inode,flg) (((inode)->i_sb && (inode)->i_sb->s_flags &
(flg)) \
                    || (inode)->i_flags & (flg))
#define IS_RDONLY(inode) (((inode)->i_sb) && ((inode)->i_sb->s_flags &
MS_RDONLY))

/* These are the Macros as defined for 2.4.10
#define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))

#define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
*/

I cannot tell, wether this is due to a failed attempt of optimization or
one just forgot to create an empty superblock in the newly introduced
function init_special_inode().

Can you please fix this for new kernel versions ?

Klaus Buehler
buehler@btbnet.de

