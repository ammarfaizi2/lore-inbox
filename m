Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVA0V51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVA0V51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVA0V50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:57:26 -0500
Received: from web52309.mail.yahoo.com ([206.190.39.104]:14677 "HELO
	web52309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261207AbVA0V41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:56:27 -0500
Message-ID: <20050127215619.56535.qmail@web52309.mail.yahoo.com>
Date: Thu, 27 Jan 2005 22:56:18 +0100 (CET)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: 2.6.11-rc2-mm1: kernel bad access while booting diskless client
To: akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1378567878-1106862978=:53309"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1378567878-1106862978=:53309
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

I'm getting a kernel Oops while booting 2.6.11-rc2-mm1
on a diskless (nfsroot based) embedded ppc system.
Vanilla 2.6.11-rc2 works Ok.

[...]
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 112k init
INIT: version 2.86 booting
Oops: kernel access of bad area, sig: 11 [#1]
[...]
TASK = c1643ae0[1] 'init' THREAD: c1646000
Last syscall: 106
[...]
NIP [c0060934] vfs_getattr+0x1c/0xa8
LR [c0060a14] vfs_stat+0x54/0x64
Call trace:
 [c0060a14] vfs_sysstat+0x54/0x64
 [c0060f24] sys_newstat+0x1c/0x54
 [c0003c40] ret_from_syscall+0x0/0x44
Kernel panic - not syncing: Attempted to kill init!


The cause of the bad access is a null inode->i_op
field that is passed to vfs_getattr() through the
corresponding struct dentry.
It triggers when vfs_getattr() blindly tries to check
inode->i_op->getattr without first checking that
inode->i_op is useable.

The attached patch workarounds the problem, by
checking inode->i_op before using it.

It is still unknown to me which code change is causing
now the appearance of the null i_op field on -rc2-mm1.
But probably you guys have better clues than me.

Cheers,
Albert



	
	
		
______________________________________________ 
Renovamos el Correo Yahoo!: ¡250 MB GRATIS! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
--0-1378567878-1106862978=:53309
Content-Type: text/plain; name="fix-kernel-bad-access-on-nfsroot.patch"
Content-Description: fix-kernel-bad-access-on-nfsroot.patch
Content-Disposition: inline; filename="fix-kernel-bad-access-on-nfsroot.patch"

--- a/fs/stat.c	2004-12-24 22:34:02.000000000 +0100
+++ b/fs/stat.c	2005-01-27 00:52:15.000000000 +0100
@@ -47,7 +47,7 @@ int vfs_getattr(struct vfsmount *mnt, st
 	if (retval)
 		return retval;
 
-	if (inode->i_op->getattr)
+	if (inode->i_op && inode->i_op->getattr)
 		return inode->i_op->getattr(mnt, dentry, stat);
 
 	generic_fillattr(inode, stat);

--0-1378567878-1106862978=:53309--
