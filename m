Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTAGDGD>; Mon, 6 Jan 2003 22:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbTAGDGD>; Mon, 6 Jan 2003 22:06:03 -0500
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:2228 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S267277AbTAGDGB>; Mon, 6 Jan 2003 22:06:01 -0500
Subject: Re: [PATCH] Deprecated exec_usermodehelper, enhance
	call_usermodehelper
From: Marcel Holtmann <marcel@holtmann.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@zip.com.au, Thomas Sailer <sailer@ife.ee.ethz.ch>,
       Jose Orlando Pereira <jop@di.uminho.pt>,
       J.E.J.Bottomley@HansenPartnership.com
In-Reply-To: <20030106053144.083C72C276@lists.samba.org>
References: <20030106053144.083C72C276@lists.samba.org>
Content-Type: multipart/mixed; boundary="=-RFd7TJ35Vc8g4FmlT/lM"
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Jan 2003 04:12:18 +0100
Message-Id: <1041909147.1016.12.camel@pegasus.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RFd7TJ35Vc8g4FmlT/lM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Rusty,

> OK.  This patch does that.  Thomas, Marcel, James?  This touches code
> I don't use, so although the transformation is fairly trivial...

it looks ok to me, but I like to have the attached patch for the bt3c_cs
driver. My test yesterday was successful and so I vote for inclusion,
like Thomas does.

Regards

Marcel


--=-RFd7TJ35Vc8g4FmlT/lM
Content-Disposition: attachment; filename=patch-2.4.54-bt3c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch-2.4.54-bt3c; charset=ISO-8859-15

diff -urN linux-2.5.54/drivers/bluetooth/bt3c_cs.c linux-2.5.54-mh/drivers/=
bluetooth/bt3c_cs.c
--- linux-2.5.54/drivers/bluetooth/bt3c_cs.c	Thu Jan  2 04:23:16 2003
+++ linux-2.5.54-mh/drivers/bluetooth/bt3c_cs.c	Mon Jan  6 22:25:30 2003
@@ -24,18 +24,14 @@
 #include <linux/config.h>
 #include <linux/module.h>
=20
-#define __KERNEL_SYSCALLS__
-
 #include <linux/kernel.h>
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/sched.h>
-#include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/errno.h>
-#include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
@@ -405,7 +401,6 @@
=20
=20
=20
-
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D HCI interface =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D */
=20
=20
@@ -489,65 +484,23 @@
=20
=20
 #define FW_LOADER  "/sbin/bluefw"
-static int errno;
-
-
-static int bt3c_fw_loader_exec(void *dev)
-{
-	char *argv[] =3D { FW_LOADER, "pccard", dev, NULL };
-	char *envp[] =3D { "HOME=3D/", "TERM=3Dlinux", "PATH=3D/sbin:/usr/sbin:/b=
in:/usr/bin", NULL };
-	int err;
-
-	err =3D exec_usermodehelper(FW_LOADER, argv, envp);
-	if (err)
-		printk(KERN_WARNING "bt3c_cs: Failed to exec \"%s pccard %s\".\n", FW_LO=
ADER, (char *)dev);
-
-	return err;
-}
=20
=20
 static int bt3c_firmware_load(bt3c_info_t *info)
 {
-	sigset_t tmpsig;
 	char dev[16];
-	pid_t pid;
-	int result;
+	int err;
=20
-	/* Check if root fs is mounted */
-	if (!current->fs->root) {
-		printk(KERN_WARNING "bt3c_cs: Root filesystem is not mounted.\n");
-		return -EPERM;
-	}
+	char *argv[] =3D { FW_LOADER, "pccard", dev, NULL };
+	char *envp[] =3D { "HOME=3D/", "TERM=3Dlinux", "PATH=3D/sbin:/usr/sbin:/b=
in:/usr/bin", NULL };
=20
 	sprintf(dev, "%04x", info->link.io.BasePort1);
=20
-	pid =3D kernel_thread(bt3c_fw_loader_exec, (void *)dev, 0);
-	if (pid < 0) {
-		printk(KERN_WARNING "bt3c_cs: Forking of kernel thread failed (errno=3D%=
d).\n", -pid);
-		return pid;
-	}
-
-	/* Block signals, everything but SIGKILL/SIGSTOP */
-	spin_lock_irq(&current->sig->siglock);
-	tmpsig =3D current->blocked;
-	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
-	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
-
-	result =3D waitpid(pid, NULL, __WCLONE);
-
-	/* Allow signals again */
-	spin_lock_irq(&current->sig->siglock);
-	current->blocked =3D tmpsig;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
-
-	if (result !=3D pid) {
-		printk(KERN_WARNING "bt3c_cs: Waiting for pid %d failed (errno=3D%d).\n"=
, pid, -result);
-		return -result;
-	}
+	err =3D call_usermodehelper(FW_LOADER, argv, envp, 1);
+	if (err)
+		printk(KERN_WARNING "bt3c_cs: Failed to run \"%s pccard %s\" (errno=3D%d=
).\n", FW_LOADER, dev, err);
=20
-	return 0;
+	return err;
 }
=20
=20

--=-RFd7TJ35Vc8g4FmlT/lM--

