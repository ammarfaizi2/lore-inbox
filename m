Return-Path: <linux-kernel-owner+w=401wt.eu-S965033AbWLOBhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWLOBhU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWLOBgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:36:46 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:34046 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964929AbWLOBgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:36:25 -0500
Message-ID: <4581FC17.8080309@us.ibm.com>
Date: Thu, 14 Dec 2006 17:36:23 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Moore, Eric" <Eric.Moore@lsil.com>
Subject: Re: [PATCH] procfs: Fix race between proc_readdir and remove_proc_entry
References: <4581F42A.8090504@us.ibm.com>
In-Reply-To: <4581F42A.8090504@us.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, sent a corrupt and old version of the patch.  Here's
the correct patch.

While running a insmod/rmmod loop with the mptsas driver
(vanilla 2.6.19, IBM Intellistation Z30, SAS1064E controller
if it matters), I encountered a bad dereference of the
pointer "de":

spin_unlock(&proc_subdir_lock);
if (filldir(dirent, de->name, de->namelen, filp->f_pos,
            de->low_ino, de->mode >> 12) < 0)
	goto out;
spin_lock(&proc_subdir_lock);
filp->f_pos++;
de = de->next;

I believe what's happening here is that proc_readdir drops
proc_subdir_lock to call filldir() on the /proc/mpt directory
at the same time mptbase is being unloaded.  The unload causes
the removal of /proc/mpt, which means that de is overwritten
with the slab poison value as it is being freed.  We reacquire
the lock and try to grab the next value of de, but by then the
next pointer has been lost, and we crash.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 fs/proc/generic.c  |    7 +++++--
 fs/proc/inode.c    |    4 ++--
 fs/proc/internal.h |    3 +++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 4ba0300..7e77d7e 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -429,7 +429,7 @@ struct dentry *proc_lookup(struct inode 
 int proc_readdir(struct file * filp,
 	void * dirent, filldir_t filldir)
 {
-	struct proc_dir_entry * de;
+	struct proc_dir_entry * de, *next;
 	unsigned int ino;
 	int i;
 	struct inode *inode = filp->f_dentry->d_inode;
@@ -477,13 +477,16 @@ int proc_readdir(struct file * filp,
 
 			do {
 				/* filldir passes info to user space */
+				de_get(de);
 				spin_unlock(&proc_subdir_lock);
 				if (filldir(dirent, de->name, de->namelen, filp->f_pos,
 					    de->low_ino, de->mode >> 12) < 0)
 					goto out;
 				spin_lock(&proc_subdir_lock);
 				filp->f_pos++;
-				de = de->next;
+				next = de->next;
+				de_put(de);
+				de = next;
 			} while (de);
 			spin_unlock(&proc_subdir_lock);
 	}
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 49dfb2a..4b5a61c 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -21,7 +21,7 @@ #include <asm/uaccess.h>
 
 #include "internal.h"
 
-static inline struct proc_dir_entry * de_get(struct proc_dir_entry *de)
+struct proc_dir_entry * de_get(struct proc_dir_entry *de)
 {
 	if (de)
 		atomic_inc(&de->count);
@@ -31,7 +31,7 @@ static inline struct proc_dir_entry * de
 /*
  * Decrements the use count and checks for deferred deletion.
  */
-static void de_put(struct proc_dir_entry *de)
+void de_put(struct proc_dir_entry *de)
 {
 	if (de) {	
 		lock_kernel();		
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 987c773..f4751ac 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -65,3 +65,6 @@ static inline int proc_fd(struct inode *
 {
 	return PROC_I(inode)->fd;
 }
+
+struct proc_dir_entry * de_get(struct proc_dir_entry *de);
+void de_put(struct proc_dir_entry *de);

