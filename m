Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWDZGpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWDZGpH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 02:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDZGpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 02:45:07 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:51613 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750879AbWDZGpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 02:45:05 -0400
Date: Wed, 26 Apr 2006 02:45:03 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Linus Torvalds <torvalds@osdl.org>
cc: Al Viro <viro@ftp.linux.org.uk>, Chris Wright <chrisw@sous-sol.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: [PATCH] LSM: add missing hook to do_compat_readv_writev()
Message-ID: <Pine.LNX.4.64.0604260237260.26341@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses a flaw in LSM, where there is no mediation of readv() 
and writev() in for 32-bit compatible apps using a 64-bit kernel.

This bug was discovered and fixed initially in the native readv/writev 
code [1], but was not fixed in the compat code.  Thanks to Al for spotting 
this one.


Please apply.

Signed-off-by: James Morris <jmorris@namei.org> 
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


[1] http://lwn.net/Articles/154282/

---

diff -purN -X dontdiff linux-2.6.17-rc2.o/fs/compat.c linux-2.6.17-rc2.fix/fs/compat.c
--- linux-2.6.17-rc2.o/fs/compat.c	2006-04-19 23:31:24.000000000 -0400
+++ linux-2.6.17-rc2.fix/fs/compat.c	2006-04-25 20:41:39.000000000 -0400
@@ -1217,6 +1217,10 @@ static ssize_t compat_do_readv_writev(in
 	if (ret < 0)
 		goto out;
 
+	ret = security_file_permission(file, type == READ ? MAY_READ:MAY_WRITE);
+	if (ret)
+		goto out;
+
 	fnv = NULL;
 	if (type == READ) {
 		fn = file->f_op->read;
