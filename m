Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTGGTQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTGGTQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:16:13 -0400
Received: from pat.uio.no ([129.240.130.16]:27267 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264248AbTGGTQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:16:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16137.51802.41123.551648@charged.uio.no>
Date: Mon, 7 Jul 2003 21:30:34 +0200
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: opening symlinks with O_CREAT under latest 2.5.74
In-Reply-To: <20030707154628.GA3220@vana.vc.cvut.cz>
References: <20030707154628.GA3220@vana.vc.cvut.cz>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Petr Vandrovec <vandrove@vc.cvut.cz> writes:

     > Hi,
     >   couple of things stopped working on my box
     > where I have /dev/vc/XX as symlinks to /dev/ttyXX, and some
     > things use /dev/vc/XX and some /dev/ttyXX. After last update
     > hour ago things which use /dev/vc/XX stopped working for
     > non-root - they now fail with EACCES error if they attempt to
     > redirect its input or output through '>' or '<>' bash
     > redirection operators:

Whoops. Looks like I missed an assumption in open_namei().
Does the following patch fix the problem?

Cheers,
  Trond

--- linux-2.5.74-up/fs/namei.c.orig	2003-06-30 08:49:25.000000000 +0200
+++ linux-2.5.74-up/fs/namei.c	2003-07-07 21:25:00.000000000 +0200
@@ -1344,6 +1344,7 @@
 	 * stored in nd->last.name and we will have to putname() it when we
 	 * are done. Procfs-like symlinks just set LAST_BIND.
 	 */
+	nd->flags |= LOOKUP_PARENT;
 	error = security_inode_follow_link(dentry, nd);
 	if (error)
 		goto exit_dput;
@@ -1352,6 +1353,7 @@
 	dput(dentry);
 	if (error)
 		return error;
+	nd->flags &= ~LOOKUP_PARENT;
 	if (nd->last_type == LAST_BIND) {
 		dentry = nd->dentry;
 		goto ok;
