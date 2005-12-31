Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVLaIyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVLaIyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 03:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVLaIyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 03:54:09 -0500
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:16108 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S1751036AbVLaIyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 03:54:08 -0500
Message-ID: <43B64712.3000105@sw.ru>
Date: Sat, 31 Dec 2005 11:53:38 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: [PATCH] protect remove_proc_entry
References: <1135973075.6039.63.camel@localhost.localdomain>	<1135978110.6039.81.camel@localhost.localdomain> <20051230154647.5a38227e.akpm@osdl.org>
In-Reply-To: <20051230154647.5a38227e.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090501060503060602040304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501060503060602040304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

I have a full patch for this.
I don't remember the details yet, but lock was not god here, we used 
semaphore. I pointed to this problem long ago when fixed error path in 
proc with moduleget.

This patch protects proc_dir_entry tree with a proc_tree_sem semaphore. 
I suppose lock_kernel() can be removed later after checking that no proc 
handlers require it.
Also this patch remakes de refcounters a bit making it more clear and 
more similar to dentry scheme - this is required to make sure that 
everything works correctly.

Patch is against 2.6.15-rcX and was tested for about a week. Also works 
half a year on 2.6.8 :)

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

Kirill

> Steven Rostedt <rostedt@goodmis.org> wrote:
>> +static DEFINE_SPINLOCK(remove_proc_lock);
>>
> 
> I'll take a closer look at this next week.
> 
> The official way of protecting the contents of a directory from concurrent
> lookup or modification is to take its i_sem.  But procfs is totally weird
> and that approach may well not be practical here.  We'd certainly prefer
> not to rely upon lock_kernel().
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--------------090501060503060602040304
Content-Type: text/plain;
 name="diff-ms-proc-locks-20051231"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-proc-locks-20051231"

--- ./fs/proc/generic.c.proclk	2005-12-26 13:43:14.000000000 +0300
+++ ./fs/proc/generic.c	2005-12-31 11:48:16.000000000 +0300
@@ -27,6 +27,8 @@ static ssize_t proc_file_write(struct fi
 			       size_t count, loff_t *ppos);
 static loff_t proc_file_lseek(struct file *, loff_t, int);
 
+static DECLARE_RWSEM(proc_tree_sem);
+
 int proc_match(int len, const char *name, struct proc_dir_entry *de)
 {
 	if (de->namelen != len)
@@ -381,6 +383,7 @@ struct dentry *proc_lookup(struct inode 
 	lock_kernel();
 	de = PDE(dir);
 	if (de) {
+		down_read(&proc_tree_sem);
 		for (de = de->subdir; de ; de = de->next) {
 			if (de->namelen != dentry->d_name.len)
 				continue;
@@ -392,6 +395,7 @@ struct dentry *proc_lookup(struct inode 
 				break;
 			}
 		}
+		up_read(&proc_tree_sem);
 	}
 	unlock_kernel();
 
@@ -446,12 +450,13 @@ int proc_readdir(struct file * filp,
 			filp->f_pos++;
 			/* fall through */
 		default:
+			down_read(&proc_tree_sem);
 			de = de->subdir;
 			i -= 2;
 			for (;;) {
 				if (!de) {
 					ret = 1;
-					goto out;
+					goto out_up;
 				}
 				if (!i)
 					break;
@@ -462,14 +467,18 @@ int proc_readdir(struct file * filp,
 			do {
 				if (filldir(dirent, de->name, de->namelen, filp->f_pos,
 					    de->low_ino, de->mode >> 12) < 0)
-					goto out;
+					goto out_up;
 				filp->f_pos++;
 				de = de->next;
 			} while (de);
+			up_read(&proc_tree_sem);
 	}
 	ret = 1;
 out:	unlock_kernel();
 	return ret;	
+out_up:
+	up_read(&proc_tree_sem);
+	goto out;
 }
 
 /*
@@ -517,6 +526,7 @@ static int proc_register(struct proc_dir
 		if (dp->proc_iops == NULL)
 			dp->proc_iops = &proc_file_inode_operations;
 	}
+	de_get(dir);
 	return 0;
 }
 
@@ -576,6 +586,7 @@ static struct proc_dir_entry *proc_creat
 
 	memset(ent, 0, sizeof(struct proc_dir_entry));
 	memcpy(((char *) ent) + sizeof(struct proc_dir_entry), fn, len + 1);
+	atomic_set(&ent->count, 1);
 	ent->name = ((char *) ent) + sizeof(*ent);
 	ent->namelen = len;
 	ent->mode = mode;
@@ -589,6 +600,7 @@ struct proc_dir_entry *proc_symlink(cons
 {
 	struct proc_dir_entry *ent;
 
+	down_write(&proc_tree_sem);
 	ent = proc_create(&parent,name,
 			  (S_IFLNK | S_IRUGO | S_IWUGO | S_IXUGO),1);
 
@@ -606,6 +618,7 @@ struct proc_dir_entry *proc_symlink(cons
 			ent = NULL;
 		}
 	}
+	up_write(&proc_tree_sem);
 	return ent;
 }
 
@@ -614,6 +627,7 @@ struct proc_dir_entry *proc_mkdir_mode(c
 {
 	struct proc_dir_entry *ent;
 
+	down_write(&proc_tree_sem);
 	ent = proc_create(&parent, name, S_IFDIR | mode, 2);
 	if (ent) {
 		ent->proc_fops = &proc_dir_operations;
@@ -624,6 +638,7 @@ struct proc_dir_entry *proc_mkdir_mode(c
 			ent = NULL;
 		}
 	}
+	up_write(&proc_tree_sem);
 	return ent;
 }
 
@@ -633,7 +648,7 @@ struct proc_dir_entry *proc_mkdir(const 
 	return proc_mkdir_mode(name, S_IRUGO | S_IXUGO, parent);
 }
 
-struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
+static struct proc_dir_entry *__create_proc_entry(const char *name, mode_t mode,
 					 struct proc_dir_entry *parent)
 {
 	struct proc_dir_entry *ent;
@@ -665,6 +680,17 @@ struct proc_dir_entry *create_proc_entry
 	return ent;
 }
 
+struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
+					 struct proc_dir_entry *parent)
+{
+	struct proc_dir_entry *ent;
+
+	down_write(&proc_tree_sem);
+	ent = __create_proc_entry(name, mode, parent);
+	up_write(&proc_tree_sem);
+	return ent;
+}
+
 void free_proc_entry(struct proc_dir_entry *de)
 {
 	unsigned int ino = de->low_ino;
@@ -683,15 +709,13 @@ void free_proc_entry(struct proc_dir_ent
  * Remove a /proc entry and free it if it's not currently in use.
  * If it is in use, we set the 'deleted' flag.
  */
-void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
+static void __remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 {
 	struct proc_dir_entry **p;
 	struct proc_dir_entry *de;
 	const char *fn = name;
 	int len;
 
-	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
-		goto out;
 	len = strlen(fn);
 	for (p = &parent->subdir; *p; p=&(*p)->next ) {
 		if (!proc_match(len, fn, *p))
@@ -699,20 +723,24 @@ void remove_proc_entry(const char *name,
 		de = *p;
 		*p = de->next;
 		de->next = NULL;
+		de_put(parent);
 		if (S_ISDIR(de->mode))
 			parent->nlink--;
 		proc_kill_inodes(de);
 		de->nlink = 0;
 		WARN_ON(de->subdir);
-		if (!atomic_read(&de->count))
-			free_proc_entry(de);
-		else {
-			de->deleted = 1;
-			printk("remove_proc_entry: %s/%s busy, count=%d\n",
-				parent->name, de->name, atomic_read(&de->count));
-		}
+		de->deleted = 1;
+		de_put(de);
 		break;
 	}
-out:
-	return;
+}
+
+void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
+{
+	const char *fn = name;
+
+	down_write(&proc_tree_sem);
+	if (parent || xlate_proc_name(name, &parent, &fn) == 0)
+		__remove_proc_entry(name, parent);
+	up_write(&proc_tree_sem);
 }
--- ./fs/proc/inode.c.proclk	2005-12-26 13:43:14.000000000 +0300
+++ ./fs/proc/inode.c	2005-12-31 11:48:16.000000000 +0300
@@ -21,34 +21,25 @@
 
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
-static void de_put(struct proc_dir_entry *de)
+void de_put(struct proc_dir_entry *de)
 {
 	if (de) {	
-		lock_kernel();		
 		if (!atomic_read(&de->count)) {
 			printk("de_put: entry %s already free!\n", de->name);
-			unlock_kernel();
 			return;
 		}
 
 		if (atomic_dec_and_test(&de->count)) {
-			if (de->deleted) {
-				printk("de_put: deferred delete of %s\n",
-					de->name);
-				free_proc_entry(de);
+			if (!de->deleted) {
+				printk("de_put: entry %s is not removed yet\n",
+						de->name);
+				return;
 			}
-		}		
-		unlock_kernel();
+			free_proc_entry(de);
+		}
 	}
 }
 
--- ./include/linux/proc_fs.h.proclk	2005-12-26 13:43:16.000000000 +0300
+++ ./include/linux/proc_fs.h	2005-12-31 11:48:16.000000000 +0300
@@ -69,6 +69,14 @@ struct proc_dir_entry {
 	void *set;
 };
 
+extern void de_put(struct proc_dir_entry *);
+static inline struct proc_dir_entry *de_get(struct proc_dir_entry *de)
+{
+	if (de)
+		atomic_inc(&de->count);
+	return de;
+}
+
 struct kcore_list {
 	struct kcore_list *next;
 	unsigned long addr;
--- ./kernel/sysctl.c.proclk	2005-12-26 13:43:16.000000000 +0300
+++ ./kernel/sysctl.c	2005-12-31 11:48:37.000000000 +0300
@@ -1396,19 +1396,15 @@ static void unregister_proc_table(ctl_ta
 				continue;
 		}
 
-		/*
-		 * In any case, mark the entry as goner; we'll keep it
-		 * around if it's busy, but we'll know to do nothing with
-		 * its fields.  We are under sysctl_lock here.
-		 */
 		de->data = NULL;
-
-		/* Don't unregister proc entries that are still being used.. */
-		if (atomic_read(&de->count))
-			continue;
-
 		table->de = NULL;
+		/*
+		 * sys_sysctl can't find us, since we are removed from list.
+		 * proc won't touch either, since de->data is NULL.
+		 */
+		spin_unlock(&sysctl_lock);
 		remove_proc_entry(table->procname, root);
+		spin_lock(&sysctl_lock);
 	}
 }
 

--------------090501060503060602040304--
