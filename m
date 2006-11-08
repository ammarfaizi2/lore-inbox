Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754138AbWKHEQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbWKHEQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 23:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754145AbWKHEQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 23:16:57 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:53490 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754138AbWKHEQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 23:16:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=CqJ/ZLwfX3vkXbaP7ww+aKRe0IqO9oaZlNZkXCNF7XepGx6gjNpwvsuc6h9TPNlgZqEGmfwhOxy9S2rGYJIG86V7+mRkIA+R26NXhtHT17Arn+rag+9PoFHKVfRMBdtgAHq9W1pEFnccs+8sbr4wNJBmUMsylsyPSNrkwytV8vQ=
Message-ID: <eb97335b0611072016y51e1625hcd6504fddfe9aa6c@mail.gmail.com>
Date: Tue, 7 Nov 2006 20:16:55 -0800
From: "Zack Weinberg" <zackw@panix.com>
To: linux-kernel@vger.kernel.org
Subject: RFC PATCH: apply security_syslog() only to the syslog() syscall, not to /proc/kmsg
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: ad15fbb2888145e9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Presently, the security checks for syslog(2) apply also to access to
/proc/kmsg, because /proc/kmsg's file_operations functions just call
do_syslog, and the call to security_syslog is in do_syslog, not
sys_syslog.  [The only callers of do_syslog are sys_syslog and
kmsg_{read,poll,open,release}.]  This has the effect, with the default
security policy, that no matter what the file permissions on
/proc/kmsg are, only a process with CAP_SYS_ADMIN can actually open or
read it.  [Yes, if you open /proc/kmsg as root and then drop
privileges, subsequent reads on that fd fail.]  In consequence, if one
wishes to run klogd as an unprivileged user, one is forced to jump
through awkward hoops - for example, Ubuntu's /etc/init.d/klogd
interposes a root-privileged "dd" process and a named pipe between
/proc/kmsg and the actual klogd.

I propose to move the security_syslog() check from do_syslog to
sys_syslog, so that the syscall remains restricted to CAP_SYS_ADMIN in
the default policy, but /proc/kmsg is governed by its file
permissions.  With the attached patch, I can run klogd as an
unprivileged user, having changed the ownership of /proc/kmsg to that
user before starting it, and it still works.  Equally, I can leave the
ownership alone but modify klogd to get messages from stdin, start it
with stdin open on /proc/kmsg (again unprivileged) and it works.

I think this is safe in the default security policy - /proc/kmsg
starts out owned by root and mode 400 - but I am not sure of the
impact on SELinux or other alternate policy frameworks.

Patch versus 2.6.19-rc4; please consider for the next release.

zw

Signed-off-by: Zack Weinberg <zackw@panix.com>

--- kernel/printk.c.unmod	2006-11-06 15:00:44.000000000 -0800
+++ kernel/printk.c	2006-11-06 15:01:51.000000000 -0800
@@ -187,10 +187,6 @@ int do_syslog(int type, char __user *buf
 	char c;
 	int error = 0;

-	error = security_syslog(type);
-	if (error)
-		return error;
-
 	switch (type) {
 	case 0:		/* Close log */
 		break;
@@ -317,6 +313,10 @@ out:

 asmlinkage long sys_syslog(int type, char __user *buf, int len)
 {
+	int error = security_syslog(type);
+	if (error)
+		return error;
+
 	return do_syslog(type, buf, len);
 }
