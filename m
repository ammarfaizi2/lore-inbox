Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTHUHjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 03:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTHUHjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 03:39:23 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:25869
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S262489AbTHUHjV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 03:39:21 -0400
Subject: [PATCH] Allow either tid or pid in SCM_CREDENTIALS struct ucred
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>, kuznet@ms2.inr.ac.ru
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061451559.4386.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 21 Aug 2003 00:39:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Could you stick this in -mm and see if anyone complains?  It fixes an
apparent bug in the validation of the SCM_CREDENTIALS structure in a
unix-domain socket sendmsg().

I found this because with Valgrind, the sendmsg call is being done in a
different thread from the one which did a getpid() to fill out the
SCM_CREDENTIALS structure, which causes the kernel to fail the sendmsg
with EPERM.  In the general case, this would cause a multithreaded
program sending messages with SCM_CREDENTIALS to appear schizophrenic to
a recipient, because every message would have a different pid depending
on which thread happened to send it.

If you use SCM_CREDENTIALS with a unix domain socket, and you're
non-root, then the kernel double-checks the values you supply for pid,
uid and gid in struct ucred.  In the case of uid or gid, it allows any
of effective, saved or real uid/gid.  In the case of pid, it only allows
current->pid, which is actually the tid.

This patch also makes it accept tgid in the SCM_CREDENTIALS pid field. 
That is, a threaded program can either supply the ID of the whole
process (tgid) or a particular thread (pid).  

Thanks,
	J

 net/core/scm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN net/core/scm.c~scm_allow_tgid net/core/scm.c
--- local-2.6/net/core/scm.c~scm_allow_tgid	2003-08-20 19:52:40.000000000 -0700
+++ local-2.6-jeremy/net/core/scm.c	2003-08-21 00:28:10.295629745 -0700
@@ -41,7 +41,8 @@
 
 static __inline__ int scm_check_creds(struct ucred *creds)
 {
-	if ((creds->pid == current->pid || capable(CAP_SYS_ADMIN)) &&
+	if (((creds->pid == current->pid || creds->pid == current->tgid) ||
+	     capable(CAP_SYS_ADMIN)) &&
 	    ((creds->uid == current->uid || creds->uid == current->euid ||
 	      creds->uid == current->suid) || capable(CAP_SETUID)) &&
 	    ((creds->gid == current->gid || creds->gid == current->egid ||

_


