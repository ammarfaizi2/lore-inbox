Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbRERUDz>; Fri, 18 May 2001 16:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbRERUDi>; Fri, 18 May 2001 16:03:38 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:1681 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S261504AbRERUDU>;
	Fri, 18 May 2001 16:03:20 -0400
Message-ID: <3B058003.81A01B77@mandrakesoft.com>
Date: Fri, 18 May 2001 16:03:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: viro@math.psu.edu, rddunlap@att.net, jack@suse.cz,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.5.3: quota initcall
Content-Type: multipart/mixed;
 boundary="------------7A0FE63FEC77EFCB6DB41AA3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7A0FE63FEC77EFCB6DB41AA3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

IMHO this is an obvious change, but it is untested...  dquot_hash and
dqstats are correctly declared static and in BSS, and thus are
automatically cleared at kernel startup.

Since quota init now just printk's a startup message, we can safely make
it an initcall.

-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
--------------7A0FE63FEC77EFCB6DB41AA3
Content-Type: text/plain; charset=us-ascii;
 name="quota-initcall-2.4.5.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="quota-initcall-2.4.5.3.patch"

Index: linux_2_4/fs/dquot.c
diff -u linux_2_4/fs/dquot.c:1.1.1.50 linux_2_4/fs/dquot.c:1.1.1.50.4.1
--- linux_2_4/fs/dquot.c:1.1.1.50	Tue May 15 04:36:48 2001
+++ linux_2_4/fs/dquot.c	Fri May 18 12:55:25 2001
@@ -1343,13 +1343,11 @@
 }
 
 
-void __init dquot_init_hash(void)
+static int __init dquot_init(void)
 {
 	printk(KERN_NOTICE "VFS: Diskquotas version %s initialized\n", __DQUOT_VERSION__);
-
-	memset(dquot_hash, 0, sizeof(dquot_hash));
-	memset((caddr_t)&dqstats, 0, sizeof(dqstats));
 }
+__initcall(dquot_init);
 
 /*
  * Definitions of diskquota operations.
Index: linux_2_4/init/main.c
diff -u linux_2_4/init/main.c:1.1.1.62 linux_2_4/init/main.c:1.1.1.62.4.1
--- linux_2_4/init/main.c:1.1.1.62	Tue May 15 04:37:56 2001
+++ linux_2_4/init/main.c	Fri May 18 12:55:25 2001
@@ -108,9 +108,6 @@
 #if defined(CONFIG_SYSVIPC)
 extern void ipc_init(void);
 #endif
-#if defined(CONFIG_QUOTA)
-extern void dquot_init_hash(void);
-#endif
 
 /*
  * Boot command-line arguments

--------------7A0FE63FEC77EFCB6DB41AA3--

