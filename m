Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265417AbTF1Uox (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbTF1UoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:44:23 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:8467 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S265434AbTF1UlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:41:12 -0400
Subject: Patch 2.4.21 use propper type for pid -V
To: linux-kernel@vger.kernel.org
Date: Sat, 28 Jun 2003 22:55:25 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19WMjG-000Cqx-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi liste,
this is a small patch to fix functions that do not use the 
correct type for pid. daniele bellucci and i have worked this 
out. 

walter

--- fs/proc/base.c.org	2003-06-28 21:32:45.000000000 +0200
+++ fs/proc/base.c	2003-06-28 21:45:14.000000000 +0200
@@ -577,7 +577,8 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct task_struct *p = inode->u.proc_i.task;
-	unsigned int fd, pid, ino;
+	unsigned int fd, ino;
+	pid_t pid;
 	int retval;
 	char buf[NUMBUF];
 	struct files_struct * files;
@@ -640,7 +641,7 @@
 	void * dirent, filldir_t filldir)
 {
 	int i;
-	int pid;
+	pid_t pid;
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct pid_entry *p;
 
@@ -981,7 +982,8 @@
 
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry)
 {
-	unsigned int pid, c;
+	unsigned int c;
+	pid_t pid;
 	struct task_struct *task;
 	const char *name;
 	struct inode *inode;
@@ -1061,7 +1063,7 @@
  * tasklist lock while doing this, and we must release it before
  * we actually do the filldir itself, so we use a temp buffer..
  */
-static int get_pid_list(int index, unsigned int *pids)
+static int get_pid_list(int index, pid_t *pids)
 {
 	struct task_struct *p;
 	int nr_pids = 0;
@@ -1069,7 +1071,7 @@
 	index--;
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
-		int pid = p->pid;
+		pid_t pid = p->pid;
 		if (!pid)
 			continue;
 		if (--index >= 0)
@@ -1085,7 +1087,7 @@
 
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	unsigned int pid_array[PROC_MAXPIDS];
+	pid_t pid_array[PROC_MAXPIDS];
 	char buf[PROC_NUMBUF];
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
 	unsigned int nr_pids, i;
@@ -1101,7 +1103,7 @@
 	nr_pids = get_pid_list(nr, pid_array);
 
 	for (i = 0; i < nr_pids; i++) {
-		int pid = pid_array[i];
+		pid_t pid = pid_array[i];
 		ino_t ino = fake_ino(pid,PROC_PID_INO);
 		unsigned long j = PROC_NUMBUF;
 
-- 
