Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263728AbUD2IoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbUD2IoY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbUD2IoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:44:24 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:48013 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S263728AbUD2IZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:25:28 -0400
Message-ID: <4090BBEC.2010205@watson.ibm.com>
Date: Thu, 29 Apr 2004 04:25:16 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [PATCH 1/6] CKRM core
Content-Type: multipart/mixed;
 boundary="------------060506010408070908050008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060506010408070908050008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060506010408070908050008
Content-Type: text/plain;
 name="00-core.ckrm-E12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="00-core.ckrm-E12.patch"

diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Wed Apr 28 22:41:05 2004
+++ b/fs/exec.c	Wed Apr 28 22:41:05 2004
@@ -46,6 +46,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap-locking.h>
+#include <linux/ckrm.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -1151,6 +1152,8 @@
 	retval = search_binary_handler(&bprm,regs);
 	if (retval >= 0) {
 		free_arg_pages(&bprm);
+
+		ckrm_cb_exec(filename);
 
 		/* execve success */
 		security_bprm_free(&bprm);
diff -Nru a/include/linux/ckrm.h b/include/linux/ckrm.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/ckrm.h	Wed Apr 28 22:41:05 2004
@@ -0,0 +1,156 @@
+/* ckrm.h - Class-based Kernel Resource Management (CKRM)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003,2004
+ *           (C) Shailabh Nagar,  IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ * 
+ * 
+ * Provides a base header file including macros and basic data structures.
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
+/* Changes
+ *
+ * 28 Aug 2003
+ *        Created.
+ * 06 Nov 2003
+ *        Made modifications to suit the new RBCE module.
+ * 10 Nov 2003
+ *        Added callbacks_active and surrounding logic. Added task paramter
+ *        for all CE callbacks.
+ * 19 Nov 2004
+ *        New Event callback structure
+ */
+
+#ifndef _LINUX_CKRM_H
+#define _LINUX_CKRM_H
+
+#ifdef CONFIG_CKRM
+
+// Data structure and function to get the list of registered 
+// resource controllers.
+
+// #include <linux/sched.h>
+
+/* CKRM defines a set of events at particular points in the kernel
+ * at which callbacks registered by various class types are called
+ */
+
+enum ckrm_event {
+	/* we distinguish various events types
+         *
+	 * (a) CKRM_LATCHABLE_EVENTS
+         *      events can be latched for event callbacks by classtypes
+         *
+	 * (b) CKRM_NONLATACHBLE_EVENTS
+         *     events can not be latched but can be used to call classification
+         * 
+	 * (c) event that are used for notification purposes
+	 *     range: [ CKRM_EVENT_CANNOT_CLASSIFY .. )
+         */
+
+	/* events (a) */
+
+	CKRM_LATCHABLE_EVENTS,
+
+	CKRM_EVENT_NEWTASK = CKRM_LATCHABLE_EVENTS,
+	CKRM_EVENT_FORK,
+	CKRM_EVENT_EXIT,
+	CKRM_EVENT_EXEC,
+	CKRM_EVENT_UID,
+	CKRM_EVENT_GID,
+	CKRM_EVENT_LOGIN,
+	CKRM_EVENT_USERADD,
+	CKRM_EVENT_USERDEL,
+	CKRM_EVENT_LISTEN_START,
+	CKRM_EVENT_LISTEN_STOP,
+	CKRM_EVENT_APPTAG,
+
+	/* events (b) */
+
+	CKRM_NONLATCHABLE_EVENTS,
+
+	CKRM_EVENT_RECLASSIFY = CKRM_NONLATCHABLE_EVENTS,
+
+	/* events (c) */
+	CKRM_NOTCLASSIFY_EVENTS,
+
+	CKRM_EVENT_MANUAL = CKRM_NOTCLASSIFY_EVENTS,
+	
+	CKRM_NUM_EVENTS
+};
+#endif
+
+#ifdef __KERNEL__
+#ifdef CONFIG_CKRM
+
+extern void ckrm_invoke_event_cb_chain(enum ckrm_event ev, void *arg);
+
+typedef void (*ckrm_event_cb)(void *arg);
+
+struct ckrm_hook_cb {
+	ckrm_event_cb fct;
+	struct ckrm_hook_cb *next;
+};
+
+#define CKRM_DEF_CB(EV,fct)					\
+static inline void ckrm_cb_##fct(void)				\
+{								\
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_##EV,NULL);      \
+}
+
+#define CKRM_DEF_CB_ARG(EV,fct,argtp)					\
+static inline void ckrm_cb_##fct(argtp arg)				\
+{									\
+         ckrm_invoke_event_cb_chain(CKRM_EVENT_##EV,(void*)arg);	\
+}
+
+#else // !CONFIG_CKRM
+
+#define CKRM_DEF_CB(EV,fct)			\
+static inline void ckrm_cb_##fct(void)  { }
+
+#define CKRM_DEF_CB_ARG(EV,fct,argtp)		\
+static inline void ckrm_cb_##fct(argtp arg) { }
+
+#endif // CONFIG_CKRM
+
+/*-----------------------------------------------------------------
+ *   define the CKRM event functions 
+ *               EVENT          FCT           ARG         
+ *-----------------------------------------------------------------*/
+
+// types we refer at 
+struct task_struct;
+struct sock;
+struct user_struct;
+
+CKRM_DEF_CB_ARG( FORK         , fork,         struct task_struct *);
+CKRM_DEF_CB_ARG( EXEC         , exec,         const char*         );
+CKRM_DEF_CB    ( UID          , uid                               );
+CKRM_DEF_CB    ( GID          , gid                               );
+CKRM_DEF_CB    ( APPTAG       , apptag                            );
+CKRM_DEF_CB    ( LOGIN        , login                             );
+CKRM_DEF_CB_ARG( USERADD      , useradd,      struct user_struct *);
+CKRM_DEF_CB_ARG( USERDEL      , userdel,      struct user_struct *);
+CKRM_DEF_CB_ARG( LISTEN_START , listen_start, struct sock *       );
+CKRM_DEF_CB_ARG( LISTEN_STOP  , listen_stop,  struct sock *       );
+
+// and a few special one's
+void ckrm_cb_newtask(struct task_struct *);
+void ckrm_cb_exit(struct task_struct *);
+
+// some other functions required
+extern void ckrm_init(void);
+extern int get_exe_path_name(struct task_struct *, char *, int);
+
+#endif // __KERNEL__
+
+#endif // _LINUX_CKRM_H
diff -Nru a/include/linux/ckrm_ce.h b/include/linux/ckrm_ce.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/ckrm_ce.h	Wed Apr 28 22:41:05 2004
@@ -0,0 +1,91 @@
+/* ckrm_ce.h - Header file to be used by Classification Engine of CKRM
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
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
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
+#include "ckrm.h"  // getting the event names
+
+/* Action parameters identifying the cause of a task<->class notify callback 
+ * these can perculate up to user daemon consuming records send by the classification
+ * engine
+ */
+
+#ifdef __KERNEL__
+
+typedef void* (*ce_classify_fct_t)(enum ckrm_event event, void *obj, ... );   
+typedef void  (*ce_notify_fct_t)  (enum ckrm_event event, void *classobj, void *obj);
+
+typedef struct ckrm_eng_callback {
+	/* general state information */
+	int  always_callback;  /* set if CE should always be called back regardless of numclasses */
+
+	/* callbacks which are called without holding locks */
+
+	unsigned long c_interest;         /* set of classification events CE is interested in */
+	ce_classify_fct_t   classify;     /* generic classify */
+
+	void   (*class_add)   (const char *name, void *core); /* class added */
+	void   (*class_delete)(const char *name, void *core); /* class deleted */
+
+	/* callback which are called while holding task_lock(tsk) */
+	unsigned long n_interest;         /* set of notification events CE is interested in */
+	ce_notify_fct_t     notify;       /* notify on class switch */
+
+} ckrm_eng_callback_t;
+
+struct inode;
+struct dentry; 
+
+typedef struct rbce_eng_callback {
+	int (*mkdir)(struct inode *, struct dentry *, int); // mkdir
+	int (*rmdir)(struct inode *, struct dentry *); // rmdir
+} rbce_eng_callback_t;
+
+extern int ckrm_register_engine  (const char *name, ckrm_eng_callback_t *);
+extern int ckrm_unregister_engine(const char *name);
+
+extern void *ckrm_classobj(char *, int *classtype);
+extern int get_exe_path_name(struct task_struct *t, char *filename, int max_size);
+
+extern int rcfs_register_engine(rbce_eng_callback_t *);
+extern int rcfs_unregister_engine(rbce_eng_callback_t *);
+
+extern int ckrm_reclassify(int pid);
+
+#ifndef _LINUX_CKRM_RC_H
+// ckrm kernel has inlined functions for this which are exported
+extern void ckrm_core_grab(void *);
+extern void ckrm_core_drop(void *);
+#endif
+
+#endif // CONFIG_CKRM
+
+#endif // __KERNEL__
+
+#endif // _LINUX_CKRM_CE_H
diff -Nru a/include/linux/ckrm_rc.h b/include/linux/ckrm_rc.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/ckrm_rc.h	Wed Apr 28 22:41:05 2004
@@ -0,0 +1,366 @@
+/* ckrm_rc.h - Header file to be used by Resource controllers of CKRM
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Shailabh Nagar,  IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ *	     (C) Vivek Kashyap , IBM Corp. 2004
+ * 
+ * Provides data structures, macros and kernel API of CKRM for 
+ * resource controllers.
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
+/* Changes
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
+#include <linux/ckrm.h>
+#include <linux/ckrm_ce.h>    
+#include <linux/seq_file.h>
+
+
+/* maximum number of class types */
+#define CKRM_MAX_CLASSTYPES         32       
+/* maximum classtype name length */
+#define CKRM_MAX_CLASSTYPE_NAME     32       
+
+/* maximum resource controllers per classtype */
+#define CKRM_MAX_RES_CTLRS           8     
+/* maximum resource controller name length */
+#define CKRM_MAX_RES_NAME          128       
+
+
+struct ckrm_core_class;
+struct ckrm_classtype;
+
+/********************************************************************************
+ * Share specifications
+ *******************************************************************************/
+
+typedef struct ckrm_shares {
+	int my_guarantee;
+	int my_limit;
+	int total_guarantee;
+	int max_limit;
+	int unused_guarantee;  // not used as parameters
+	int cur_max_limit;     // not used as parameters
+} ckrm_shares_t;
+
+#define CKRM_SHARE_UNCHANGED     (-1)  // value to indicate no change
+#define CKRM_SHARE_DONTCARE      (-2)  // value to indicate don't care.
+#define CKRM_SHARE_DFLT_TOTAL_GUARANTEE (100) // Start off with these values
+#define CKRM_SHARE_DFLT_MAX_LIMIT     (100) // to simplify set_res_shares logic
+
+
+/********************************************************************************
+ * RESOURCE CONTROLLERS
+ *******************************************************************************/
+
+/* resource controller callback structure */
+
+typedef struct ckrm_res_ctlr {
+	char res_name[CKRM_MAX_RES_NAME];
+	int  res_hdepth;	          // maximum hierarchy
+	int  resid;         	          // (for now) same as the enum resid
+	struct ckrm_classtype *classtype; // classtype owning this resource controller
+
+	/* allocate/free new resource class object for resource controller */
+	void *(*res_alloc)  (struct ckrm_core_class *this, struct ckrm_core_class *parent);
+	void  (*res_free)   (void *);
+
+	/* set/get limits/guarantees for a resource controller class */
+	int  (*set_share_values) (void* , struct ckrm_shares *shares);
+	int  (*get_share_values) (void* , struct ckrm_shares *shares);
+
+	/* statistics and configuration access */
+	int  (*get_stats)    (void* , struct seq_file *);
+	int  (*reset_stats)  (void *);
+	int  (*show_config)  (void* , struct seq_file *);
+	int  (*set_config)   (void* , const char *cfgstr);
+
+	void (*change_resclass)(void *, void *, void *);
+
+} ckrm_res_ctlr_t;
+
+/***************************************************************************************
+ * CKRM_CLASSTYPE
+ *
+ *   A <struct ckrm_classtype> object describes a dimension for CKRM to classify 
+ *   along. I needs to provide methods to create and manipulate class objects in
+ *   this dimension
+ ***************************************************************************************/
+
+/* list of predefined class types, we always recognize */
+#define CKRM_CLASSTYPE_TASK_CLASS    0
+#define CKRM_CLASSTYPE_SOCKET_CLASS 1
+#define CKRM_RESV_CLASSTYPES         2  /* always +1 of last known type */
+
+#define CKRM_MAX_TYPENAME_LEN       32
+
+
+typedef struct ckrm_classtype {
+	/* Hubertus:   Rearrange slots so that they are more cache friendly during access */
+
+	/* resource controllers */
+	spinlock_t        res_ctlrs_lock;        /* protect data below (other than atomics) */
+	int               max_res_ctlrs;         /* maximum number of resource controller allowed */
+	int               max_resid;             /* maximum resid used                      */
+	int               resid_reserved;        /* maximum number of reserved controllers  */
+	long              bit_res_ctlrs;         /* bitmap of resource ID used              */
+	atomic_t          nr_resusers[CKRM_MAX_RES_CTLRS];
+	ckrm_res_ctlr_t*  res_ctlrs[CKRM_MAX_RES_CTLRS];
+
+	/* state about my classes */
+
+	struct ckrm_core_class   *default_class; // pointer to default class
+	struct list_head          classes;       // listhead to link up all classes of this classtype
+	int                       num_classes;    // how many classes do exist
+
+	/* state about my ce interaction */
+	int                       ce_regd;       // Has a CE been registered for this classtype
+	int                       ce_cb_active;  // are callbacks active
+	atomic_t                  ce_nr_users;   // how many transient calls active
+	struct ckrm_eng_callback  ce_callbacks;  // callback engine
+
+ 	// Begin classtype-rcfs private data. No rcfs/fs specific types used. 
+ 	int               mfidx;             // Index into genmfdesc array used to initialize
+ 	                                     // mfdesc and mfcount 
+ 	void              *mfdesc;           // Array of descriptors of root and magic files
+ 	int               mfcount;           // length of above array 
+ 	void              *rootde;           // root dentry created by rcfs
+ 	// End rcfs private data 
+
+	char name[CKRM_MAX_TYPENAME_LEN];    // currently same as mfdesc[0]->name but could be different
+ 	int  typeID;			       /* unique TypeID                         */
+	int  maxdepth;                         /* maximum depth supported               */
+
+	/* functions to be called on any class type by external API's */
+	struct ckrm_core_class*  (*alloc)(struct ckrm_core_class *parent, const char *name);   /* alloc class instance */
+	int                      (*free) (struct ckrm_core_class *cls);                        /* free  class instance */
+	
+	int                      (*show_members)(struct ckrm_core_class *, struct seq_file *);
+	int                      (*show_stats)  (struct ckrm_core_class *, struct seq_file *);
+	int                      (*show_config) (struct ckrm_core_class *, struct seq_file *);
+	int                      (*show_shares) (struct ckrm_core_class *, struct seq_file *);
+
+	int                      (*reset_stats) (struct ckrm_core_class *, const char *resname, 
+						 const char *);
+	int                      (*set_config)  (struct ckrm_core_class *, const char *resname,
+						 const char *cfgstr);
+	int                      (*set_shares)  (struct ckrm_core_class *, const char *resname,
+						 struct ckrm_shares *shares);
+	int                      (*forced_reclassify)(struct ckrm_core_class *, const char *);
+
+  
+	/* functions to be called on a class type by ckrm internals */
+	void                     (*add_resctrl)(struct ckrm_core_class *, int resid);     // class initialization for new RC
+ 
+} ckrm_classtype_t;
+
+/******************************************************************************************
+ * CKRM CORE CLASS
+ *      common part to any class structure (i.e. instance of a classtype)
+ ******************************************************************************************/
+
+/* basic definition of a hierarchy that is to be used by the the CORE classes
+ * and can be used by the resource class objects
+ */
+
+#define CKRM_CORE_MAGIC		0xBADCAFFE
+
+typedef struct ckrm_hnode {
+        struct ckrm_core_class *parent;
+	struct list_head   siblings; /* linked list of siblings */
+	struct list_head   children; /* anchor for children     */
+} ckrm_hnode_t;
+
+typedef struct ckrm_core_class {
+	struct ckrm_classtype *classtype; // what type does this core class belong to
+        void* res_class[CKRM_MAX_RES_CTLRS];                 // pointer to array of resource classes
+  	spinlock_t ckrm_lock;             // to protect the list and the array above
+	struct list_head objlist;         // generic list for any object list to be maintained by class
+	struct list_head clslist;         // to link up all classes in a single list type wrt to type
+	struct dentry  *dentry;           // dentry of inode in the RCFS
+	int magic;
+	struct ckrm_hnode  hnode;    // hierarchy
+	rwlock_t hnode_rwlock; // rw_clock protecting the hnode above.
+	atomic_t refcnt;
+	const char *name;
+} ckrm_core_class_t;
+
+/* type coerce between derived class types and ckrm core class type */
+#define class_type(type,coreptr)   container_of(coreptr,type,core)
+#define class_core(clsptr)         (&(clsptr)->core)
+/* locking classes */
+#define class_lock(coreptr)        spin_lock(&(coreptr)->ckrm_lock)
+#define class_unlock(coreptr)      spin_unlock(&(coreptr)->ckrm_lock)
+/* what type is a class of ISA */
+#define class_isa(clsptr)          (class_core(clsptr)->classtype)
+
+
+/******************************************************************************************
+ * OTHER
+ ******************************************************************************************/
+
+#define ckrm_get_res_class(rescls,resid,type)   ((type*)((rescls)->res_class[resid]))
+
+extern int ckrm_register_res_ctlr   (struct ckrm_classtype *, ckrm_res_ctlr_t *);
+extern int ckrm_unregister_res_ctlr (ckrm_res_ctlr_t *);
+
+extern int ckrm_validate_and_grab_core(struct ckrm_core_class *core);
+extern int ckrm_init_core_class(struct ckrm_classtype  *clstype,struct ckrm_core_class *dcore,
+				struct ckrm_core_class *parent, const char *name);
+extern int ckrm_release_core_class(struct ckrm_core_class *);   // Hubertus .. can disappear after cls del debugging
+extern struct ckrm_res_ctlr *ckrm_resctlr_lookup(struct ckrm_classtype *type, const char *resname);
+
+#if 0
+
+// Hubertus ... need to straighten out all these I don't think we will even call thsie ore are we 
+
+/* interface to the RCFS filesystem */
+extern struct ckrm_core_class *ckrm_alloc_core_class(struct ckrm_core_class *, const char *, int);
+
+// Reclassify the given pid to the given core class by force
+extern void ckrm_forced_reclassify_pid(int, struct ckrm_core_class *);
+
+// Reclassify the given net_struct  to the given core class by force
+extern void ckrm_forced_reclassify_laq(struct ckrm_net_struct *, 
+		struct ckrm_core_class *);
+
+#endif
+
+extern void ckrm_lock_hier(struct ckrm_core_class *);
+extern void ckrm_unlock_hier(struct ckrm_core_class *);
+extern struct ckrm_core_class * ckrm_get_next_child(struct ckrm_core_class *,
+		            struct ckrm_core_class *);
+
+extern void child_guarantee_changed(struct ckrm_shares *, int, int);
+extern void child_maxlimit_changed(struct ckrm_shares *, int);
+extern int  set_shares(struct ckrm_shares *, struct ckrm_shares *, struct ckrm_shares *);
+
+/* classtype registration and lookup */
+extern int ckrm_register_classtype  (struct ckrm_classtype *clstype);
+extern int ckrm_unregister_classtype(struct ckrm_classtype *clstype);
+extern struct ckrm_classtype* ckrm_find_classtype_by_name(const char *name);
+
+/* default functions that can be used in classtypes's function table */
+extern int ckrm_class_show_shares(struct ckrm_core_class *core, struct seq_file *seq);
+extern int ckrm_class_show_stats(struct ckrm_core_class *core, struct seq_file *seq);
+extern int ckrm_class_show_config(struct ckrm_core_class *core, struct seq_file *seq);
+extern int ckrm_class_set_config(struct ckrm_core_class *core, const char *resname, const char *cfgstr);
+extern int ckrm_class_set_shares(struct ckrm_core_class *core, const char *resname, struct ckrm_shares *shares);
+extern int ckrm_class_reset_stats(struct ckrm_core_class *core, const char *resname, const char *unused);
+
+#if 0
+extern void ckrm_ns_hold(struct ckrm_net_struct *);
+extern void ckrm_ns_put(struct ckrm_net_struct *);
+extern void *ckrm_set_rootcore_byname(char *, void *);
+#endif
+
+static inline void ckrm_core_grab(struct ckrm_core_class *core)  
+{ 
+	if (core) atomic_inc(&core->refcnt);
+}
+
+static inline void ckrm_core_drop(struct ckrm_core_class *core) 
+{ 
+	// only make definition available in this context
+	extern void ckrm_free_core_class(struct ckrm_core_class *core);   
+	if (core && (atomic_dec_and_test(&core->refcnt)))
+	    ckrm_free_core_class(core);
+}
+
+static inline unsigned int
+ckrm_is_core_valid(ckrm_core_class_t *core)
+{
+	return (core && (core->magic == CKRM_CORE_MAGIC));
+}
+
+// iterate through all associate resource controllers:
+// requires following arguments (ckrm_core_class *cls, 
+//                               ckrm_res_ctrl   *ctlr,
+//                               void            *robj,
+//                               int              bmap)
+#define forall_class_resobjs(cls,rcbs,robj,bmap)									\
+       for ( bmap=((cls->classtype)->bit_res_ctlrs) ;									\
+	     ({ int rid; ((rid=ffs(bmap)-1) >= 0) && 									\
+	                 (bmap&=~(1<<rid),((rcbs=cls->classtype->res_ctlrs[rid]) && (robj=cls->res_class[rid]))); }) ;	\
+           )
+
+extern struct ckrm_classtype* ckrm_classtypes[]; /* should provide a different interface */
+
+
+/*-----------------------------------------------------------------------------
+ * CKRM event callback specification for the classtypes or resource controllers 
+ *   typically an array is specified using CKRM_EVENT_SPEC terminated with 
+ *   CKRM_EVENT_SPEC_LAST and then that array is registered using
+ *   ckrm_register_event_set.
+ *   Individual registration of event_cb is also possible
+ *-----------------------------------------------------------------------------*/
+
+struct ckrm_event_spec {
+	enum ckrm_event     ev;
+	struct ckrm_hook_cb cb;
+};
+#define CKRM_EVENT_SPEC(EV,FCT) { CKRM_EVENT_##EV, { (ckrm_event_cb)FCT, NULL } }
+
+int ckrm_register_event_set(struct ckrm_event_spec especs[]);
+int ckrm_unregister_event_set(struct ckrm_event_spec especs[]);
+int ckrm_register_event_cb(enum ckrm_event ev, struct ckrm_hook_cb *cb);
+int ckrm_unregister_event_cb(enum ckrm_event ev, struct ckrm_hook_cb *cb);
+
+/******************************************************************************************
+ * CE Invocation interface
+ ******************************************************************************************/
+
+#define ce_protect(ctype)      (atomic_inc(&((ctype)->ce_nr_users)))
+#define ce_release(ctype)      (atomic_dec(&((ctype)->ce_nr_users)))
+
+// CE Classification callbacks with 
+
+#define CE_CLASSIFY_NORET(ctype, event, objs_to_classify...)					\
+do {												\
+	if ((ctype)->ce_cb_active && (test_bit(event,&(ctype)->ce_callbacks.c_interest)))	\
+		(*(ctype)->ce_callbacks.classify)(event, objs_to_classify);			\
+} while (0)
+
+#define CE_CLASSIFY_RET(ret, ctype, event, objs_to_classify...)					\
+do {												\
+	if ((ctype)->ce_cb_active && (test_bit(event,&(ctype)->ce_callbacks.c_interest)))	\
+		ret = (*(ctype)->ce_callbacks.classify)(event, objs_to_classify);		\
+} while (0)
+
+#define CE_NOTIFY(ctype, event, cls, objs_to_classify)						\
+do {												\
+	if ((ctype)->ce_cb_active && (test_bit(event,&(ctype)->ce_callbacks.n_interest)))	\
+		(*(ctype)->ce_callbacks.notify)(event,cls,objs_to_classify);			\
+} while (0)
+
+
+#endif // CONFIG_CKRM
+
+#endif // __KERNEL__
+
+#endif // _LINUX_CKRM_RC_H
+
+
+
+
+
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Wed Apr 28 22:41:05 2004
+++ b/include/linux/sched.h	Wed Apr 28 22:41:05 2004
@@ -493,6 +493,16 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+
+#ifdef CONFIG_CKRM
+	spinlock_t  ckrm_tsklock; 
+	void       *ce_data;
+#ifdef CONFIG_CKRM_TYPE_TASKCLASS
+	// .. Hubertus should change to CONFIG_CKRM_TYPE_TASKCLASS 
+	struct ckrm_task_class *taskclass;
+	struct list_head        taskclass_link;
+#endif // CONFIG_CKRM_TYPE_TASKCLASS
+#endif // CONFIG_CKRM
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	Wed Apr 28 22:41:05 2004
+++ b/init/Kconfig	Wed Apr 28 22:41:05 2004
@@ -104,6 +104,75 @@
 	  up to the user level program to do useful things with this
 	  information.  This is generally a good idea, so say Y.
 
+menu "Class Based Kernel Resource Management"
+
+config CKRM
+	bool "Class Based Kernel Resource Management Core"
+	depends on EXPERIMENTAL
+	help
+	  Class-based Kernel Resource Management is a framework for controlling
+	  and monitoring resource allocation of user-defined groups of tasks or
+	  incoming socket connections. For more information, please visit
+	  http://ckrm.sf.net. 
+
+	  If you say Y here, enable the Resource Class File System and atleast
+	  one of the resource controllers below. Say N if you are unsure. 
+
+config RCFS_FS
+       tristate "Resource Class File System (User API)"
+       depends on CKRM
+       help
+	  RCFS is the filesystem API for CKRM. This separate configuration 
+	  option is provided only for debugging and will eventually disappear 
+	  since rcfs will be automounted whenever CKRM is configured. 
+
+          Say N if unsure, Y if you've enabled CKRM, M to debug rcfs 
+	  initialization.
+
+config CKRM_TYPE_TASKCLASS
+	bool "Class Manager for Task Groups"
+	depends on CKRM
+	help
+	  TASKCLASS provides the extensions for CKRM to track task classes
+	  This is the base to enable task class based resource control for
+	  cpu, memory and disk I/O.
+	
+	  Say N if unsure 
+
+config CKRM_RES_NUMTASKS
+	tristate "Number of Tasks Resource Manager"
+	depends on CKRM_TYPE_TASKCLASS
+	default m
+	help
+	  Provides a Resource Controller for CKRM that allows limiting no of
+	  tasks a task class can have.
+	
+	  Say N if unsure, Y to use the feature.
+
+config CKRM_TYPE_SOCKETCLASS
+	bool "Class Manager for socket groups"
+	depends on CKRM
+	help
+	  SOCKET provides the extensions for CKRM to track per socket
+	  classes.  This is the base to enable socket based resource 
+	  control for inbound connection control, bandwidth control etc.
+	
+	  Say N if unsure.  
+
+config CKRM_RES_LISTENAQ
+	tristate "Multiple Accept Queues Resource Manager"
+	depends on CKRM_TYPE_SOCKETCLASS && ACCEPT_QUEUES
+	default m
+	help
+	  Provides a  resource controller for CKRM to prioritize inbound
+	  connection requests. See inbound control description for
+	  "IP: TCP Multiple accept queues support". If you choose that
+	  option choose this option to control the queue weights.
+ 
+	  If unsure, say N.
+
+endmenu
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Wed Apr 28 22:41:05 2004
+++ b/init/main.c	Wed Apr 28 22:41:05 2004
@@ -46,6 +46,8 @@
 #include <asm/io.h>
 #include <asm/bugs.h>
 
+#include <linux/ckrm.h>
+
 /*
  * This is one of the first .c files built. Error out early
  * if we have compiler trouble..
@@ -431,6 +433,7 @@
 	rcu_init();
 	init_IRQ();
 	pidhash_init();
+	ckrm_init();
 	sched_init();
 	softirq_init();
 	time_init();
@@ -479,6 +482,7 @@
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
+
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
 
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	Wed Apr 28 22:41:05 2004
+++ b/kernel/Makefile	Wed Apr 28 22:41:05 2004
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o ckrm/
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Nru a/kernel/ckrm/Makefile b/kernel/ckrm/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/ckrm/Makefile	Wed Apr 28 22:41:05 2004
@@ -0,0 +1,14 @@
+#
+# Makefile for CKRM 
+#
+
+ifeq ($(CONFIG_CKRM),y)
+	obj-y = ckrm.o ckrmutils.o 
+endif
+
+obj-$(CONFIG_CKRM_TYPE_TASKCLASS) += ckrm_tc.o 
+obj-$(CONFIG_CKRM_RES_NUMTASKS) += ckrm_tasks.o
+
+obj-$(CONFIG_CKRM_TYPE_SOCKETCLASS) += ckrm_sockc.o        
+obj-$(CONFIG_CKRM_RES_LISTENAQ) += ckrm_listenaq.o  
+
diff -Nru a/kernel/ckrm/ckrm.c b/kernel/ckrm/ckrm.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/ckrm/ckrm.c	Wed Apr 28 22:41:05 2004
@@ -0,0 +1,1003 @@
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
+/* Changes
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
+
+rwlock_t ckrm_class_lock = RW_LOCK_UNLOCKED;  // protect classlists 
+
+struct rcfs_functions rcfs_fn ;
+EXPORT_SYMBOL(rcfs_fn);
+
+/**************************************************************************
+ *                   Helper Functions                                     *
+ **************************************************************************/
+
+/*
+ * Return TRUE if the given core class pointer is valid.
+ */
+
+/*
+ * Return TRUE if the given resource is registered.
+ */
+inline unsigned int
+is_res_regd(struct ckrm_classtype *clstype, int resid)
+{
+	return ( (resid>=0) && (resid < clstype->max_resid) &&
+		 test_bit(resid, &clstype->bit_res_ctlrs)
+		);
+}
+
+struct ckrm_res_ctlr*
+ckrm_resctlr_lookup(struct ckrm_classtype *clstype, const char *resname)
+{
+	int resid = -1;
+	
+	for (resid=0; resid < clstype->max_resid; resid++) { 
+		if (test_bit(resid, &clstype->bit_res_ctlrs)) {
+			struct ckrm_res_ctlr *rctrl = clstype->res_ctlrs[resid];
+			if (!strncmp(resname, rctrl->res_name,CKRM_MAX_RES_NAME))
+				return rctrl;
+		}
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(ckrm_resctlr_lookup);
+
+/* given a classname return the class handle and its classtype*/
+void *
+ckrm_classobj(char *classname, int *classTypeID)
+{
+	int i;
+
+	*classTypeID = -1;
+	if (!classname || !*classname) {
+		return NULL;
+	}
+
+	read_lock(&ckrm_class_lock);
+	for ( i=0 ; i<CKRM_MAX_CLASSTYPES; i++) {
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
+EXPORT_SYMBOL(is_res_regd);
+EXPORT_SYMBOL(ckrm_classobj);
+
+/**************************************************************************
+ *                   Internal Functions/macros                            *
+ **************************************************************************/
+
+static inline void 
+set_callbacks_active(struct ckrm_classtype *ctype)
+{
+	ctype->ce_cb_active = ((atomic_read(&ctype->ce_nr_users) > 0) &&
+			       (ctype->ce_callbacks.always_callback || (ctype->num_classes > 1)));
+}
+
+int
+ckrm_validate_and_grab_core(struct ckrm_core_class *core)
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
+/****************************************************************************
+ *           Interfaces for classification engine                           *
+ ****************************************************************************/
+
+/*
+ * Registering a callback structure by the classification engine.
+ *
+ * Returns typeId of class on success -errno for failure.
+ */
+int
+ckrm_register_engine(const char *typename, ckrm_eng_callback_t *ecbs)
+{
+	struct ckrm_classtype *ctype;
+
+	ctype = ckrm_find_classtype_by_name(typename);
+	if (ctype == NULL) 
+		return (-ENOENT);
+
+	ce_protect(ctype);
+	if (atomic_read(&ctype->ce_nr_users) != 1) {
+		// Some engine is acive, deregister it first.
+		ce_release(ctype);
+		return (-EBUSY);
+	}
+	
+	/* we require that either classify and class_delete are set (due to object reference)
+	 * or that notify is set (in case no real classification is supported only notification
+	 * also require that the function pointer be set the momement the mask is non-null
+	 */
+	if ( ! (((ecbs->classify) && (ecbs->class_delete)) || (ecbs->notify)) ||
+	     (ecbs->c_interest && ecbs->classify == NULL) ||
+	     (ecbs->n_interest && ecbs->notify == NULL) )
+	{
+		ce_release(ctype);
+		return (-EINVAL);
+	}
+	
+
+	/* Is any other engine registered for this classtype ? */
+	if (ctype->ce_regd) {
+		ce_release(ctype);
+		return (-EINVAL);
+	}
+	
+	ctype->ce_regd = 1;
+	ctype->ce_callbacks = *ecbs;
+	set_callbacks_active(ctype);
+	if (ctype->ce_callbacks.class_add) 
+		(*ctype->ce_callbacks.class_add)(ctype->default_class->name,ctype->default_class);
+	return ctype->typeID;
+}
+
+/*
+ * Unregistering a callback structure by the classification engine.
+ *
+ * Returns 0 on success -errno for failure.
+ */
+int
+ckrm_unregister_engine(const char *typename)
+{
+	struct ckrm_classtype *ctype;
+
+	ctype = ckrm_find_classtype_by_name(typename);
+	if (ctype == NULL) 
+		return (-ENOENT);
+
+	ctype->ce_cb_active = 0; 
+
+	if (atomic_dec_and_test(&ctype->ce_nr_users) != 1) {
+		// Somebody is currently using the engine, cannot deregister.
+		atomic_inc(&ctype->ce_nr_users);
+		return (-EBUSY);
+	}
+
+	ctype->ce_regd = 0;
+	memset(&ctype->ce_callbacks, 0, sizeof(ckrm_eng_callback_t));
+	return 0;
+}
+
+/****************************************************************************
+ *           Interfaces to manipulate class (core or resource) hierarchies 
+ ****************************************************************************/
+
+/* 
+ */
+static void
+ckrm_add_child(struct ckrm_core_class *parent, struct ckrm_core_class *child)
+{
+	struct ckrm_hnode *cnode = &child->hnode;
+
+	if (!ckrm_is_core_valid(child)) {
+		printk(KERN_ERR "Invalid child %p given in ckrm_add_child\n", child);
+		return;
+	}
+	
+	spin_lock(&child->ckrm_lock);
+	INIT_LIST_HEAD(&cnode->children);
+	INIT_LIST_HEAD(&cnode->siblings);
+
+ 	if (parent) {
+		struct ckrm_hnode *pnode;
+
+		if (!ckrm_is_core_valid(parent)) {
+			printk(KERN_ERR "Invalid parent %p given in ckrm_add_child\n",
+					parent);
+			parent = NULL;
+		} else {
+			pnode = &parent->hnode;
+			write_lock(&parent->hnode_rwlock);
+			list_add(&cnode->siblings, &pnode->children);
+			write_unlock(&parent->hnode_rwlock);
+		}
+	}
+	cnode->parent = parent;
+	spin_unlock(&child->ckrm_lock);
+	return;
+}
+
+/* 
+ */
+static int
+ckrm_remove_child(struct ckrm_core_class *child)
+{
+	struct ckrm_hnode *cnode, *pnode;
+	struct ckrm_core_class *parent;
+
+	if (!ckrm_is_core_valid(child)) {
+		printk(KERN_ERR "Invalid child %p given in ckrm_remove_child\n", child);
+		return 0;
+	}
+
+	cnode = &child->hnode;
+	parent = cnode->parent;
+	if (!ckrm_is_core_valid(parent)) {
+		printk(KERN_ERR "Invalid parent %p in ckrm_remove_child\n", parent);
+		return 0;
+	}
+
+	pnode = &parent->hnode;
+
+	spin_lock(&child->ckrm_lock);
+	/* ensure that the node does not have children */
+	if (!list_empty(&cnode->children)) {
+		spin_unlock(&child->ckrm_lock);
+		return 0;
+	}
+	write_lock(&parent->hnode_rwlock);
+	list_del(&cnode->siblings);
+	write_unlock(&parent->hnode_rwlock);
+	cnode->parent = NULL;
+	spin_unlock(&child->ckrm_lock);
+	return 1;
+}
+
+void
+ckrm_lock_hier(struct ckrm_core_class *parent)
+{
+	if (ckrm_is_core_valid(parent)) {
+		read_lock(&parent->hnode_rwlock);
+	}
+}
+
+void 
+ckrm_unlock_hier(struct ckrm_core_class *parent)
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
+#define hnode_2_core(ptr) ((ptr) ? container_of(ptr, struct ckrm_core_class, hnode) : NULL)
+
+struct ckrm_core_class *
+ckrm_get_next_child(struct ckrm_core_class *parent,
+			struct ckrm_core_class *child)
+{
+	struct list_head *cnode;
+	struct ckrm_hnode *next_cnode;
+	struct ckrm_core_class *next_childcore;
+
+	if (!ckrm_is_core_valid(parent)) {
+		printk(KERN_ERR "Invalid parent %p in ckrm_get_next_child\n", parent);
+		return NULL;
+	}
+	if (list_empty(&parent->hnode.children)) {
+		return NULL;
+	}
+
+	if (child) {
+		if (!ckrm_is_core_valid(child)) {
+			printk(KERN_ERR "Invalid child %p in ckrm_get_next_child\n", child);
+			return NULL;
+		}
+		cnode = child->hnode.siblings.next;
+	} else {
+		cnode = parent->hnode.children.next;
+	}
+
+	if (cnode == &parent->hnode.children) { // back at the anchor
+		return NULL;
+	}
+
+	next_cnode = container_of(cnode, struct ckrm_hnode, siblings);
+	next_childcore = hnode_2_core(next_cnode);
+
+	if (!ckrm_is_core_valid(next_childcore)) {
+		printk(KERN_ERR "Invalid next child %p in ckrm_get_next_child\n",
+				next_childcore);
+		return NULL;
+	}
+	return next_childcore;
+}
+
+EXPORT_SYMBOL(ckrm_lock_hier);
+EXPORT_SYMBOL(ckrm_unlock_hier);
+EXPORT_SYMBOL(ckrm_get_next_child);
+
+static void 
+ckrm_alloc_res_class(struct ckrm_core_class *core,
+		     struct ckrm_core_class *parent,
+		     int resid)
+{
+
+	struct ckrm_classtype *clstype;
+
+	/* 
+	 * Allocate a resource class only if the resource controller has
+	 * registered with core and the engine requests for the class.
+	 */
+
+	if (!ckrm_is_core_valid(core))
+		return ; 
+
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
+			core->res_class[resid] =(*rcbs->res_alloc)(core,parent);
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
+int
+ckrm_init_core_class(struct ckrm_classtype  *clstype,
+		     struct ckrm_core_class *dcore,
+		     struct ckrm_core_class *parent,
+		     const char *name)
+{
+	// Hubertus   ... should replace name with dentry or add dentry ?
+	int i;
+
+	// Hubertus .. how is this used in initialization 
+
+	printk("ckrm_init_core_class: name %s => %p\n", name?name:"default",dcore);
+	
+	if ((dcore != clstype->default_class) && ( !ckrm_is_core_valid(parent))) {
+		printk("error not a valid parent %p\n", parent);
+		return -EINVAL;
+	}
+#if 0  // Hubertus .. dynamic allocation still breaks when RCs registers. See def in ckrm_rc.h
+	dcore->res_class = NULL;
+	if (clstype->max_resid > 0) {
+		dcore->res_class = (void**)kmalloc(clstype->max_resid * sizeof(void*) , GFP_KERNEL);
+		if (dcore->res_class == NULL) {
+			printk("error no mem\n");
+			return -ENOMEM;
+		}
+	}
+#endif
+
+	dcore->classtype    = clstype;
+	dcore->magic        = CKRM_CORE_MAGIC;
+	dcore->name         = name;
+	dcore->ckrm_lock    = SPIN_LOCK_UNLOCKED;
+	dcore->hnode_rwlock = RW_LOCK_UNLOCKED;
+
+	atomic_set(&dcore->refcnt, 0);
+	write_lock(&ckrm_class_lock);
+
+	INIT_LIST_HEAD(&dcore->objlist);
+	list_add(&dcore->clslist,&clstype->classes);
+
+	clstype->num_classes++;
+	set_callbacks_active(clstype);
+
+	write_unlock(&ckrm_class_lock);
+	ckrm_add_child(parent, dcore); 
+
+	for (i = 0; i < clstype->max_resid; i++) 
+		ckrm_alloc_res_class(dcore,parent,i);
+
+	// fix for race condition seen in stress with numtasks
+	if (parent) 
+		ckrm_core_grab(parent);
+
+	ckrm_core_grab( dcore );
+	return 0;
+}
+
+
+static void 
+ckrm_free_res_class(struct ckrm_core_class *core, int resid)
+{
+	/* 
+	 * Free a resource class only if the resource controller has
+	 * registered with core 
+	 */
+
+	if (core->res_class[resid]) {
+		ckrm_res_ctlr_t *rcbs;
+		struct ckrm_classtype *clstype = core->classtype;
+
+		atomic_inc(&clstype->nr_resusers[resid]);
+		rcbs = clstype->res_ctlrs[resid];
+
+		if (rcbs->res_free) {
+			(*rcbs->res_free)(core->res_class[resid]);
+			atomic_dec(&clstype->nr_resusers[resid]); // for inc in alloc
+			core->res_class[resid] = NULL;	
+		}
+		atomic_dec(&clstype->nr_resusers[resid]);
+	}
+}
+
+
+/*
+ * Free a core class 
+ *   requires that all tasks were previously reassigned to another class
+ *
+ * Returns 0 on success -errno on failure.
+ */
+
+void
+ckrm_free_core_class(struct ckrm_core_class *core)
+{
+	int i;
+	struct ckrm_classtype *clstype = core->classtype;
+	struct ckrm_core_class *parent = core->hnode.parent;
+	
+	printk("%s: core=%p:%s parent=%p:%s\n",__FUNCTION__,core,core->name,parent,parent->name);
+	if (core->magic == 0) {
+		/* this core was marked as late */
+		printk("class <%s> finally deleted %lu\n",core->name,jiffies);
+	}
+	if (ckrm_remove_child(core) == 0) {
+		printk("Core class removal failed. Chilren present\n");
+	}
+
+	for (i = 0; i < clstype->max_resid; i++) {
+		ckrm_free_res_class(core,i);
+	}
+
+	write_lock(&ckrm_class_lock);
+
+	// Clear the magic, so we would know if this core is reused.
+	core->magic = 0;
+#if 0 // Dynamic not yet enabled
+	core->res_class = NULL;
+#endif
+	// Remove this core class from its linked list.
+	list_del(&core->clslist);
+	clstype->num_classes--;
+	set_callbacks_active(clstype);
+	write_unlock(&ckrm_class_lock);
+
+	// fix for race condition seen in stress with numtasks
+	if (parent) 
+		ckrm_core_drop(parent);
+ 
+	kfree(core);
+}
+
+int
+ckrm_release_core_class(struct ckrm_core_class *core)
+{
+	if (!ckrm_is_core_valid(core)) {
+		// Invalid core
+		return (-EINVAL);
+	}
+
+	if (core == core->classtype->default_class)
+ 		return 0;
+
+	/* need to make sure that the classgot really dropped */
+	if (atomic_read(&core->refcnt) != 1) {
+		printk("class <%s> deletion delayed refcnt=%d jif=%ld\n",
+		       core->name,core->refcnt,jiffies);
+		core->magic = 0;  /* just so we have a ref point */
+	}
+	ckrm_core_drop(core);
+	return 0;
+}
+
+/****************************************************************************
+ *           Interfaces for the resource controller                         *
+ ****************************************************************************/
+/*
+ * Registering a callback structure by the resource controller.
+ *
+ * Returns the resource id(0 or +ve) on success, -errno for failure.
+ */
+static int
+ckrm_register_res_ctlr_intern(struct ckrm_classtype *clstype, ckrm_res_ctlr_t *rcbs)
+{
+	int  resid, ret,i;
+	
+	if (!rcbs)
+		return -EINVAL;
+
+	resid = rcbs->resid;
+	
+	spin_lock(&clstype->res_ctlrs_lock);
+	
+	printk(KERN_WARNING "resid is %d name is %s %s\n", 
+	       resid, rcbs->res_name,clstype->res_ctlrs[resid]->res_name);
+
+	if (resid >= 0) {
+		if ((resid < CKRM_MAX_RES_CTLRS) && (clstype->res_ctlrs[resid] == NULL)) {
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
+
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
+	
+	spin_unlock(&clstype->res_ctlrs_lock);
+	return (-ENOMEM);
+}
+
+int
+ckrm_register_res_ctlr(struct ckrm_classtype *clstype, ckrm_res_ctlr_t *rcbs)
+{
+	struct ckrm_core_class *core;
+	int resid;
+	
+	resid = ckrm_register_res_ctlr_intern(clstype,rcbs);
+	
+	if (resid >= 0) {
+		/* run through all classes and create the resource class object and
+		 * if necessary "initialize" class in context of this resource 
+		 */
+		read_lock(&ckrm_class_lock);
+		list_for_each_entry(core, &clstype->classes, clslist) {
+			printk("CKRM .. create res clsobj for resouce <%s> class <%s> par=%p\n", 
+			       rcbs->res_name, core->name, core->hnode.parent);
+			ckrm_alloc_res_class(core, core->hnode.parent, resid);
+			if (clstype->add_resctrl)  // FIXME: this should be mandatory
+				(*clstype->add_resctrl)(core,resid);
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
+int
+ckrm_unregister_res_ctlr(struct ckrm_res_ctlr *rcbs)
+{	
+	struct ckrm_classtype *clstype = rcbs->classtype;
+	int resid = rcbs->resid;
+
+	if ((clstype == NULL) || (resid < 0))
+		return -EINVAL;
+	
+	if (atomic_read(&clstype->nr_resusers[resid]))
+		return -EBUSY;
+	
+	// FIXME: probably need to also call deregistration function
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
+/*******************************************************************
+ *   Class Type Registration
+ *******************************************************************/
+
+/* Hubertus ... we got to do some locking here */
+
+struct ckrm_classtype* ckrm_classtypes[CKRM_MAX_CLASSTYPES];
+EXPORT_SYMBOL(ckrm_classtypes);     // really should build a better interface for this
+
+int
+ckrm_register_classtype(struct ckrm_classtype *clstype)
+{
+	int tid = clstype->typeID;
+
+	if (tid != -1) {
+		if ((tid < 0) || (tid > CKRM_MAX_CLASSTYPES) || (ckrm_classtypes[tid]))
+			return -EINVAL;
+	} else {
+		int i;
+		for ( i=CKRM_RESV_CLASSTYPES ; i<CKRM_MAX_CLASSTYPES; i++) {
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
+	/* Hubertus .. we need to call the callbacks of the RCFS client */
+	if (rcfs_fn.register_classtype) {
+		(* rcfs_fn.register_classtype)(clstype);
+		// No error return for now ;
+	}
+
+	return tid;
+}
+
+int
+ckrm_unregister_classtype(struct ckrm_classtype *clstype)
+{
+	int tid = clstype->typeID;
+
+	if ((tid < 0) || (tid > CKRM_MAX_CLASSTYPES) || (ckrm_classtypes[tid] != clstype))
+		return -EINVAL;
+
+	if (rcfs_fn.deregister_classtype) {
+		(* rcfs_fn.deregister_classtype)(clstype);
+		// No error return for now
+	}
+
+	ckrm_classtypes[tid] = NULL;
+	clstype->typeID = -1;
+	return 0;
+}
+
+struct ckrm_classtype*
+ckrm_find_classtype_by_name(const char *name)
+{
+	int i;
+	for ( i=0 ; i<CKRM_MAX_CLASSTYPES; i++) {
+		struct ckrm_classtype *ctype = ckrm_classtypes[i];
+		if (ctype && !strncmp(ctype->name,name,CKRM_MAX_TYPENAME_LEN)) 
+			return ctype;
+	}
+	return NULL;
+}
+
+
+/*******************************************************************
+ *   Event callback invocation
+ *******************************************************************/
+
+struct ckrm_hook_cb* ckrm_event_callbacks[CKRM_NONLATCHABLE_EVENTS];
+
+/* Registration / Deregistration / Invocation functions */
+
+int
+ckrm_register_event_cb(enum ckrm_event ev, struct ckrm_hook_cb *cb)
+{
+	struct ckrm_hook_cb **cbptr;
+
+	if ((ev < CKRM_LATCHABLE_EVENTS) || (ev >= CKRM_NONLATCHABLE_EVENTS))
+		return 1;
+	cbptr = &ckrm_event_callbacks[ev];
+	while (*cbptr != NULL) 
+		cbptr = &((*cbptr)->next);
+	*cbptr = cb;
+	return 0;
+}
+
+int
+ckrm_unregister_event_cb(enum ckrm_event ev, struct ckrm_hook_cb *cb)
+{
+	struct ckrm_hook_cb **cbptr;
+
+	if ((ev < CKRM_LATCHABLE_EVENTS) || (ev >= CKRM_NONLATCHABLE_EVENTS))
+		return -1;
+	cbptr = &ckrm_event_callbacks[ev];
+	while ((*cbptr != NULL) && (*cbptr != cb))
+		cbptr = &((*cbptr)->next);
+	if (*cbptr)
+		(*cbptr)->next = cb->next;
+	return (*cbptr == NULL);
+}
+
+int
+ckrm_register_event_set(struct ckrm_event_spec especs[])
+{
+	struct ckrm_event_spec *espec = especs;
+
+	for ( espec = especs ; espec->ev != -1 ; espec++ )
+		ckrm_register_event_cb(espec->ev,&espec->cb);
+	return 0;
+}
+
+int
+ckrm_unregister_event_set(struct ckrm_event_spec especs[])
+{
+	struct ckrm_event_spec *espec = especs;
+
+	for ( espec = especs ; espec->ev != -1 ; espec++ )
+		ckrm_unregister_event_cb(espec->ev,&espec->cb);
+	return 0;
+}
+
+#define ECC_PRINTK(fmt, args...) // printk("%s: " fmt, __FUNCTION__ , ## args)
+
+void
+ckrm_invoke_event_cb_chain(enum ckrm_event ev, void *arg)
+{
+	struct ckrm_hook_cb *cb, *anchor;
+
+	ECC_PRINTK("%d %x\n",current,ev,arg);
+	if ((anchor = ckrm_event_callbacks[ev]) != NULL) {
+		for ( cb = anchor ; cb ; cb = cb->next ) 
+			(*cb->fct)(arg);
+	}
+}
+
+/*******************************************************************
+ *   Generic Functions that can be used as default functions 
+ *   in almost all classtypes
+ *     (a) function iterator over all resource classes of a class
+ *     (b) function invoker on a named resource
+ *******************************************************************/
+
+int                      
+ckrm_class_show_shares(struct ckrm_core_class *core, struct seq_file *seq)
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
+			(*rcbs->get_share_values)(core->res_class[i], &shares);
+			seq_printf(seq,"res=%s,guarantee=%d,limit=%d,total_guarantee=%d,max_limit=%d\n",
+				   rcbs->res_name,
+				   shares.my_guarantee,
+				   shares.my_limit,
+				   shares.total_guarantee,
+				   shares.max_limit);
+		}
+		atomic_dec(&clstype->nr_resusers[i]);
+	}
+	return 0;
+}
+
+int                      
+ckrm_class_show_stats(struct ckrm_core_class *core, struct seq_file *seq)
+{
+	int i;
+	struct ckrm_res_ctlr *rcbs;
+	struct ckrm_classtype *clstype = core->classtype;
+
+	for (i = 0; i < clstype->max_resid; i++) {
+		atomic_inc(&clstype->nr_resusers[i]);
+		rcbs = clstype->res_ctlrs[i];
+		if (rcbs && rcbs->get_stats) 
+			(*rcbs->get_stats)(core->res_class[i], seq);
+		atomic_dec(&clstype->nr_resusers[i]);
+	}
+	return 0;
+}
+
+int                      
+ckrm_class_show_config(struct ckrm_core_class *core, struct seq_file *seq)
+{
+	int i;
+	struct ckrm_res_ctlr *rcbs;
+	struct ckrm_classtype *clstype = core->classtype;
+
+	for (i = 0; i < clstype->max_resid; i++) {
+		atomic_inc(&clstype->nr_resusers[i]);
+		rcbs = clstype->res_ctlrs[i];
+		if (rcbs && rcbs->show_config) 
+			(*rcbs->show_config)(core->res_class[i], seq);
+		atomic_dec(&clstype->nr_resusers[i]);
+	}
+	return 0;
+}
+
+int
+ckrm_class_set_config(struct ckrm_core_class *core, const char *resname, const char *cfgstr)
+{
+	struct ckrm_classtype *clstype = core->classtype;
+	struct ckrm_res_ctlr *rcbs = ckrm_resctlr_lookup(clstype,resname);
+	int rc;
+
+	if (rcbs == NULL || rcbs->set_config == NULL)
+		return -EINVAL; 
+	rc = (*rcbs->set_config)(core->res_class[rcbs->resid],cfgstr);
+	return rc;
+}
+
+int
+ckrm_class_set_shares(struct ckrm_core_class *core, const char *resname,
+		      struct ckrm_shares *shares)
+{
+	struct ckrm_classtype *clstype = core->classtype;
+	struct ckrm_res_ctlr *rcbs;
+	int rc;
+
+	printk("ckrm_class_set_shares(%s,%s)\n",core->name,resname);
+	rcbs = ckrm_resctlr_lookup(clstype,resname);
+	if (rcbs == NULL || rcbs->set_share_values == NULL)
+		return -EINVAL; 
+	rc = (*rcbs->set_share_values)(core->res_class[rcbs->resid],shares);
+	return rc;
+}
+
+int 
+ckrm_class_reset_stats(struct ckrm_core_class *core, const char *resname, const char *unused)
+{
+	struct ckrm_classtype *clstype = core->classtype;
+	struct ckrm_res_ctlr *rcbs = ckrm_resctlr_lookup(clstype,resname);
+	int rc;
+
+	if (rcbs == NULL || rcbs->reset_stats == NULL)
+		return -EINVAL; 
+	rc = (*rcbs->reset_stats)(core->res_class[rcbs->resid]);
+	return rc;
+}	
+
+/*******************************************************************
+ *   Initialization 
+ *******************************************************************/
+
+void
+ckrm_cb_newtask(struct task_struct *tsk)
+{
+	tsk->ce_data   = NULL;
+	spin_lock_init(&tsk->ckrm_tsklock);
+	ckrm_invoke_event_cb_chain(CKRM_EVENT_NEWTASK,tsk);
+}
+
+void 
+ckrm_cb_exit(struct task_struct *tsk)
+{
+	ckrm_invoke_event_cb_chain(CKRM_EVENT_EXIT,tsk);
+	tsk->ce_data = NULL;
+}
+
+void __init
+ckrm_init(void) 
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
+
+EXPORT_SYMBOL(ckrm_register_engine);
+EXPORT_SYMBOL(ckrm_unregister_engine);
+
+EXPORT_SYMBOL(ckrm_register_res_ctlr);
+EXPORT_SYMBOL(ckrm_unregister_res_ctlr);
+
+EXPORT_SYMBOL(ckrm_init_core_class);
+EXPORT_SYMBOL(ckrm_free_core_class);
+EXPORT_SYMBOL(ckrm_release_core_class);
+
+EXPORT_SYMBOL(ckrm_register_classtype);
+EXPORT_SYMBOL(ckrm_unregister_classtype);
+EXPORT_SYMBOL(ckrm_find_classtype_by_name);
+
+EXPORT_SYMBOL(ckrm_core_grab);
+EXPORT_SYMBOL(ckrm_core_drop);
+EXPORT_SYMBOL(ckrm_is_core_valid);
+EXPORT_SYMBOL(ckrm_validate_and_grab_core);
+
+EXPORT_SYMBOL(ckrm_register_event_set);
+EXPORT_SYMBOL(ckrm_unregister_event_set);
+EXPORT_SYMBOL(ckrm_register_event_cb);
+EXPORT_SYMBOL(ckrm_unregister_event_cb);
+
+EXPORT_SYMBOL(ckrm_class_show_stats);
+EXPORT_SYMBOL(ckrm_class_show_config);
+EXPORT_SYMBOL(ckrm_class_show_shares);
+
+EXPORT_SYMBOL(ckrm_class_set_config);
+EXPORT_SYMBOL(ckrm_class_set_shares);
+
+EXPORT_SYMBOL(ckrm_class_reset_stats);
diff -Nru a/kernel/ckrm/ckrmutils.c b/kernel/ckrm/ckrmutils.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/ckrm/ckrmutils.c	Wed Apr 28 22:41:05 2004
@@ -0,0 +1,207 @@
+/* ckrmutils.c - Utility functions for CKRM
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
+/* Changes
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
+int
+get_exe_path_name(struct task_struct *tsk, char *buf, int buflen)
+{
+	struct vm_area_struct * vma;
+	struct vfsmount *mnt;
+	struct mm_struct * mm = get_task_mm(tsk);
+	struct dentry *dentry;
+	char *lname;
+	int rc = 0;
+
+	*buf = '\0';
+	if (!mm) {
+		return -EINVAL;
+	}
+
+	down_read(&mm->mmap_sem);
+	vma = mm->mmap;
+	while (vma) {
+		if ((vma->vm_flags & VM_EXECUTABLE) &&
+				vma->vm_file) {
+			dentry = dget(vma->vm_file->f_dentry);
+			mnt = mntget(vma->vm_file->f_vfsmnt);
+			lname = d_path(dentry, mnt, buf, buflen);
+			if (! IS_ERR(lname)) {
+				strncpy(buf, lname, strlen(lname) + 1);
+			} else {
+				rc = (int) PTR_ERR(lname);
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
+
+/*
+ * must be called with cnt_lock of parres held
+ * Caller is responsible for making sure that the new guarantee doesn't
+ * overflow parent's total guarantee.
+ */
+void
+child_guarantee_changed(struct ckrm_shares *parent, int cur, int new)
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
+void
+child_maxlimit_changed(struct ckrm_shares *parent, int new_limit)
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
+		struct ckrm_shares *par)
+{
+	int rc = -EINVAL;
+	int cur_usage_guar = cur->total_guarantee - cur->unused_guarantee;
+	int increase_by = new->my_guarantee - cur->my_guarantee;
+
+	// Check total_guarantee for correctness
+	if (new->total_guarantee <= CKRM_SHARE_DONTCARE) {
+		goto set_share_err;
+	} else if (new->total_guarantee == CKRM_SHARE_UNCHANGED) {
+		;// do nothing
+	} else if (cur_usage_guar > new->total_guarantee) {
+		goto set_share_err;
+	}
+
+	// Check max_limit for correctness
+	if (new->max_limit <= CKRM_SHARE_DONTCARE) {
+		goto set_share_err;
+	} else if (new->max_limit == CKRM_SHARE_UNCHANGED) {
+		; // do nothing
+	} else if (cur->cur_max_limit > new->max_limit) {
+		goto set_share_err;
+	}
+
+	// Check my_guarantee for correctness
+	if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
+		; // do nothing
+	} else if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
+		; // do nothing
+	} else if (par && increase_by > par->unused_guarantee) {
+		goto set_share_err;
+	}
+
+	// Check my_limit for correctness
+	if (new->my_limit == CKRM_SHARE_UNCHANGED) {
+		; // do nothing
+	} else if (new->my_limit == CKRM_SHARE_DONTCARE) {
+		; // do nothing
+	} else if (par && new->my_limit > par->max_limit) {
+		// I can't get more limit than my parent's limit
+		goto set_share_err;
+		
+	}
+
+	// make sure guarantee is lesser than limit
+	if (new->my_limit == CKRM_SHARE_DONTCARE) {
+		; // do nothing
+	} else if (new->my_limit == CKRM_SHARE_UNCHANGED) {
+		if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
+			; // do nothing
+		} else if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
+			; // do nothing earlier setting would 've taken care of it
+		} else if (new->my_guarantee > cur->my_limit) {
+			goto set_share_err;
+		}
+	} else { // new->my_limit has a valid value
+		if (new->my_guarantee == CKRM_SHARE_DONTCARE) {
+			; // do nothing
+		} else if (new->my_guarantee == CKRM_SHARE_UNCHANGED) {
+			if (cur->my_guarantee > new->my_limit) {
+				goto set_share_err;
+			}
+		} else if (new->my_guarantee > new->my_limit) {
+			goto set_share_err;
+		}
+	}
+
+	if (new->my_guarantee != CKRM_SHARE_UNCHANGED) {
+		child_guarantee_changed(par, cur->my_guarantee,
+				new->my_guarantee);
+		cur->my_guarantee = new->my_guarantee;
+	}
+
+	if (new->my_limit != CKRM_SHARE_UNCHANGED) {
+		child_maxlimit_changed(par, new->my_limit);
+		cur->my_limit = new->my_limit;
+	}
+
+	if (new->total_guarantee != CKRM_SHARE_UNCHANGED) {
+		cur->unused_guarantee = new->total_guarantee - cur_usage_guar;
+		cur->total_guarantee = new->total_guarantee;
+	}
+
+	if (new->max_limit != CKRM_SHARE_UNCHANGED) {
+		cur->max_limit = new->max_limit;
+	}
+
+	rc = 0;
+set_share_err:
+	return rc;
+}
+
+EXPORT_SYMBOL(get_exe_path_name);
+EXPORT_SYMBOL(child_guarantee_changed);
+EXPORT_SYMBOL(child_maxlimit_changed);
+EXPORT_SYMBOL(set_shares);
+
+
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Wed Apr 28 22:41:05 2004
+++ b/kernel/exit.c	Wed Apr 28 22:41:05 2004
@@ -22,6 +22,8 @@
 #include <linux/profile.h>
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
+#include <linux/ckrm.h>
+#include <linux/ckrm_tsk.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -625,6 +627,8 @@
 	int state;
 	struct task_struct *t;
 
+	ckrm_cb_exit(tsk);
+
 	if (signal_pending(tsk) && !tsk->signal->group_exit
 	    && !thread_group_empty(tsk)) {
 		/*
@@ -788,6 +792,7 @@
 		module_put(tsk->binfmt->module);
 
 	tsk->exit_code = code;
+	numtasks_put_ref(tsk->taskclass);
 	exit_notify(tsk);
 	schedule();
 	BUG();
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Wed Apr 28 22:41:05 2004
+++ b/kernel/fork.c	Wed Apr 28 22:41:05 2004
@@ -31,6 +31,8 @@
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
+#include <linux/ckrm.h>
+#include <linux/ckrm_tsk.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -256,6 +258,7 @@
 	tsk->thread_info = ti;
 	ti->task = tsk;
 
+	ckrm_cb_newtask(tsk);
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	return tsk;
@@ -1143,6 +1146,10 @@
 			clone_flags |= CLONE_PTRACE;
 	}
 
+	if (numtasks_get_ref(current->taskclass, 0) == 0) {
+		return -ENOMEM;
+	}
+
 	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr);
 	/*
 	 * Do this prior waking up the new thread - the thread pointer
@@ -1153,6 +1160,8 @@
 	if (!IS_ERR(p)) {
 		struct completion vfork;
 
+		ckrm_cb_fork(p);
+
 		if (clone_flags & CLONE_VFORK) {
 			p->vfork_done = &vfork;
 			init_completion(&vfork);
@@ -1187,6 +1196,8 @@
 			 * COW overhead when the child exec()s afterwards.
 			 */
 			set_need_resched();
+	} else {
+		numtasks_put_ref(current->taskclass);
 	}
 	return pid;
 }
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Wed Apr 28 22:41:05 2004
+++ b/kernel/sys.c	Wed Apr 28 22:41:05 2004
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
+#include <linux/ckrm.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -582,6 +583,9 @@
 	current->fsgid = new_egid;
 	current->egid = new_egid;
 	current->gid = new_rgid;
+
+	ckrm_cb_gid();
+
 	return 0;
 }
 
@@ -619,6 +623,9 @@
 	}
 	else
 		return -EPERM;
+
+	ckrm_cb_gid();
+
 	return 0;
 }
   
@@ -707,6 +714,8 @@
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
+	ckrm_cb_uid();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
@@ -752,6 +761,8 @@
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
+	ckrm_cb_uid();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
@@ -798,6 +809,8 @@
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
+	ckrm_cb_uid();
+
 	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
@@ -847,5 +860,8 @@
 		current->gid = rgid;
 	if (sgid != (gid_t) -1)
 		current->sgid = sgid;
+
+	ckrm_cb_gid();
+
 	return 0;
 }

--------------060506010408070908050008--
