Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTJZR1J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTJZR1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:27:09 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:44679 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263340AbTJZR1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:27:04 -0500
Message-ID: <3F9C03CB.8030200@colorfullife.com>
Date: Sun, 26 Oct 2003 18:26:35 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: viro@parcelfarce.linux.theplanet.co.uk, arekm@pld-linux.org,
       linux-kernel@vger.kernel.org, jmorris@redhat.com, sds@epoch.ncsc.mil,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: 2.6.0-test9 and sleeping function called from invalid context
References: <200310260045.52094.arekm@pld-linux.org>	<20031025185055.4d9273ae.akpm@osdl.org>	<20031025224950.001b4055.akpm@osdl.org>	<20031026082610.GU7665@parcelfarce.linux.theplanet.co.uk> <20031026014153.0fdbd50a.akpm@osdl.org> <3F9BAA1B.6080203@colorfullife.com>
In-Reply-To: <3F9BAA1B.6080203@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------000601080109050704090705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000601080109050704090705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

What about the attached patch?

The lifetime of dentries is quite long, thus I'd prefer if the race 
between proc_pid_lookup and sys_exit is closed.

--
    Manfred


--------------000601080109050704090705
Content-Type: text/plain;
 name="patch-proc_dentry"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-proc_dentry"

--- 2.6/fs/proc/base.c	2003-10-09 21:23:15.000000000 +0200
+++ build-2.6/fs/proc/base.c	2003-10-26 16:25:24.000000000 +0100
@@ -1524,6 +1524,7 @@
 	struct inode *inode;
 	struct proc_inode *ei;
 	unsigned tgid;
+	int died;
 
 	if (dentry->d_name.len == 4 && !memcmp(dentry->d_name.name,"self",4)) {
 		inode = new_inode(dir->i_sb);
@@ -1567,12 +1568,21 @@
 
 	dentry->d_op = &pid_base_dentry_operations;
 
+	died = 0;
+	d_add(dentry, inode);
 	spin_lock(&task->proc_lock);
 	task->proc_dentry = dentry;
-	d_add(dentry, inode);
+	if (!pid_alive(task)) {
+		dentry = proc_pid_unhash(task);
+		died = 1;
+	}
 	spin_unlock(&task->proc_lock);
 
 	put_task_struct(task);
+	if (died) {
+		proc_pid_flush(dentry);
+		goto out;
+	}
 	return NULL;
 out:
 	return ERR_PTR(-ENOENT);
@@ -1612,10 +1622,7 @@
 
 	dentry->d_op = &pid_base_dentry_operations;
 
-	spin_lock(&task->proc_lock);
-	task->proc_dentry = dentry;
 	d_add(dentry, inode);
-	spin_unlock(&task->proc_lock);
 
 	put_task_struct(task);
 	return NULL;

--------------000601080109050704090705--

