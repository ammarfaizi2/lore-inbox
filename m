Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWFTLuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWFTLuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWFTLuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:50:09 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:10625 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030223AbWFTLts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:49:48 -0400
Message-Id: <20060620114708.454448000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:05 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Oleg Drokin <green@linuxhacker.ru>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/13] [PATCH] Missed error checking for intents filp in open_namei().
Content-Disposition: inline; filename=missed-error-checking-for-intent-s-filp-in-open_namei.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Oleg Drokin <green@linuxhacker.ru>

It seems there is error check missing in open_namei for errors returned
through intent.open.file (from lookup_instantiate_filp).

If there is plain open performed, then such a check done inside
__path_lookup_intent_open called from path_lookup_open(), but when the open
is performed with O_CREAT flag set, then __path_lookup_intent_open is only
called with LOOKUP_PARENT set where no file opening can occur yet.

Later on lookup_hash is called where exact opening might take place and
intent.open.file may be filled.  If it is filled with error value of some
sort, then we get kernel attempting to dereference this error value as
address (and corresponding oops) in nameidata_to_filp() called from
filp_open().

While this is relatively simple to workaround in ->lookup() method by just
checking lookup_instantiate_filp() return value and returning error as
needed, this is not so easy in ->d_revalidate(), where we can only return
"yes, dentry is valid" or "no, dentry is invalid, perform full lookup
again", and just returning 0 on error would cause extra lookup (with
potential extra costly RPCs).

So in short, I believe that there should be no difference in error handling
for opening a file and creating a file in open_namei() and propose this
simple patch as a solution.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/namei.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.16.21.orig/fs/namei.c
+++ linux-2.6.16.21/fs/namei.c
@@ -1628,6 +1628,12 @@ do_last:
 		goto exit;
 	}
 
+	if (IS_ERR(nd->intent.open.file)) {
+		mutex_unlock(&dir->d_inode->i_mutex);
+		error = PTR_ERR(nd->intent.open.file);
+		goto exit_dput;
+	}
+
 	/* Negative dentry, just create the file */
 	if (!path.dentry->d_inode) {
 		if (!IS_POSIXACL(dir->d_inode))

--
