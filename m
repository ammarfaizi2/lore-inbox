Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRCRSPf>; Sun, 18 Mar 2001 13:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131253AbRCRSP0>; Sun, 18 Mar 2001 13:15:26 -0500
Received: from smtp.tpomail.net ([212.246.196.7]:17118 "HELO smtp.koti.soon.fi")
	by vger.kernel.org with SMTP id <S131248AbRCRSPQ>;
	Sun, 18 Mar 2001 13:15:16 -0500
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
X-No-Archive: yes
Reply-To: Topi Miettinen <Topi.Miettinen@koti.tpo.fi>
From: Topi Miettinen <Topi.Miettinen@koti.tpo.fi>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Non-root sshd and capabilities
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-1020552840"
Date: Sun, 18 Mar 2001 20:12:51 +0200
Message-Id: <20010318181419.A4197417C@smtp.koti.soon.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-1020552840
Content-Type: text/plain; charset=us-ascii

(Please cc: me, I'm not subscribed.)

Using the magical prctl() call it's possible to run daemons as non-root
while still possessing some capabilities. For full support, patched kernel
with ext2 capabilities is required, but if the daemon doesn't exec()
anything (for example, by emulating exec() with mmap()), stock 2.4 is
enough.

This works well for programs like pppd, hwclock and XFree86. There is a
problem if the daemon uses setuid() and setgid() to change identity, like
sshd or cron. In function cap_emulate_setxuid() (in kernel/sys.c) the
capabilities are cleared when IDs are switched. However, the check misses
the case where old_*uid are already nonzero. This patch attempts to fix
the problem.

There are still problems with sequence
orig_euid = geteuid();
seteuid(65534);
/* work */
seteuid(orig_euid);

Any suggestions?

-Topi


--==_Exmh_-1020552840
Content-Type: text/plain ; name="cap_emulate_setxuid"; charset=us-ascii
Content-Description: cap_emulate_setxuid
Content-Disposition: attachment; filename="cap_emulate_setxuid"

diff -ru kernel/sys.c.orig kernel/sys.c
--- kernel/sys.c.orig	Mon Oct 16 22:58:51 2000
+++ kernel/sys.c	Mon Mar 12 23:40:26 2001
@@ -449,9 +449,13 @@
 extern inline void cap_emulate_setxuid(int old_ruid, int old_euid, 
 				       int old_suid)
 {
-	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
-	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
+	if ((!cap_isclear(current->cap_inheritable) ||
+	     !cap_isclear(current->cap_permitted) ||
+	     !cap_isclear(current->cap_effective)) &&
+	    (current->uid != old_ruid && current->euid != old_euid &&
+	     current->suid != old_suid) &&
 	    !current->keep_capabilities) {
+		cap_clear(current->cap_inheritable);
 		cap_clear(current->cap_permitted);
 		cap_clear(current->cap_effective);
 	}

--==_Exmh_-1020552840--


