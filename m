Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTLMSsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 13:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbTLMSsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 13:48:25 -0500
Received: from fep06-svc.mail.telepac.pt ([194.65.5.211]:48769 "EHLO
	fep06-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S265270AbTLMSsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 13:48:24 -0500
Date: Sat, 13 Dec 2003 12:23:46 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.24-pre1 fix 'noexec' behaviour
Message-ID: <20031213122346.GA1609@hobbes.netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16-cvs20031210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo.


This patch submitted by Ullrich Drepper to 2.6 last week fixes the 
behaviour of 'noexec' mounted partitions. Up until now it was possible to 
circumvent the 'noexec' flag and run binaries off a 'noexec' partition by 
using ld-linux.so.2 or any other executable loader. This patch allows to 
properly honour the 'noexec' behaviour.

Please review and apply.


Regards,


		Nuno



--- linux-2.4.24-pre1/mm/mmap.c.orig	2003-12-13 11:52:56.943963096 +0000
+++ linux-2.4.24-pre1/mm/mmap.c	2003-12-13 11:55:37.674528336 +0000
@@ -14,6 +14,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/personality.h>
+#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -400,8 +401,13 @@
 	int error;
 	rb_node_t ** rb_link, * rb_parent;
 
-	if (file && (!file->f_op || !file->f_op->mmap))
-		return -ENODEV;
+	if (file) {
+		if (!file->f_op || !file->f_op->mmap)
+			return -ENODEV;
+
+		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+			return -EPERM;
+	}
 
 	if (!len)
 		return addr;
