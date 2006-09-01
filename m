Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWIABEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWIABEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWIABEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:04:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61889 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932500AbWIABEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:04:34 -0400
X-Originating-IP: [172.16.57.183]
From: "Chris Snook" <csnook@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: willy@w.ods.org
Subject: [PATCH 2.4.33.2] enforce RLIMIT_NOFILE in poll()
Date: Thu, 31 Aug 2006 21:06:55 -0400
Message-ID: <20060901.PbR.07536400@egw.corp.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Mailer: AngleMail for eGroupWare (http://www.egroupware.org) v 1.2.008
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Snook <csnook@redhat.com>

POSIX states that poll() shall fail with EINVAL if nfds > OPEN_MAX.  In this
context, POSIX is referring to sysconf(OPEN_MAX), which is the value of
current->rlim[RLIMIT_NOFILE].rlim_cur, not the compile-time constant which
happens to be named OPEN_MAX.  The current code will permit polling up to 1024
file descriptors even if RLIMIT_NOFILE is less than 1024, which POSIX forbids.
 The current code also breaks polling greater than 1024 file descriptors if
the process has less than 1024 valid descriptors, even if RLIMIT_NOFILE >
1024.  While it is silly to poll duplicate or invalid file descriptors, POSIX
permits this, and it worked circa 2.4.18, and currently works up to 1024.
This patch directly checks the RLIMIT_NOFILE value, and permits exactly what
POSIX suggests, no more, no less.

Signed-off-by: Chris Snook <csnook@redhat.com>
---

diff -urNp linux-2.4.33.2-orig/fs/select.c linux-2.4.33.2-patch/fs/select.c
--- linux-2.4.33.2-orig/fs/select.c	2006-08-22 16:13:54.000000000 -0400
+++ linux-2.4.33.2-patch/fs/select.c	2006-08-31 13:43:39.000000000 -0400
@@ -417,7 +417,7 @@ asmlinkage long sys_poll(struct pollfd *
 	int nchunks, nleft;

 	/* Do a sanity check on nfds ... */
-	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
+	if (nfds > current->rlim[RLIMIT_NOFILE].rlim_cur)
 		return -EINVAL;

 	if (timeout) {

