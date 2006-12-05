Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760087AbWLEOUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760087AbWLEOUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 09:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760127AbWLEOUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 09:20:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56981 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760087AbWLEOUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 09:20:34 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200612050436_MC3-1-D3F9-FB3D@compuserve.com> 
References: <200612050436_MC3-1-D3F9-FB3D@compuserve.com> 
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Kasper Sandberg <lkml@metanurb.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, ak@muc.de, vojtech@suse.cz
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: Tue, 05 Dec 2006 14:19:53 +0000
Message-ID: <4701.1165328393@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Chuck Ebbert <76306.1226@compuserve.com> wrote:

> Here is a patch to reverse that.  Kasper, can you test it?
> (Your filesystem is on a FAT/VFAT volume, I assume.)

Please don't revert that patch.  If you do, you'll break CONFIG_BLOCK=n.

Can you compile and run the attached program as both 32-bit and 64-bit?

On my x86_64 test box, I did:

	[root@andromeda ~]# mkfs.vfat /dev/sda5
	[root@andromeda ~]# mount /dev/sda5 /mnt
	[root@andromeda ~]# mkdir /mnt/a
	[root@andromeda ~]# /tmp/ioctl /mnt/a		# 32-bit
	268 : 82187201, 82187202
	268 : 82187201, 82187202
	Calling VFAT_IOCTL_READDIR_BOTH32
	Calling VFAT_IOCTL_READDIR_BOTH
	[root@andromeda ~]# /tmp/ioctl /mnt/a		# 64-bit
	280 : 82307201, 82307202
	268 : 82187201, 82187202
	Calling VFAT_IOCTL_READDIR_BOTH32
	ioctl: Inappropriate ioctl for device
	Calling VFAT_IOCTL_READDIR_BOTH

Which is what I'd expect (the 64-bit ioctl does not support the 32-bit
function).  Tracing the 64-bit version shows that the right numbers are being
given to the syscall, though strace decodes them as the same symbol if not in
raw mode:

	[root@andromeda ~]# strace -eioctl -eraw=ioctl /tmp/ioctl /mnt/a
	280 : 82307201, 82307202
	268 : 82187201, 82187202
	Calling VFAT_IOCTL_READDIR_BOTH32
	ioctl(0x3, 0x82187201, 0x7fff9cec36c0)  = -1 (errno 25)
	ioctl: Inappropriate ioctl for device
	Calling VFAT_IOCTL_READDIR_BOTH
	ioctl(0x3, 0x82307201, 0x7fff9cec3490)  = 0x1
	Process 3410 detached

Applying the attached patch to the kernel produces the following elements in
the log for the 32-bit compilation:

	==> fat_compat_dir_ioctl(82187201,ffa803b8)
	==> fat_dir_ioctl(82307201,ffff810036a97ca8)
	<== fat_dir_ioctl() = 1
	<== fat_compat_dir_ioctl() = 1
	==> fat_compat_dir_ioctl(82187201,ffa801a0)
	==> fat_dir_ioctl(82307201,ffff810036a97ca8)
	<== fat_dir_ioctl() = 1
	<== fat_compat_dir_ioctl() = 1

and this for the 64-bit compilation:

	==> fat_dir_ioctl(82187201,7fff031f69f0)
	call fat_generic_ioctl()
	<== fat_dir_ioctl() = -25
	==> fat_dir_ioctl(82307201,7fff031f67c0)
	<== fat_dir_ioctl() = 1

Which is entirely what I'd expect.

However, it's possible that the 64-bit kernel interface used to allow the
32-bit calls.  If that's the case could you be running a 64-bit program
somewhere in your 32-bit chroot?

| i have only tested with >=rc5, thw folling, as an example, appears in
| dmesg:
| ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
| arg(00221000) on /home/redeeman
| ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
| arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
| ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
| arg(00221000) on /home/redeeman/.wine/drive_c/windows/system

How do you get that?  I don't see anything like that.  I've tried:

	echo 1 >/proc/sys/kernel/compat-log

But that doesn't seem to do anything.

David


--=-=-=
Content-Type: text/x-c
Content-Disposition: inline; filename=ioctl.c

#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>

#define _IOC_NRBITS	8
#define _IOC_TYPEBITS	8
#define _IOC_SIZEBITS	14
#define _IOC_DIRBITS	2

#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)

#define _IOC_NRSHIFT	0
#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)

#define _IOC_NONE	0U
#define _IOC_WRITE	1U
#define _IOC_READ	2U

#define _IOC(dir,type,nr,size) \
	(((dir)  << _IOC_DIRSHIFT) | \
	 ((type) << _IOC_TYPESHIFT) | \
	 ((nr)   << _IOC_NRSHIFT) | \
	 ((size) << _IOC_SIZESHIFT))

extern unsigned int __invalid_size_argument_for_IOC;
#define _IOC_TYPECHECK(t) \
	((sizeof(t) == sizeof(t[1]) && \
	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
	  sizeof(t) : __invalid_size_argument_for_IOC)

#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))

#define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
#define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
#define VFAT_IOCTL_READDIR_BOTH		_IOR('r', 1, struct dirent [2])
#define VFAT_IOCTL_READDIR_SHORT	_IOR('r', 2, struct dirent [2])

typedef unsigned short u16;
typedef signed int s32;
typedef unsigned int u32;
typedef long		__kernel_off_t;
typedef s32		compat_off_t;

struct compat_dirent {
	u32		d_ino;
	compat_off_t	d_off;
	u16		d_reclen;
	char		d_name[256];
};

struct dirent {
	long		d_ino;
	__kernel_off_t	d_off;
	unsigned short	d_reclen;
	char		d_name[256]; /* We must not include limits.h! */
};

#define O_DIRECTORY	00200000	/* must be a directory */

int main(int argc, char *argv[])
{
	struct compat_dirent cdire[2];
	struct dirent dire[2];
	int fd;

	printf("%zu : %lx, %lx\n",
	       sizeof(struct dirent),
	       (unsigned long) VFAT_IOCTL_READDIR_BOTH,
	       (unsigned long) VFAT_IOCTL_READDIR_SHORT);
	printf("%zu : %lx, %lx\n",
	       sizeof(struct compat_dirent),
	       (unsigned long) VFAT_IOCTL_READDIR_BOTH32,
	       (unsigned long) VFAT_IOCTL_READDIR_SHORT32);

	for (argv++; *argv; argv++) {
		fd = open(*argv, O_DIRECTORY | O_RDONLY);
		if (fd < 0) {
			perror(*argv);
			exit(1);
		}

		printf("Calling VFAT_IOCTL_READDIR_BOTH32\n");
		if (ioctl(fd, VFAT_IOCTL_READDIR_BOTH32, cdire) < 0)
			perror("ioctl");
		printf("Calling VFAT_IOCTL_READDIR_BOTH\n");
		if (ioctl(fd, VFAT_IOCTL_READDIR_BOTH, dire) < 0)
			perror("ioctl");
		close(fd);
	}

	return 0;
}

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=ioctl.diff

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 69c439f..eadaef1 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -704,6 +704,8 @@ static int fat_dir_ioctl(struct inode * 
 	struct dirent __user *d1;
 	int ret, short_only, both;
 
+	printk("==> fat_dir_ioctl(%x,%lx)\n", cmd, arg);
+
 	switch (cmd) {
 	case VFAT_IOCTL_READDIR_SHORT:
 		short_only = 1;
@@ -714,7 +716,9 @@ static int fat_dir_ioctl(struct inode * 
 		both = 1;
 		break;
 	default:
-		return fat_generic_ioctl(inode, filp, cmd, arg);
+		printk("call fat_generic_ioctl()\n");
+		ret = fat_generic_ioctl(inode, filp, cmd, arg);
+		goto out;
 	}
 
 	d1 = (struct dirent __user *)arg;
@@ -739,6 +743,8 @@ static int fat_dir_ioctl(struct inode * 
 	mutex_unlock(&inode->i_mutex);
 	if (ret >= 0)
 		ret = buf.result;
+out:
+	printk("<== fat_dir_ioctl() = %d\n", ret);
 	return ret;
 }
 
@@ -769,6 +775,8 @@ static long fat_compat_dir_ioctl(struct 
 	mm_segment_t oldfs = get_fs();
 	struct dirent d[2];
 
+	printk("==> fat_compat_dir_ioctl(%x,%lx)\n", cmd, arg);
+
 	switch (cmd) {
 	case VFAT_IOCTL_READDIR_BOTH32:
 		cmd = VFAT_IOCTL_READDIR_BOTH;
@@ -790,6 +798,7 @@ static long fat_compat_dir_ioctl(struct 
 		ret |= fat_compat_put_dirent32(&d[0], p);
 		ret |= fat_compat_put_dirent32(&d[1], p + 1);
 	}
+	printk("<== fat_compat_dir_ioctl() = %d\n", ret);
 	return ret;
 }
 #endif /* CONFIG_COMPAT */

--=-=-=--
