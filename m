Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbTLaOgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 09:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTLaOgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 09:36:14 -0500
Received: from gamemakers.de ([217.160.141.117]:17546 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S265105AbTLaOfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 09:35:50 -0500
Message-ID: <3FF2FC85.5070906@lambda-computing.de>
Date: Wed, 31 Dec 2003 17:42:45 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@lambda-computing.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: File change notification
Content-Type: multipart/mixed;
 boundary="------------000803080000010905030400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000803080000010905030400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi everybody.

This is my first post to lkml, so please be patient with me

I have been wondering for some time why there is no decent file change 
notification mechanism in linux. Is there some deep philosophical reason 
for this, or is it just that nobody has found the time to implement it? 
If it is the latter, I am willing to implement it as long there is a 
chance to get this accepted into the mainstream kernel.

Is there already somebody working on this problem? I know a few efforts 
that try to do something similar, but they all work by intercepting 
every single system call that has to do with files, and they are thus 
not very fast. See for example
<http://www.bangstate.com/software.html#changedfiles>
<http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/openxdsm/openxdsm/eventmodule/> 


The dnotify mechanism is very limited since it requires a file handle, 
it is not working for whole directory trees and it does not report much 
useful information. For example to watch for changes in the /home tree 
you would have to open every single directory in the tree, which would 
probably not even work since it would require more than the maximum 
number of file handles. If you have a directory with many files in it, 
the only thing dnotify tells you is that something has changed in the 
directory, so you have to rescan the whole directory to find out which 
file has changed. Kind of defeats the purpose of change notification...

What I would like to have would be some way to watch for certain changes 
anywhere in a whole tree or even the whole file system. This new 
mechanism should have no measurable performance impact and should log 
all information that is readily available. The amount of new code in 
kernel space should be as small as possible. So complicated stuff like 
pattern matching would have to happen in user space.

I wrote some experimental mechanism yesterday. Whenever a file is 
accessed or changed, I write all easily available information to a ring 
buffer which is presented to user space as a device. The information 
that is easily available is the inode number of the file or directory 
that has changed, the inode number of the directory in which the change 
took place, and in most cases the name of the dentry of the file that 
has changed.

Here is the struct I use for logging:

typedef struct
{
   unsigned long event; /* the type of change. As of now, I use the same 
constants as dnotify */
   unsigned long file_ino; /* the inode of the file that has changed (if 
available) */
   unsigned long src_ino; /* the inode of the directory in which the 
change took place (if available) */
   unsigned long dst_ino; /* the inode of the destination directory. 
This is only used when logging moves */
   unsigned char name[DNAME_LEN]; /* the name of the dentry of the 
changed file. This is simply truncated if it is too long. */
} inotify_info;

Information that is not easily available and therefore not logged 
includes the full path(s) of the changed file/directory. If you want or 
need that, you will have to look it up in user space.

Since I only log information that can be gathered at practically no 
cost, the logging does not take any noticeable time in kernel space.

I attached a patch containing the code I wrote yesterday. This is very 
preliminary and probably not bug-free. I would like to have feedback on 
the general approach before I spend more time refining this.

best regards,

    Rüdiger Klaehn



--------------000803080000010905030400
Content-Type: text/plain;
 name="inotify-patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="inotify-patch"

diff -urN -X dontdiff vanilla/fs/dnotify.c develop/fs/dnotify.c
--- vanilla/fs/dnotify.c	2003-10-17 23:43:00.000000000 +0200
+++ develop/fs/dnotify.c	2003-12-31 16:59:36.000000000 +0100
@@ -153,8 +153,9 @@
 void dnotify_parent(struct dentry *dentry, unsigned long event)
 {
 	struct dentry *parent;
-
 	spin_lock(&dentry->d_lock);
+	/* call inotify for this dentry */
+	inotify_dentrychange(dentry,event);
 	parent = dentry->d_parent;
 	if (parent->d_inode->i_dnotify_mask & event) {
 		dget(parent);
diff -urN -X dontdiff vanilla/fs/inotify.c develop/fs/inotify.c
--- vanilla/fs/inotify.c	1970-01-01 01:00:00.000000000 +0100
+++ develop/fs/inotify.c	2003-12-31 16:59:39.000000000 +0100
@@ -0,0 +1,306 @@
+/*
+ * Inode notifications for Linux.
+ *
+ * Copyright (C) 2003,2004 Rüdiger Klaehn
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+#ifdef HAVE_CONFIG_H
+#include "../config.h"
+#endif
+
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <asm/segment.h>
+#include <asm/uaccess.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/smp_lock.h>
+#include <asm/segment.h>
+
+#define BUFFER_LEN 512
+#define DNAME_LEN 32
+#define IGNORE_LEN 16
+#define DEBUG 2
+
+typedef struct
+{
+	unsigned long event;
+	unsigned long file_ino;
+	unsigned long src_ino;
+	unsigned long dst_ino;
+	unsigned char name[DNAME_LEN];
+} in_info;
+
+/* The ring buffer. Statically allocated as of now */
+in_info in_buffer[BUFFER_LEN];
+int in_buffer_head = 0;
+int in_buffer_tail = 0;
+spinlock_t in_lock = SPIN_LOCK_UNLOCKED;
+unsigned long lock_flags;
+unsigned long in_ignore[IGNORE_LEN];
+
+/* device info for the in device */
+static int in_major = 40;
+
+int add_ignore_ino(unsigned long ino)
+{
+	int i;
+	for(i=0;i<IGNORE_LEN;i++)
+		if(in_ignore[i]==0) 
+		{
+			in_ignore[i]=ino;
+			return 1;
+		}
+	return 0;
+}
+
+int remove_ignore_ino(unsigned long ino)
+{
+	int i;
+	for(i=0;i<IGNORE_LEN;i++)
+		if(in_ignore[i]==ino)
+		{
+			in_ignore[i]=0;
+			return 1;
+		}
+	return 0;
+}
+
+int test_ignore_ino(unsigned long ino)
+{
+	int i;
+	if(!ino)
+		return 1;
+	for(i=0;i<IGNORE_LEN;i++)
+		if(in_ignore[i]==ino)
+			return 1;
+	return 0;		
+}
+
+int in_get_from_buffer(in_info *info)
+{
+	spin_lock_irqsave(&in_lock, lock_flags);
+	if (in_buffer_head == in_buffer_tail)
+	{
+		spin_unlock_irqrestore( &in_lock, lock_flags );
+		return 0;
+	}
+	memcpy(info,&in_buffer[in_buffer_head],sizeof(in_info));
+	memset(&in_buffer[in_buffer_head],0,sizeof(in_info));
+	in_buffer_head++;
+	if(in_buffer_head == BUFFER_LEN) in_buffer_head=0;
+	spin_unlock_irqrestore( &in_lock, lock_flags );
+	return 1;
+}
+
+int in_put_to_buffer(in_info *info)
+{
+	#if DEBUG>2
+	printk("in: put_to_buffer: %ld %ld %ld %ld\n",
+		info->event,info->file_ino,info->src_ino,info->dst_ino);
+	#endif
+	spin_lock_irqsave(&in_lock, lock_flags);
+	if((in_buffer_tail + 1) == in_buffer_head || (
+		((in_buffer_tail + 1) == BUFFER_LEN) &&
+		( in_buffer_head == 0 ) ))
+	{
+		/* Buffer overrun. Drop one entry! */
+		in_buffer_head++;
+		if ( in_buffer_head == BUFFER_LEN )
+		{
+			in_buffer_head = 0;
+		}
+		/*signal changedfiles_buffer overrun*/
+		/*strncpy( (char *)changedfiles_buffer[cf_buffer_head], "!", 2);*/
+	}
+	memcpy(&in_buffer[in_buffer_tail],info,sizeof(in_info));
+	in_buffer_tail++;
+	if ( in_buffer_tail == BUFFER_LEN )
+		in_buffer_tail=0;
+	spin_unlock_irqrestore( &in_lock, lock_flags );
+	return 1;
+}
+
+/*
+void in_zero_buffer()
+{
+	int i;
+	for (i=0; i < BUFFER_LEN; i++)
+	{
+		memset(&in_buffer[i], 0, sizeof(in_info));
+	}
+	return;
+}
+*/
+
+int in_open_dev( struct inode *in,struct file * fi )
+{
+	MOD_INC_USE_COUNT;
+	add_ignore_ino(in->i_ino);
+#if DEBUG > 1
+	printk("inotify: in_open_dev() %ld\n",in->i_ino);
+#endif
+	return 0;
+}
+
+int in_close_dev( struct inode *in,struct file * fi )
+{
+#if DEBUG > 1
+	printk("inotify: in_close_dev() %ld\n",in->i_ino);
+#endif
+	remove_ignore_ino(in->i_ino);
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+/*ssize_t changedfiles_read_dev( struct inode *in,
+				  struct file *fi,
+				  char * buf,
+				  unsigned long count ) */
+ssize_t in_read_dev( struct file *filep, char *buf, size_t count,loff_t *f_pos )
+{
+	in_info read_buf;
+	if(!in_get_from_buffer(&read_buf))
+		return 0;
+#if DEBUG>2
+	printk("inotify: got info from buffer\n");
+#endif
+	if(count>sizeof(in_info))
+		count=sizeof(in_info);
+	if(copy_to_user(buf,&read_buf,count))
+	{
+		printk("inotify:  copy_to_user failed\n");
+		return -EFAULT;
+	}
+#if DEBUG>2
+	printk("inotify: changedfiles_read_dev() returning");
+#endif
+	return count;
+}
+
+static struct file_operations in_fop = {
+  read: in_read_dev,
+  open: in_open_dev,
+  release: in_close_dev,
+};
+
+/*
+ * This function should be called whenever something changes on an inode
+ * where we do not have the dentry, such as reading and writing
+*/
+void inotify_inodechange(struct inode *inode, unsigned long event)
+{
+	in_info info;
+	memset(&info,0,sizeof(in_info));
+	if(test_ignore_ino(inode->i_ino))
+		return;
+	info.event=event;
+	info.file_ino=inode->i_ino;
+	info.src_ino=0;
+	info.dst_ino=0;
+	in_put_to_buffer(&info);
+}
+
+/*
+ * This function should be called when something changes about a dentry, such
+ * as attributes, creating, deleting, renaming etc.
+ */
+void inotify_dentrychange(struct dentry *dentry,unsigned long event)
+{
+	in_info info;
+	struct dentry *parent;
+	memset(&info,0,sizeof(in_info));
+	info.event=event;
+	spin_lock(&dentry->d_lock);
+	if(dentry->d_inode)
+		info.file_ino=dentry->d_inode->i_ino;
+	else
+		info.file_ino=0;
+	if(test_ignore_ino(info.file_ino))
+		goto ignore;
+	parent=dentry->d_parent;
+	if(parent!=dentry)
+	{
+		dget(parent);
+		info.src_ino=parent->d_inode->i_ino;
+		dput(parent);
+	}
+	else
+		info.src_ino=0;
+	if(test_ignore_ino(info.src_ino))
+		goto ignore;
+	info.dst_ino=0;
+	strncpy(info.name,dentry->d_name.name,DNAME_LEN);
+	spin_unlock(&dentry->d_lock);
+	in_put_to_buffer(&info);
+	return;
+ignore:
+	spin_unlock(&dentry->d_lock);
+	return;
+}
+
+/*
+ * This function should be called whenever a dentry is moved (after it is moved)
+ * This one needs a lot of work!
+ */
+void inotify_dentrymove(struct dentry *dentry,struct dentry *dsrc,unsigned long event)
+{
+/*	in_info info;
+	struct dentry *parent;
+	memset(&info,0,sizeof(in_info));
+	info.event=event;
+	spin_lock(&dentry->d_lock);
+	if(dentry->d_inode)
+		info.file_ino=dentry->d_inode->i_ino;
+	else
+		info.file_ino=0;
+	parent=dentry->d_parent;
+	if(parent!=dentry)
+	{
+		dget(parent);
+		info.dst_ino=parent->d_inode->i_ino;
+		dput(parent);
+	}
+	else
+		info.dst_ino=0;
+	strncpy(info.name,dentry->d_name.name,DNAME_LEN);
+	spin_unlock(&dentry->d_lock);
+	spin_lock(&dsrc->d_lock);
+	if(dsrc->d_inode)
+		info.src_ino=dsrc->d_inode->i_ino;
+	else
+		info.dst_ino=0;
+	spin_unlock(&dsrc->d_lock);
+	in_put_to_buffer(&info);*/
+}
+
+static int __init inotify_init(void)
+{
+#ifdef DEBUG
+	printk("initializing inotify subsystem...\n");
+#endif
+	int i;
+	for (i=0; i < BUFFER_LEN; i++)
+	{
+		memset(&in_buffer[i], 0, sizeof(in_info));
+	}
+	memset(&in_ignore,0,sizeof(in_ignore));
+	if ( register_chrdev(in_major, "inotify", &in_fop))
+		return -EIO;
+	return 0;
+}
+
+module_init(inotify_init)
diff -urN -X dontdiff vanilla/fs/Makefile develop/fs/Makefile
--- vanilla/fs/Makefile	2003-08-23 01:56:59.000000000 +0200
+++ develop/fs/Makefile	2003-12-31 16:59:36.000000000 +0100
@@ -10,7 +10,7 @@
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o
+		fs-writeback.o mpage.o direct-io.o aio.o inotify.o
 
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o
diff -urN -X dontdiff vanilla/include/linux/dnotify.h develop/include/linux/dnotify.h
--- vanilla/include/linux/dnotify.h	2003-04-07 19:30:34.000000000 +0200
+++ develop/include/linux/dnotify.h	2003-12-31 16:59:43.000000000 +0100
@@ -22,6 +22,8 @@
 
 static inline void inode_dir_notify(struct inode *inode, unsigned long event)
 {
+	/* call inotify for this inode */
+	inotify_inodechange(inode,event);
 	if ((inode)->i_dnotify_mask & (event))
 		__inode_dir_notify(inode, event);
 }
diff -urN -X dontdiff vanilla/include/linux/inotify.h develop/include/linux/inotify.h
--- vanilla/include/linux/inotify.h	1970-01-01 01:00:00.000000000 +0100
+++ develop/include/linux/inotify.h	2003-12-31 16:59:43.000000000 +0100
@@ -0,0 +1,17 @@
+/*
+ * Inode notification for Linux
+ *
+ * Copyright (C) 2003,2004 Rüdiger Klaehn
+ */
+
+#include <linux/fs.h>
+#define IN_ACCESS	0x00000001	/* Node accessed */
+#define IN_MODIFY	0x00000002	/* Node modified */
+#define IN_CREATE	0x00000004	/* Node created */
+#define IN_DELETE	0x00000008	/* Node removed */
+#define IN_RENAME	0x00000010	/* Node renamed */
+#define IN_ATTRIB	0x00000020	/* Node changed attibutes */
+
+extern void inotify_inodechange(struct inode *inode, unsigned long event);
+extern void inotify_dentrychange(struct dentry *dentry,unsigned long event);
+extern void inotify_dentrymove(struct dentry *dentry,struct dentry *dsrc,unsigned long event);

--------------000803080000010905030400--

