Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbUKWOkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUKWOkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUKWOkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:40:06 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:40167 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261262AbUKWOjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:39:01 -0500
Subject: [PATCH 2.6.9] fork: move security_task_alloc() after p->parent
	initialization
From: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       guillaume.thouvenin@bull.net
Date: Tue, 23 Nov 2004 15:38:51 +0100
Message-Id: <1101220731.6210.142.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 15:45:56,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 15:46:04,
	Serialize complete at 23/11/2004 15:46:04
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we register a LSM hook and if we use the parameter passed to
security_task_alloc(struct task_struct *p), the value of p->parent is
wrong. This patch move the call to security_task_alloc() after the
initialization of the field p->parent. 

Guillaume,

Signed-Off-By: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

--- kernel/fork.c.orig	2004-10-19 08:41:53.000000000 +0200
+++ kernel/fork.c	2004-11-23 15:29:25.799903744 +0100
@@ -1006,8 +1006,6 @@ static task_t *copy_process(unsigned lon
  	}
 #endif
 
-	if ((retval = security_task_alloc(p)))
-		goto bad_fork_cleanup_policy;
 	if ((retval = audit_alloc(p)))
 		goto bad_fork_cleanup_security;
 	/* copy all the process information */
@@ -1092,6 +1090,9 @@ static task_t *copy_process(unsigned lon
 		p->real_parent = current;
 	p->parent = p->real_parent;
 
+	if ((retval = security_task_alloc(p)))
+		goto bad_fork_cleanup_policy;
+
 	if (clone_flags & CLONE_THREAD) {
 		spin_lock(&current->sighand->siglock);
 		/*


