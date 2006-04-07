Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWDGSto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWDGSto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWDGSss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:48:48 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:2448
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S964871AbWDGSsg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:48:36 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: linux-security-module@vger.kernel.org
Subject: [RFC][PATCH 1/7] fireflier LSM for labeling sockets based on its creator (owner)
Date: Fri, 7 Apr 2006 21:27:30 +0300
User-Agent: KMail/1.9.1
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, sds@tycho.nsa.gov
References: <200604021240.21290.edwin@gurde.com> <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com>
In-Reply-To: <200604072124.24000.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604072127.30925.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-labeling logic. This is where the (individual&group) SIDs are generated, 
and maintained.

---
 autolabel.c |  262 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 autolabel.h |   24 +++++
 constants.h |    7 +
 context.h   |   62 ++++++++++++++
 4 files changed, 355 insertions(+)
diff -uprN null/autolabel.c fireflier_lsm/autolabel.c
--- /dev/null	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/autolabel.c	2006-04-07 17:43:48.000000000 +0300
@@ -0,0 +1,262 @@
+/*
+ *  Fireflier security labeling module
+ *
+ *
+ *  This file contains the Fireflier auto-labeling implementations.
+ *
+ *  Copyright (C) 2006 Török Edwin <edwin@gurde.com>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License version 2,
+ *      as published by the Free Software Foundation.
+ */
+#include "autolabel.h"
+#include "sidtab.h"
+#include "constants.h"
+#include "fireflier_debug.h"
+#include "fireflier.h"
+/*
+  How all this works:
+
+  a SID is generated based on the file (mountpoint+inode), and it is used to 
label processes.
+  A SID of the process always refers to a single file, that of the process's 
executable.
+
+  In case of inodes (of files of a process), a SID can either be the SID of 
the _only_ process that has access to that file,
+  or if multiple processes have access to that file, then it is a "group 
SID".
+  A "group SID" is a list of all the executables that have access to that 
file.
+
+  The first time a file is created, it is labeled with the current tasks SID.
+  When another process gains access to that file, and that process has a 
different executable then the one that already has access to the file,
+  then the file's SID will be changed to a "group SID".
+  The file's SID will transition to this new group SID:
+  First we'll check if a group SID already exists for these  processes, and 
if so, that one will be used.
+  If not, we'll create another group.
+  
+  Note: we are not going to label all files, just sockets, but that doesn't 
have any impact on the labeling implementation
+*/
+
+//TODO: we will also need to remove unused SIDs?
+
+
+struct sidtab fireflier_sidtab;
+
+/**
+ * autolabel_init - initialize the sidtab
+ */
+int autolabel_init(void)
+{
+	return sidtab_init(&fireflier_sidtab);
+}
+
+
+/**
+ * getfile_from_sid - returns the execfile of this SID
+ * @tasksid: the SID of a task
+ */
+static inline const struct context* getcontext_from_sid(const u32 tasksid)
+{
+	const struct context* context = sidtab_search(&fireflier_sidtab,tasksid);
+	if(unlikely(context->groupmembers)) {
+		printk(KERN_DEBUG "Fireflier: programming logic error: a task's SID can't 
be a group SID!\n");
+		return NULL;
+	}
+	else
+		return context;
+}
+
+/**
+ * don't use NULL for empty device, use this empty string
+ */
+static char empty_dev[] = "";
+
+/**
+ * internal_get_or_generate_sid - returns a SID that uniqueuly identifies 
this devname+inode combination
+ * @devname - name of the mountpoint(device) the process's executable is on
+ * @inode - inode of the process's executable
+ * @unsafe - reason this process might be unsafe (ptrace,etc.)
+ */
+static inline u32 internal_get_or_generate_sid(const char* devname,const 
unsigned long inode,const char unsafe)
+{
+	u32 sid = FIREFLIER_SID_UNLABELED;
+	const struct context context=
+		{
+			.inode = inode,
+			.mnt_devname = unlikely(devname==NULL) ? empty_dev : devname,
+			.groupmembers = 0,
+			.unsafe = unsafe
+		};
+	sidtab_context_to_sid(&fireflier_sidtab,&context,&sid);
+
+	ff_debug_dump_sid(&context,sid);
+
+	return sid;
+}
+
+/**
+ * get_or_generate_unsafe_sid - generate a new SID because a task became 
unsafe
+ * @oldtasksid - the "safe" task's SID
+ * @unsafe - reason it became unsafe
+ * this generates a new SID, referring to the same inode+mountpoint as old 
SID, but with the added unsafe attribute
+ */
+u32 get_or_generate_unsafe_sid(const u32 oldtasksid,const char unsafe)
+{
+	const struct context* oldcontext = getcontext_from_sid(oldtasksid);
+	return 
internal_get_or_generate_sid(oldcontext->mnt_devname,oldcontext->inode,unsafe);
+}
+
+/**
+ * get_or_generate_sid - return a SID that uniquely identifies this file
+ * @execfile: file member of linux_binprm
+ * @unsafe: reason for this task to be unsafe (ptrace,..)
+ * wrapper around internal_get_or_generate_sid
+ */
+u32 get_or_generate_sid(const struct file* execfile,const char unsafe)
+{
+	return 
internal_get_or_generate_sid(execfile->f_vfsmnt->mnt_devname,execfile->f_dentry->d_inode->i_ino,unsafe);
+}
+
+/** fireflier_ctx_to_id - converts the mountpoint+inode to a SID
+ * @dev - the device (mountpoint) name - this will be copied
+ * @inode - the inode
+ * @ctxid - a pointer to where the SID will be stored
+ * this is intended to be called from the iptables match module
+ */
+int fireflier_ctx_to_id(const char* dev,unsigned long inode,u32 *ctxid)
+{
+	if(ctxid)
+	{
+//	   printk(KERN_DEBUG "fireflier_ctx_to_id: %s, %ld\n",dev,inode);
+		*ctxid=internal_get_or_generate_sid(kstrdup(dev,GFP_KERNEL),inode,0);
+		return 0;
+	}
+	return 1;
+}
+
+/**
+ * add_sid_to_group - returns a group that has tasksid added to it
+ * @oldgroup: the old group
+ * @tasksid: the SID to add to the old group
+ * If a group already exists that contains all sids in oldgroup, and the 
tsid, then it is used
+ * otherwise a new group is created
+ */
+static u32 add_sid_to_group(u32 oldgroup,u32 tasksid)
+{
+	const struct context* oldcontext = sidtab_search(&fireflier_sidtab,tasksid);
+	const int old_member_count = oldcontext->groupmembers==0 ? 1 : 
oldcontext->groupmembers;
+	struct context* newcontext = 
kmalloc(sizeof(*newcontext)+sizeof(u32)*(old_member_count+1),GFP_ATOMIC);
+	u32 sid = FIREFLIER_SID_UNLABELED;
+
+	/* If we are creating a group, then add the old sid, as first member */
+	if(old_member_count==1)
+		newcontext->sids[0]=oldgroup;
+	newcontext->mnt_devname=empty_dev;
+	newcontext->inode=0;
+
+	newcontext->groupmembers=old_member_count+1;
+	if(old_member_count!=1)
+		memcpy(&newcontext->sids,&oldcontext->sids,old_member_count);
+	newcontext->sids[old_member_count]=tasksid;
+
+	sidtab_context_to_sid(&fireflier_sidtab,newcontext,&sid);
+	ff_debug_dump_sid(newcontext,sid);
+	kfree(newcontext);
+
+	return sid;
+}
+
+static inline int is_sid_in_group(u32 sid,u32 group)
+{
+	const struct context* context = sidtab_search(&fireflier_sidtab,sid);
+	int i;
+	for(i=0;i<context->groupmembers;i++)
+		if(context->sids[i]==sid)
+			return 1;
+	return 0;
+}
+
+/**
+ * compute_inode_sid - calculates the new SID of this inode
+ * @oldinodesid: the old SID of this inode (if it had one)
+ * @tasksid: the tasks's SID
+ *
+ * This function calculates the new SID of an inode, it _has_ to be called 
each time a new
+ * task gains access to the file/socket identified by this inode.
+ * If the task's SID already matches (or is included in) the inode's SID, 
then that SID is used.
+ * Otherwise the task is added to a group SID.
+ */
+u32 compute_inode_sid(u32 oldinodesid,u32 tasksid)
+{
+//	printk(KERN_DEBUG "oldinode:%d, tasksid:%d",oldinodesid,tasksid);
+	if(likely(oldinodesid == tasksid))
+		return tasksid;
+	if(is_sid_in_group(tasksid,oldinodesid))
+		return oldinodesid;
+	return add_sid_to_group(oldinodesid,tasksid);
+}
+
+/**
+ * u32_compute_len - counts nr. of digits
+ */
+static inline int u32_compute_len(u32 value)
+{
+	int digits=0;
+	if(value==0)
+		return 1;
+	for(;value;digits++)
+		value /= 10;
+	return digits;	
+}
+/**
+ * fireflier_sid_to_context - returns string representation of sid
+ * @sid - sid to be converted
+ * @scontext -string representation - the list of mountpoint+inodes; NULL - 
query length
+ * @scontextlen - length of the string
+ */
+int fireflier_sid_to_context(u32 sid,char** scontext,u32* scontextlen)
+{
+	const struct context* context = sidtab_search(&fireflier_sidtab,sid);
+	const size_t mntdevlen = strlen(context->mnt_devname);
+	if(likely(!context->groupmembers)) {				
+		const size_t len  = mntdevlen + u32_compute_len(context->inode) + 2;
+		*scontextlen = len;
+		if(!scontext)
+			return -1;
+		if(!*scontext)
+			*scontext = (char*) kmalloc(len,GFP_ATOMIC);
+		if(!scontext)
+			return -ENOMEM;
+		snprintf(*scontext,len,"%s:%ld",context->mnt_devname,context->inode);		
+
+		return 0;		
+	}
+	else {
+		size_t len = mntdevlen + 1;
+		int i;
+		char* string;
+		for(i=0;i<context->groupmembers;i++) {
+			u32 len_sub;
+			fireflier_sid_to_context(context->sids[i],NULL,&len_sub);
+			len += len_sub-1;
+		}
+		*scontextlen = len+1;
+		if(!scontext)
+			return -1;
+		*scontext = (char*) kmalloc(len,GFP_ATOMIC);
+		if(!scontext)
+			return -ENOMEM;
+	        string = *scontext;
+		for(i=0;i<context->groupmembers;i++) {
+			u32 len_sub;
+			int err;
+			if((err=fireflier_sid_to_context(context->sids[i],&string,&len_sub)))
+				return err;
+			string += len_sub-1;
+		}
+
+		return 0;		
+			
+	}
+}
+
+EXPORT_SYMBOL_GPL(fireflier_ctx_to_id);
diff -uprN null/autolabel.h fireflier_lsm/autolabel.h
--- /dev/null	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/autolabel.h	2006-04-06 22:50:49.000000000 +0300
@@ -0,0 +1,24 @@
+/*
+ *  Fireflier security labeling module
+ *
+ *
+ *  This file contains the Fireflier auto-labeling implementations.
+ *
+ *  Copyright (C) 2006 Török Edwin <edwin@gurde.com>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License version 2,
+ *      as published by the Free Software Foundation.
+ */
+#ifndef _FF_AUTOLABEL_H_
+#define _FF_AUTOLABEL_H_
+#include <linux/types.h>
+#include <linux/file.h>
+
+u32 get_or_generate_sid(const struct file* execfile,const char unsafe);
+u32 get_or_generate_unsafe_sid(const u32 oldtasksid,const char unsafe);
+u32 compute_inode_sid(u32 oldinodesid,u32 tasksid);
+int fireflier_sid_to_context(u32 sid,char** scontext,u32* scontextlen);
+int autolabel_init(void);
+#endif
diff -uprN null/constants.h fireflier_lsm/constants.h
--- /dev/null	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/constants.h	2006-04-07 14:11:38.000000000 +0300
@@ -0,0 +1,7 @@
+#ifndef _FF_CONSTANTS_H_
+#define _FF_CONSTANTS_H_
+
+#define FIREFLIER_MAGIC 0xb81ff123
+#define FIREFLIER_SID_UNLABELED 0
+#define FIREFLIER_SECINITSID_KERNEL 1
+#endif
diff -uprN null/context.h fireflier_lsm/context.h
--- null/context.h	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/context.h	2006-03-29 23:23:57.000000000 +0300
@@ -0,0 +1,62 @@
+/*
+ *  Fireflier security labeling module
+ *
+ *
+ *  This file contains the Fireflier security context structures
+ *
+ *  Copyright (C) 2006 Török Edwin <edwin@gurde.com>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License version 2,
+ *      as published by the Free Software Foundation.
+ */
+
+#ifndef _FF_CONTEXT_H_
+#define _FF_CONTEXT_H_
+
+#include <linux/fs.h>
+#include <linux/dcache.h>
+#include <linux/mount.h>
+/* this is the context of our SID,
+ * actually it is the executable file (mountpoint+inode)
+ */
+struct context {
+	unsigned long inode;
+	const char* mnt_devname;	/* if this is a group SID, then this is NULL */
+	char groupmembers;/* nr. of group members, if it is 0 this is not a group, 
but a SID by itself*/
+	char unsafe;/* Reason for task being unsafe: ptrace,... */
+	/*if this is a group SID, then a list of group member SIDs follows*/
+	u32 sids[];
+};
+
+
+/**
+ * context_cmp - compares 2 contexts
+ * @a: the context to compare
+ * @b: the context to compare with
+ * Compares (for equality) the 2 fireflier security contexts
+ * it actually has to compare if the inode+mountpoint of the executable is 
the same
+ * and to compare group SIDs
+ */
+static inline int context_cmp(const struct context* a,const struct context* 
b)
+{
+	return (a->inode==b->inode) && !strcmp(a->mnt_devname,b->mnt_devname)
+		&& (a->groupmembers==b->groupmembers) &&
+		
(!a->groupmembers || !memcmp(&a->sids,&b->sids,a->groupmembers*sizeof(u32))) 
&&
+		(a->unsafe == b->unsafe) ;
+}
+
+/**
+ * context_cpy - copies a context
+ * @dest:  destination context
+ * @source: source context
+ *
+ */
+static inline void context_cpy(struct context** dest,const struct context* 
source)
+{
+	const size_t struct_size = sizeof(*source)+sizeof(u32)*source->groupmembers;
+	*dest = kmalloc(struct_size,GFP_ATOMIC);
+	memcpy(*dest,source,struct_size);
+}
+#endif
