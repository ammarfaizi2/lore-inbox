Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268138AbUHFP3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268138AbUHFP3w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUHFP3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:29:52 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:54660 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268140AbUHFPYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:24:24 -0400
Date: Fri, 6 Aug 2004 17:23:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: d_path errors
Message-ID: <20040806152356.GD2514@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there's some minor bug in the d_path handling (the nfsd one may not the
the correct fix, there's no failure path for it, so I just terminate the
string, and the last one in the audit subsystem is just a robustness
cleanup if somebody will extend d_path in the future, right now it's a
noop).

on a slightly different topic, Al, could you suggest how to hack d_path
so that it provides an absolute path with respect to the init_task root
directory?

d_path currently returns /meminfo for dentries from /proc, instead
of /proc/meminfo. I need to build '/proc/meminfo' instead. I'm unsure if
to hack d_path to do it internally, or if to work around d_path and to
walk the mountpoints externally to it. I think the internal one is
simpler though.

Index: linux-2.5/fs/compat.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/fs/compat.c,v
retrieving revision 1.35
diff -u -p -r1.35 compat.c
--- linux-2.5/fs/compat.c	13 Jul 2004 18:30:17 -0000	1.35
+++ linux-2.5/fs/compat.c	6 Aug 2004 14:58:05 -0000
@@ -429,6 +429,8 @@ asmlinkage long compat_sys_ioctl(unsigne
 			       		fn = d_path(filp->f_dentry,
 						filp->f_vfsmnt, path,
 						PAGE_SIZE);
+					if (IS_ERR(fn))
+						fn = "?";
 				}
 
 				sprintf(buf,"'%c'", (cmd>>24) & 0x3f);
Index: linux-2.5/fs/nfsd/export.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/fs/nfsd/export.c,v
retrieving revision 1.92
diff -u -p -r1.92 export.c
--- linux-2.5/fs/nfsd/export.c	19 May 2004 23:39:57 -0000	1.92
+++ linux-2.5/fs/nfsd/export.c	6 Aug 2004 15:02:54 -0000
@@ -294,6 +294,11 @@ void svc_export_request(struct cache_det
 
 	qword_add(bpp, blen, exp->ex_client->name);
 	pth = d_path(exp->ex_dentry, exp->ex_mnt, *bpp, *blen);
+	if (IS_ERR(pth)) {
+		/* is this correct? */
+		(*bpp)[0] = '\n';
+		return;
+	}
 	qword_add(bpp, blen, pth);
 	(*bpp)[-1] = '\n';
 }
Index: linux-2.5/kernel/audit.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/kernel/audit.c,v
retrieving revision 1.2
diff -u -p -r1.2 audit.c
--- linux-2.5/kernel/audit.c	12 Apr 2004 20:29:12 -0000	1.2
+++ linux-2.5/kernel/audit.c	6 Aug 2004 15:05:32 -0000
@@ -708,7 +708,7 @@ void audit_log_d_path(struct audit_buffe
 		audit_log_move(ab);
 	avail = sizeof(ab->tmp) - ab->len;
 	p = d_path(dentry, vfsmnt, ab->tmp + ab->len, avail);
-	if (p == ERR_PTR(-ENAMETOOLONG)) {
+	if (IS_ERR(p)) {
 		/* FIXME: can we save some information here? */
 		audit_log_format(ab, "<toolong>");
 	} else {
