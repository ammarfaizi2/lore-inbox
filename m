Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbUK2TMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUK2TMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUK2TMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:12:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:9915 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261539AbUK2Sy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:54:59 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: [PATCH] CKRM: 3/10 CKRM:  Core ckrm, rcfs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19693.1101754052.1@us.ibm.com>
Date: Mon, 29 Nov 2004 10:47:32 -0800
Message-Id: <E1CYqYe-00057g-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Main code for CKRM default classification engine.  Adds Resrouce
Control (rc) filesystem as mechanism for setting policies for
class assignments in CKRM.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>


 include/linux/ckrm_ce.h     |  108 +++++
 include/linux/ckrm_events.h |    8 
 include/linux/ckrm_rc.h     |  355 ++++++++++++++++
 include/linux/rcfs.h        |   96 ++++
 include/linux/sched.h       |    6 
 init/main.c                 |    2 
 kernel/ckrm/Makefile        |    2 
 kernel/ckrm/ckrm.c          |  927 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/ckrm/ckrmutils.c     |  195 +++++++++
 9 files changed, 1694 insertions(+), 5 deletions(-)

Index: linux-2.6.10-rc2/include/linux/ckrm_ce.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/include/linux/ckrm_ce.h	2004-11-19 20:43:43.484218139 -0800
@@ -0,0 +1,108 @@
+/*
+ *  ckrm_ce.h - Header file to be used by Classification Engine of CKRM
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Shailabh Nagar,  IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ * 
+ * Provides data structures, macros and kernel API of CKRM for 
+ * classification engine.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+/* Changes
+ *
+ * 12 Nov 2003
+ *        Created.
+ * 22 Apr 2004
+ *        Adopted to classtypes
+ */
+
+#ifndef _LINUX_CKRM_CE_H
+#define _LINUX_CKRM_CE_H
+
+#ifdef CONFIG_CKRM
+
+#include <linux/ckrm_events.h>
+
+/*
+ * Action parameters identifying the cause of a task<->class notify callback 
+ * these can perculate up to user daemon consuming records send by the 
+ * classification engine
+ */
+
+#ifdef __KERNEL__
+
+typedef void *(*ce_classify_fct_t) (enum ckrm_event event, void *obj, ...);
+typedef void (*ce_notify_fct_t) (enum ckrm_event event, void *classobj,
+				 void *obj);
+
+typedef struct ckrm_eng_callback {
+	/* general state information */
+	int always_callback;	/* set if CE should always be called back 
+				   regardless of numclasses */
+
+	/* callbacks which are called without holding locks */
+
+	unsigned long c_interest;	/* set of classification events of 
+					 * interest to CE 
+					 */
+
+	/* generic classify */
+	ce_classify_fct_t classify;
+
+	/* class added */
+	void (*class_add) (const char *name, void *core, int classtype);
+
+	/* class deleted */
+	void (*class_delete) (const char *name, void *core, int classtype);
+
+	/* callbacks which are called while holding task_lock(tsk) */
+	unsigned long n_interest;	/* set of notification events of 
+					 *  interest to CE 
+					 */
+	/* notify on class switch */
+	ce_notify_fct_t notify;	
+} ckrm_eng_callback_t;
+
+struct inode;
+struct dentry;
+
+typedef struct rbce_eng_callback {
+	int (*mkdir) (struct inode *, struct dentry *, int);	/* mkdir */
+	int (*rmdir) (struct inode *, struct dentry *);		/* rmdir */
+	int (*mnt) (void);
+	int (*umnt) (void);
+} rbce_eng_callback_t;
+
+extern int ckrm_register_engine(const char *name, ckrm_eng_callback_t *);
+extern int ckrm_unregister_engine(const char *name);
+
+extern void *ckrm_classobj(char *, int *classtype);
+extern int get_exe_path_name(struct task_struct *t, char *filename,
+			     int max_size);
+
+extern int rcfs_register_engine(rbce_eng_callback_t *);
+extern int rcfs_unregister_engine(rbce_eng_callback_t *);
+
+extern int ckrm_reclassify(int pid);
+
+#ifndef _LINUX_CKRM_RC_H
+
+extern void ckrm_core_grab(void *);
+extern void ckrm_core_drop(void *);
+#endif
+
+#endif /* CONFIG_CKRM */
+#endif /* __KERNEL__ */
+#endif /* _LINUX_CKRM_CE_H */
Index: linux-2.6.10-rc2/include/linux/ckrm_events.h
===================================================================
--- linux-2.6.10-rc2.orig/include/linux/ckrm_events.h	2004-11-19 20:40:52.517303823 -0800
+++ linux-2.6.10-rc2/include/linux/ckrm_events.h	2004-11-19 20:43:43.487217664 -0800
@@ -163,8 +163,6 @@
 struct user_struct;
 
 CKRM_DEF_CB_ARG(FORK, fork, struct task_struct *);
-CKRM_DEF_CB_ARG(NEWTASK, newtask, struct task_struct *);
-CKRM_DEF_CB_ARG(EXIT, exit, struct task_struct *);
 CKRM_DEF_CB_ARG(EXEC, exec, const char *);
 CKRM_DEF_CB(UID, uid);
 CKRM_DEF_CB(GID, gid);
@@ -177,9 +175,11 @@
 
 /* some other functions required */
 #ifdef CONFIG_CKRM
-void ckrm_cb_newtask(struct task_struct *);
-void ckrm_cb_exit(struct task_struct *);
+extern void ckrm_init(void);
+extern void ckrm_cb_newtask(struct task_struct *);
+extern void ckrm_cb_exit(struct task_struct *);
 #else
+#define ckrm_init()		do { } while (0)
 #define ckrm_cb_newtask(x)	do { } while (0)
 #define ckrm_cb_exit(x)		do { } while (0)
 #endif
Index: linux-2.6.10-rc2/include/linux/ckrm_rc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/include/linux/ckrm_rc.h	2004-11-19 20:43:43.493216714 -0800
@@ -0,0 +1,355 @@
+/*
+ *  ckrm_rc.h - Header file to be used by Resource controllers of CKRM
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Shailabh Nagar,  IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ *	     (C) Vivek Kashyap , IBM Corp. 2004
+ * 
+ * Provides data structures, macros and kernel API of CKRM for 
+ * resource controllers.
+ *
+ * More details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/*
+ * Changes
+ *
+ * 12 Nov 2003
+ *        Created.
+ */
+
+#ifndef _LINUX_CKRM_RC_H
+#define _LINUX_CKRM_RC_H
+
+#ifdef __KERNEL__
+
+#ifdef CONFIG_CKRM
+
+#include <linux/list.h>
+#include <linux/ckrm_events.h>
+#include <linux/ckrm_ce.h>
+#include <linux/seq_file.h>
+
+#define CKRM_MAX_CLASSTYPES         32	/* maximum number of class types */
+#define CKRM_MAX_CLASSTYPE_NAME     32 	/* maximum classtype name length */
+
+#define CKRM_MAX_RES_CTLRS           8	/* maximum resource controllers per classtype */
+#define CKRM_MAX_RES_NAME          128	/* maximum resource controller name length */
+
+struct ckrm_core_class;
+struct ckrm_classtype;
+
+/*
+ * Share specifications
+ */
+
+typedef struct ckrm_shares {
+	int my_guarantee;
+	int my_limit;
+	int total_guarantee;
+	int max_limit;
+	int unused_guarantee;	/* not used as parameters */
+	int cur_max_limit;	/* not used as parameters */
+} ckrm_shares_t;
+
+#define CKRM_SHARE_UNCHANGED     (-1)	
+#define CKRM_SHARE_DONTCARE      (-2)	
+#define CKRM_SHARE_DFLT_TOTAL_GUARANTEE (100) 
+#define CKRM_SHARE_DFLT_MAX_LIMIT     (100)  
+
+/*
+ * RESOURCE CONTROLLERS
+ */
+
+/* resource controller callback structure */
+
+typedef struct ckrm_res_ctlr {
+	char res_name[CKRM_MAX_RES_NAME];
+	int res_hdepth;		/* maximum hierarchy */
+	int resid;		/* (for now) same as the enum resid */
+	struct ckrm_classtype *classtype;    /* classtype owning this res ctlr */
+
+	/* allocate/free new resource class object for resource controller */
+	void *(*res_alloc) (struct ckrm_core_class * this,
+			    struct ckrm_core_class * parent);
+	void (*res_free) (void *);
+
+	/* set/get limits/guarantees for a resource controller class */
+	int (*set_share_values) (void *, struct ckrm_shares * shares);
+	int (*get_share_values) (void *, struct ckrm_shares * shares);
+
+	/* statistics and configuration access */
+	int (*get_stats) (void *, struct seq_file *);
+	int (*reset_stats) (void *);
+	int (*show_config) (void *, struct seq_file *);
+	int (*set_config) (void *, const char *cfgstr);
+
+	void (*change_resclass) (void *, void *, void *);
+} ckrm_res_ctlr_t;
+
+/*
+ * CKRM_CLASSTYPE
+ *
+ * A <struct ckrm_classtype> object describes a dimension for CKRM to classify 
+ * along. Need to provide methods to create and manipulate class objects in
+ * this dimension
+ */
+
+/* list of predefined class types, we always recognize */
+#define CKRM_CLASSTYPE_TASK_CLASS    0
+#define CKRM_CLASSTYPE_SOCKET_CLASS  1
+#define CKRM_RESV_CLASSTYPES         2	/* always +1 of last known type */
+
+#define CKRM_MAX_TYPENAME_LEN       32
+
+typedef struct ckrm_classtype {
+	/* TODO: Review for cache alignment */
+
+	/* resource controllers */
+
+	spinlock_t res_ctlrs_lock;  /* protect res ctlr related data */
+	int max_res_ctlrs;          /* max number of res ctlrs allowed */
+	int max_resid;              /* max resid used */
+	int resid_reserved;	    /* max number of reserved controllers */
+	long bit_res_ctlrs;	    /* bitmap of resource ID used */
+	atomic_t nr_resusers[CKRM_MAX_RES_CTLRS];
+	ckrm_res_ctlr_t *res_ctlrs[CKRM_MAX_RES_CTLRS];
+
+	/* state about my classes */
+
+	struct ckrm_core_class *default_class;	
+	struct list_head classes;  /* link all classes of this classtype */
+	int num_classes;	 
+
+	/* state about my ce interaction */
+	atomic_t ce_regd;		/* if CE registered */
+	int ce_cb_active;		/* if Callbacks active */
+	atomic_t ce_nr_users;		/* number of active transient calls */
+	struct ckrm_eng_callback ce_callbacks;	/* callback engine */
+
+	/* Begin classtype-rcfs private data. No rcfs/fs specific types used.  */
+
+	int mfidx;		/* Index into genmfdesc array used to initialize */
+	void *mfdesc;		/* Array of descriptors of root and magic files */
+	int mfcount;		/* length of above array */
+	void *rootde;		/* root dentry created by rcfs */
+	/* End rcfs private data */
+
+	char name[CKRM_MAX_TYPENAME_LEN]; /* currently same as mfdesc[0]->name  */
+	                                  /* but could be different */
+	int typeID;			  /* unique TypeID */
+	int maxdepth;			  /* maximum depth supported */
+
+	/* functions to be called on any class type by external API's */
+
+	struct ckrm_core_class *(*alloc) (struct ckrm_core_class * parent, 
+					  const char *name);	
+	int (*free) (struct ckrm_core_class * cls);	
+	int (*show_members) (struct ckrm_core_class *, struct seq_file *);
+	int (*show_stats) (struct ckrm_core_class *, struct seq_file *);
+	int (*show_config) (struct ckrm_core_class *, struct seq_file *);
+	int (*show_shares) (struct ckrm_core_class *, struct seq_file *);
+
+	int (*reset_stats) (struct ckrm_core_class *, const char *resname,
+			    const char *);
+	int (*set_config) (struct ckrm_core_class *, const char *resname,
+			   const char *cfgstr);
+	int (*set_shares) (struct ckrm_core_class *, const char *resname,
+			   struct ckrm_shares * shares);
+	int (*forced_reclassify) (struct ckrm_core_class *, const char *);
+
+	/* functions to be called on a class type by ckrm internals */
+
+	/* class initialization for new RC */
+	void (*add_resctrl) (struct ckrm_core_class *, int resid);	
+} ckrm_classtype_t;
+
+/*
+ * CKRM CORE CLASS
+ *      common part to any class structure (i.e. instance of a classtype)
+ */
+
+/*
+ * basic definition of a hierarchy that is to be used by the the CORE classes
+ * and can be used by the resource class objects
+ */
+
+#define CKRM_CORE_MAGIC		0xBADCAFFE
+
+typedef struct ckrm_hnode {
+	struct ckrm_core_class *parent;
+	struct list_head siblings;	
+	struct list_head children;	
+} ckrm_hnode_t;
+
+typedef struct ckrm_core_class {
+	struct ckrm_classtype *classtype;	
+	void *res_class[CKRM_MAX_RES_CTLRS];	/* resource classes */
+	spinlock_t class_lock;	                /* protects list,array above */
+
+	struct list_head objlist;		/* generic object list */
+	struct list_head clslist;		/* peer classtype classes */
+	struct dentry *dentry;			/* dentry of inode in the RCFS */
+	int magic;
+
+	struct ckrm_hnode hnode;		/* hierarchy */
+	rwlock_t hnode_rwlock;			/* protects hnode above. */
+	atomic_t refcnt;
+	const char *name;
+	int delayed;				/* core deletion delayed  */
+						/* because of race conditions */
+} ckrm_core_class_t;
+
+/* type coerce between derived class types and ckrm core class type */
+#define class_type(type,coreptr)   container_of(coreptr,type,core)
+#define class_core(clsptr)         (&(clsptr)->core)
+/* locking classes */
+#define class_lock(coreptr)        spin_lock(&(coreptr)->class_lock)
+#define class_unlock(coreptr)      spin_unlock(&(coreptr)->class_lock)
+/* what type is a class of ISA */
+#define class_isa(clsptr)          (class_core(clsptr)->classtype)
+
+/*
+ * OTHER
+ */
+
+#define ckrm_get_res_class(rescls, resid, type) \
+	((type*) (((resid != -1) && ((rescls) != NULL) \
+			   && ((rescls) != (void *)-1)) ? \
+	 ((struct ckrm_core_class *)(rescls))->res_class[resid] : NULL))
+
+
+extern int ckrm_register_res_ctlr(struct ckrm_classtype *, ckrm_res_ctlr_t *);
+extern int ckrm_unregister_res_ctlr(ckrm_res_ctlr_t *);
+
+extern int ckrm_validate_and_grab_core(struct ckrm_core_class *core);
+extern int ckrm_init_core_class(struct ckrm_classtype *clstype,
+				struct ckrm_core_class *dcore,
+				struct ckrm_core_class *parent,
+				const char *name);
+extern int ckrm_release_core_class(struct ckrm_core_class *);	
+
+/* TODO: can disappear after cls del debugging */
+
+extern struct ckrm_res_ctlr *ckrm_resctlr_lookup(struct ckrm_classtype *type,
+						 const char *resname);
+
+extern void ckrm_lock_hier(struct ckrm_core_class *);
+extern void ckrm_unlock_hier(struct ckrm_core_class *);
+extern struct ckrm_core_class *ckrm_get_next_child(struct ckrm_core_class *,
+						   struct ckrm_core_class *);
+
+extern void child_guarantee_changed(struct ckrm_shares *, int, int);
+extern void child_maxlimit_changed(struct ckrm_shares *, int);
+extern int set_shares(struct ckrm_shares *, struct ckrm_shares *,
+		      struct ckrm_shares *);
+
+/* classtype registration and lookup */
+extern int ckrm_register_classtype(struct ckrm_classtype *clstype);
+extern int ckrm_unregister_classtype(struct ckrm_classtype *clstype);
+extern struct ckrm_classtype *ckrm_find_classtype_by_name(const char *name);
+
+/* default functions that can be used in classtypes's function table */
+extern int ckrm_class_show_shares(struct ckrm_core_class *core,
+				  struct seq_file *seq);
+extern int ckrm_class_show_stats(struct ckrm_core_class *core,
+				 struct seq_file *seq);
+extern int ckrm_class_show_config(struct ckrm_core_class *core,
+				  struct seq_file *seq);
+extern int ckrm_class_set_config(struct ckrm_core_class *core,
+				 const char *resname, const char *cfgstr);
+extern int ckrm_class_set_shares(struct ckrm_core_class *core,
+				 const char *resname,
+				 struct ckrm_shares *shares);
+extern int ckrm_class_reset_stats(struct ckrm_core_class *core,
+				  const char *resname, const char *unused);
+
+static inline void ckrm_core_grab(struct ckrm_core_class *core)
+{
+	if (core)
+		atomic_inc(&core->refcnt);
+}
+
+static inline void ckrm_core_drop(struct ckrm_core_class *core)
+{
+	/* only make definition available in this context */
+	extern void ckrm_free_core_class(struct ckrm_core_class *core);
+	if (core && (atomic_dec_and_test(&core->refcnt)))
+		ckrm_free_core_class(core);
+}
+
+static inline unsigned int ckrm_is_core_valid(ckrm_core_class_t * core)
+{
+	return (core && (core->magic == CKRM_CORE_MAGIC));
+}
+
+/*
+ * iterate through all associate resource controllers:
+ * requires following arguments (ckrm_core_class *cls, 
+ *                               ckrm_res_ctrl   *ctlr,
+ *                               void            *robj,
+ *                               int              bmap)
+ */
+
+#define forall_class_resobjs(cls,rcbs,robj,bmap)			\
+       for ( bmap=((cls->classtype)->bit_res_ctlrs) ;			\
+	     ({ int rid; ((rid=ffs(bmap)-1) >= 0) &&			\
+	                 (bmap &= ~(1<<rid),				\
+				((rcbs=cls->classtype->res_ctlrs[rid])	\
+				 && (robj=cls->res_class[rid]))); });	\
+           )
+
+extern struct ckrm_classtype *ckrm_classtypes[];	
+
+/*
+ * CE Invocation interface
+ */
+
+#define ce_protect(ctype)      (atomic_inc(&((ctype)->ce_nr_users)))
+#define ce_release(ctype)      (atomic_dec(&((ctype)->ce_nr_users)))
+
+/* CE Classification callbacks with */
+
+#define CE_CLASSIFY_NORET(ctype, event, objs_to_classify...)		\
+do {									\
+	if ((ctype)->ce_cb_active					\
+	    && (test_bit(event,&(ctype)->ce_callbacks.c_interest)))	\
+		(*(ctype)->ce_callbacks.classify)(event,		\
+						  objs_to_classify);	\
+} while (0)
+
+#define CE_CLASSIFY_RET(ret, ctype, event, objs_to_classify...)		\
+do {									\
+	if ((ctype)->ce_cb_active					\
+	    && (test_bit(event,&(ctype)->ce_callbacks.c_interest)))	\
+		ret = (*(ctype)->ce_callbacks.classify)(event,		\
+							objs_to_classify);\
+} while (0)
+
+#define CE_NOTIFY(ctype, event, cls, objs_to_classify)			\
+do {									\
+	if ((ctype)->ce_cb_active					\
+	    && (test_bit(event,&(ctype)->ce_callbacks.n_interest)))	\
+		(*(ctype)->ce_callbacks.notify)(event,			\
+						cls,objs_to_classify);	\
+} while (0)
+
+/*
+ * RCFS related 
+ */
+
+/* vars needed by other modules/core */
+
+extern int rcfs_mounted;
+extern int rcfs_engine_regd;
+
+#endif /* CONFIG_CKRM */
+#endif /* __KERNEL__ */
+#endif /* _LINUX_CKRM_RC_H */
Index: linux-2.6.10-rc2/include/linux/rcfs.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/include/linux/rcfs.h	2004-11-19 20:43:43.497216080 -0800
@@ -0,0 +1,96 @@
+#ifndef _LINUX_RCFS_H
+#define _LINUX_RCFS_H
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/ckrm_events.h>
+#include <linux/ckrm_rc.h>
+#include <linux/ckrm_ce.h>
+
+/*
+ * The following declarations cannot be included in any of ckrm*.h files 
+ * without jumping hoops. Remove later when rearrangements done
+ */
+
+#define RCFS_MAGIC	0x4feedbac
+#define RCFS_MAGF_NAMELEN 20
+extern int RCFS_IS_MAGIC;
+
+#define rcfs_is_magic(dentry)  ((dentry)->d_fsdata == &RCFS_IS_MAGIC)
+
+typedef struct rcfs_inode_info {
+	ckrm_core_class_t *core;
+	char *name;
+	struct inode vfs_inode;
+} rcfs_inode_info_t;
+
+#define RCFS_DEFAULT_DIR_MODE	(S_IFDIR | S_IRUGO | S_IXUGO)
+#define RCFS_DEFAULT_FILE_MODE	(S_IFREG | S_IRUSR | S_IWUSR | S_IRGRP |S_IROTH)
+
+struct rcfs_magf {
+	char name[RCFS_MAGF_NAMELEN];
+	int mode;
+	struct inode_operations *i_op;
+	struct file_operations *i_fop;
+};
+
+struct rcfs_mfdesc {
+	struct rcfs_magf *rootmf;	/* Root directory and its magic files */
+	int rootmflen;			/* length of above array */
+	/*
+	 * Can have a different magf describing magic files 
+	 * for non-root entries too.
+	 */
+};
+
+extern struct rcfs_mfdesc *genmfdesc[];
+
+inline struct rcfs_inode_info *RCFS_I(struct inode *inode);
+
+int rcfs_empty(struct dentry *);
+struct inode *rcfs_get_inode(struct super_block *, int, dev_t);
+int rcfs_mknod(struct inode *, struct dentry *, int, dev_t);
+int _rcfs_mknod(struct inode *, struct dentry *, int, dev_t);
+int rcfs_mkdir(struct inode *, struct dentry *, int);
+ckrm_core_class_t *rcfs_make_core(struct dentry *, struct ckrm_core_class *);
+struct dentry *rcfs_set_magf_byname(char *, void *);
+
+struct dentry *rcfs_create_internal(struct dentry *, struct rcfs_magf *, int);
+int rcfs_delete_internal(struct dentry *);
+int rcfs_create_magic(struct dentry *, struct rcfs_magf *, int);
+int rcfs_clear_magic(struct dentry *);
+
+extern struct super_operations rcfs_super_ops;
+extern struct address_space_operations rcfs_aops;
+
+extern struct inode_operations rcfs_dir_inode_operations;
+extern struct inode_operations rcfs_rootdir_inode_operations;
+extern struct inode_operations rcfs_file_inode_operations;
+
+extern struct file_operations target_fileops;
+extern struct file_operations shares_fileops;
+extern struct file_operations stats_fileops;
+extern struct file_operations config_fileops;
+extern struct file_operations members_fileops;
+extern struct file_operations reclassify_fileops;
+extern struct file_operations rcfs_file_operations;
+
+/* Callbacks into rcfs from ckrm */
+
+typedef struct rcfs_functions {
+	int (*mkroot) (struct rcfs_magf *, int, struct dentry **);
+	int (*rmroot) (struct dentry *);
+	int (*register_classtype) (ckrm_classtype_t *);
+	int (*deregister_classtype) (ckrm_classtype_t *);
+} rcfs_fn_t;
+
+int rcfs_register_classtype(ckrm_classtype_t *);
+int rcfs_deregister_classtype(ckrm_classtype_t *);
+int rcfs_mkroot(struct rcfs_magf *, int, struct dentry **);
+int rcfs_rmroot(struct dentry *);
+
+#define RCFS_ROOT "/rcfs"  	/* TODO:  Should use the mount point */
+extern struct dentry *rcfs_rootde;
+extern rbce_eng_callback_t rcfs_eng_callbacks;
+
+#endif	/* _LINUX_RCFS_H */
Index: linux-2.6.10-rc2/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc2.orig/include/linux/sched.h	2004-11-19 20:41:45.564899680 -0800
+++ linux-2.6.10-rc2/include/linux/sched.h	2004-11-19 20:43:43.503215130 -0800
@@ -30,6 +30,7 @@
 #include <linux/pid.h>
 #include <linux/percpu.h>
 #include <linux/topology.h>
+#include <linux/taskdelays.h>
 
 struct exec_domain;
 
@@ -667,6 +668,11 @@
 #ifdef CONFIG_DELAY_ACCT
 	struct task_delay_info delays;
 #endif
+#ifdef CONFIG_CKRM
+	spinlock_t  ckrm_tsklock;
+	void       *ce_data;
+#endif
+
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: linux-2.6.10-rc2/init/main.c
===================================================================
--- linux-2.6.10-rc2.orig/init/main.c	2004-11-14 17:27:03.000000000 -0800
+++ linux-2.6.10-rc2/init/main.c	2004-11-19 20:44:11.316808720 -0800
@@ -46,6 +46,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/ckrm_events.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -523,6 +524,7 @@
 	rcu_init();
 	init_IRQ();
 	pidhash_init();
+	ckrm_init();
 	init_timers();
 	softirq_init();
 	time_init();
Index: linux-2.6.10-rc2/kernel/ckrm/ckrm.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/kernel/ckrm/ckrm.c	2004-11-19 20:43:43.520212437 -0800
@@ -0,0 +1,927 @@
+/* ckrm.c - Class-based Kernel Resource Management (CKRM)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003, 2004
+ *           (C) Shailabh Nagar,  IBM Corp. 2003, 2004
+ *           (C) Chandra Seetharaman,  IBM Corp. 2003
+ *	     (C) Vivek Kashyap,	IBM Corp. 2004
+ * 
+ * 
+ * Provides kernel API of CKRM for in-kernel,per-resource controllers 
+ * (one each for cpu, memory, io, network) and callbacks for 
+ * classification modules.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/*
+ * Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ * 06 Nov 2003
+ *        Made modifications to suit the new RBCE module.
+ * 10 Nov 2003
+ *        Fixed a bug in fork and exit callbacks. Added callbacks_active and
+ *        surrounding logic. Added task paramter for all CE callbacks.
+ * 23 Mar 2004
+ *        moved to referenced counted class objects and correct locking
+ * 19 Apr 2004
+ *        Integrated ckrm hooks, classtypes, ...
+ *  
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+#include <linux/mm.h>
+#include <asm/errno.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/ckrm_rc.h>
+#include <linux/rcfs.h>
+#include <net/sock.h>
+#include <linux/ip.h>
+
+rwlock_t ckrm_class_lock = RW_LOCK_UNLOCKED;	/* protects classlists */
+
+struct rcfs_functions rcfs_fn;
+EXPORT_SYMBOL_GPL(rcfs_fn);
+
+int rcfs_engine_regd;		/* rcfs state needed by another module */
+EXPORT_SYMBOL_GPL(rcfs_engine_regd);
+
+int rcfs_mounted;
+EXPORT_SYMBOL_GPL(rcfs_mounted);
+
+/*
+ * Helper Functions
+ */
+
+/*
+ * Return TRUE if the given resource is registered.
+ */
+inline unsigned int is_res_regd(struct ckrm_classtype *clstype, int resid)
+{
+	return ((resid >= 0) && (resid < clstype->max_resid) &&
+		test_bit(resid, &clstype->bit_res_ctlrs)
+	    );
+}
+
+/*
+ * Return TRUE if the given core class pointer is valid.
+ */
+struct ckrm_res_ctlr *ckrm_resctlr_lookup(struct ckrm_classtype *clstype,
+					  const char *resname)
+{
+	int resid = -1;
+
+	if (!clstype || !resname) {
+		return NULL;
+	}
+	for (resid = 0; resid < clstype->max_resid; resid++) {
+		if (test_bit(resid, &clstype->bit_res_ctlrs)) {
+			struct ckrm_res_ctlr *rctrl = clstype->res_ctlrs[resid];
+			if (!strncmp(resname, rctrl->res_name,
+				     CKRM_MAX_RES_NAME))
+				return rctrl;
+		}
+	}
+	return NULL;
+}
+
+EXPORT_SYMBOL_GPL(ckrm_resctlr_lookup);
+
+/* given a classname return the class handle and its classtype*/
+void *ckrm_classobj(char *classname, int *classTypeID)
+{
+	int i;
+
+	*classTypeID = -1;
+	if (!classname || !*classname) {
+		return NULL;
+	}
+
+	read_lock(&ckrm_class_lock);
+	for (i = 0; i < CKRM_MAX_CLASSTYPES; i++) {
+		struct ckrm_classtype *ctype = ckrm_classtypes[i];
+		struct ckrm_core_class *core;
+
+		if (ctype == NULL)
+			continue;
+		list_for_each_entry(core, &ctype->classes, clslist) {
+			if (core->name && !strcmp(core->name, classname)) {
+				// FIXME:   should grep reference..
+				read_unlock(&ckrm_class_lock);
+				*classTypeID = ctype->typeID;
+				return core;
+			}
+		}
+	}
+	read_unlock(&ckrm_class_lock);
+	return NULL;
+}
+
+EXPORT_SYMBOL_GPL(is_res_regd);
+EXPORT_SYMBOL_GPL(ckrm_classobj);
+
+/*
+ * Internal Functions/macros
+ */
+
+static inline void set_callbacks_active(struct ckrm_classtype *ctype)
+{
+	ctype->ce_cb_active = ((atomic_read(&ctype->ce_regd) > 0) &&
+			       (ctype->ce_callbacks.always_callback
+				|| (ctype->num_classes > 1)));
+}
+
+int ckrm_validate_and_grab_core(struct ckrm_core_class *core)
+{
+	int rc = 0;
+	read_lock(&ckrm_class_lock);
+	if (likely(ckrm_is_core_valid(core))) {
+		ckrm_core_grab(core);
+		rc = 1;
+	}
+	read_unlock(&ckrm_class_lock);
+	return rc;
+}
+
+/*
+ * Interfaces for classification engine
+ */
+
+/*
+ * Registering a callback structure by the classification engine.
+ *
+ * Returns typeId of class on success -errno for failure.
+ */
+int ckrm_register_engine(const char *typename, ckrm_eng_callback_t * ecbs)
+{
+	struct ckrm_classtype *ctype;
+
+	ctype = ckrm_find_classtype_by_name(typename);
+	if (ctype == NULL)
+		return (-ENOENT);
+
+	atomic_inc(&ctype->ce_regd);
+
+	/* another engine registered or trying to register ? */
+	if (atomic_read(&ctype->ce_regd) != 1) {
+		atomic_dec(&ctype->ce_regd);
+		return (-EBUSY);
+	}
+
+	/*
+	 * One of the following must be set: 
+	 * classify, class_delete (due to object reference) or 
+	 * notify (case where notification supported but not classification)
+	 * The function pointer must be set the momement the mask is non-null
+	 */
+	if (!(((ecbs->classify) && (ecbs->class_delete)) || (ecbs->notify)) ||
+	    (ecbs->c_interest && ecbs->classify == NULL) ||
+	    (ecbs->n_interest && ecbs->notify == NULL)) {
+		atomic_dec(&ctype->ce_regd);
+		return (-EINVAL);
+	}
+
+	ctype->ce_callbacks = *ecbs;
+	set_callbacks_active(ctype);
+
+	if (ctype->ce_callbacks.class_add) {
+		struct ckrm_core_class *core;
+
+		read_lock(&ckrm_class_lock);
+		list_for_each_entry(core, &ctype->classes, clslist) {
+			(*ctype->ce_callbacks.class_add) (core->name, core,
+							  ctype->typeID);
+		}
+		read_unlock(&ckrm_class_lock);
+	}
+	return ctype->typeID;
+}
+
+/*
+ * Unregistering a callback structure by the classification engine.
+ *
+ * Returns 0 on success -errno for failure.
+ */
+int ckrm_unregister_engine(const char *typename)
+{
+	struct ckrm_classtype *ctype;
+
+	ctype = ckrm_find_classtype_by_name(typename);
+	if (ctype == NULL)
+		return (-ENOENT);
+
+	ctype->ce_cb_active = 0;
+	if (atomic_read(&ctype->ce_nr_users) > 1) {
+		/* Somebody is currently using the engine, cannot deregister. */
+		return (-EAGAIN);
+	}
+	atomic_set(&ctype->ce_regd, 0);
+	memset(&ctype->ce_callbacks, 0, sizeof(ckrm_eng_callback_t));
+	return 0;
+}
+
+/*
+ * Interfaces to manipulate class (core or resource) hierarchies
+ */
+
+static void
+ckrm_add_child(struct ckrm_core_class *parent, struct ckrm_core_class *child)
+{
+	struct ckrm_hnode *cnode = &child->hnode;
+
+	if (!ckrm_is_core_valid(child)) {
+		printk(KERN_ERR "Invalid child %p given in ckrm_add_child\n",
+		       child);
+		return;
+	}
+	class_lock(child);
+	INIT_LIST_HEAD(&cnode->children);
+	INIT_LIST_HEAD(&cnode->siblings);
+
+	if (parent) {
+		struct ckrm_hnode *pnode;
+
+		if (!ckrm_is_core_valid(parent)) {
+			printk(KERN_ERR
+			       "Invalid parent %p given in ckrm_add_child\n",
+			       parent);
+			parent = NULL;
+		} else {
+			pnode = &parent->hnode;
+			write_lock(&parent->hnode_rwlock);
+			list_add(&cnode->siblings, &pnode->children);
+			write_unlock(&parent->hnode_rwlock);
+		}
+	}
+	cnode->parent = parent;
+	class_unlock(child);
+	return;
+}
+
+static int ckrm_remove_child(struct ckrm_core_class *child)
+{
+	struct ckrm_hnode *cnode, *pnode;
+	struct ckrm_core_class *parent;
+
+	if (!ckrm_is_core_valid(child)) {
+		printk(KERN_ERR "Invalid child %p given"
+		       		" in ckrm_remove_child\n",
+		       	child);
+		return 0;
+	}
+
+	cnode = &child->hnode;
+	parent = cnode->parent;
+	if (!ckrm_is_core_valid(parent)) {
+		printk(KERN_ERR "Invalid parent %p in ckrm_remove_child\n",
+		       parent);
+		return 0;
+	}
+
+	pnode = &parent->hnode;
+
+	class_lock(child);
+	/* ensure that the node does not have children */
+	if (!list_empty(&cnode->children)) {
+		class_unlock(child);
+		return 0;
+	}
+	write_lock(&parent->hnode_rwlock);
+	list_del(&cnode->siblings);
+	write_unlock(&parent->hnode_rwlock);
+	cnode->parent = NULL;
+	class_unlock(child);
+	return 1;
+}
+
+void ckrm_lock_hier(struct ckrm_core_class *parent)
+{
+	if (ckrm_is_core_valid(parent)) {
+		read_lock(&parent->hnode_rwlock);
+	}
+}
+
+void ckrm_unlock_hier(struct ckrm_core_class *parent)
+{
+	if (ckrm_is_core_valid(parent)) {
+		read_unlock(&parent->hnode_rwlock);
+	}
+}
+
+/*
+ * hnode_rwlock of the parent core class must held in read mode.
+ * external callers should 've called ckrm_lock_hier before calling this
+ * function.
+ */
+#define hnode_2_core(ptr) \
+((ptr)? container_of(ptr, struct ckrm_core_class, hnode) : NULL)
+
+struct ckrm_core_class *ckrm_get_next_child(struct ckrm_core_class *parent,
+					    struct ckrm_core_class *child)
+{
+	struct list_head *cnode;
+	struct ckrm_hnode *next_cnode;
+	struct ckrm_core_class *next_childcore;
+
+	if (!ckrm_is_core_valid(parent)) {
+		printk(KERN_ERR "Invalid parent %p in ckrm_get_next_child\n",
+		       parent);
+		return NULL;
+	}
+	if (list_empty(&parent->hnode.children)) {
+		return NULL;
+	}
+	if (child) {
+		if (!ckrm_is_core_valid(child)) {
+			printk(KERN_ERR
+			       "Invalid child %p in ckrm_get_next_child\n",
+			       child);
+			return NULL;
+		}
+		cnode = child->hnode.siblings.next;
+	} else {
+		cnode = parent->hnode.children.next;
+	}
+
+	if (cnode == &parent->hnode.children) {	/* back at the anchor */
+		return NULL;
+	}
+
+	next_cnode = container_of(cnode, struct ckrm_hnode, siblings);
+	next_childcore = hnode_2_core(next_cnode);
+
+	if (!ckrm_is_core_valid(next_childcore)) {
+		printk(KERN_ERR
+		       "Invalid next child %p in ckrm_get_next_child\n",
+		       next_childcore);
+		return NULL;
+	}
+	return next_childcore;
+}
+
+EXPORT_SYMBOL_GPL(ckrm_lock_hier);
+EXPORT_SYMBOL_GPL(ckrm_unlock_hier);
+EXPORT_SYMBOL_GPL(ckrm_get_next_child);
+
+static void
+ckrm_alloc_res_class(struct ckrm_core_class *core,
+		     struct ckrm_core_class *parent, int resid)
+{
+
+	struct ckrm_classtype *clstype;
+	/* 
+	 * Allocate a resource class only if the resource controller has
+	 * registered with core and the engine requests for the class.
+	 */
+	if (!ckrm_is_core_valid(core))
+		return;
+	clstype = core->classtype;
+	core->res_class[resid] = NULL;
+
+	if (test_bit(resid, &clstype->bit_res_ctlrs)) {
+		ckrm_res_ctlr_t *rcbs;
+
+		atomic_inc(&clstype->nr_resusers[resid]);
+		rcbs = clstype->res_ctlrs[resid];
+
+		if (rcbs && rcbs->res_alloc) {
+			core->res_class[resid] =
+			    (*rcbs->res_alloc) (core, parent);
+			if (core->res_class[resid])
+				return;
+			printk(KERN_ERR "Error creating res class\n");
+		}
+		atomic_dec(&clstype->nr_resusers[resid]);
+	}
+}
+
+/*
+ * Initialize a core class
+ *
+ */
+
+#define CLS_DEBUG(fmt, args...) \
+do { /* printk("%s: " fmt, __FUNCTION__ , ## args); */ } while (0)
+
+int
+ckrm_init_core_class(struct ckrm_classtype *clstype,
+		     struct ckrm_core_class *dcore,
+		     struct ckrm_core_class *parent, const char *name)
+{
+	/* TODO:  Should replace name with dentry or add dentry? */
+	int i;
+
+	/* TODO:  How is this used in initialization? */
+	CLS_DEBUG("name %s => %p\n", name ? name : "default", dcore);
+	if ((dcore != clstype->default_class) && (!ckrm_is_core_valid(parent))){
+		printk("error not a valid parent %p\n", parent);
+		return -EINVAL;
+	}
+	dcore->classtype = clstype;
+	dcore->magic = CKRM_CORE_MAGIC;
+	dcore->name = name;
+	dcore->class_lock = SPIN_LOCK_UNLOCKED;
+	dcore->hnode_rwlock = RW_LOCK_UNLOCKED;
+	dcore->delayed = 0;
+
+	atomic_set(&dcore->refcnt, 0);
+	write_lock(&ckrm_class_lock);
+
+	INIT_LIST_HEAD(&dcore->objlist);
+	list_add_tail(&dcore->clslist, &clstype->classes);
+
+	clstype->num_classes++;
+	set_callbacks_active(clstype);
+
+	write_unlock(&ckrm_class_lock);
+	ckrm_add_child(parent, dcore);
+
+	for (i = 0; i < clstype->max_resid; i++)
+		ckrm_alloc_res_class(dcore, parent, i);
+
+	/* fix for race condition seen in stress with numtasks */
+	if (parent)
+		ckrm_core_grab(parent);
+
+	ckrm_core_grab(dcore);
+	return 0;
+}
+
+static void ckrm_free_res_class(struct ckrm_core_class *core, int resid)
+{
+	/* 
+	 * Free a resource class only if the resource controller has
+	 * registered with core 
+	 */
+	if (core->res_class[resid]) {
+		ckrm_res_ctlr_t *rcbs;
+		struct ckrm_classtype *clstype = core->classtype;
+
+		atomic_inc(&clstype->nr_resusers[resid]);
+		rcbs = clstype->res_ctlrs[resid];
+
+		if (rcbs->res_free) {
+			(*rcbs->res_free) (core->res_class[resid]);
+			// compensate inc in alloc
+			atomic_dec(&clstype->nr_resusers[resid]); 
+		}
+		atomic_dec(&clstype->nr_resusers[resid]);
+	}
+	core->res_class[resid] = NULL;
+}
+
+/*
+ * Free a core class 
+ *   requires that all tasks were previously reassigned to another class
+ *
+ * Returns 0 on success -errno on failure.
+ */
+
+void ckrm_free_core_class(struct ckrm_core_class *core)
+{
+	int i;
+	struct ckrm_classtype *clstype = core->classtype;
+	struct ckrm_core_class *parent = core->hnode.parent;
+
+	CLS_DEBUG("core=%p:%s parent=%p:%s\n", core, core->name, parent,
+		  parent->name);
+	if (core->delayed) {
+		/* this core was marked as late */
+		printk("class <%s> finally deleted %lu\n", core->name, jiffies);
+	}
+	if (ckrm_remove_child(core) == 0) {
+		printk("Core class removal failed. Chilren present\n");
+	}
+	for (i = 0; i < clstype->max_resid; i++) {
+		ckrm_free_res_class(core, i);
+	}
+
+	write_lock(&ckrm_class_lock);
+	/* Clear the magic, so we would know if this core is reused. */
+	core->magic = 0;
+#if 0				/* Dynamic not yet enabled */
+	core->res_class = NULL;
+#endif
+	/* Remove this core class from its linked list. */
+	list_del(&core->clslist);
+	clstype->num_classes--;
+	set_callbacks_active(clstype);
+	write_unlock(&ckrm_class_lock);
+
+	/* fix for race condition seen in stress with numtasks */
+	if (parent)
+		ckrm_core_drop(parent);
+
+	kfree(core);
+}
+
+int ckrm_release_core_class(struct ckrm_core_class *core)
+{
+	if (!ckrm_is_core_valid(core)) {
+		// Invalid core
+		return (-EINVAL);
+	}
+
+	if (core == core->classtype->default_class)
+		return 0;
+
+	/* need to make sure that the classgot really dropped */
+	if (atomic_read(&core->refcnt) != 1) {
+		CLS_DEBUG("class <%s> deletion delayed refcnt=%d jif=%ld\n",
+			  core->name, atomic_read(&core->refcnt), jiffies);
+		core->delayed = 1;	/* just so we have a ref point */
+	}
+	ckrm_core_drop(core);
+	return 0;
+}
+
+/*
+ * Interfaces for the resource controller
+ */
+/*
+ * Registering a callback structure by the resource controller.
+ *
+ * Returns the resource id(0 or +ve) on success, -errno for failure.
+ */
+static int
+ckrm_register_res_ctlr_intern(struct ckrm_classtype *clstype,
+			      ckrm_res_ctlr_t * rcbs)
+{
+	int resid, ret, i;
+
+	if (!rcbs)
+		return -EINVAL;
+
+	resid = rcbs->resid;
+
+	spin_lock(&clstype->res_ctlrs_lock);
+	printk(KERN_WARNING "resid is %d name is %s %s\n",
+	       resid, rcbs->res_name, clstype->res_ctlrs[resid]->res_name);
+	if (resid >= 0) {
+		if ((resid < CKRM_MAX_RES_CTLRS)
+		    && (clstype->res_ctlrs[resid] == NULL)) {
+			clstype->res_ctlrs[resid] = rcbs;
+			atomic_set(&clstype->nr_resusers[resid], 0);
+			set_bit(resid, &clstype->bit_res_ctlrs);
+			ret = resid;
+			if (resid >= clstype->max_resid) {
+				clstype->max_resid = resid + 1;
+			}
+		} else {
+			ret = -EBUSY;
+		}
+		spin_unlock(&clstype->res_ctlrs_lock);
+		return ret;
+	}
+	for (i = clstype->resid_reserved; i < clstype->max_res_ctlrs; i++) {
+		if (clstype->res_ctlrs[i] == NULL) {
+			clstype->res_ctlrs[i] = rcbs;
+			rcbs->resid = i;
+			atomic_set(&clstype->nr_resusers[i], 0);
+			set_bit(i, &clstype->bit_res_ctlrs);
+			if (i >= clstype->max_resid) {
+				clstype->max_resid = i + 1;
+			}
+			spin_unlock(&clstype->res_ctlrs_lock);
+			return i;
+		}
+	}
+	spin_unlock(&clstype->res_ctlrs_lock);
+	return (-ENOMEM);
+}
+
+int
+ckrm_register_res_ctlr(struct ckrm_classtype *clstype, ckrm_res_ctlr_t * rcbs)
+{
+	struct ckrm_core_class *core;
+	int resid;
+
+	resid = ckrm_register_res_ctlr_intern(clstype, rcbs);
+
+	if (resid >= 0) {
+		/* run through all classes and create the resource class 
+		 * object and if necessary "initialize" class in context 
+		 * of this resource 
+		 */
+		read_lock(&ckrm_class_lock);
+		list_for_each_entry(core, &clstype->classes, clslist) {
+			printk("CKRM .. create res clsobj for resouce <%s>"
+			       "class <%s> par=%p\n", rcbs->res_name, 
+			       core->name, core->hnode.parent);
+			ckrm_alloc_res_class(core, core->hnode.parent, resid);
+
+			if (clstype->add_resctrl) { 
+				/* FIXME: this should be mandatory */
+				(*clstype->add_resctrl) (core, resid);
+			}
+		}
+		read_unlock(&ckrm_class_lock);
+	}
+	return resid;
+}
+
+/*
+ * Unregistering a callback structure by the resource controller.
+ *
+ * Returns 0 on success -errno for failure.
+ */
+int ckrm_unregister_res_ctlr(struct ckrm_res_ctlr *rcbs)
+{
+	struct ckrm_classtype *clstype = rcbs->classtype;
+	struct ckrm_core_class *core = NULL;
+	int resid = rcbs->resid;
+
+	if ((clstype == NULL) || (resid < 0)) {
+		return -EINVAL;
+	}
+	/* TODO: probably need to also call deregistration function */
+
+	read_lock(&ckrm_class_lock);
+	/* free up this resource from all the classes */
+	list_for_each_entry(core, &clstype->classes, clslist) {
+		ckrm_free_res_class(core, resid);
+	}
+	read_unlock(&ckrm_class_lock);
+
+	if (atomic_read(&clstype->nr_resusers[resid])) {
+		return -EBUSY;
+	}
+
+	spin_lock(&clstype->res_ctlrs_lock);
+	clstype->res_ctlrs[resid] = NULL;
+	clear_bit(resid, &clstype->bit_res_ctlrs);
+	clstype->max_resid = fls(clstype->bit_res_ctlrs);
+	rcbs->resid = -1;
+	spin_unlock(&clstype->res_ctlrs_lock);
+
+	return 0;
+}
+
+/*
+ * Class Type Registration
+ */
+
+/* TODO: What locking is needed here?*/
+
+struct ckrm_classtype *ckrm_classtypes[CKRM_MAX_CLASSTYPES];
+EXPORT_SYMBOL_GPL(ckrm_classtypes);	
+
+int ckrm_register_classtype(struct ckrm_classtype *clstype)
+{
+	int tid = clstype->typeID;
+
+	if (tid != -1) {
+		if ((tid < 0) || (tid > CKRM_MAX_CLASSTYPES)
+		    || (ckrm_classtypes[tid]))
+			return -EINVAL;
+	} else {
+		int i;
+		for (i = CKRM_RESV_CLASSTYPES; i < CKRM_MAX_CLASSTYPES; i++) {
+			if (ckrm_classtypes[i] == NULL) {
+				tid = i;
+				break;
+			}
+		}
+	}
+	if (tid == -1)
+		return -EBUSY;
+	clstype->typeID = tid;
+	ckrm_classtypes[tid] = clstype;
+
+	/* TODO: Need to call the callbacks of the RCFS client */
+	if (rcfs_fn.register_classtype) {
+		(*rcfs_fn.register_classtype) (clstype);
+		/* No error return for now. */
+	}
+	return tid;
+}
+
+int ckrm_unregister_classtype(struct ckrm_classtype *clstype)
+{
+	int tid = clstype->typeID;
+
+	if ((tid < 0) || (tid > CKRM_MAX_CLASSTYPES)
+	    || (ckrm_classtypes[tid] != clstype))
+		return -EINVAL;
+
+	if (rcfs_fn.deregister_classtype) {
+		(*rcfs_fn.deregister_classtype) (clstype);
+		// No error return for now
+	}
+
+	ckrm_classtypes[tid] = NULL;
+	clstype->typeID = -1;
+	return 0;
+}
+
+struct ckrm_classtype *ckrm_find_classtype_by_name(const char *name)
+{
+	int i;
+	for (i = 0; i < CKRM_MAX_CLASSTYPES; i++) {
+		struct ckrm_classtype *ctype = ckrm_classtypes[i];
+		if (ctype && !strncmp(ctype->name, name, CKRM_MAX_TYPENAME_LEN))
+			return ctype;
+	}
+	return NULL;
+}
+
+/*
+ *   Generic Functions that can be used as default functions 
+ *   in almost all classtypes
+ *     (a) function iterator over all resource classes of a class
+ *     (b) function invoker on a named resource
+ */
+
+int ckrm_class_show_shares(struct ckrm_core_class *core, struct seq_file *seq)
+{
+	int i;
+	struct ckrm_res_ctlr *rcbs;
+	struct ckrm_classtype *clstype = core->classtype;
+	struct ckrm_shares shares;
+
+	for (i = 0; i < clstype->max_resid; i++) {
+		atomic_inc(&clstype->nr_resusers[i]);
+		rcbs = clstype->res_ctlrs[i];
+		if (rcbs && rcbs->get_share_values) {
+			(*rcbs->get_share_values) (core->res_class[i], &shares);
+			seq_printf(seq,"res=%s,guarantee=%d,limit=%d,"
+				   "total_guarantee=%d,max_limit=%d\n",
+				   rcbs->res_name, shares.my_guarantee,
+				   shares.my_limit, shares.total_guarantee,
+				   shares.max_limit);
+		}
+		atomic_dec(&clstype->nr_resusers[i]);
+	}
+	return 0;
+}
+
+int ckrm_class_show_stats(struct ckrm_core_class *core, struct seq_file *seq)
+{
+	int i;
+	struct ckrm_res_ctlr *rcbs;
+	struct ckrm_classtype *clstype = core->classtype;
+
+	for (i = 0; i < clstype->max_resid; i++) {
+		atomic_inc(&clstype->nr_resusers[i]);
+		rcbs = clstype->res_ctlrs[i];
+		if (rcbs && rcbs->get_stats)
+			(*rcbs->get_stats) (core->res_class[i], seq);
+		atomic_dec(&clstype->nr_resusers[i]);
+	}
+	return 0;
+}
+
+int ckrm_class_show_config(struct ckrm_core_class *core, struct seq_file *seq)
+{
+	int i;
+	struct ckrm_res_ctlr *rcbs;
+	struct ckrm_classtype *clstype = core->classtype;
+
+	for (i = 0; i < clstype->max_resid; i++) {
+		atomic_inc(&clstype->nr_resusers[i]);
+		rcbs = clstype->res_ctlrs[i];
+		if (rcbs && rcbs->show_config)
+			(*rcbs->show_config) (core->res_class[i], seq);
+		atomic_dec(&clstype->nr_resusers[i]);
+	}
+	return 0;
+}
+
+int ckrm_class_set_config(struct ckrm_core_class *core, const char *resname,
+			  const char *cfgstr)
+{
+	struct ckrm_classtype *clstype = core->classtype;
+	struct ckrm_res_ctlr *rcbs = ckrm_resctlr_lookup(clstype, resname);
+	int rc;
+
+	if (rcbs == NULL || rcbs->set_config == NULL)
+		return -EINVAL;
+	rc = (*rcbs->set_config) (core->res_class[rcbs->resid], cfgstr);
+	return rc;
+}
+
+#define legalshare(a)   \
+         ( ((a) >=0) \
+	   || ((a) == CKRM_SHARE_UNCHANGED) \
+	   || ((a) == CKRM_SHARE_DONTCARE) )
+
+int ckrm_class_set_shares(struct ckrm_core_class *core, const char *resname,
+			  struct ckrm_shares *shares)
+{
+	struct ckrm_classtype *clstype = core->classtype;
+	struct ckrm_res_ctlr *rcbs;
+	int rc;
+
+	/* Check for legal values */
+	if (!legalshare(shares->my_guarantee) || !legalshare(shares->my_limit)
+	    || !legalshare(shares->total_guarantee)
+	    || !legalshare(shares->max_limit))
+		return -EINVAL;
+
+	rcbs = ckrm_resctlr_lookup(clstype, resname);
+	if (rcbs == NULL || rcbs->set_share_values == NULL)
+		return -EINVAL;
+	rc = (*rcbs->set_share_values) (core->res_class[rcbs->resid], shares);
+	return rc;
+}
+
+int ckrm_class_reset_stats(struct ckrm_core_class *core, const char *resname,
+			   const char *unused)
+{
+	struct ckrm_classtype *clstype = core->classtype;
+	struct ckrm_res_ctlr *rcbs = ckrm_resctlr_lookup(clstype, resname);
+	int rc;
+
+	if (rcbs == NULL || rcbs->reset_stats == NULL)
+		return -EINVAL;
+	rc = (*rcbs->reset_stats) (core->res_class[rcbs->resid]);
+	return rc;
+}
+
+/*
+ * Initialization
+ */
+
+void ckrm_cb_newtask(struct task_struct *tsk)
+{
+	tsk->ce_data = NULL;
+	spin_lock_init(&tsk->ckrm_tsklock);
+	ckrm_invoke_event_cb_chain(CKRM_EVENT_NEWTASK, tsk);
+}
+
+void ckrm_cb_exit(struct task_struct *tsk)
+{
+	ckrm_invoke_event_cb_chain(CKRM_EVENT_EXIT, tsk);
+	tsk->ce_data = NULL;
+}
+
+void __init ckrm_init(void)
+{
+	printk("CKRM Initialization\n");
+
+	// register/initialize the Metatypes
+
+#ifdef CONFIG_CKRM_TYPE_TASKCLASS
+	{
+		extern void ckrm_meta_init_taskclass(void);
+		ckrm_meta_init_taskclass();
+	}
+#endif
+#ifdef CONFIG_CKRM_TYPE_SOCKETCLASS
+	{
+		extern void ckrm_meta_init_sockclass(void);
+		ckrm_meta_init_sockclass();
+	}
+#endif
+	// prepare init_task and then rely on inheritance of properties
+	ckrm_cb_newtask(&init_task);
+	printk("CKRM Initialization done\n");
+}
+
+EXPORT_SYMBOL_GPL(ckrm_register_engine);
+EXPORT_SYMBOL_GPL(ckrm_unregister_engine);
+
+EXPORT_SYMBOL_GPL(ckrm_register_res_ctlr);
+EXPORT_SYMBOL_GPL(ckrm_unregister_res_ctlr);
+
+EXPORT_SYMBOL_GPL(ckrm_init_core_class);
+EXPORT_SYMBOL_GPL(ckrm_free_core_class);
+EXPORT_SYMBOL_GPL(ckrm_release_core_class);
+
+EXPORT_SYMBOL_GPL(ckrm_register_classtype);
+EXPORT_SYMBOL_GPL(ckrm_unregister_classtype);
+EXPORT_SYMBOL_GPL(ckrm_find_classtype_by_name);
+
+EXPORT_SYMBOL_GPL(ckrm_core_grab);
+EXPORT_SYMBOL_GPL(ckrm_core_drop);
+EXPORT_SYMBOL_GPL(ckrm_is_core_valid);
+EXPORT_SYMBOL_GPL(ckrm_validate_and_grab_core);
+
+EXPORT_SYMBOL_GPL(ckrm_register_event_set);
+EXPORT_SYMBOL_GPL(ckrm_unregister_event_set);
+EXPORT_SYMBOL_GPL(ckrm_register_event_cb);
+EXPORT_SYMBOL_GPL(ckrm_unregister_event_cb);
+
+EXPORT_SYMBOL_GPL(ckrm_class_show_stats);
+EXPORT_SYMBOL_GPL(ckrm_class_show_config);
+EXPORT_SYMBOL_GPL(ckrm_class_show_shares);
+
+EXPORT_SYMBOL_GPL(ckrm_class_set_config);
+EXPORT_SYMBOL_GPL(ckrm_class_set_shares);
+
+EXPORT_SYMBOL_GPL(ckrm_class_reset_stats);
Index: linux-2.6.10-rc2/kernel/ckrm/ckrmutils.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/kernel/ckrm/ckrmutils.c	2004-11-19 20:43:43.524211803 -0800
@@ -0,0 +1,195 @@
+/*
+ * ckrmutils.c - Utility functions for CKRM
+ *
+ * Copyright (C) Chandra Seetharaman,  IBM Corp. 2003
+ *           (C) Hubertus Franke    ,  IBM Corp. 2004
+ * 
+ * Provides simple utility functions for the core module, CE and resource
+ * controllers.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/*
+ * Changes
+ * 
+ * 13 Nov 2003
+ *        Created
+ */
+
+#include <linux/mm.h>
+#include <linux/err.h>
+#include <linux/mount.h>
+#include <linux/module.h>
+#include <linux/ckrm_rc.h>
+
+int get_exe_path_name(struct task_struct *tsk, char *buf, int buflen)
+{
+	struct vm_area_struct *vma;
+	struct vfsmount *mnt;
+	struct mm_struct *mm = get_task_mm(tsk);
+	struct dentry *dentry;
+	char *lname;
+	int rc = 0;
+
+	*buf = '\0';
+	if (!mm) {
+		return -EINVAL;
+	}
+	down_read(&mm->mmap_sem);
+	vma = mm->mmap;
+	while (vma) {
+		if ((vma->vm_flags & VM_EXECUTABLE) && vma->vm_file) {
+			dentry = dget(vma->vm_file->f_dentry);
+			mnt = mntget(vma->vm_file->f_vfsmnt);
+			lname = d_path(dentry, mnt, buf, buflen);
+			if (!IS_ERR(lname)) {
+				strncpy(buf, lname, strlen(lname) + 1);
+			} else {
+				rc = (int)PTR_ERR(lname);
+			}
+			mntput(mnt);
+			dput(dentry);
+			break;
+		}
+		vma = vma->vm_next;
+	}
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+	return rc;
+}
+
+/*
+ * must be called with cnt_lock of parres held
+ * Caller is responsible for making sure that the new guarantee doesn't
+ * overflow parent's total guarantee.
+ */
+void child_guarantee_changed(struct ckrm_shares *parent, int cur, int new)
+{
+	if (new == cur || !parent) {
+		return;
+	}
+	if (new != CKRM_SHARE_DONTCARE) {
+		parent->unused_guarantee -= new;
+	}
+	if (cur != CKRM_SHARE_DONTCARE) {
+		parent->unused_guarantee += cur;
+	}
+	return;
+}
+
+/*
+ * must be called with cnt_lock of parres held
+ * Caller is responsible for making sure that the new limit is not more 
+ * than parent's max_limit
+ */
+void child_maxlimit_changed(struct ckrm_shares *parent, int new_limit)
+{
+	if (parent && parent->cur_max_limit < new_limit) {
+		parent->cur_max_limit = new_limit;
+	}
+	return;
+}
+
+/*
+ * Caller is responsible for holding any lock to protect the data
+ * structures passed to this function
+ */
+int
+set_shares(struct ckrm_shares *new, struct ckrm_shares *cur,
+	   struct ckrm_shares *par)
+{
+	int rc = -EINVAL;
+	int cur_usage_guar = cur->total_guarantee - cur->unused_guarantee;
+	int increase_by = new->my_guarantee - cur->my_guarantee;
+
+	/* Check total_guarantee for correctness */
+	if (new->total_guarantee <= CKRM_SHARE_DONTCARE) {
+		goto set_share_err;
+	} else if (new->total_guarantee == CKRM_SHARE_UNCHANGED) {
+		/* do nothing */;
+	} else if (cur_usage_guar > new->total_guarantee) {
+		goto set_share_err;
+	}
+	/* Check max_limit for correctness */
+	if (new->max_limit <= CKRM_SHARE_DONTCARE) {
+		goto set_share_err;
+	} else if (new->max_limit == CKRM_SHARE_UNCHANGED) {
+		/* do nothing */;
+	} else if (cur->cur_max_limit > new->max_limit) {
+		goto set_share_err;
+	}
+	/* Check my_guarantee for correctness */
+	if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
+		/* do nothing */;
+	} else if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
+		/* do nothing */;
+	} else if (par && increase_by > par->unused_guarantee) {
+		goto set_share_err;
+	}
+	/* Check my_limit for correctness */
+	if (new->my_limit == CKRM_SHARE_UNCHANGED) {
+		/* do nothing */;
+	} else if (new->my_limit == CKRM_SHARE_DONTCARE) {
+		/* do nothing */;
+	} else if (par && new->my_limit > par->max_limit) {
+		/* I can't get more limit than my parent's limit */
+		goto set_share_err;
+
+	}
+	/* make sure guarantee is lesser than limit */
+	if (new->my_limit == CKRM_SHARE_DONTCARE) {
+		/* do nothing */;
+	} else if (new->my_limit == CKRM_SHARE_UNCHANGED) {
+		if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
+			/* do nothing */;
+		} else if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
+			/*
+			 * do nothing; earlier setting would have
+			 * taken care of it
+			 */;
+		} else if (new->my_guarantee > cur->my_limit) {
+			goto set_share_err;
+		}
+	} else {		/* new->my_limit has a valid value */
+		if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
+			/* do nothing */;
+		} else if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
+			if (cur->my_guarantee > new->my_limit) {
+				goto set_share_err;
+			}
+		} else if (new->my_guarantee > new->my_limit) {
+			goto set_share_err;
+		}
+	}
+	if (new->my_guarantee != CKRM_SHARE_UNCHANGED) {
+		child_guarantee_changed(par, cur->my_guarantee,
+					new->my_guarantee);
+		cur->my_guarantee = new->my_guarantee;
+	}
+	if (new->my_limit != CKRM_SHARE_UNCHANGED) {
+		child_maxlimit_changed(par, new->my_limit);
+		cur->my_limit = new->my_limit;
+	}
+	if (new->total_guarantee != CKRM_SHARE_UNCHANGED) {
+		cur->unused_guarantee = new->total_guarantee - cur_usage_guar;
+		cur->total_guarantee = new->total_guarantee;
+	}
+	if (new->max_limit != CKRM_SHARE_UNCHANGED) {
+		cur->max_limit = new->max_limit;
+	}
+	rc = 0;
+set_share_err:
+	return rc;
+}
+
+EXPORT_SYMBOL_GPL(get_exe_path_name);
+EXPORT_SYMBOL_GPL(child_guarantee_changed);
+EXPORT_SYMBOL_GPL(child_maxlimit_changed);
+EXPORT_SYMBOL_GPL(set_shares);
Index: linux-2.6.10-rc2/kernel/ckrm/Makefile
===================================================================
--- linux-2.6.10-rc2.orig/kernel/ckrm/Makefile	2004-11-19 20:40:52.528302080 -0800
+++ linux-2.6.10-rc2/kernel/ckrm/Makefile	2004-11-19 20:43:43.526211486 -0800
@@ -3,5 +3,5 @@
 #
 
 ifeq ($(CONFIG_CKRM),y)
-    obj-y = ckrm_events.o
+    obj-y = ckrm_events.o ckrm.o ckrmutils.o
 endif	
