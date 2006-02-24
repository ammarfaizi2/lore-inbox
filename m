Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWBXHHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWBXHHu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWBXHHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:07:50 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:11918 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750715AbWBXHHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:07:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=PpBN9Hm5Zcv2JQNAcJv23P5UsJ2Pb5iP544q/FwURRaduArU2gtiUUWgJ7MfM7+TTmJ7OHG1NlLPHZvj99XY145vA0QYLeR4t1dJgMn2QbumsoaoHQxFG0SAuxSXlBeTon+Prmp5m06ZbYIhaZFXCGlCBHBQAm6jl7Wb0hjnXxg=  ;
Message-ID: <43FEB0BF.6080403@yahoo.com.au>
Date: Fri, 24 Feb 2006 18:07:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: John McCutchan <john@johnmccutchan.com>, holt@sgi.com,
       linux-kernel@vger.kernel.org, rml@novell.com, arnd@arndb.de, hch@lst.de,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: udevd is killing file write performance.
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>	<1140626903.13461.5.camel@localhost.localdomain>	<20060222175030.GB30556@lnx-holt.americas.sgi.com>	<1140648776.1729.5.camel@localhost.localdomain>	<20060222151223.5c9061fd.akpm@osdl.org>	<1140651662.2985.2.camel@localhost.localdomain>	<20060223161425.4388540e.akpm@osdl.org>	<20060224054724.GA8593@johnmccutchan.com> <20060223220053.2f7a977e.akpm@osdl.org>
In-Reply-To: <20060223220053.2f7a977e.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010900060604030805030809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010900060604030805030809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> John McCutchan <john@johnmccutchan.com> wrote:
> 
>> > > @@ -538,7 +537,7 @@
>> > >  	struct dentry *parent;
>> > >  	struct inode *inode;
>> > >  
>> > > -	if (!atomic_read (&inotify_watches))
>> > > +	if (!atomic_read (&dentry->d_sb->s_inotify_watches))
>> > >  		return;
>> > >  
>> > 
>> > What happens here if we're watching a mountpoint - the parent is on a
>> > different fs?
>>
>> There are four cases to consider here.
>>
>> Case 1: parent fs watched and child fs watched
>> 	correct results
>> Case 2: parent fs watched and child fs not watched
>> 	We may not deliver an event that should be delivered.
>> Case 3: parent fs not watched and child fs watched
>> 	We take d_lock when we don't need to
>> Case 4: parent fs not watched and child fs not watched
>> 	correct results
>>
>> Case 2 screws us. We have to take the lock to even look at the parent's
>> dentry->d_sb->s_inotify_watches. I don't know of a way around this one.
> 
> 
> Yeah.  There are a lot of "screw"s in this thread.
> 
> I wonder if RCU can save us - if we do an rcu_read_lock() we at least know
> that the dentries won't get deallocated.  Then we can take a look at
> d_parent (which might not be the parent any more).  Once in a million years
> we might send a false event or miss sending an event, depending on where
> our dentry suddenly got moved to.  Not very nice, but at least it won't
> oops.
> 
> (hopefully cc's Dipankar)

I saw this problem when testing my lockless pagecache a while back.

Attached is a first implementation of what was my idea then of how
to solve it... note it is pretty rough and I never got around to doing
much testing of it.

Basically: moves work out of inotify event time and to inotify attach
/detach time while staying out of the core VFS.

-- 
SUSE Labs, Novell Inc.

--------------010900060604030805030809
Content-Type: text/plain;
 name="inotify-dentry-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inotify-dentry-flag.patch"

Index: linux-2.6/fs/dcache.c
===================================================================
--- linux-2.6.orig/fs/dcache.c
+++ linux-2.6/fs/dcache.c
@@ -799,6 +799,7 @@ void d_instantiate(struct dentry *entry,
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
 	entry->d_inode = inode;
+	fsnotify_d_instantiate(entry, inode);
 	spin_unlock(&dcache_lock);
 	security_d_instantiate(entry, inode);
 }
@@ -850,6 +851,7 @@ struct dentry *d_instantiate_unique(stru
 	list_add(&entry->d_alias, &inode->i_dentry);
 do_negative:
 	entry->d_inode = inode;
+	fsnotify_d_instantiate(entry, inode);
 	spin_unlock(&dcache_lock);
 	security_d_instantiate(entry, inode);
 	return NULL;
@@ -980,6 +982,7 @@ struct dentry *d_splice_alias(struct ino
 		new = __d_find_alias(inode, 1);
 		if (new) {
 			BUG_ON(!(new->d_flags & DCACHE_DISCONNECTED));
+			fsnotify_d_instantiate(new, inode);
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(new, inode);
 			d_rehash(dentry);
@@ -989,6 +992,7 @@ struct dentry *d_splice_alias(struct ino
 			/* d_instantiate takes dcache_lock, so we do it by hand */
 			list_add(&dentry->d_alias, &inode->i_dentry);
 			dentry->d_inode = inode;
+			fsnotify_d_instantiate(dentry, inode);
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(dentry, inode);
 			d_rehash(dentry);
Index: linux-2.6/fs/inotify.c
===================================================================
--- linux-2.6.orig/fs/inotify.c
+++ linux-2.6/fs/inotify.c
@@ -381,6 +381,41 @@ static int find_inode(const char __user 
 }
 
 /*
+ * inotify_inode_watched - returns nonzero if there are watches on this inode
+ * and zero otherwise.  We call this lockless, we do not care if we race.
+ */
+static inline int inotify_inode_watched(struct inode *inode)
+{
+	return !list_empty(&inode->inotify_watches);
+}
+
+static void set_dentry_child_flags(struct inode *inode, int new_watch)
+{
+	struct dentry *alias;
+
+	if (inotify_inode_watched(inode))
+		return;
+
+	spin_lock(&dcache_lock);
+	list_for_each_entry(alias, &inode->i_dentry, d_alias) {
+		struct dentry *child;
+
+		list_for_each_entry(child, &alias->d_subdirs, d_u.d_child) {
+			spin_lock(&child->d_lock);
+			if (new_watch) {
+				BUG_ON(child->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);
+				child->d_flags |= DCACHE_INOTIFY_PARENT_WATCHED;
+			} else {
+				BUG_ON(!(child->d_flags & DCACHE_INOTIFY_PARENT_WATCHED));
+				child->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
+			}
+			spin_unlock(&child->d_lock);
+		}
+	}
+	spin_unlock(&dcache_lock);
+}
+
+/*
  * create_watch - creates a watch on the given device.
  *
  * Callers must hold dev->sem.  Calls inotify_dev_get_wd() so may sleep.
@@ -406,6 +441,8 @@ static struct inotify_watch *create_watc
 		return ERR_PTR(ret);
 	}
 
+	set_dentry_child_flags(inode, 1);
+
 	dev->last_wd = watch->wd;
 	watch->mask = mask;
 	atomic_set(&watch->count, 0);
@@ -462,6 +499,8 @@ static void remove_watch_no_event(struct
 	atomic_dec(&inotify_watches);
 	idr_remove(&dev->idr, watch->wd);
 	put_inotify_watch(watch);
+
+	set_dentry_child_flags(watch->inode, 0);
 }
 
 /*
@@ -481,16 +520,18 @@ static void remove_watch(struct inotify_
 	remove_watch_no_event(watch, dev);
 }
 
-/*
- * inotify_inode_watched - returns nonzero if there are watches on this inode
- * and zero otherwise.  We call this lockless, we do not care if we race.
- */
-static inline int inotify_inode_watched(struct inode *inode)
+/* Kernel API */
+
+void inotify_d_instantiate(struct dentry *entry, struct inode *inode)
 {
-	return !list_empty(&inode->inotify_watches);
-}
+	struct dentry *parent;
 
-/* Kernel API */
+	spin_lock(&entry->d_lock);
+	parent = entry->d_parent;
+	if (inotify_inode_watched(parent->d_inode))
+		entry->d_flags |= DCACHE_INOTIFY_PARENT_WATCHED;
+	spin_unlock(&entry->d_lock);
+}
 
 /**
  * inotify_inode_queue_event - queue an event to all watches on this inode
@@ -538,7 +579,7 @@ void inotify_dentry_parent_queue_event(s
 	struct dentry *parent;
 	struct inode *inode;
 
-	if (!atomic_read (&inotify_watches))
+	if (!(dentry->d_flags & DCACHE_INOTIFY_PARENT_WATCHED))
 		return;
 
 	spin_lock(&dentry->d_lock);
Index: linux-2.6/include/linux/dcache.h
===================================================================
--- linux-2.6.orig/include/linux/dcache.h
+++ linux-2.6/include/linux/dcache.h
@@ -162,6 +162,8 @@ d_iput:		no		no		no       yes
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
 #define DCACHE_UNHASHED		0x0010	
 
+#define DCACHE_INOTIFY_PARENT_WATCHED	0x0020 /* Parent inode is watched */
+
 extern spinlock_t dcache_lock;
 
 /**
Index: linux-2.6/include/linux/fsnotify.h
===================================================================
--- linux-2.6.orig/include/linux/fsnotify.h
+++ linux-2.6/include/linux/fsnotify.h
@@ -16,6 +16,12 @@
 #include <linux/dnotify.h>
 #include <linux/inotify.h>
 
+static inline void fsnotify_d_instantiate(struct dentry *entry,
+						struct inode *inode)
+{
+	inotify_d_instantiate(entry, inode);
+}
+
 /*
  * fsnotify_move - file old_name at old_dir was moved to new_name at new_dir
  */
Index: linux-2.6/include/linux/inotify.h
===================================================================
--- linux-2.6.orig/include/linux/inotify.h
+++ linux-2.6/include/linux/inotify.h
@@ -71,6 +71,7 @@ struct inotify_event {
 
 #ifdef CONFIG_INOTIFY
 
+extern void inotify_d_instantiate(struct dentry *, struct inode *);
 extern void inotify_inode_queue_event(struct inode *, __u32, __u32,
 				      const char *);
 extern void inotify_dentry_parent_queue_event(struct dentry *, __u32, __u32,
@@ -81,6 +82,10 @@ extern u32 inotify_get_cookie(void);
 
 #else
 
+static inline void inotify_d_instantiate(struct dentry *, struct inode *)
+{
+}
+
 static inline void inotify_inode_queue_event(struct inode *inode,
 					     __u32 mask, __u32 cookie,
 					     const char *filename)

--------------010900060604030805030809--
Send instant messages to your online friends http://au.messenger.yahoo.com 
