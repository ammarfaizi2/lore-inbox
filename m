Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268266AbTBSBkC>; Tue, 18 Feb 2003 20:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268268AbTBSBkC>; Tue, 18 Feb 2003 20:40:02 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:39952 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268266AbTBSBj6>; Tue, 18 Feb 2003 20:39:58 -0500
Date: Wed, 19 Feb 2003 02:48:33 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <kronos@kronoz.cjb.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <20030217221837.Q2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302181516210.1336-100000@serv>
References: <20030214105338.E2092@almesberger.net> <Pine.LNX.4.44.0302141500540.1336-100000@serv>
 <20030214153039.G2092@almesberger.net> <Pine.LNX.4.44.0302142106140.1336-100000@serv>
 <20030214211226.I2092@almesberger.net> <Pine.LNX.4.44.0302150148010.1336-100000@serv>
 <20030214232818.J2092@almesberger.net> <Pine.LNX.4.44.0302151816550.1336-100000@serv>
 <20030217140423.N2092@almesberger.net> <Pine.LNX.4.44.0302172019220.1336-100000@serv>
 <20030217221837.Q2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Feb 2003, Werner Almesberger wrote:

> > failure: if the object is still busy, we just return -EBUSY. This is 
> > simple, but this doesn't work for modules, since during module exit you 
> > can't fail anymore.
> 
> That's a modules API problem. And yes, I think modules should
> eventually be able to say that they're busy.

As Rusty already correctly said, this is currently not possible with the 
current modules API. On the other hand he also jumps very quickly to 
conclusions, so let's look at all the options first and then decide how 
trivial they are.
Anyway, for now just keep this option in mind and let's look at the other
options, which don't require a module API change.

> By the way, a loong time ago, in the modules thread, I suggested
> a "decrement_module_count_and_return" function [1]. Such a
> construct would be useful in this specific case.

This would just be an optimization(?) for the module count, it doesn't 
change the general problem and is not useful as generic solution, so I'd 
rather put it back for now.

> > failure doesn't work with modules, so that only leaves the module count.
> 
> And how would you ensure correct access to static data in the
> absence of modules ? Any solution that _requires_ a module count
> looks highly suspicious to me.

In that case it would be kernel memory, which cannot be freed, so it will 
not go away and requires no module count.

> Likewise, possibly dynamically allocated data that is synchronized
> by the caller, e.g. "user" in "struct proc_dir_entry".

user?

> > The last solution sounds complicated, but exactly this is done for 
> > filesystems and we didn't really get rid of the second reference count, we 
> > just moved it somewhere else, where it hurts least.
> 
> Hmm, I'm confused. With "filesystem", do you mean the file system
> driver per se (e.g. "ext3"), or a specific instance of such a file
> system (e.g. /dev/hda1 mounted on /) ?

A generic file system as it's registered via register_filesystem. A file 
system exports lots of dynamic and static data and the only (used) module 
pointer you will find is in struct file_system_type (the owner pointer in 
struct file_operations is not used by any standard fs). It's interesting 
to see how file systems keep the module business at a minimum (no 
try_module_get() is still cheaper than the cheapest try_module_get()).

Um, it's getting late and I just played too much with procfs to find a 
sensible solution. Below is an experimental patch to add callback which 
would allow it to safely remove user data. Very lightly tested, so no 
guarantees.

bye, Roman

Index: include/linux/proc_fs.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/linux/proc_fs.h,v
retrieving revision 1.1.1.9
diff -u -p -r1.1.1.9 proc_fs.h
--- include/linux/proc_fs.h	27 Aug 2002 23:38:02 -0000	1.1.1.9
+++ include/linux/proc_fs.h	19 Feb 2003 00:46:28 -0000
@@ -69,6 +69,7 @@ struct proc_dir_entry {
 	void *data;
 	read_proc_t *read_proc;
 	write_proc_t *write_proc;
+	void (*release_proc)(struct proc_dir_entry *);
 	atomic_t count;		/* use count */
 	int deleted;		/* delete flag */
 	kdev_t	rdev;
Index: fs/proc/generic.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/proc/generic.c,v
retrieving revision 1.1.1.12
diff -u -p -r1.1.1.12 generic.c
--- fs/proc/generic.c	15 Feb 2003 01:25:07 -0000	1.1.1.12
+++ fs/proc/generic.c	19 Feb 2003 01:40:36 -0000
@@ -639,6 +639,8 @@ void free_proc_entry(struct proc_dir_ent
 	if (ino < PROC_DYNAMIC_FIRST ||
 	    ino >= PROC_DYNAMIC_FIRST+PROC_NDYNAMIC)
 		return;
+	if (de->release_proc)
+		de->release_proc(de);
 	if (S_ISLNK(de->mode) && de->data)
 		kfree(de->data);
 	kfree(de);
@@ -655,6 +657,7 @@ void remove_proc_entry(const char *name,
 	const char *fn = name;
 	int len;
 
+	lock_kernel();
 	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
 		goto out;
 	len = strlen(fn);
@@ -680,5 +683,6 @@ void remove_proc_entry(const char *name,
 		break;
 	}
 out:
+	unlock_kernel();
 	return;
 }
Index: fs/proc/inode.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/proc/inode.c,v
retrieving revision 1.1.1.13
diff -u -p -r1.1.1.13 inode.c
--- fs/proc/inode.c	1 Feb 2003 19:59:21 -0000	1.1.1.13
+++ fs/proc/inode.c	19 Feb 2003 01:40:36 -0000
@@ -23,13 +23,6 @@
 
 extern void free_proc_entry(struct proc_dir_entry *);
 
-static inline struct proc_dir_entry * de_get(struct proc_dir_entry *de)
-{
-	if (de)
-		atomic_inc(&de->count);
-	return de;
-}
-
 /*
  * Decrements the use count and checks for deferred deletion.
  */
@@ -44,11 +37,13 @@ static void de_put(struct proc_dir_entry
 		}
 
 		if (atomic_dec_and_test(&de->count)) {
+			struct module *owner = de->owner;
 			if (de->deleted) {
 				printk("de_put: deferred delete of %s\n",
 					de->name);
 				free_proc_entry(de);
 			}
+			module_put(owner);
 		}		
 		unlock_kernel();
 	}
@@ -71,11 +66,8 @@ static void proc_delete_inode(struct ino
 
 	/* Let go of any associated proc directory entry */
 	de = PROC_I(inode)->pde;
-	if (de) {
-		if (de->owner)
-			module_put(de->owner);
+	if (de)
 		de_put(de);
-	}
 }
 
 struct vfsmount *proc_mnt;
@@ -178,44 +170,36 @@ struct inode * proc_get_inode(struct sup
 	/*
 	 * Increment the use count so the dir entry can't disappear.
 	 */
-	de_get(de);
-#if 1
-/* shouldn't ever happen */
-if (de && de->deleted)
-printk("proc_iget: using deleted entry %s, count=%d\n", de->name, atomic_read(&de->count));
-#endif
+	if (!atomic_read(&de->count) && !try_module_get(de->owner))
+		return NULL;
+	atomic_inc(&de->count);
 
 	inode = iget(sb, ino);
 	if (!inode)
 		goto out_fail;
-	
+
 	PROC_I(inode)->pde = de;
-	if (de) {
-		if (de->mode) {
-			inode->i_mode = de->mode;
-			inode->i_uid = de->uid;
-			inode->i_gid = de->gid;
-		}
-		if (de->size)
-			inode->i_size = de->size;
-		if (de->nlink)
-			inode->i_nlink = de->nlink;
-		if (!try_module_get(de->owner))
-			goto out_fail;
-		if (de->proc_iops)
-			inode->i_op = de->proc_iops;
-		if (de->proc_fops)
-			inode->i_fop = de->proc_fops;
-		else if (S_ISBLK(de->mode)||S_ISCHR(de->mode)||S_ISFIFO(de->mode))
-			init_special_inode(inode,de->mode,kdev_t_to_nr(de->rdev));
+	if (de->mode) {
+		inode->i_mode = de->mode;
+		inode->i_uid = de->uid;
+		inode->i_gid = de->gid;
 	}
+	if (de->size)
+		inode->i_size = de->size;
+	if (de->nlink)
+		inode->i_nlink = de->nlink;
+	if (de->proc_iops)
+		inode->i_op = de->proc_iops;
+	if (de->proc_fops)
+		inode->i_fop = de->proc_fops;
+	else if (S_ISBLK(de->mode)||S_ISCHR(de->mode)||S_ISFIFO(de->mode))
+		init_special_inode(inode,de->mode,kdev_t_to_nr(de->rdev));
 
-out:
 	return inode;
 
 out_fail:
 	de_put(de);
-	goto out;
+	return NULL;
 }			
 
 int proc_fill_super(struct super_block *s, void *data, int silent)

