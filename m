Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTKUWdT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 17:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTKUWdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 17:33:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:12508 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261460AbTKUWdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 17:33:15 -0500
Message-ID: <3FBE92D2.7080300@austin.ibm.com>
Date: Fri, 21 Nov 2003 16:33:54 -0600
From: Nathan Lynch <nathanl@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: zwane@arm.linux.org.uk, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] better locking in fs/proc/generic.c (bug 1552)
Content-Type: multipart/mixed;
 boundary="------------090708020108090401020506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090708020108090401020506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi-

I have been experiencing various oopses in the procfs code when rapidly 
adding and removing /proc entries.  It seems that the main problem is 
lack of proper locking around code that traverses or modifies the 
proc_dir_entry tree.  There is also the matter of proc_kill_inodes() 
clearing the file pointer's f_op, which caused oopses in vfs_read() in 
my testing.

I have followed the example of proc_lookup() and used 
lock_kernel/unlock_kernel around critical sections.  I'm not much of a 
filesystem person, so I would appreciate a review of the patch from 
folks more knowledgeable.  I have been testing the code on a couple of 
dual processor machines (i386 and ppc64) without incident.

Please see http://bugme.osdl.org/show_bug.cgi?id=1552 for oops traces 
and a testcase.  Andrew posted a one-liner patch there which was 
included in mm4 which is also needed.

Patch is against 2.6.0-test9-mm4.

Thanks,
Nathan

--------------090708020108090401020506
Content-Type: text/plain;
 name="proc_generic_locking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_generic_locking.patch"

diff -Naurp linux-2.6.0-test9-mm4.orig/fs/proc/generic.c linux-2.6.0-test9-mm4.new/fs/proc/generic.c
--- linux-2.6.0-test9-mm4.orig/fs/proc/generic.c	2003-10-25 13:44:56.000000000 -0500
+++ linux-2.6.0-test9-mm4.new/fs/proc/generic.c	2003-11-21 14:47:00.000000000 -0600
@@ -260,6 +260,7 @@ static int xlate_proc_name(const char *n
 	int			len;
 
 	de = &proc_root;
+	lock_kernel();
 	while (1) {
 		next = strchr(cp, '/');
 		if (!next)
@@ -270,10 +271,13 @@ static int xlate_proc_name(const char *n
 			if (proc_match(len, cp, de))
 				break;
 		}
-		if (!de)
+		if (!de) {
+			unlock_kernel();
 			return -ENOENT;
+		}
 		cp += len + 1;
 	}
+	unlock_kernel();
 	*residual = cp;
 	*ret = de;
 	return 0;
@@ -462,6 +466,7 @@ static int proc_register(struct proc_dir
 	if (i < 0)
 		return -EAGAIN;
 	dp->low_ino = i;
+	lock_kernel(); /* needed to protect against concurrent registration */
 	dp->next = dir->subdir;
 	dp->parent = dir;
 	dir->subdir = dp;
@@ -480,6 +485,7 @@ static int proc_register(struct proc_dir
 		if (dp->proc_iops == NULL)
 			dp->proc_iops = &proc_file_inode_operations;
 	}
+	unlock_kernel();
 	return 0;
 }
 
@@ -507,7 +513,6 @@ static void proc_kill_inodes(struct proc
 		if (PDE(inode) != de)
 			continue;
 		fops = filp->f_op;
-		filp->f_op = NULL;
 		fops_put(fops);
 	}
 	file_list_unlock();
@@ -643,6 +648,7 @@ void remove_proc_entry(const char *name,
 	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
 		goto out;
 	len = strlen(fn);
+	lock_kernel();
 	for (p = &parent->subdir; *p; p=&(*p)->next ) {
 		if (!proc_match(len, fn, *p))
 			continue;
@@ -664,6 +670,7 @@ void remove_proc_entry(const char *name,
 		}
 		break;
 	}
+	unlock_kernel();
 out:
 	return;
 }

--------------090708020108090401020506--

