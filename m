Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbTH2T5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTH2T5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:57:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15587 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261723AbTH2TzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:55:16 -0400
Subject: [RFC/PATCH] CKRM rule-based classification engine (RBCE)
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: ckrm-tech <ckrm-tech@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1062186872.15245.838.camel@elinux05.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Aug 2003 15:54:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Module implementing a Rule-based classification Engine (RBCE)  for use
with Class-based Kernel Resource Management.

Requires ckcore-A01-2.6.0-test2 patch posted earlier.
To define classification rules, classes and policies, you also need
userspace
libraries and a control program which can be downloaded from
	
	http://ckrm.sourceforge.net/downloads/rbce-A01.tar.gz

For more details, please refer to 
	http://ckrm.sf.net

and earlier postings on lkml.

-- Shailabh

-----------------------------------------------------------------------------------
Makefile
-----------------------------------------------------------------------------------
DIR    := /lib/modules/$(shell uname -r)/build
PWD     := $(shell pwd)
# KDIR is the CKRM enabled Linux kernel src tree
KDIR   := /usr/src/linux

obj-m := rbcemod.o 

rbcemem-objs := rbcemod.o 

default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
	rm -f *.o *.ko *~ core

-----------------------------------------------------------------------------------
rbcemod.mod.c
-----------------------------------------------------------------------------------

#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

static const char __module_depends[]
__attribute_used__
__attribute__((section(".modinfo"))) =
"depends=";


-----------------------------------------------------------------------------------
rbcemod.c	
-----------------------------------------------------------------------------------
/* Rule-based Classification Engine (RBCE) module
 *
 * Copyright (C) Hubertus Franke, IBM Corp. 2003
 *           (C) Chandra Seetharaman, IBM Corp. 2003
 * 
 * Module for loading of classification policies and providing
 * a user API for Class-based Kernel Resource Management (CKRM)
 *
 * Latest version, more details at http://ckrm.sf.net
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 */

/* Changes
 *
 * 28 Aug 2003
 *        Created. First cut with much scope for cleanup !
 */

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <asm/io.h>
#include <linux/ckrm.h>
#include <asm/uaccess.h>
#include <linux/proc_fs.h>

#include "../include/rbce.h"


MODULE_AUTHOR("Hubertus Franke, Chandra Seetharaman (IBM)");
MODULE_DESCRIPTION("Rule Based Classification Engine Module for CKRM");
MODULE_LICENSE("GPL");    

static char modname[] = "rbce";
static int rbce_major = 179;	// driver's assigned major number

struct named_obj_hdr {
	struct list_head link;
	rbce_id_t        id;
	char             name[RBCE_MAX_NAME_LEN];
};

struct rbce_class {
	struct named_obj_hdr obj;

	struct ckrm_cpu_class *cpu_class;
	struct ckrm_mem_class *mem_class;
	struct ckrm_net_class *net_class;
	struct ckrm_io_class  *io_class;
};

struct rbce_rule_term {
	rbce_rule_op_t  op;
	union {
		char cmd[RBCE_MAX_COMMAND_LEN];
		char tag[RBCE_MAX_TAG_LEN];
		long id;
		struct rbce_rule *deprule;
	};
};

struct rbce_rule {
	struct named_obj_hdr obj;
	struct rbce_class *target_class;
	int num_terms;
	struct rbce_rule_term *terms;
};

#define RBCE_RULE_NAME	1
#define RBCE_RULE_ID	2

struct rbce_policy {
	struct named_obj_hdr obj;
	rbce_policy_type_t type;
	struct rbce_class *def_class;
	rwlock_t rwlock;
	struct list_head classes;
	struct list_head rules;
};

void rbce_classify(struct task_struct *);


extern int errno;

int rbcedebug = 1;
#define cprintk(lvl,x) if ((lvl) <= rbcedebug) printk x

// /proc stuff for debugging

static ssize_t
my_write(struct file *file, const char *buf, size_t count, loff_t *p)
{
	if (count) {
		char c;

		if (get_user(c, buf)) {
			return -EFAULT;
		}
		if (c < '0' || c > '9') {
			return -EINVAL;
		}
		rbcedebug = c - '0';
	}
	return count;
}

static int
my_read(struct file *file, char *ubuf, size_t size, loff_t *ppos)
{
	int len;
	char kbuf[10];

	if (size < 5) {
		return -ENOMEM;
	}
	len = sprintf(kbuf, "%d\n", rbcedebug);
	if (copy_to_user(ubuf, kbuf, len+1)) {
		return -EFAULT;
	}
	*ppos += len;
	return len;
}

static struct file_operations my_proc_operations = {
	.read = my_read,
	.write = my_write,
};

// Forward declarations

static void reclassify_tasks(struct rbce_class *);
static void rbce_classify_l(struct task_struct *);

/*-----------------------------------------------------------------------*/
rwlock_t global_rwlock = RW_LOCK_UNLOCKED;
	/* This lock protects "policies" list and cur_policy.
	 * Anybody that needs to access any policy in the "policies" list
	 * or cur_policy have to get this lock in read mode and then get the
	 * (reader/writer depending on the operation) lock on that specific
	 * policy. After getting the policy's lock this global lock can be
	 * dropped.
	 *
	 * Insertions of policy to the "policies" list and changing cur_policy
	 * must be done with this lock held in write mode.
	 *
	 * Both the locks must be held(read or write) while deferencing the
	 * class pointer in the task data structure.
	 */
LIST_HEAD(policies);

static struct rbce_policy default_policy = {
	.obj = {
		.link = LIST_HEAD_INIT(default_policy.obj.link),
		.id   = (rbce_id_t)&default_policy,
		.name = "default policy"
	},
	.type               = RBCE_POLICY_MONITOR,
	.rwlock             = RW_LOCK_UNLOCKED,
	.classes            = LIST_HEAD_INIT(default_policy.classes),
	.rules              = LIST_HEAD_INIT(default_policy.rules)
};

static struct rbce_class default_class = {
	.obj = {
		.link = LIST_HEAD_INIT(default_policy.obj.link),
		.id   = (rbce_id_t)&default_class,
		.name = "default class"
	},
};

static struct rbce_policy *cur_policy = &default_policy;

inline static rbce_id_t getid(void *obj) { return (rbce_id_t) obj; }

static struct named_obj_hdr*
find_named_obj(struct list_head *lst, char *name)
{
	struct named_obj_hdr *pos;

	list_for_each_entry(pos, lst, link) {
		if (!strcmp(pos->name, name)) 
			return pos;
	}
	return NULL;
}

static struct named_obj_hdr*
find_id_obj(struct list_head *lst, rbce_id_t id)
{
	struct named_obj_hdr *pos;

	list_for_each_entry(pos, lst, link) {
		if (pos->id == id) 
			return pos;
	}
	return NULL;
}

static inline struct rbce_policy*
find_policy_name(char *name)
{
	return (struct rbce_policy*) find_named_obj(&policies, name);
}

static inline struct rbce_policy*
find_policy_id(rbce_id_t id)
{
	return (struct rbce_policy*) find_id_obj(&policies, id);
}

static inline struct rbce_class*
find_class_name(struct rbce_policy *policy, char *name)
{
	return (struct rbce_class*) find_named_obj(&policy->classes, name);
}

static inline struct rbce_class*
find_class_id(struct rbce_policy *policy, rbce_id_t id)
{
	return (struct rbce_class*) find_id_obj(&policy->classes, id);
}

static inline struct rbce_rule*
find_rule_name(struct rbce_policy *policy, char *name)
{
	return (struct rbce_rule*) find_named_obj(&policy->rules, name);
}

static inline struct rbce_rule*
find_rule_id(struct rbce_policy *policy, rbce_id_t id)
{
	return (struct rbce_rule*) find_id_obj(&policy->rules, id);
}

static rbce_id_t
create_policy(struct rbce_policy_descr *udescr)
{
	rbce_id_t polid = 0, classid;
	struct rbce_policy_descr kdescr;
	struct rbce_policy *policy;
	struct rbce_class *newcls;
	static int firsttime = 1;

	if (firsttime) {
		struct proc_dir_entry *entry;

		firsttime = 0;
		entry = create_proc_entry("rbce_debug", S_IWUGO|S_IRUGO, NULL);
		if (entry) {
			entry->proc_fops = &my_proc_operations;
		}
	}

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_policy_descr))) {
		return (rbce_id_t)-EFAULT;
	}

	if (!strlen(kdescr.name) || ((kdescr.type != RBCE_POLICY_MONITOR) &&
				(kdescr.type != RBCE_POLICY_MANAGE))) {
		return (rbce_id_t)-EINVAL;
	}

	write_lock(&global_rwlock);
	policy = find_policy_name(kdescr.name);
	if (policy) {
		polid = (rbce_id_t)-EINVAL;
		goto out;
	}
	policy = kmalloc(sizeof(struct rbce_policy), GFP_KERNEL);
	if (!policy) {
		polid = (rbce_id_t)-ENOMEM;
		goto out;
	}
	polid = getid(policy);
	policy->obj.id = polid;
	strcpy(policy->obj.name, kdescr.name);
	policy->type = kdescr.type;
	rwlock_init(&policy->rwlock);
	INIT_LIST_HEAD(&policy->classes);
	INIT_LIST_HEAD(&policy->rules);
	list_add_tail(&policy->obj.link, &policies);

	// Create the default class.
	newcls = kmalloc(sizeof(struct rbce_class), GFP_KERNEL);
	if (!newcls) {
		polid = (rbce_id_t)(-ENOMEM);
		goto out_free;
	}
	classid = getid(newcls);
	policy->def_class = newcls;
	newcls->obj.id = classid;
	strcpy(newcls->obj.name, "policy_default_class");
	newcls->cpu_class = ckrm_dflt_cpu_class(&default_class);
	newcls->mem_class = ckrm_dflt_mem_class(&default_class);
	newcls->net_class = ckrm_dflt_net_class(&default_class);
	newcls->io_class  = ckrm_dflt_io_class(&default_class);
	
	list_add_tail(&newcls->obj.link, &policy->classes);
	goto out;

out_free:
	kfree(policy);

out:
	write_unlock(&global_rwlock);
	cprintk(3,("create_policy polid %ld\n", polid));
	return polid;
}

static int
commit_policy(struct rbce_policy_descr *udescr)
{
	struct rbce_policy_descr kdescr;
	struct rbce_policy *policy, *old_policy;
	struct rbce_class *cls;
	int rc = 0;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_policy_descr))) {
		return -EFAULT;
	}

	if (kdescr.policy_id <= 0) {
		return (rbce_id_t)-EINVAL;
	}

	write_lock(&global_rwlock);
	policy = find_policy_id(kdescr.policy_id);
	if (!policy) {
		rc = -EINVAL;
		goto out;
	}

	if (policy == cur_policy) {
		rc = -EBUSY;
		goto out;
	}

	// Get the cur_policy's write lock to protect the current readers.
	write_lock(&cur_policy->rwlock);

	// Reclassify all tasks in all classes in the old policy.
	// Strictly speaking, there should be no tasks in the class.... we
	// should ASSERT this state instead of reclassifying the tasks.
	list_for_each_entry(cls, &cur_policy->classes, obj.link) {
		reclassify_tasks(cls);
	}

	// XXX Need to clear the resource information in the classes of
"policy"
	// before dropping the policy's rwlock.
	write_unlock(&cur_policy->rwlock);

	old_policy = cur_policy;
	cur_policy = policy;

out:
	write_unlock(&global_rwlock);
	return rc;
}

static int
decommit_policy(struct rbce_policy_descr *udescr)
{
	struct rbce_policy_descr kdescr;
	struct rbce_policy *policy;
	struct rbce_class *cls;
	int rc = 0;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_policy_descr))) {
		return -EFAULT;
	}

	if (kdescr.policy_id <= 0) {
		return (rbce_id_t)-EINVAL;
	}

	write_lock(&global_rwlock);
	policy = find_policy_id(kdescr.policy_id);
	if (!policy || policy != cur_policy) {
		rc = -EINVAL;
		goto out;
	}
	if (policy == &default_policy) {// paranoia
		goto out;
	}

	// Get the cur_policy's write lock to protect the current readers.
	write_lock(&cur_policy->rwlock);
	cur_policy = &default_policy;

	// Reclassify all tasks in all classes in the decommited policy.
	list_for_each_entry(cls, &policy->classes, obj.link) {
		reclassify_tasks(cls);
	}
	write_unlock(&cur_policy->rwlock);

out:
	write_unlock(&global_rwlock);
	return rc;
}

static int
delete_policy(struct rbce_policy_descr *udescr)
{
	struct rbce_policy_descr kdescr;
	struct rbce_policy *policy;
	struct list_head *lh1, *lh2;
	struct rbce_rule *rule;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_policy_descr))) {
		return -EFAULT;
	}

	if (kdescr.policy_id <= 0) {
		return (rbce_id_t)-EINVAL;
	}

	write_lock(&global_rwlock);
	policy = find_policy_id(kdescr.policy_id);
	if (!policy || policy == cur_policy) {
		write_unlock(&global_rwlock);
		return (rbce_id_t)-EINVAL;
	}

	// Get the policy's write lock to protect the current readers, if any
	write_lock(&policy->rwlock);

	list_del(&policy->obj.link);
	write_unlock(&policy->rwlock);
	write_unlock(&global_rwlock);

	// delete the rules
	list_for_each_safe(lh1, lh2, &policy->rules) {
		list_del(lh1);
		rule = (struct rbce_rule *) lh1;
		kfree(rule->terms);
		kfree(rule);
	}

	// delete the classses
	list_for_each_safe(lh1, lh2, &policy->classes) {
		list_del(lh1);
		kfree(lh1);
	}

	// delete the policy
	kfree(policy);	

	return 0;
}

static int
set_policy_type(struct rbce_policy_descr *udescr)
{
	struct rbce_policy_descr kdescr;
	struct rbce_policy *policy;
	int rc = -EINVAL;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_policy_descr))) {
		return -EFAULT;
	}

	if (kdescr.policy_id <= 0) {
		return (rbce_id_t)-EINVAL;
	}

	if (kdescr.type != RBCE_POLICY_MONITOR &&
				kdescr.type != RBCE_POLICY_MANAGE) {
		return rc;
	}

	read_lock(&global_rwlock);
	policy = find_policy_id(kdescr.policy_id);
	if (policy && policy != &default_policy) {
				// can't change type of default policy.
		write_lock(&policy->rwlock);
		read_unlock(&global_rwlock);
		policy->type = kdescr.type;
		write_unlock(&policy->rwlock);
		rc = 0;
	} else {
		read_unlock(&global_rwlock);
	}

	return rc;
}

static int
get_policy_type(struct rbce_policy_descr *udescr)
{
	struct rbce_policy_descr kdescr;
	struct rbce_policy *policy;
	int rc = -EINVAL;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_policy_descr))) {
		return -EFAULT;
	}

	if (kdescr.policy_id <= 0) {
		return rc;
	}

	read_lock(&global_rwlock);
	policy = find_policy_id(kdescr.policy_id);
	if (policy) {
		read_lock(&policy->rwlock);
		rc = policy->type;
		read_unlock(&policy->rwlock);
	}
	read_unlock(&global_rwlock);

	return rc;
}

static rbce_id_t
get_policy_byname(struct rbce_policy_descr *udescr)
{
	struct rbce_policy_descr kdescr;
	struct rbce_policy *policy;
	int rc = -EINVAL;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_policy_descr))) {
		return -EFAULT;
	}
	read_lock(&global_rwlock);
	policy = find_policy_name(kdescr.name);
	if (policy) {
		read_lock(&policy->rwlock);
		rc = getid(policy);
		read_unlock(&policy->rwlock);
	}
	read_unlock(&global_rwlock);
	return rc;
}

static rbce_id_t
create_class(struct rbce_class_descr *udescr)
{
	struct rbce_class_descr kdescr;
	struct rbce_policy         *policy;
	struct rbce_class          *newcls  = NULL;
	rbce_id_t                   classid;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_class_descr))) {
		return -EFAULT;
	}

	read_lock(&global_rwlock);
	policy = find_policy_id(kdescr.policy_id);
	if (policy == NULL) {
		read_unlock(&global_rwlock);
		classid = (rbce_id_t)(-EINVAL);
		goto out;
	}
	write_lock(&policy->rwlock);
	read_unlock(&global_rwlock);

	if (find_class_name(policy, kdescr.name)) {
		classid = (rbce_id_t)(-EINVAL);
		goto out_unlock;
	}

	newcls = kmalloc(sizeof(struct rbce_class), GFP_KERNEL);
	if (!newcls) {
		classid = (rbce_id_t)(-ENOMEM);
		goto out_unlock;
	}
	classid = getid(newcls);
	newcls->obj.id = classid;
	strncpy(newcls->obj.name, kdescr.name,RBCE_MAX_NAME_LEN);
	list_add_tail(&newcls->obj.link, &policy->classes);

	newcls->cpu_class = ckrm_alloc_cpu_class(newcls);
	newcls->mem_class = ckrm_alloc_mem_class(newcls);
	newcls->net_class = ckrm_alloc_net_class(newcls);
	newcls->io_class  = ckrm_alloc_io_class(newcls);

out_unlock:
	write_unlock(&policy->rwlock);
out:
	cprintk(3,("create_class classid %ld\n", classid));
	return classid;
}

static int
delete_class(struct rbce_delete_class_descr *udescr)
{
	struct rbce_delete_class_descr kdescr;
	struct rbce_class          *cls;
	struct rbce_rule          *rule;
	struct rbce_policy         *policy;
	int rc = 0;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_delete_class_descr))) {
		return -EFAULT;
	}

	read_lock(&global_rwlock);
	policy = find_policy_id(kdescr.policy_id);
	if (policy == NULL) {
		read_unlock(&global_rwlock);
		return -EINVAL;
	}
	write_lock(&policy->rwlock);

	if ((cls = find_class_id(policy, kdescr.class_id)) != NULL) {
		// Make sure that there are no rules ending in this class.
		list_for_each_entry(rule, &policy->rules, obj.link) {
			if (cls == rule->target_class) {
				rc = -EINVAL;
				goto out_unlock;
			}
		}
		list_del(&cls->obj.link);
		reclassify_tasks(cls);
		ckrm_free_cpu_class(cls->cpu_class);
		ckrm_free_mem_class(cls->mem_class);
		ckrm_free_net_class(cls->net_class);
		ckrm_free_io_class(cls->io_class);
	} else {
		rc = -EINVAL;
	}

out_unlock:
	write_unlock(&policy->rwlock);
	read_unlock(&global_rwlock);
	return rc;
}

static rbce_id_t
get_class_byname(struct rbce_class_descr *udescr)
{
	struct rbce_class_descr kdescr;
	struct rbce_policy         *policy;
	struct rbce_class          *cls;
	rbce_id_t                   classid = -EINVAL;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_class_descr))) {
		return (rbce_id_t)-EFAULT;
	}

	read_lock(&global_rwlock);
	policy = find_policy_id(kdescr.policy_id);
	if (policy == NULL) {
		read_unlock(&global_rwlock);
		return classid;	
	}
	read_lock(&policy->rwlock);
	read_unlock(&global_rwlock);

	if ((cls = find_class_name(policy, kdescr.name)) != NULL) {
		classid = getid(cls);
	}
	read_unlock(&policy->rwlock);
	
	return classid;
}

static rbce_id_t
create_rule(struct rbce_rule_descr *udescr)
{
	struct rbce_rule_term_descr *kterms = NULL;
	struct rbce_rule_descr   kdescr;
	struct rbce_rule            *newrule = NULL;
	struct rbce_rule_term       *terms = NULL;
	struct rbce_class           *targetcls;
	struct rbce_policy          *policy;
	int i;
	rbce_id_t                    ruleid;
	struct list_head *after = NULL;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_rule_descr))) {
		return (rbce_id_t)-EFAULT;
	}

	kterms = kmalloc(kdescr.num_terms *
			sizeof(struct rbce_rule_term_descr), GFP_KERNEL);
	if (!kterms) {
		return (rbce_id_t)-ENOMEM;
	}

	if (copy_from_user(kterms, kdescr.terms,
				sizeof(struct rbce_rule_term_descr) * kdescr.num_terms)) {
		kfree(kterms);
		return (rbce_id_t)-EFAULT;
	}

	terms  = kmalloc(kdescr.num_terms * sizeof(struct rbce_rule_term),
								GFP_KERNEL);
	if (!terms) {
		kfree(kterms);
		return (rbce_id_t)-ENOMEM;
	}

	read_lock(&global_rwlock);
	ruleid = (rbce_id_t)(-EINVAL);

	/* find policy and target class and verify all rules */
	if ((policy = find_policy_id(kdescr.policy_id)) == NULL ||
				(targetcls = (struct rbce_class*)
				 find_id_obj(&policy->classes, kdescr.class_id)) == NULL) {
		read_unlock(&global_rwlock);
		goto out_free;
	}
	write_lock(&policy->rwlock);
	read_unlock(&global_rwlock);

	for (i = 0; i < kdescr.num_terms; i++) {
		switch(kterms[i].op) {
		case RBCE_RULE_CMD_PATH:
		case RBCE_RULE_CMD:
			strcpy(terms[i].cmd, kterms[i].ruledata.cmd);
			break;
		case RBCE_RULE_REAL_UID:
		case RBCE_RULE_REAL_GID:
		case RBCE_RULE_EFFECTIVE_UID:
		case RBCE_RULE_EFFECTIVE_GID:
			terms[i].id = kterms[i].ruledata.id;
			break;
		case RBCE_RULE_APP_TAG:
			strcpy(terms[i].tag, kterms[i].ruledata.tag);
			break;
		case RBCE_RULE_DEP_RULE:
			terms[i].deprule = find_rule_id(policy, kterms[i].ruledata.dep_rule);
			if (i != 0 || terms[i].deprule == NULL) {
				//dependent rule must be the first term and must exist
				goto out_unlock;
			}
			break;
		default:
			goto out_unlock;
		}
		terms[i].op = kterms[i].op;
	}

	newrule = kmalloc(sizeof(struct rbce_rule), GFP_KERNEL);
	if (!newrule) {
		ruleid = (rbce_id_t)-ENOMEM;
		goto out_unlock;
	}

	ruleid = getid(newrule);
	newrule->obj.id = ruleid;
	strcpy(newrule->obj.name, kdescr.name);
	newrule->target_class = targetcls;
	newrule->num_terms = kdescr.num_terms;
	newrule->terms = terms;
	switch(kdescr.insert_after) {
		case 0:
			// Add at the head.
			list_add(&newrule->obj.link, &policy->rules);
			break;
		default:
			// Add after the specified rule.
			after = (struct list_head *)
					find_rule_id(policy, kdescr.insert_after);
			if (!after) {
				goto out_unlock;
			}
			list_add(&newrule->obj.link, after);
			break;
		case -1:
			// Add at the tail.
			list_add_tail(&newrule->obj.link, &policy->rules);

	}
	write_unlock(&policy->rwlock);
	kfree(kterms);
	goto out;

out_unlock:
	write_unlock(&policy->rwlock);
out_free:
	if (newrule)
		kfree(newrule);
	if (kterms)
		kfree(kterms);
	if (terms)
		kfree(terms);
out:
	cprintk(3,("create_rule ruleid %ld\n", ruleid));
	return ruleid;
}

static rbce_id_t
change_rule(struct rbce_rule_descr *udescr)
{
	struct rbce_rule_term_descr *kterms = NULL;
	struct rbce_rule_descr   kdescr;
	struct rbce_rule            *rule;
	struct rbce_rule_term       *terms = NULL;
	struct rbce_class           *targetcls;
	struct rbce_policy          *policy;
	int i;
	rbce_id_t                    ruleid;
	struct list_head *after = NULL;

	kterms = kmalloc(kdescr.num_terms *
			sizeof(struct rbce_rule_term_descr), GFP_KERNEL);
	if (!kterms) {
		return (rbce_id_t)-ENOMEM;
	}

	if (copy_from_user(&kterms, kdescr.terms,
				sizeof(struct rbce_rule_term_descr) * kdescr.num_terms)) {
		kfree(kterms);
		return (rbce_id_t)-EFAULT;
	}

	terms = kmalloc(kdescr.num_terms * sizeof(struct rbce_rule_term),
								GFP_KERNEL);
	if (!terms) {
		kfree(kterms);
		return (rbce_id_t)-ENOMEM;
	}

	ruleid = (rbce_id_t)(-EINVAL);

	/* find policy and target class and verify all rules */
	read_lock(&global_rwlock);
	if ((policy = find_policy_id(kdescr.policy_id)) == NULL ||
				(targetcls = (struct rbce_class*)
				 find_id_obj(&policy->classes, kdescr.class_id)) == NULL  ||
			(rule = find_rule_id(policy, kdescr.rule_id)) == NULL) {
		read_unlock(&global_rwlock);
		goto out_free;
	}
	write_lock(&policy->rwlock);
	read_unlock(&global_rwlock);

	for (i = 0; i < kdescr.num_terms; i++) {
		switch(kterms[i].op) {
		case RBCE_RULE_CMD_PATH:
		case RBCE_RULE_CMD:
			strcpy(terms[i].cmd, kterms[i].ruledata.cmd);
			break;
		case RBCE_RULE_REAL_UID:
		case RBCE_RULE_REAL_GID:
		case RBCE_RULE_EFFECTIVE_UID:
		case RBCE_RULE_EFFECTIVE_GID:
			terms[i].id = kterms[i].ruledata.id;
			break;
		case RBCE_RULE_APP_TAG:
			strcpy(terms[i].tag, kterms[i].ruledata.tag);
			break;
		case RBCE_RULE_DEP_RULE:
			terms[i].deprule = find_rule_id(policy, kterms[i].ruledata.dep_rule);
			if (i != 0 || terms[i].deprule == NULL) {
				// dependent rule must be the first term
				// that rule must exist
				goto out_unlock;
			}
			break;
		default:
			goto out_unlock;
		}
		terms[i].op = kterms[i].op;
	}

	// Free the old terms.
	list_del(&rule->obj.link);
	kfree(rule->terms);

	switch(kdescr.insert_after) {
		case 0:
			// Add at the head.
			list_add(&rule->obj.link, &policy->rules);
			break;
		default:
			// Add after the specified rule.
			after = (struct list_head *)
					find_rule_id(policy, kdescr.insert_after);
			if (!after) {
				// XXX need to put back the original rule in this case.
				goto out_unlock;
			}
			list_add(&rule->obj.link, after);
			break;
		case -1:
			// Add at the tail.
			list_add_tail(&rule->obj.link, &policy->rules);

	}
	ruleid = getid(rule);
	rule->obj.id = ruleid;
	rule->target_class = targetcls;
	rule->num_terms = kdescr.num_terms;
	rule->terms = terms;
	write_unlock(&policy->rwlock);
	kfree(kterms);
	goto out;

out_unlock:
	write_unlock(&policy->rwlock);
out_free:
	kfree(kterms);
	kfree(terms);
out:
	return ruleid;
}

static rbce_id_t
delete_rule(struct rbce_delete_rule_descr *udescr)
{
	struct rbce_delete_rule_descr   kdescr;
	struct rbce_policy          *policy;
	struct rbce_rule            *rule;

	if (copy_from_user(&kdescr, udescr,
				sizeof(struct rbce_delete_rule_descr))) {
		return (rbce_id_t)-EFAULT;
	}

	read_lock(&global_rwlock);
	if ((policy = find_policy_id(kdescr.policy_id)) == NULL ||
			(rule = find_rule_id(policy, kdescr.rule_id)) == NULL) {
		read_unlock(&global_rwlock);
		return (rbce_id_t)-EINVAL;
	}
	write_lock(&policy->rwlock);
	read_unlock(&global_rwlock);
	list_del(&rule->obj.link);
	write_unlock(&policy->rwlock);
	kfree(rule->terms);
	kfree(rule);
	return 0;
}

static rbce_id_t
get_rule_bytype(struct rbce_rule_descr *udescr, int type_info)
{
	struct rbce_rule_descr   kdescr;
	struct rbce_rule            *rule = NULL;
	struct rbce_rule_term       *terms = NULL;
	struct rbce_policy          *policy;
	int num_terms;
	rbce_id_t                    ruleid;

	if (copy_from_user(&kdescr, udescr, sizeof(struct rbce_rule_descr))) {
		return (rbce_id_t)-EFAULT;
	}

	if (kdescr.policy_id <= 0) {
		return (rbce_id_t)-EINVAL;
	}

	read_lock(&global_rwlock);
	ruleid = (rbce_id_t)(-EINVAL);

	if ((policy = find_policy_id(kdescr.policy_id)) == NULL) {
		read_unlock(&global_rwlock);
		return ruleid;
	}

	switch (type_info) {
	case RBCE_RULE_NAME:
		rule = find_rule_name(policy, kdescr.name);
		break;
	case RBCE_RULE_ID:
		rule = find_rule_id(policy, kdescr.rule_id);
		break;
	default:
		read_unlock(&global_rwlock);
		return ruleid;
	}

	read_lock(&policy->rwlock);
	read_unlock(&global_rwlock);

	kdescr.rule_id = ruleid = getid(rule);
	kdescr.class_id = getid(rule->target_class);
	num_terms = rule->num_terms;
	if (kdescr.num_terms >= num_terms) {
		terms = kmalloc(num_terms * sizeof(struct rbce_rule_term),
GFP_KERNEL);
		if (terms == NULL) {
			ruleid = -ENOMEM;
			read_unlock(&policy->rwlock);
		} else {
			memcpy(terms, rule->terms, num_terms *
					sizeof(struct rbce_rule_term));
			read_unlock(&policy->rwlock);
			if (copy_to_user(kdescr.terms, terms, num_terms *
					sizeof(struct rbce_rule_term))) {
				ruleid = -EFAULT;	
				kdescr.terms = NULL;
			}
			kfree(terms);
		}
	} else {
		read_unlock(&policy->rwlock);
	}
	kdescr.num_terms = num_terms;
	kdescr.insert_after = 0;
	return ruleid;
}

static void
reclassify_all_tasks(struct rbce_class *cls)
{
	struct task_struct *proc, *thread;

	// Could call rbce_classify() without holding the following locks, but
	// grabbing the locks at this level will reduce the number of
	// lock/unlocks of global_rwlock and cur_policy->rwlock.
	read_lock(&global_rwlock);
	read_lock(&cur_policy->rwlock); 

	read_lock(&tasklist_lock);
	do_each_thread(proc, thread) {
		/* todo:  need to descriminate based on <cls> */
		rbce_classify_l(thread);
	} while_each_thread(proc, thread);
	read_unlock(&tasklist_lock);

	read_unlock(&cur_policy->rwlock);
	read_unlock(&global_rwlock);
	return;
}

static int
get_my_class(struct rbce_my_info_descr * udescr)
{
#if 0
	char c_name[RBCE_MAX_NAME_LEN];
	char p_name[RBCE_MAX_NAME_LEN];

	// To avoid copying to user land while holding the locks, copy
	// the contents to local variables first.
	read_lock(&global_rwlock);
	read_lock(&cur_policy->rwlock); 
	strcpy(c_name, current->class->obj.name);
	strcpy(p_name, cur_policy->obj.name);
	read_unlock(&cur_policy->rwlock);
	read_unlock(&global_rwlock);

	if (copy_to_user(udescr->class_name, c_name, RBCE_MAX_NAME_LEN-1)) {
		return -EFAULT;
	}
	if (copy_to_user(udescr->policy_name, p_name, RBCE_MAX_NAME_LEN-1)) {
		return -EFAULT;
	}
#endif
	return 0;
}

rbce_id_t
rbce_ctl(rbce_op_t op, void *data)
{
	char utag[RBCE_MAX_TAG_LEN];

	switch (op) {
	case RBCE_CREATE_POLICY:
		return create_policy((struct rbce_policy_descr*) data);

	case RBCE_COMMIT_POLICY:
		return commit_policy((struct rbce_policy_descr*) data);

	case RBCE_DECOMMIT_POLICY:
		return decommit_policy((struct rbce_policy_descr*) data);

	case RBCE_DELETE_POLICY:
		return delete_policy((struct rbce_policy_descr *) data);

	case RBCE_SET_POLICY_TYPE:
		return set_policy_type((struct rbce_policy_descr *) data);

	case RBCE_GET_POLICY_TYPE:
		return get_policy_type((struct rbce_policy_descr *) data);

	case RBCE_GET_POLICY_BYNAME:
		return get_policy_byname((struct rbce_policy_descr *) data);

	case RBCE_CREATE_CLASS:
		return create_class((struct rbce_class_descr*) data);

	case RBCE_DELETE_CLASS:
		return delete_class((struct rbce_delete_class_descr*) data);

	case RBCE_GET_CLASS_BYNAME:
		return get_class_byname((struct rbce_class_descr*) data);

	case RBCE_SET_CLASS_SHARES:
	case RBCE_GET_CLASS_SHARES:
	case RBCE_GET_RESOURCE_USAGE: 
	case RBCE_GET_CUM_RESOURCE_USAGE: 
		return -ENOSYS;

	case RBCE_CREATE_RULE:
		return create_rule((struct rbce_rule_descr*) data);

	case RBCE_DELETE_RULE:
		return delete_rule((struct rbce_delete_rule_descr*) data);

	case RBCE_CHANGE_RULE:
		return change_rule((struct rbce_rule_descr*) data);

	case RBCE_GET_RULE_BYNAME:
		return get_rule_bytype((struct rbce_rule_descr*) data,
RBCE_RULE_NAME);

	case RBCE_GET_RULE_BYID:
		return get_rule_bytype((struct rbce_rule_descr*) data, RBCE_RULE_ID);

	case RBCE_RECLASSIFY_ALL_TASKS:
		reclassify_all_tasks(NULL);
		return 0;

	case RBCE_GET_MY_INFO:
		return get_my_class((struct rbce_my_info_descr *) data);

	case RBCE_SET_TAG:
		if (copy_from_user(current->ckrm_client_data, utag,
RBCE_MAX_TAG_LEN-1)) 
			return -EFAULT;
		rbce_classify(current);
		return 0;

	case RBCE_GET_TAG:
		if (copy_from_user(utag, current->ckrm_client_data,
RBCE_MAX_TAG_LEN-1)) 
			return -EFAULT;
		return 0;

	default:
		return -EINVAL;
	}
}

static void 
rbce_set_task_classes(struct task_struct *tsk, struct rbce_class *cls)
{
	cprintk(1,("__classify %d<%s> -> <%s>\n",
		tsk->pid, tsk->comm, cls->obj.name));

	/* Don't set directly
	  
	tsk->cpu_class = cls->cpu_class;
	tsk->mem_class = cls->cpu_class;
	tsk->net_class = cls->net_class;
	tsk->io_class  = cls->io_class;

	*/

	ckrm_cpu_change_class(tsk, cls->cpu_class);
	ckrm_mem_change_class(tsk, cls->mem_class);
	ckrm_io_change_class(tsk, cls->io_class);
	ckrm_net_change_class(tsk, cls->net_class);

}


/*====================== Start Classification Engine
=======================*/

static int
match_cmd(char *tsk_comm, char *cmd_exp, int fullpath)
{
	char *c, *t, *last_ast, next_c;
	char tsk_command[128];

	/* first we need to retrieve the full name of the tsk */
	if (fullpath) {
		strncpy(tsk_command, tsk_comm, 16);
		tsk_command[16] = '\0';
	} else {
		// Make sure there is no '/' in the command expression.
		c = cmd_exp;	
		while(*c && *c != '/') c++;
		if (*c) {
			return 0;
		}

		// Get only the command name from tsk_comm.
		c = strrchr (tsk_comm, '/');
		if (c != NULL) {
			strcpy(tsk_command, c+1);
		} else {
			strcpy(tsk_command, tsk_comm);
		}
	}
	cprintk(4,("tsk_command |%s| tsk_comm |%s| cmd_exp |%s|\n",
			tsk_command, tsk_comm, cmd_exp));

	/* now faithfully assume the entire pathname of the file is in
tsk_command */

	/* we now have to effectively implement a regular expression 
	 * for now assume 
	 *    '?'   any single character 
	 *    '*'   one or more '?'
	 *    rest  must match
	 */

	c        = cmd_exp;
	t        = tsk_command;
	last_ast = NULL;
	next_c = '\0';

	while (*c && *t) {
		switch (*c) {
		case '?':
			if (*t == '/') {
				return 0;
			}
			c++; t++;
			continue;
		case '*':
			if (*t == '/') {
				return 0;
			}
			// eat up all '*' in c
			while (*(c+1) == '*') c++;	
			next_c = '\0';
			last_ast = c;
			//t++; // Add this for matching '*' with "one" or more chars.
			while (*t && (*t != *(c+1)) && *t != '/') t++;
			if (*t == *(c+1)) {
				c++; 
				if (*c != '/') {
					if (*c == '?') {
						if (*t == '/') {
							return 0;
						}
						t++; c++;
					}
					next_c = *c;
					if (*c) {
						if (*t == '/') {
							return 0;
						}
						t++; c++;
						if (!*c && *t)
							c = last_ast;	
					}
				} else {
					last_ast = NULL;
				}
				continue;
			}
			return 0;
		case '/':
			next_c = '\0';
			/*FALLTHRU*/
		default:
			if (*t == *c && next_c != *t) {
				c++, t++; 
				continue;
			} else {
				/* reset to last asterix and continue from there */
				if (last_ast) {
					c = last_ast;
				} else {
					return 0;
				}
			}
		}			       
	}

	/* check for trailing "*" */
	while (*c == '*') c++;

	return (!*c && !*t);
}

static int
evaluate_rule(struct task_struct *tsk,struct rbce_rule *rule)
{
	struct rbce_rule_term *term;
	char *task_cmd;
	int i;
	int rc = 1;

	/* we count down to anticipate deprules to listed first */

	// XXX Full command name is between mm->arg_start & mm->arg_end.
	// for now use tsk->comm
	task_cmd = tsk->comm;

	for (i = rule->num_terms-1, term = &rule->terms[i];
					(rc == 1) && (i >= 0); i--, term-- ) {

		switch(term->op) {

		case RBCE_RULE_CMD_PATH:
			rc &= match_cmd(task_cmd, term->cmd, 1);
			break;
		case RBCE_RULE_CMD:
			rc &= match_cmd(task_cmd, term->cmd, 0);
			break;
		case RBCE_RULE_REAL_UID:
			rc &= (tsk->uid == term->id);
			break;
		case RBCE_RULE_REAL_GID:
			rc &= (tsk->gid == term->id);
			break;
		case RBCE_RULE_EFFECTIVE_UID:
			rc &= (tsk->euid == term->id);
			break;
		case RBCE_RULE_EFFECTIVE_GID:
			rc &= (tsk->egid == term->id);
			break;
		case RBCE_RULE_APP_TAG:
			rc &= !strcmp(tsk->ckrm_client_data, term->tag);
			break;
		case RBCE_RULE_DEP_RULE:
			rc &= evaluate_rule(tsk, term->deprule);
			break;
		}
	}
	return rc;
}

/*
 * global lock(in read or write mode) and cur_policy's lock(write mode)
 * must be held while calling this function.
 */
static void
rbce_classify_l(struct task_struct *tsk)
{
	struct rbce_class *cls = NULL;

	struct rbce_rule *rule;

	list_for_each_entry(rule, &cur_policy->rules, obj.link) {
		if (evaluate_rule(tsk, rule) && rule->target_class) {
			cls =  rule->target_class;
			break;
		}
	}
	if (cls == NULL) 
		cls = cur_policy->def_class;
	rbce_set_task_classes(tsk,cls);
}

/*
 * Must be called with both global_lock and policy_lock(of the policy to
 * which the class belongs) held(in read or write mode).
 */
static void
reclassify_tasks(struct rbce_class *cls)
{
	reclassify_all_tasks(cls);
}

/*
 * Called from the kernel routines from the following system calls:
 * 		execve()
 * 		setuid(), setgid() and family
 * 		set_my_tag()
 */
void
rbce_classify(struct task_struct *tsk)
{
	cprintk(3,("enter rbce_classify\n"));
	read_lock(&global_rwlock);
	read_lock(&cur_policy->rwlock); 

	rbce_classify_l(tsk);

	read_unlock(&cur_policy->rwlock);
	read_unlock(&global_rwlock);
	cprintk(3,("exit rbce_classify\n"));
	return;
}

/*
 * Called from the kernel routines from the following system calls:
 * 		fork(), after copy_process()
 */
void
rbce_fork_task(struct task_struct *tsk)
{
	cprintk(2,("fork task %d\n",tsk->pid));

	// memset(current->tag, 0, RBCE_MAX_TAG_LEN); // tag not inherited.
	rbce_classify(tsk);
	return;
}

/*
 * To be called from exit()
 */
void
rbce_exit_task(struct task_struct *tsk)
{
	cprintk(2,("Exit task %d\n",tsk->pid));

#if 0
	read_lock(&global_rwlock);
	read_lock(&cur_policy->rwlock); 

	spin_lock(&tsk->class->lock);
	list_del(&tsk->rbce_link);
	spin_unlock(&tsk->class->lock);

	read_unlock(&cur_policy->rwlock);
	read_unlock(&global_rwlock);
#endif
	return;
}

void
rbce_exec_task(struct task_struct *tsk, char *filename)
{

	cprintk(2,("Exec task %d<%s><%s>\n",tsk->pid,tsk->comm,filename));

	// memset(current->tag, 0, RBCE_MAX_TAG_LEN); // tag not inherited.
	rbce_classify(tsk);
	return;
}

void 
rbce_id_change(void) 
{ 
	struct task_struct *tsk = current;
	cprintk(2,("ID change pid=%d\n",tsk->pid));

	rbce_classify(current);
	return;
}

/*================ calback testing only ==================*/
void 
rbce_useradd(struct user_struct *up)
{
	cprintk(2,("useradd\n"));
}

void 
rbce_userdel(struct user_struct *up)
{
	cprintk(2,("userdel\n"));
}

/*====================== end classification engine
=======================*/

struct ckrm_callbacks call_table = {
	.fork    = rbce_fork_task,
	.exec 	 = rbce_exec_task,
	.exit    = rbce_exit_task,
	.id      = rbce_id_change,
	.useradd = rbce_useradd,
	.userdel = rbce_useradd,
};

/* ===================== initialization ==========================*/

static int rbce_open(struct inode *inode, struct file *filp)
{
	if (! try_module_get(THIS_MODULE)) {
		cprintk(1,("rbce_open failed\n"));
		return -EFAULT;
	}

	cprintk(1,("rbce_open() by <%s>\n",current->comm));
	return 0;
}

static int rbce_release(struct inode *inode, struct file *filp)
{
	cprintk(1,("rbce_close() by <%s>\n",current->comm));
	module_put(THIS_MODULE);
        return 0;
}


static int rbce_ioctl( struct inode *inode, struct file *file,
		       unsigned int ioctl_num, unsigned long ioctl_param)
{
	cprintk(1,("rbc_ioctl %d\n",ioctl_num));
	return rbce_ctl ( ioctl_num, (void*)ioctl_param );
}


static struct file_operations rbce_fops = {
	owner:		THIS_MODULE,
	ioctl:		rbce_ioctl,		
	open:           rbce_open,
	release:        rbce_release,
};

/* ===================== initialization ==========================*/


int init_rbce ( void )
{
	int rc;

        printk( "<1>\nInstalling \'%s\' module\n", modname );
	if ((rc = register_chrdev( rbce_major, modname, &rbce_fops )) != 0) {
		printk("can't register device\n");
		return rc;
	}
	default_policy.def_class = &default_class;

	default_class.cpu_class = ckrm_dflt_cpu_class(&default_class);
	default_class.mem_class = ckrm_dflt_mem_class(&default_class);
	default_class.net_class = ckrm_dflt_net_class(&default_class);
	default_class.io_class  = ckrm_dflt_io_class(&default_class);
	
	ckrm_register_engine(&call_table);
	return 0;
}


void exit_rbce ( void )
{
        printk( "<1>Removing \'%s\' module\n", modname );
	ckrm_unregister_engine();
	unregister_chrdev( rbce_major, modname );
}


/* ===================== System call interfaces
==========================*/

module_init(init_rbce);
module_exit(exit_rbce);







