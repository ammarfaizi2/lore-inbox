Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVIMVhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVIMVhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVIMVha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:37:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:43749 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750840AbVIMVha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:37:30 -0400
Message-ID: <43274503.7090303@in.ibm.com>
Date: Tue, 13 Sep 2005 16:30:43 -0500
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ZenIV.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk>
In-Reply-To: <20050913171215.GS25261@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> 
> Well...  If exposing the list of tasks in a group is OK, we can just leave
> ->permission NULL for that sucker.  If it's not (and arguably it can be
> sensitive information), we have a bigger problem - right now chroot boundary
> is the only control we have there; normally anyone can ls /proc/<whatever>/task
> and see other threads.
> 

Al, I understand that we can't set ->permission to NULL as it removes the 
chroot boundary check. If I understood you correctly, we need to put 
additional checks in proc_permission to ensure anyone doing ls 
/proc/<pid>/task won't be able to see other threads.

Coming back to the problem of being able to see the threads of a process 
whose main thread has done pthread_exit, it appears to me that the only 
hurdle is getting the ->fs pointer from task struct. Since all threads of 
the process point to the same fs structure, would it be okay if we try to 
get it from some other thread? Below is the patch I tried for this:


Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>

--- linux-2.6.13.1-orig/fs/proc/base.c	2005-09-13 23:53:06.000000000 -0500
+++ linux-2.6.13.1/fs/proc/base.c	2005-09-13 23:51:36.000000000 -0500
@@ -273,13 +273,25 @@ static int proc_cwd_link(struct inode *i

  static int proc_root_link(struct inode *inode, struct dentry **dentry, 
struct vfsmount **mnt)
  {
-	struct fs_struct *fs;
+	struct fs_struct *fs = NULL;
  	int result = -ENOENT;
-	task_lock(proc_task(inode));
-	fs = proc_task(inode)->fs;
-	if(fs)
-		atomic_inc(&fs->count);
-	task_unlock(proc_task(inode));
+	struct task_struct *task = proc_task(inode);
+	struct task_struct *leader_task = task;
+
+	read_lock(&tasklist_lock);
+	if (pid_alive(task)) {
+		do {
+			task_lock(task);
+			if ((fs = task->fs)) {
+				atomic_inc(&fs->count);
+				task_unlock(task);
+				break;
+			}
+			task_unlock(task);
+		} while ((task = next_thread(task)) != leader_task);
+	}
+	read_unlock(&tasklist_lock);
+
  	if (fs) {
  		read_lock(&fs->lock);
  		*mnt = mntget(fs->rootmnt);
