Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbVGHWSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVGHWSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVGHWP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:15:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:61345 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262926AbVGHWNJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:13:09 -0400
Date: Fri, 8 Jul 2005 17:12:24 -0500
From: serue@us.ibm.com
To: serue@us.ibm.com
Cc: Tony Jones <tonyj@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050708221224.GA30733@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <20050704031820.GA6871@immunix.com> <20050708214329.GA30671@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708214329.GA30671@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting serue@us.ibm.com (serue@us.ibm.com):
> Quoting Tony Jones (tonyj@suse.de):
> Attached is a patch to re-introduce the necessary locking to allow
> unloading of LSMs.  I don't have any performance results nor hardcore
> stability tests yet.

And here is a patch on top of that to use securityfs.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 stacker.c |  169 +++++++++++++++++++-------------------------------------------
 1 files changed, 53 insertions(+), 116 deletions(-)

Index: linux-2.6.12/security/stacker.c
===================================================================
--- linux-2.6.12.orig/security/stacker.c	2005-07-08 16:21:54.000000000 -0500
+++ linux-2.6.12/security/stacker.c	2005-07-08 21:51:08.000000000 -0500
@@ -41,8 +41,6 @@ struct module_entry {
 };
 static struct list_head stacked_modules;  /* list of stacked modules */
 
-static short sysfsfiles_registered;
-
 /*
  * when !modules_registered, the default_module, defined
  * below, will be stacked
@@ -104,7 +102,7 @@ static void free_mod_fromrcu(struct rcu_
 static void stacker_del_module(struct rcu_head *head)
 {
 	struct module_entry *m;
-	
+
 	m = container_of(head, struct module_entry, m_rcu);
 	if (atomic_dec_and_test(&m->use))
 		stacker_free_module(m);
@@ -1430,155 +1428,95 @@ static struct security_operations stacke
 #endif
 };
 
-
-/*
- * Functions to provide the sysfs interface
- */
-
-/* A structure to pass into sysfs through kobjects */
-struct stacker_kobj {
-	struct list_head		slot_list;
-	struct kobject			kobj;
-};
-
-struct stacker_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct stacker_kobj *, char *);
-	ssize_t (*store)(struct stacker_kobj *, const char *, size_t);
-};
-
-/* variables to hold kobject/sysfs data */
-static struct subsystem stacker_subsys;
-
-static void unregister_sysfs_files(void);
-
-static ssize_t stacker_attr_store(struct kobject *kobj,
-		struct attribute *attr, const char *buf, size_t len)
-{
-	struct stacker_kobj *obj = container_of(kobj,
-			struct stacker_kobj, kobj);
-	struct stacker_attribute *attribute = container_of(attr,
-			struct stacker_attribute, attr);
-
-	return attribute->store ? attribute->store(obj, buf, len) : 0;
-}
-
-static ssize_t stacker_attr_show(struct kobject *kobj,
-		struct attribute *attr, char *buf)
+static u64 stacker_u8_get(void *data)
 {
-	struct stacker_kobj *obj = container_of(kobj,
-			struct stacker_kobj, kobj);
-	struct stacker_attribute *attribute = container_of(attr,
-			struct stacker_attribute, attr);
-
-	return attribute->show ? attribute->show(obj, buf) : 0;
+	return *(u8 *)data;
 }
 
-static struct sysfs_ops stacker_sysfs_ops = {
-	.show = stacker_attr_show,
-	.store = stacker_attr_store,
-};
-
-static struct kobj_type stacker_ktype = {
-	.sysfs_ops = &stacker_sysfs_ops
-};
-
-static decl_subsys(stacker, &stacker_ktype, NULL);
-
 /* Set lockdown */
-static ssize_t lockdown_read (struct stacker_kobj *obj, char *buff)
-{
-	return sprintf(buff, "%d", forbid_stacker_register);
-}
-
-static ssize_t lockdown_write (struct stacker_kobj *obj, const char *buff, size_t count)
+static void lockdown_write(void *data, u64 val)
 {
-	if (count>0)
-		forbid_stacker_register = 1;
-
-	return count;
+	forbid_stacker_register = 1;
 }
 
-static struct stacker_attribute stacker_attr_lockdown = {
-	.attr = {.name = "lockdown", .mode = S_IFREG | S_IRUGO | S_IWUSR},
-	.show = lockdown_read,
-	.store = lockdown_write
-};
+DEFINE_SIMPLE_ATTRIBUTE(lockdown_fops, stacker_u8_get, lockdown_write, "%llu\n");
 
 /* list modules */
-static ssize_t listmodules_read (struct stacker_kobj *obj, char *buff)
+static ssize_t listmodules_read ( struct file *filp, char __user *user_buf,
+				       size_t count, loff_t *ppos)
 {
 	ssize_t len = 0;
 	struct module_entry *m;
+	char *page;
+
+	page = (char *)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
 
 	rcu_read_lock();
 	stack_for_each_entry(m, &stacked_modules, lsm_list) {
-		len += snprintf(buff+len, PAGE_SIZE - len, "%s\n",
+		len += snprintf(page+len, PAGE_SIZE - len, "%s\n",
 			m->module_name);
 	}
 	rcu_read_unlock();
 
+	if (len >= 0)
+		len = simple_read_from_buffer(user_buf, count, ppos, page, len);
+	free_page((unsigned long)page);
+
 	return len;
 }
 
-static struct stacker_attribute stacker_attr_listmodules = {
-	.attr = {.name = "list_modules", .mode = S_IFREG | S_IRUGO | S_IWUSR},
-	.show = listmodules_read,
+static struct file_operations listmodules_fops = {
+	.read =		listmodules_read,
 };
 
+static void unregister_stacker_files(void);
+
 /* stop responding to sysfs */
-static ssize_t stop_responding_write (struct stacker_kobj *obj,
-					const char *buff, size_t count)
+static void stop_responding_write(void *data, u64 val)
 {
-	if (count>0)
-		unregister_sysfs_files();
-	return count;
+	unregister_stacker_files();
 }
 
-static struct stacker_attribute stacker_attr_stop_responding = {
-	.attr = {.name = "stop_responding", .mode = S_IFREG | S_IRUGO | S_IWUSR},
-	.store = stop_responding_write
-};
-
-static void unregister_sysfs_files(void)
-{
-	struct kobject *kobj;
+DEFINE_SIMPLE_ATTRIBUTE(stopresp_fops, NULL, stop_responding_write, "%llu\n");
 
-	if (!sysfsfiles_registered)
-		return;
+struct dentry   * stacker_dir_ino,
+		* lockdown_ino,
+		* listmodules_ino,
+		* stopresp_ino,
+		* modunload_ino;
 
-	kobj = &stacker_subsys.kset.kobj;
-	sysfs_remove_file(kobj, &stacker_attr_lockdown.attr);
-	sysfs_remove_file(kobj, &stacker_attr_listmodules.attr);
-	sysfs_remove_file(kobj, &stacker_attr_stop_responding.attr);
-
-	sysfsfiles_registered = 0;
+static void unregister_stacker_files(void)
+{
+	securityfs_remove(stacker_dir_ino);
+	securityfs_remove(lockdown_ino);
+	securityfs_remove(listmodules_ino);
+	securityfs_remove(stopresp_ino);
 }
 
-static int register_sysfs_files(void)
+static int register_stacker_files(void)
 {
-	int result;
+	stacker_dir_ino = securityfs_create_dir("stacker", NULL);
+	if (!stacker_dir_ino)
+		return -EFAULT;
 
-	result = subsystem_register(&stacker_subsys);
-	if (result) {
-		printk(KERN_WARNING
-			"Error (%d) registering stacker sysfs subsystem\n",
-			result);
-		return result;
-	}
+	lockdown_ino = securityfs_create_file("lockdown", S_IRUGO | S_IWUSR,
+			stacker_dir_ino, &forbid_stacker_register,
+			&lockdown_fops);
+	listmodules_ino = securityfs_create_file("listmodules", S_IRUGO,
+			stacker_dir_ino, NULL, &listmodules_fops);
+	stopresp_ino = securityfs_create_file("stop_responding", S_IWUSR,
+			stacker_dir_ino, NULL, &stopresp_fops);
 
-	sysfs_create_file(&stacker_subsys.kset.kobj,
-			&stacker_attr_lockdown.attr);
-	sysfs_create_file(&stacker_subsys.kset.kobj,
-			&stacker_attr_listmodules.attr);
-	sysfs_create_file(&stacker_subsys.kset.kobj,
-			&stacker_attr_stop_responding.attr);
-	sysfsfiles_registered = 1;
-	stacker_dbg("sysfs files registered\n");
+	if (!lockdown_ino || !listmodules_ino || !stopresp_ino) {
+		unregister_stacker_files();
+		return -EFAULT;
+	}
 	return 0;
 }
 
-module_init(register_sysfs_files);
+module_init(register_stacker_files);
 
 extern struct security_operations dummy_security_ops;
 #define DEFAULT_MODULE_NAME "dummy"
@@ -1586,7 +1524,6 @@ extern struct security_operations dummy_
 static int __init stacker_init (void)
 {
 	forbid_stacker_register = 0;
-	sysfsfiles_registered = 0;
 
 	INIT_LIST_HEAD(&stacked_modules);
 	spin_lock_init(&stacker_lock);
@@ -1620,7 +1557,7 @@ static void __exit stacker_exit (void)
 	 * Should probably force all child modules to exit somehow...
 	 */
 
-	unregister_sysfs_files();
+	unregister_stacker_files();
 	if (unregister_security (&stacker_ops))
 		printk(KERN_WARNING "Error unregistering LSM stacker.\n");
 	else
