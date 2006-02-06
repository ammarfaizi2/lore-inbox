Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWBFTzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWBFTzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWBFTzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:55:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12270 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932339AbWBFTzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:55:08 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 11/20] ioprio: Update ioprio to handle pspaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
	<m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:51:58 -0700
In-Reply-To: <m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:49:20 -0700")
Message-ID: <m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/ioprio.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

42c8b99a7c1417f8fc587f86c218a0be10ec27d0
diff --git a/fs/ioprio.c b/fs/ioprio.c
index ca77008..008301b 100644
--- a/fs/ioprio.c
+++ b/fs/ioprio.c
@@ -24,6 +24,7 @@
 #include <linux/blkdev.h>
 #include <linux/capability.h>
 #include <linux/syscalls.h>
+#include <linux/pspace.h>
 
 static int set_task_ioprio(struct task_struct *task, int ioprio)
 {
@@ -78,18 +79,18 @@ asmlinkage long sys_ioprio_set(int which
 			if (!who)
 				p = current;
 			else
-				p = find_task_by_pid(who);
+				p = find_task_by_pid(current->pspace, who);
 			if (p)
 				ret = set_task_ioprio(p, ioprio);
 			break;
 		case IOPRIO_WHO_PGRP:
 			if (!who)
 				who = process_group(current);
-			do_each_task_pid(who, PIDTYPE_PGID, p) {
+			do_each_task_pid(current->pspace, who, PIDTYPE_PGID, p) {
 				ret = set_task_ioprio(p, ioprio);
 				if (ret)
 					break;
-			} while_each_task_pid(who, PIDTYPE_PGID, p);
+			} while_each_task_pid(current->pspace, who, PIDTYPE_PGID, p);
 			break;
 		case IOPRIO_WHO_USER:
 			if (!who)
@@ -131,19 +132,19 @@ asmlinkage long sys_ioprio_get(int which
 			if (!who)
 				p = current;
 			else
-				p = find_task_by_pid(who);
+				p = find_task_by_pid(current->pspace, who);
 			if (p)
 				ret = p->ioprio;
 			break;
 		case IOPRIO_WHO_PGRP:
 			if (!who)
 				who = process_group(current);
-			do_each_task_pid(who, PIDTYPE_PGID, p) {
+			do_each_task_pid(current->pspace, who, PIDTYPE_PGID, p) {
 				if (ret == -ESRCH)
 					ret = p->ioprio;
 				else
 					ret = ioprio_best(ret, p->ioprio);
-			} while_each_task_pid(who, PIDTYPE_PGID, p);
+			} while_each_task_pid(current->pspace, who, PIDTYPE_PGID, p);
 			break;
 		case IOPRIO_WHO_USER:
 			if (!who)
-- 
1.1.5.g3480

