Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269157AbUHaUdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269157AbUHaUdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUHaUc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:32:58 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:4814 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S269157AbUHaU0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:26:49 -0400
Message-ID: <4134DEFB.2070607@colorfullife.com>
Date: Tue, 31 Aug 2004 22:26:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Roger Luethi <rl@hellgate.ch>
Subject: [PATCH] fix f_version optimization for get_tgid_list
Content-Type: multipart/mixed;
 boundary="------------090000040807070005090109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090000040807070005090109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the kernel contains an optimization that skips the linked list walk in 
get_tgid_list for the common case of sequential accesses.
Unfortunately the optimization is buggy (missing NULL pointer check for 
the result of find_task_by_pid) and broken (actually - broken twice: the 
tgid value that is stored in f_version is always 0 because tgid is 
overwritten when the string is created and additionally the common case 
is not filldir < 0, it's running out of nr_tgids).

The attached patch fixes these bugs.

Roger: could you run your 100k processes test against a kernel with this 
fix applied? I'm just interested how much it helps. One obvious result 
are fewer getdents64 syscalls: instead of returning 20 entries (480 
bytes) the new code fills the user space buffer completely (42 
entries/syscall).

Andrew, could you add the patch to your -mm tree?

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

--------------090000040807070005090109
Content-Type: text/plain;
 name="patch-tgid-bugfixes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-tgid-bugfixes"

--- 2.6/fs/proc/base.c	2004-08-20 19:59:19.000000000 +0200
+++ build-2.6/fs/proc/base.c	2004-08-31 21:42:28.000000000 +0200
@@ -1689,7 +1689,7 @@ static int get_tgid_list(int index, unsi
 	p = NULL;
 	if (version) {
 		p = find_task_by_pid(version);
-		if (!thread_group_leader(p))
+		if (p && !thread_group_leader(p))
 			p = NULL;
 	}
 
@@ -1752,6 +1752,7 @@ int proc_pid_readdir(struct file * filp,
 	char buf[PROC_NUMBUF];
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
 	unsigned int nr_tgids, i;
+	int next_tgid;
 
 	if (!nr) {
 		ino_t ino = fake_ino(0,PROC_TGID_INO);
@@ -1761,26 +1762,45 @@ int proc_pid_readdir(struct file * filp,
 		nr++;
 	}
 
-	/*
-	 * f_version caches the last tgid which was returned from readdir
+	/* f_version caches the tgid value that the last readdir call couldn't
+	 * return. lseek aka telldir automagically resets f_version to 0.
 	 */
-	nr_tgids = get_tgid_list(nr, filp->f_version, tgid_array);
-
-	for (i = 0; i < nr_tgids; i++) {
-		int tgid = tgid_array[i];
-		ino_t ino = fake_ino(tgid,PROC_TGID_INO);
-		unsigned long j = PROC_NUMBUF;
-
-		do
-			buf[--j] = '0' + (tgid % 10);
-		while ((tgid /= 10) != 0);
-
-		if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0) {
-			filp->f_version = tgid;
+	next_tgid = filp->f_version;
+	filp->f_version = 0;
+	for (;;) {
+		nr_tgids = get_tgid_list(nr, next_tgid, tgid_array);
+		if (!nr_tgids) {
+			/* no more entries ! */
 			break;
 		}
-		filp->f_pos++;
+		next_tgid = 0;
+
+		/* do not use the last found pid, reserve it for next_tgid */
+		if (nr_tgids == PROC_MAXPIDS) {
+			nr_tgids--;
+			next_tgid = tgid_array[nr_tgids];
+		}
+		
+		for (i=0;i<nr_tgids;i++) {
+			int tgid = tgid_array[i];
+			ino_t ino = fake_ino(tgid,PROC_TGID_INO);
+			unsigned long j = PROC_NUMBUF;
+
+			do
+				buf[--j] = '0' + (tgid % 10);
+			while ((tgid /= 10) != 0);
+
+			if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0) {
+				/* returning this tgid failed, save it as the first
+				 * pid for the next readir call */
+				filp->f_version = tgid_array[i];
+				goto out;
+			}
+			filp->f_pos++;
+			nr++;
+		}
 	}
+out:
 	return 0;
 }
 

--------------090000040807070005090109--
