Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbTGROvb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271757AbTGROtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:49:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30853
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271804AbTGROL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:11:59 -0400
Date: Fri, 18 Jul 2003 15:26:20 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181426.h6IEQKpD017820@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix failed sethostname corrupting the data
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Stephan Maciej)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/kernel/sys.c linux-2.6.0-test1-ac2/kernel/sys.c
--- linux-2.6.0-test1/kernel/sys.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test1-ac2/kernel/sys.c	2003-07-14 14:56:29.000000000 +0100
@@ -1159,6 +1167,7 @@
 asmlinkage long sys_sethostname(char __user *name, int len)
 {
 	int errno;
+	char tmp[__NEW_UTS_LEN];
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1166,7 +1175,8 @@
 		return -EINVAL;
 	down_write(&uts_sem);
 	errno = -EFAULT;
-	if (!copy_from_user(system_utsname.nodename, name, len)) {
+	if (!copy_from_user(tmp, name, len)) {
+		memcpy(system_utsname.nodename, tmp, len);
 		system_utsname.nodename[len] = 0;
 		errno = 0;
 	}
@@ -1198,6 +1208,7 @@
 asmlinkage long sys_setdomainname(char __user *name, int len)
 {
 	int errno;
+	char tmp[__NEW_UTS_LEN];
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1206,9 +1217,10 @@
 
 	down_write(&uts_sem);
 	errno = -EFAULT;
-	if (!copy_from_user(system_utsname.domainname, name, len)) {
-		errno = 0;
+	if (!copy_from_user(tmp, name, len)) {
+		memcpy(system_utsname.domainname, tmp, len);
 		system_utsname.domainname[len] = 0;
+		errno = 0;
 	}
 	up_write(&uts_sem);
 	return errno;
