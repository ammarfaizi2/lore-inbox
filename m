Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133062AbREFHQL>; Sun, 6 May 2001 03:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133067AbREFHQB>; Sun, 6 May 2001 03:16:01 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:25363 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S133062AbREFHPv>;
	Sun, 6 May 2001 03:15:51 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4 add suffix for uname -r
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 06 May 2001 17:15:45 +1000
Message-ID: <3024.989133345@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A frequent requirement is to rename vmlinuz-2.x.y to 2.x.y-old or
2.x.y.save to preserve a working kernel.  But renaming the image does
not change the value of uname -r so it still tries to use modules
2.x.y, which defeats the purpose of saving an working kernel.

Normally I would say that this is a user space problem but it requires
finding every program that uses uname(2) and every script that uses
uname -r and changing them, not practical (modutils, alsa, pciutils,
/etc/rc.d, mkinitrd etc.).  Instead this small patch to the kernel adds
the boot time option unamersfx (uname -r suffix).  Rename a kernel
image from 2.x.y to 2.x.y.foo, rename /lib/modules/2.x.y to 2.x.y.foo
and boot with unamersfx=.foo to safely pick up the old kernel.

Objects that "know" the value of uname -r that they were compiled with
will not work with unamersfx.  Are there any?

Against 2.4.4.

Index: 4.1/init/main.c
--- 4.1/init/main.c Sat, 28 Apr 2001 18:38:57 +1000 kaos (linux-2.4/k/11_main.c 1.1.5.1.1.4 644)
+++ 4.1(w)/init/main.c Sun, 06 May 2001 16:50:44 +1000 kaos (linux-2.4/k/11_main.c 1.1.5.1.1.4 644)
@@ -405,10 +405,20 @@ static int __init quiet_kernel(char *str
 	return 1;
 }
 
+static int __init unamersfx(char *str)
+{
+	int l1 = strlen(system_utsname.release), l2 = strlen(str);
+	if ((l1 + l2) > sizeof(system_utsname.release))
+		return 0;
+	memcpy(system_utsname.release+l1, str+1, l2);
+	return 1;
+}
+
 __setup("ro", readonly);
 __setup("rw", readwrite);
 __setup("debug", debug_kernel);
 __setup("quiet", quiet_kernel);
+__setup("unamersfx", unamersfx);
 
 /*
  * This is a simple kernel command line parsing function: it parses
Index: 4.1/Documentation/kernel-parameters.txt
--- 4.1/Documentation/kernel-parameters.txt Sun, 22 Apr 2001 08:26:07 +1000 kaos (linux-2.4/V/c/21_kernel-par 1.1.1.1.1.1 644)
+++ 4.1(w)/Documentation/kernel-parameters.txt Sun, 06 May 2001 15:39:06 +1000 kaos (linux-2.4/V/c/21_kernel-par 1.1.1.1.1.1 644)
@@ -574,7 +574,11 @@ running once the system is up.
 	uart401=	[HW,SOUND]
 
 	uart6850=	[HW,SOUND]
- 
+
+	unamersfx=	[KNL] Copy the string as a suffix on the result of
+			uname -r.  Use unamersfx=.xxx if you have renamed your
+			kernel and modules from foo to foo.xxx
+
 	usbfix		[BUGS=IA-64] 
  
 	video=		[FB] frame buffer configuration.

