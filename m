Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293640AbSCATNk>; Fri, 1 Mar 2002 14:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293633AbSCATMT>; Fri, 1 Mar 2002 14:12:19 -0500
Received: from hanoi.cronyx.ru ([144.206.181.53]:62222 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id <S293641AbSCATLC>;
	Fri, 1 Mar 2002 14:11:02 -0500
Message-ID: <007501c1c154$bca973c0$48b5ce90@crox>
From: "Serge Vakulenko" <vak@cronyx.ru>
To: <alan@cymru.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] added SIGIO support for /dev/tap0 and other netlink-based drivers
Date: Fri, 1 Mar 2002 22:10:22 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0072_01C1C16D.E1EBD650"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0072_01C1C16D.E1EBD650
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit

Dear Alan,

I added fasync support to netlink_dev.c.
It permits signal-based i/o on /dev/tap0 and other
netlink-based devices.

The sources of small testing program included.
___
Best wishes,
Serge Vakulenko

------=_NextPart_000_0072_01C1C16D.E1EBD650
Content-Type: application/octet-stream;
	name="netlnk_dev.pch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="netlnk_dev.pch"

Adding SIGIO support for /dev/tapX and other netlink-based drivers.=0A=
=0A=
Use the following program to test it:=0A=
=0A=
	#include <stdio.h>=0A=
	#include <stdlib.h>=0A=
	#include <unistd.h>=0A=
	#include <signal.h>=0A=
	=0A=
	#define __USE_GNU=0A=
	#include <fcntl.h>=0A=
	=0A=
	#define DEVNAME	"/dev/tap0"=0A=
	#define SIGNUM	SIGIO=0A=
	=0A=
	void sigio (int signum)=0A=
	{=0A=
		printf ("Got signal %d\n", signum);=0A=
		fflush (stdout);=0A=
	}=0A=
	=0A=
	int main (int argc, char **argv)=0A=
	{=0A=
		int fd, flags;=0A=
	=0A=
		fd =3D open (DEVNAME, O_RDWR);=0A=
		if (fd < 0) {=0A=
			perror (DEVNAME);=0A=
			exit (1);=0A=
		}=0A=
		signal (SIGNUM, sigio);=0A=
		fcntl (fd, F_SETOWN, getpid());=0A=
		fcntl (fd, F_SETSIG, SIGNUM);=0A=
	=0A=
		flags =3D fcntl (fd, F_GETFL, 0);=0A=
		fcntl (fd, F_SETFL, flags | O_ASYNC);=0A=
	=0A=
		printf ("Waiting for i/o signal.\n");=0A=
		printf ("Ping /dev/tap0 interface.\n");=0A=
		for (;;)=0A=
			pause ();=0A=
	}=0A=
___=0A=
Best wishes,=0A=
Serge Vakulenko <vak@cronyx.ru>=0A=
=0A=
=0A=
--- /usr/src/linux-2.2.5/net/netlink/netlink_dev.c	Fri Aug 28 06:33:09 =
1998=0A=
+++ netlink_dev.c	Fri Mar  1 21:20:17 2002=0A=
@@ -25,6 +25,7 @@=0A=
 #include <linux/netlink.h>=0A=
 #include <linux/poll.h>=0A=
 #include <linux/init.h>=0A=
+#include <net/sock.h>=0A=
 =0A=
 #include <asm/system.h>=0A=
 #include <asm/uaccess.h>=0A=
@@ -148,11 +149,27 @@=0A=
 	return err;=0A=
 }=0A=
 =0A=
+static int netlink_fasync(int fd, struct file *filp, int on)=0A=
+{=0A=
+	struct inode *inode =3D filp->f_dentry->d_inode;=0A=
+	struct socket *sock =3D netlink_user[MINOR(inode->i_rdev)];=0A=
+	int retval;=0A=
+=0A=
+	lock_sock(sock->sk);=0A=
+	retval =3D fasync_helper(fd, filp, on, &sock->fasync_list);=0A=
+	release_sock(sock->sk);=0A=
+=0A=
+	if (retval <=3D 0)=0A=
+		return retval;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static int netlink_release(struct inode * inode, struct file * file)=0A=
 {=0A=
 	unsigned int minor =3D MINOR(inode->i_rdev);=0A=
 	struct socket *sock =3D netlink_user[minor];=0A=
 =0A=
+	netlink_fasync(-1, file, 0);=0A=
 	netlink_user[minor] =3D NULL;=0A=
 	open_map &=3D ~(1<<minor);=0A=
 	sock_release(sock);=0A=
@@ -187,7 +204,9 @@=0A=
 	NULL,		/* netlink_mmap */=0A=
 	netlink_open,=0A=
 	NULL,		/* flush */=0A=
-	netlink_release=0A=
+	netlink_release,=0A=
+	NULL,		/* no fsync */=0A=
+	netlink_fasync=0A=
 };=0A=
 =0A=
 __initfunc(int init_netlink(void))=0A=

------=_NextPart_000_0072_01C1C16D.E1EBD650--

