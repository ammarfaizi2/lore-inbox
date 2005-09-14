Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVINBrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVINBrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 21:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVINBrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 21:47:37 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:61665 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932571AbVINBrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 21:47:36 -0400
Message-ID: <43278116.8020403@in.ibm.com>
Date: Tue, 13 Sep 2005 20:47:02 -0500
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com> <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> I don't think this is wrong per se, but you shouldn't take the tasklist 
> lock normally. You're better off just doing

Linus,

I incarporated the path that doesn't hold tasklist lock unnecessarily. The 
patch is below. This seems to work without any problems for me.

If the decision is to remove ->permission, I can send a small patch I have 
that removes .permission entry from proc_task_inode_operations. Either way 
fixes the problem I found.

Thanks and regards,
Sripathi.

Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>

--- linux-2.6.13.1-orig/fs/proc/base.c	2005-09-14 03:46:22.000000000 -0500
+++ linux-2.6.13.1/fs/proc/base.c	2005-09-14 03:48:35.000000000 -0500
@@ -275,11 +275,33 @@ static int proc_root_link(struct inode *
  {
  	struct fs_struct *fs;
  	int result = -ENOENT;
-	task_lock(proc_task(inode));
-	fs = proc_task(inode)->fs;
-	if(fs)
+	struct task_struct *leader = proc_task(inode);
+
+	task_lock(leader);
+	fs = leader->fs;
+	if (fs) {
  		atomic_inc(&fs->count);
-	task_unlock(proc_task(inode));
+		task_unlock(leader);
+	} else {
+		/* Try to get fs from sub-threads */
+		task_unlock(leader);
+		struct task_struct *task = leader;
+		read_lock(&tasklist_lock);
+		if (pid_alive(task)) {
+			while ((task = next_thread(task)) != leader) {
+				task_lock(task);
+				fs = task->fs;
+				if (fs) {
+					atomic_inc(&fs->count);
+					task_unlock(task);
+					break;
+				}
+				task_unlock(task);
+			}
+		}
+		read_unlock(&tasklist_lock);
+	}
+
  	if (fs) {
  		read_lock(&fs->lock);
  		*mnt = mntget(fs->rootmnt);

