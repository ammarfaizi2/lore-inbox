Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTIHPRo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTIHPRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:17:44 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:10640 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262575AbTIHPRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:17:37 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.23-pre3] do we want negative file descriptors?
Date: Mon, 8 Sep 2003 17:18:36 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081718.36517@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can see it does not make much sense to have negative fds
(which are in fact indexes for an array), so we can declare them unsigned.
Or not? (If yes, this one avoids some compiler warnings with gcc 3.3)

Eike

--- linux-2.4.23-pre3/include/linux/sched.h	2003-09-05 15:04:48.000000000 +0200
+++ linux-2.4.23-pre3-caliban/include/linux/sched.h	2003-09-07 11:04:34.000000000 +0200
@@ -172,9 +172,9 @@
 struct files_struct {
 	atomic_t count;
 	rwlock_t file_lock;	/* Protects all the below members.  Nests inside tsk->alloc_lock */
-	int max_fds;
-	int max_fdset;
-	int next_fd;
+	unsigned int max_fds;
+	unsigned int max_fdset;
+	unsigned int next_fd;
 	struct file ** fd;	/* current fd array */
 	fd_set *close_on_exec;
 	fd_set *open_fds;
--- linux-2.4.23-pre3/fs/file.c	2003-09-05 15:04:46.000000000 +0200
+++ linux-2.4.23-pre3-caliban/fs/file.c	2003-09-07 11:01:09.000000000 +0200
@@ -57,7 +57,8 @@
 int expand_fd_array(struct files_struct *files, int nr)
 {
 	struct file **new_fds;
-	int error, nfds;
+	int error;
+	unsigned int nfds;
 
 	
 	error = -EMFILE;
@@ -166,7 +167,8 @@
 int expand_fdset(struct files_struct *files, int nr)
 {
 	fd_set *new_openset = 0, *new_execset = 0;
-	int error, nfds = 0;
+	int error;
+	unsigned int nfds = 0;
 
 	error = -EMFILE;
 	if (files->max_fdset >= NR_OPEN || nr >= NR_OPEN)
