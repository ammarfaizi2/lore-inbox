Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267690AbUG3OcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267690AbUG3OcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 10:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267693AbUG3OcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 10:32:19 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:53718 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S267690AbUG3Obj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 10:31:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.8-rc2-mm1: DVB: "errno" undefined
Date: Fri, 30 Jul 2004 16:30:17 +0200
User-Agent: KMail/1.6.2
References: <20040728020444.4dca7e23.akpm@osdl.org> <200407300044.13738.lists@kenneth.aafloy.net> <20040729232427.GK23589@fs.tum.de>
In-Reply-To: <20040729232427.GK23589@fs.tum.de>
Cc: Kenneth =?iso-8859-15?q?Aafl=F8y?= <lists@kenneth.aafloy.net>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, hunold@linuxtv.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_8tlCBBBtt/Xhwal";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301630.20864.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_8tlCBBBtt/Xhwal
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freitag, 30. Juli 2004 01:24, Adrian Bunk <bunk@fs.tum.de> wrote:

> The removal of errno from this three drivers is currently only in -mm.
>=20
> So unless someone forwards them (they were sent by Andi Kleen as gcc 3.5=
=20
> build fixes, but he apparently didn't test a modular build) to Linus=20
> which hopefully won't happen before the affected modules are properly=20
> fixed, Linus' tree isn't affected.

Actually, the problem has its origin in my removal of all in-kernel
syscalls (except execve, which is non-trivial) earlier this year.
This change was blindly reverted by the maintainer, while at the same
time the local errno variable was removed. See also
http://linux.bkbits.net:8080/linux-2.5/hist/drivers/media/dvb/frontends/tda=
1004x.c

This patch is the one that was already merged earlier. I'm now also
removing the definitions for the kernel syscalls on i386 to make it
harder to reintroduce them again. This was already done for ppc64,
the others should probably follow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 drivers/media/dvb/frontends/alps_tdlb7.c |   10 ++++------
 drivers/media/dvb/frontends/sp887x.c     |    9 ++++-----
 drivers/media/dvb/frontends/tda1004x.c   |   10 ++++------
 drivers/net/wireless/prism54/isl_38xx.c  |    2 --
 include/asm-i386/unistd.h                |    8 --------
 5 files changed, 12 insertions(+), 27 deletions(-)

=3D=3D=3D=3D=3D drivers/media/dvb/frontends/alps_tdlb7.c 1.14 vs edited =3D=
=3D=3D=3D=3D
=2D-- 1.14/drivers/media/dvb/frontends/alps_tdlb7.c	Wed Jul 14 02:09:53 2004
+++ edited/drivers/media/dvb/frontends/alps_tdlb7.c	Fri Jul 30 16:00:28 2004
@@ -28,8 +28,6 @@
    =20
 */ =20
=20
=2D
=2D#define __KERNEL_SYSCALLS__
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/vmalloc.h>
@@ -148,13 +146,13 @@
 	loff_t filesize;
 	char *dp;
=20
=2D	fd =3D open(fn, 0, 0);
+	fd =3D sys_open(fn, 0, 0);
 	if (fd =3D=3D -1) {
                 printk("%s: unable to open '%s'.\n", __FUNCTION__, fn);
 		return -EIO;
 	}
=20
=2D	filesize =3D lseek(fd, 0L, 2);
+	filesize =3D sys_lseek(fd, 0L, 2);
 	if (filesize <=3D 0 || filesize < SP8870_FIRMWARE_OFFSET + SP8870_FIRMWAR=
E_SIZE) {
 	        printk("%s: firmware filesize to small '%s'\n", __FUNCTION__, fn);
 		sys_close(fd);
@@ -168,8 +166,8 @@
 		return -EIO;
 	}
=20
=2D	lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
=2D	if (read(fd, dp, SP8870_FIRMWARE_SIZE) !=3D SP8870_FIRMWARE_SIZE) {
+	sys_lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
+	if (sys_read(fd, dp, SP8870_FIRMWARE_SIZE) !=3D SP8870_FIRMWARE_SIZE) {
 		printk("%s: failed to read '%s'.\n",__FUNCTION__, fn);
 		vfree(dp);
 		sys_close(fd);
=3D=3D=3D=3D=3D drivers/media/dvb/frontends/sp887x.c 1.12 vs edited =3D=3D=
=3D=3D=3D
=2D-- 1.12/drivers/media/dvb/frontends/sp887x.c	Wed Jul 14 02:09:55 2004
+++ edited/drivers/media/dvb/frontends/sp887x.c	Fri Jul 30 16:00:28 2004
@@ -12,7 +12,6 @@
    next 0x4000 loaded. This may change in future versions.
  */
=20
=2D#define __KERNEL_SYSCALLS__
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
@@ -209,13 +208,13 @@
=20
 	// Load the firmware
 	set_fs(get_ds());
=2D	fd =3D open(sp887x_firmware, 0, 0);
+	fd =3D sys_open(sp887x_firmware, 0, 0);
 	if (fd < 0) {
 		printk(KERN_WARNING "%s: Unable to open firmware %s\n", __FUNCTION__,
 		       sp887x_firmware);
 		return -EIO;
 	}
=2D	filesize =3D lseek(fd, 0L, 2);
+	filesize =3D sys_lseek(fd, 0L, 2);
 	if (filesize <=3D 0) {
 		printk(KERN_WARNING "%s: Firmware %s is empty\n", __FUNCTION__,
 		       sp887x_firmware);
@@ -237,8 +236,8 @@
 	// read it!
 	// read the first 16384 bytes from the file
 	// ignore the first 10 bytes
=2D	lseek(fd, 10, 0);
=2D	if (read(fd, firmware, fw_size) !=3D fw_size) {
+	sys_lseek(fd, 10, 0);
+	if (sys_read(fd, firmware, fw_size) !=3D fw_size) {
 		printk(KERN_WARNING "%s: Failed to read firmware\n", __FUNCTION__);
 		vfree(firmware);
 		sys_close(fd);
=3D=3D=3D=3D=3D drivers/media/dvb/frontends/tda1004x.c 1.14 vs edited =3D=
=3D=3D=3D=3D
=2D-- 1.14/drivers/media/dvb/frontends/tda1004x.c	Wed Jul 14 02:09:55 2004
+++ edited/drivers/media/dvb/frontends/tda1004x.c	Fri Jul 30 16:02:15 2004
@@ -32,7 +32,6 @@
  */
=20
=20
=2D#define __KERNEL_SYSCALLS__
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
@@ -40,7 +39,6 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
=2D#include <linux/unistd.h>
 #include <linux/fcntl.h>
 #include <linux/errno.h>
 #include <linux/syscalls.h>
@@ -397,13 +395,13 @@
=20
 	// Load the firmware
 	set_fs(get_ds());
=2D	fd =3D open(tda1004x_firmware, 0, 0);
+	fd =3D sys_open(tda1004x_firmware, 0, 0);
 	if (fd < 0) {
 		printk("%s: Unable to open firmware %s\n", __FUNCTION__,
 		       tda1004x_firmware);
 		return -EIO;
 	}
=2D	filesize =3D lseek(fd, 0L, 2);
+	filesize =3D sys_lseek(fd, 0L, 2);
 	if (filesize <=3D 0) {
 		printk("%s: Firmware %s is empty\n", __FUNCTION__,
 		       tda1004x_firmware);
@@ -434,8 +432,8 @@
 	}
=20
 	// read it!
=2D	lseek(fd, fw_offset, 0);
=2D	if (read(fd, firmware, fw_size) !=3D fw_size) {
+	sys_lseek(fd, fw_offset, 0);
+	if (sys_read(fd, firmware, fw_size) !=3D fw_size) {
 		printk("%s: Failed to read firmware\n", __FUNCTION__);
 		vfree(firmware);
 		sys_close(fd);
=3D=3D=3D=3D=3D drivers/net/wireless/prism54/isl_38xx.c 1.3 vs edited =3D=
=3D=3D=3D=3D
=2D-- 1.3/drivers/net/wireless/prism54/isl_38xx.c	Sat Jun  5 13:45:32 2004
+++ edited/drivers/net/wireless/prism54/isl_38xx.c	Fri Jul 30 16:06:25 2004
@@ -18,8 +18,6 @@
  *
  */
=20
=2D#define __KERNEL_SYSCALLS__
=2D
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/types.h>
=3D=3D=3D=3D=3D include/asm-i386/unistd.h 1.39 vs edited =3D=3D=3D=3D=3D
=2D-- 1.39/include/asm-i386/unistd.h	Wed Jul 14 02:09:34 2004
+++ edited/include/asm-i386/unistd.h	Fri Jul 30 16:07:06 2004
@@ -431,15 +431,7 @@
  * won't be any messing with the stack from main(), but we define
  * some others too.
  */
=2Dstatic inline _syscall0(pid_t,setsid)
=2Dstatic inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
=2Dstatic inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
=2Dstatic inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
=2Dstatic inline _syscall1(int,dup,int,fd)
 static inline _syscall3(int,execve,const char *,file,char **,argv,char **,=
envp)
=2Dstatic inline _syscall3(int,open,const char *,file,int,flag,int,mode)
=2Dstatic inline _syscall1(int,close,int,fd)
=2Dstatic inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,opti=
ons)
=20
 asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long by=
tecount);
 asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,

--Boundary-02=_8tlCBBBtt/Xhwal
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBClt85t5GS2LDRf4RAiCoAJ4hl56w3ZM9BLbQKrFmSTiJFiObOQCggTyW
ESSGberCCnQRuL2FRFuFXwQ=
=D0pl
-----END PGP SIGNATURE-----

--Boundary-02=_8tlCBBBtt/Xhwal--
