Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWBRXKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWBRXKe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 18:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWBRXKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 18:10:34 -0500
Received: from linuxhacker.ru ([217.76.32.60]:27056 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S932256AbWBRXKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 18:10:33 -0500
Date: Sun, 19 Feb 2006 01:11:53 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Missed error checking for intent's filp in open_namei in 2.6.15
Message-ID: <20060218231153.GA32003@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   It seems there is error check missing in open_namei for errors returned
   through intent.open.file (from lookup_instantiate_filp).
   If there is plain open performed, then such a check done inside
   __path_lookup_intent_open called from path_lookup_open(), but
   when the open is performed with O_CREAT flag set, then
   __path_lookup_intent_open is only called with LOOKUP_PARENT set where no file
   opening can occur yet. Later on lookup_hash is called where exact opening
   might take place and intent.open.file may be filled. If it is filled
   with error value of some sort, then we get kernel attempting to dereference
   this error value as address (and corresponding oops) in nameidata_to_filp()
   called from filp_open().
   While this is relatively simple to workaround in ->lookup() method by just
   checking lookup_instantiate_filp() return value and returning error as
   needed, this is not so easy in ->d_revalidate(), where we can only return
   "yes, dentry is valid" or "no, dentry is invalid, perform full lookup again",
   and just returning 0 on error would cause extra lookup (with potential
   extra costly RPCs).
   So in short, I believe that there should be no difference in error handling
   for opening a file and creating a file in open_namei() and propose
   this simple patch as a solution.
   What do you think?

--- fs/namei.c.orig	2006-02-19 00:33:24.000000000 +0200
+++ fs/namei.c	2006-02-19 00:46:28.000000000 +0200
@@ -1575,6 +1575,12 @@ do_last:
 		goto exit;
 	}
 
+        if (IS_ERR(nd->intent.open.file)) {
+		up(&dir->d_inode->i_sem);
+		error = PTR_ERR(nd->intent.open.file);
+		goto exit_dput;
+	}
+
 	/* Negative dentry, just create the file */
 	if (!path.dentry->d_inode) {
 		if (!IS_POSIXACL(dir->d_inode))

Bye,
    Oleg
