Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292888AbSB0UWL>; Wed, 27 Feb 2002 15:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292932AbSB0UV4>; Wed, 27 Feb 2002 15:21:56 -0500
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:12040 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S292931AbSB0UVX>; Wed, 27 Feb 2002 15:21:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eric Swalens <eric.swalens@easynet.be>
To: linux-kernel@vger.kernel.org
Subject: [BUG] execve("/bin/sh"...) in init/main.c
Date: Wed, 27 Feb 2002 21:21:39 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16gAZm-0000W3-00@bigglesworth.mail.be.easynet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If init cannot be executed, the init(.) function in init/main.c falls back to 
sh and calls execve("/bin/sh", argv_init, envp_init).

But if there is no "init=" in the command line, argv_init can contain 
something (most likely the "auto" preprended by lilo) and the shell will 
terminate immediately. (parse_options(.) does not handle this case since it 
does not find "init=").

I used the simple patch below to correct the problem.

Eric

--- linux-2.4.18/init/main.c    Mon Feb 25 20:38:13 2002
+++ linux/init/main.c   Wed Feb 27 18:46:51 2002
@@ -130,6 +130,7 @@
 char root_device_name[64];


+static char * argv_sh[2] = { "sh", NULL };
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 static char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };

@@ -835,6 +836,6 @@
        execve("/sbin/init",argv_init,envp_init);
        execve("/etc/init",argv_init,envp_init);
        execve("/bin/init",argv_init,envp_init);
-       execve("/bin/sh",argv_init,envp_init);
+       execve("/bin/sh",argv_sh,envp_init);
        panic("No init found.  Try passing init= option to kernel.");
 }
