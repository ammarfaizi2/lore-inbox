Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUAFKFR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 05:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAFKFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 05:05:16 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:44951 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261784AbUAFKFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 05:05:07 -0500
Message-ID: <3FFA884E.1040203@colorfullife.com>
Date: Tue, 06 Jan 2004 11:05:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] speed up get_tgid_list
Content-Type: multipart/mixed;
 boundary="------------070306010302000806090806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070306010302000806090806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

get_tgid_list(n,) should lookup the next few valid pids after the nth 
task in the task list. The current implementation scans through the task 
list to find the nth task.

What about the attached patch? filp->f_version is indented for readdir 
implementations to store the current position. The patch stores the next 
pid in that field. If filp->f_version is not 0 (i.e. no lseek/seekdir) 
and the task is still found by find_task_by_pid, then get_tgid_list 
starts immediately from that position.

It's just a speed up, the worst case 
(fd=open("/proc");lseek(fd,1000000,SEEK_SET);readdir()) still walks 
through the whole task list.

--
    Manfred

--------------070306010302000806090806
Content-Type: text/plain;
 name="patch-tgid_lookup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-tgid_lookup"

--- 2.6/fs/proc/base.c	2003-12-20 09:19:13.000000000 +0100
+++ build-2.6/fs/proc/base.c	2004-01-06 10:50:35.000000000 +0100
@@ -1631,14 +1631,23 @@
  * tasklist lock while doing this, and we must release it before
  * we actually do the filldir itself, so we use a temp buffer..
  */
-static int get_tgid_list(int index, unsigned int *tgids)
+static int get_tgid_list(int index, unsigned long version, unsigned int *tgids)
 {
 	struct task_struct *p;
 	int nr_tgids = 0;
 
 	index--;
 	read_lock(&tasklist_lock);
-	for_each_process(p) {
+	p = NULL;
+	if  (version)
+		p = find_task_by_pid(version);
+
+	if (p)
+		index = 0;
+	else
+		p = next_task(&init_task);
+
+	for ( ; p != &init_task; p = next_task(p)) {
 		int tgid = p->pid;
 		if (!pid_alive(p))
 			continue;
@@ -1701,7 +1710,7 @@
 		nr++;
 	}
 
-	nr_tgids = get_tgid_list(nr, tgid_array);
+	nr_tgids = get_tgid_list(nr, filp->f_version, tgid_array);
 
 	for (i = 0; i < nr_tgids; i++) {
 		int tgid = tgid_array[i];
@@ -1710,8 +1719,10 @@
 
 		do buf[--j] = '0' + (tgid % 10); while (tgid/=10);
 
-		if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0)
+		if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0) {
+			filp->f_version = tgid;
 			break;
+		}
 		filp->f_pos++;
 	}
 	return 0;

--------------070306010302000806090806--

