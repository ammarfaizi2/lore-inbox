Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTBTRPd>; Thu, 20 Feb 2003 12:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbTBTROY>; Thu, 20 Feb 2003 12:14:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60426 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265402AbTBTRNz>; Thu, 20 Feb 2003 12:13:55 -0500
Date: Thu, 20 Feb 2003 09:20:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Alex Larsson <alexl@redhat.com>,
       <procps-list@redhat.com>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <Pine.LNX.4.44.0302200902260.2493-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302200918300.2493-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Linus Torvalds wrote:
> 
> It would just be _so_ much nicer if the threads would show up as 
> subdirectories ie /proc/<tgid>/<tid>/xxx. More scalable, more readable, 
> and just generally more sane.

It shouldn't even be all that much harder. You only really need to add the 
"lookup()" and "readdir()" logic to the pid-fd's, and they both should be 
fairly straightforward, ie something like the appended should do the 
lookup() part.

(UNTESTED! NOT COMPILED! PROBABLY HORRIBLY BUGGY! CAVEAT USER! CONCEPTUAL 
CODE ONLY! YOU GET THE IDEA! I'M GETTING HOARSE FROM ALL THE SHOUTING!)

		Linus

---
===== base.c 1.39 vs edited =====
--- 1.39/fs/proc/base.c	Sat Feb 15 19:30:17 2003
+++ edited/base.c	Thu Feb 20 09:18:15 2003
@@ -964,10 +964,15 @@
 	struct task_struct *task = proc_task(dir);
 	struct pid_entry *p;
 	struct proc_inode *ei;
+	unsigned long tid;
 
 	error = -ENOENT;
 	inode = NULL;
 
+	tid = name_to_int(dentry);
+	if (tid != ~0U)
+		goto thread_lookup;
+                                
 	for (p = base_stuff; p->name; p++) {
 		if (p->len != dentry->d_name.len)
 			continue;
@@ -1052,6 +1057,30 @@
 	if (!proc_task(dentry->d_inode)->pid)
 		d_drop(dentry);
 	return NULL;
+
+thread_lookup: {
+	struct task_struct *thread;
+	read_lock(&tasklist_lock);
+	thread = task;
+	while ((thread = next_thread(thread)) != task) {
+		if (thread->pid == tid)
+			goto found_thread;
+	}
+	read_unlock(&tasklist_lock);
+	return ERR_PTR(-ENOENT);
+
+found_thread:
+	get_task_struct(thread);
+	read_unlock(&tasklist_lock);
+
+	inode = proc_pid_make_inode(sb, thread, 0x800000);
+	put_task_struct(thread);
+	if (!inode)
+		ERR_PTR(-ENOENT);
+	dentry->d_op = dentry->d_parent->d_op;
+	d_add(dentry, inode);
+	return NULL;
+}
 
 out:
 	return ERR_PTR(error);

