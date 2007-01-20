Return-Path: <linux-kernel-owner+w=401wt.eu-S965297AbXATToz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbXATToz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 14:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965354AbXATToz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 14:44:55 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:47878 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965297AbXATToy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 14:44:54 -0500
Date: Sat, 20 Jan 2007 11:44:56 -0800
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Containers <containers@lists.osdl.org>,
       clg@fr.ibm.com, "David C. Hansen" <haveblue@us.ibm.com>,
       serue@us.ibm.com, ebiederm@xmission.com
Subject: [PATCH 2/2] Explicitly set pgid/sid of init
Message-ID: <20070120194456.GA15691@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pls treat this patch as Patch 2/2 where Patch 1/2 is

	http://lkml.org/lkml/2007/1/19/159
---

From: Sukadev Bhattiprolu <sukadev@us.ibm.com>

Explicitly set pgid and sid of init process to 1.

Signed-off-by: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>
Cc: Serge Hallyn <serue@us.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: containers@lists.osdl.org
---
 init/main.c   |    1 +
 kernel/exit.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: lx26-20-rc4-mm1/init/main.c
===================================================================
--- lx26-20-rc4-mm1.orig/init/main.c	2007-01-20 11:12:00.803672744 -0800
+++ lx26-20-rc4-mm1/init/main.c	2007-01-20 11:12:20.786634872 -0800
@@ -774,6 +774,7 @@ static int __init init(void * unused)
 	 */
 	init_pid_ns.child_reaper = current;
 
+	__set_special_pids(1, 1);
 	cad_pid = task_pid(current);
 
 	smp_prepare_cpus(max_cpus);
Index: lx26-20-rc4-mm1/kernel/exit.c
===================================================================
--- lx26-20-rc4-mm1.orig/kernel/exit.c	2007-01-20 11:12:00.803672744 -0800
+++ lx26-20-rc4-mm1/kernel/exit.c	2007-01-20 11:12:20.787634720 -0800
@@ -297,12 +297,12 @@ void __set_special_pids(pid_t session, p
 {
 	struct task_struct *curr = current->group_leader;
 
-	if (process_session(curr) != session) {
+	if (pid_nr(task_session(curr)) != session) {
 		detach_pid(curr, PIDTYPE_SID);
 		set_signal_session(curr->signal, session);
 		attach_pid(curr, PIDTYPE_SID, find_pid(session));
 	}
-	if (process_group(curr) != pgrp) {
+	if (pid_nr(task_pgrp(curr)) != pgrp) {
 		detach_pid(curr, PIDTYPE_PGID);
 		curr->signal->pgrp = pgrp;
 		attach_pid(curr, PIDTYPE_PGID, find_pid(pgrp));
