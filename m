Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWDGSto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWDGSto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWDGSsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:48:46 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:400
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S964866AbWDGSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:48:36 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: linux-security-module@vger.kernel.org
Subject: [RFC][PATCH 5/7] debugging/testing support
Date: Fri, 7 Apr 2006 21:43:48 +0300
User-Agent: KMail/1.9.1
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, sds@tycho.nsa.gov
References: <200604021240.21290.edwin@gurde.com> <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com>
In-Reply-To: <200604072124.24000.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072143.48918.edwin@gurde.com>
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

This dumps sid/pid maps to debugfs.
It is to be used for debugging/testing only.

---
 fireflier_debug.c |  134 
++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fireflier_debug.h |   18 +++++++
 2 files changed, 152 insertions(+)
diff -uprN null/fireflier_debug.c fireflier_lsm/fireflier_debug.c
--- null/fireflier_debug.c	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/fireflier_debug.c	2006-03-29 23:23:57.000000000 +0300
@@ -0,0 +1,134 @@
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "fireflier_debug.h"
+static struct dentry* fireflier_debugfs=0;
+static struct dentry* sidmap_debugfs=0;
+static struct dentry* pidmap_debugfs=0;
+
+extern int ff_debug;
+
+static int debug_show(struct seq_file *s, void *_)
+{
+	seq_printf(s,"%s\n",(char*)s->private);
+	return 0;
+}
+
+static int debug_string_open(struct inode* inode, struct file* file)
+{
+	return single_open(file,debug_show,inode->u.generic_ip);
+}
+
+
+static struct file_operations fops_string = {
+	.open           = debug_string_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+
+
+static inline struct dentry* debugfs_create_readonly_string(const char* 
name,mode_t mode,struct dentry* parent,char* value)
+{
+	return debugfs_create_file(name,mode,parent,value,&fops_string);
+}
+
+void ff_debug_map_pidsid(u32 sid)
+{
+	u32* sid_d = kmalloc(sizeof(u32),GFP_ATOMIC);
+	char pid_s[16];
+
+	if(unlikely(!ff_debug))
+		return;
+
+	if(unlikely(!sid_d)) {
+		printk(KERN_DEBUG "fireflier::ff_debug_map_pidsid: OOM\n");
+		return;
+	}
+	*sid_d = sid;
+	snprintf(pid_s,16,"%d",current->pid);
+
+	debugfs_create_u32(pid_s,0,pidmap_debugfs,sid_d);
+}
+
+void ff_debug_dump_sid(const struct context* context,u32 sid)
+{
+	struct
+	{
+
+		u32 inode;
+		u8  unsafe;
+		char mntpoint[];
+
+	}
+	* sid_debug = kmalloc( sizeof(*sid_debug)+strlen(context->mnt_devname)+1, 
GFP_ATOMIC);
+	//	u32* inode_d = kmalloc(sizeof(u32),GFP_ATOMIC);
+	char sid_s[16];
+	struct dentry* sid_dentry=NULL;
+	//	char* mntpoint_d = kmalloc(strlen(mntpoint)+1,GFP_ATOMIC);
+	//	strncpy(mntpoint_d,mntpoint,strlen(mntpoint)+1);
+
+	if(unlikely(!ff_debug))
+		return;
+
+	
strncpy(sid_debug->mntpoint,context->mnt_devname,strlen(context->mnt_devname)+1);
+	sid_debug->inode=context->inode;
+	sid_debug->unsafe=context->unsafe;
+
+	/*	if(unlikely(!inode_d)) {
+		printk(KERN_DEBUG "fireflier::ff_debug_dump_sid: OOM\n");
+		return;
+		}
+		*inode_d=inode;*/
+	snprintf(sid_s,16,"%d",sid);
+
+	sid_dentry = debugfs_create_dir(sid_s,sidmap_debugfs);
+	if(!sid_dentry) {
+		//already created
+		return;
+	}
+
+
+	debugfs_create_u32("inode",0,sid_dentry,&sid_debug->inode);
+	debugfs_create_u8("unsafe",0,sid_dentry,&sid_debug->unsafe);
+	
debugfs_create_readonly_string("mountpoint",0,sid_dentry,sid_debug->mntpoint);
+	if(context->groupmembers>0)
+	{
+		int i;
+		for(i=0;i<context->groupmembers;i++)
+		{
+			snprintf(sid_s,16,"%d",context->sids[i]);
+			debugfs_create_u8(sid_s,0,sid_dentry,&sid_debug->unsafe);
+		}
+	}
+}
+
+
+
+void ff_debug_startup(void)
+{
+	if(!ff_debug)
+		return;
+	ff_debug=0;
+	fireflier_debugfs = debugfs_create_dir("fireflier",NULL);
+	if(!fireflier_debugfs)  {
+		printk(KERN_DEBUG "fireflier: failed to create debug root fs!\n");
+		return;
+	}
+
+	sidmap_debugfs = debugfs_create_dir("sidmap",fireflier_debugfs);
+	if(!sidmap_debugfs) {
+		printk(KERN_DEBUG "fireflier: failed to create debug sidmap fs!\n");
+		return;
+	}
+
+	pidmap_debugfs = debugfs_create_dir("pidmap",fireflier_debugfs);
+	if(!pidmap_debugfs) {
+		printk(KERN_DEBUG "fireflier: failed to create debug sidmap fs!\n");
+		return;
+	}
+
+	ff_debug=1;
+	printk(KERN_DEBUG "fireflier: debugging enabled\n");
+}
diff -uprN null/fireflier_debug.h fireflier_lsm/fireflier_debug.h
--- null/fireflier_debug.h	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/fireflier_debug.h	2006-03-29 23:23:57.000000000 +0300
@@ -0,0 +1,18 @@
+#ifndef _FIREFLIER_DEBUG_H
+#define _FIREFLIER_DEBUG_H
+
+#define FIREFLIER_DEBUG 1
+#include "context.h"
+//extern struct dentry* fireflier_debugfs;
+
+#ifndef FIREFLIER_DEBUG
+static inline void ff_debug_dump_sid(const struct context* context,u32 sid) 
{}
+static inline void ff_debug_startup(void) {}
+static inline void ff_debug_map_pidsid(u32 sid) {}
+#else
+void ff_debug_dump_sid(const struct context* context,u32 sid);
+void ff_debug_startup(void);
+void ff_debug_map_pidsid(u32 sid);
+#endif
+
+#endif
