Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbVGNOWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbVGNOWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 10:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVGNOWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 10:22:17 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:17642 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263033AbVGNOVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 10:21:31 -0400
Date: Thu, 14 Jul 2005 09:21:07 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "David A. Wheeler" <dwheeler@ida.org>, Tony Jones <tonyj@immunix.com>
Subject: rcu-refcount stacker performance
Message-ID: <20050714142107.GA20984@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On July 8 I sent out a patch which re-implemented the rcu-refcounting
of the LSM list in stacker for the sake of supporting safe security
module unloading.  (patch reattached here for convenience)  Here are
some performance results with and without that patch.  Tests were run
on a 16-way ppc64 machine.  Dbench was run 50 times, and kernbench
and reaim were run 10 times, and intervals are 95% confidence half-
intervals.

These results seem pretty poor.  I'm now wondering whether this is
really necessary.  David Wheeler's original stacker had an option
of simply waiting a while after a module was taken out of the list
of active modules before freeing the modules.  Something like that
is of course one option.  I'm hoping we can also take advantage of
some already known module state info to be a little less coarse
about it.  For instance, sys_delete_module() sets m->state to
MODULE_STATE_GOING before calling mod->exit().  If in place of
doing atomic_inc(&m->use), stacker skipped the m->hook() if
m->state!=MODULE_STATE_LIVE, then it may be safe to assume that
any m->hook() should be finished before sys_delete_module() gets
to free_module(mod).  This seems to require adding a struct
module argument to security/security:mod_reg_security() so an LSM
can pass itself along.

So I'll try that next.  Hopefully by avoiding the potential cache
line bounces which atomic_inc(&m->use) bring, this should provide
far better performance.

thanks,
-serge

Dbench (throughput, larger is better)
--------------------------------------------
plain stacker:    1531.448400 +/- 15.791116
stacker with rcu: 1408.056200 +/- 12.597277

Kernbench (runtime, smaller is better)
--------------------------------------------
plain stacker:    52.341000  +/- 0.184995
stacker with rcu: 53.722000 +/- 0.161473

Reaim (numjobs, larger is better) (gnuplot-friendly format)
plain stacker:
----------------------------------------------------------
Numforked   jobs/minute         95% CI
1           106662.857000     5354.267865
3           301628.571000     6297.121934
5           488142.858000     16031.685536
7           673200.000000     23994.030784
9           852428.570000     31485.607271
11          961714.290000     0.000000
13          1108157.144000    27287.525982
15          1171178.571000    49790.796869

Reaim (numjobs, larger is better) (gnuplot-friendly format)
plain stacker:
----------------------------------------------------------
Numforked   jobs/minute         95% CI
1           100542.857000     2099.040645
3           266657.139000     6297.121934
5           398892.858000     12023.765252
7           467670.000000     14911.383385
9           418648.352000     11665.751441
11          396825.000000     8700.115252
13          357480.912000     7567.947838
15          337571.428000     2332.267703

Patch:

Index: linux-2.6.12/security/stacker.c
===================================================================
--- linux-2.6.12.orig/security/stacker.c	2005-07-08 13:43:15.000000000 -0500
+++ linux-2.6.12/security/stacker.c	2005-07-08 16:21:54.000000000 -0500
@@ -33,13 +33,13 @@
 
 struct module_entry {
 	struct list_head lsm_list;  /* list of active lsms */
-	struct list_head all_lsms; /* list of all lsms */
 	char *module_name;
 	int namelen;
 	struct security_operations module_operations;
+	struct rcu_head m_rcu;
+	atomic_t use;
 };
 static struct list_head stacked_modules;  /* list of stacked modules */
-static struct list_head all_modules;  /* list of all modules, including freed */
 
 static short sysfsfiles_registered;
 
@@ -84,6 +84,32 @@ MODULE_PARM_DESC(debug, "Debug enabled o
  * We return as soon as an error is returned.
  */
 
+static inline void stacker_free_module(struct module_entry *m)
+{
+	kfree(m->module_name);
+	kfree(m);
+}
+
+/*
+ * Version of stacker_free_module called from call_rcu
+ */
+static void free_mod_fromrcu(struct rcu_head *head)
+{
+	struct module_entry *m;
+
+	m = container_of(head, struct module_entry, m_rcu);
+	stacker_free_module(m);
+}
+
+static void stacker_del_module(struct rcu_head *head)
+{
+	struct module_entry *m;
+	
+	m = container_of(head, struct module_entry, m_rcu);
+	if (atomic_dec_and_test(&m->use))
+		stacker_free_module(m);
+}
+
 #define stack_for_each_entry(pos, head, member)				\
 	for (pos = list_entry((head)->next, typeof(*pos), member);	\
 		&pos->member != (head);					\
@@ -93,16 +119,27 @@ MODULE_PARM_DESC(debug, "Debug enabled o
 /* to make this safe for module deletion, we would need to
  * add a reference count to m as we had before
  */
+/*
+ * XXX We can't quite do this - we delete the module before we grab
+ * m->next?
+ * We could just do a call_rcu.  Then the call_rcu happens in same
+ * rcu cycle has dereference, so module won't be deleted until the
+ * next cycle.
+ * That's what I'm going to do.
+ */
 #define RETURN_ERROR_IF_ANY_ERROR(BASE_FUNC, FUNC_WITH_ARGS) do { \
 	int result = 0; \
 	struct module_entry *m; \
 	rcu_read_lock(); \
 	stack_for_each_entry(m, &stacked_modules, lsm_list) { \
-		if (!m->module_operations.BASE_FUNC) \
-			continue; \
-		rcu_read_unlock(); \
-		result = m->module_operations.FUNC_WITH_ARGS; \
-		rcu_read_lock(); \
+		if (m->module_operations.BASE_FUNC) { \
+			atomic_inc(&m->use); \
+			rcu_read_unlock(); \
+			result = m->module_operations.FUNC_WITH_ARGS; \
+			rcu_read_lock(); \
+			if (unlikely(atomic_dec_and_test(&m->use))) \
+				call_rcu(&m->m_rcu, free_mod_fromrcu); \
+		} \
 		if (result) \
 			break; \
 	} \
@@ -116,9 +153,12 @@ MODULE_PARM_DESC(debug, "Debug enabled o
 	rcu_read_lock(); \
 	stack_for_each_entry(m, &stacked_modules, lsm_list) { \
 		if (m->module_operations.BASE_FUNC) { \
+			atomic_inc(&m->use); \
 			rcu_read_unlock(); \
 			m->module_operations.FUNC_WITH_ARGS; \
 			rcu_read_lock(); \
+			if (unlikely(atomic_dec_and_test(&m->use))) \
+				call_rcu(&m->m_rcu, free_mod_fromrcu); \
 		} \
 	} \
 	rcu_read_unlock(); \
@@ -129,38 +169,47 @@ MODULE_PARM_DESC(debug, "Debug enabled o
 	rcu_read_lock(); \
 	stack_for_each_entry(m, &stacked_modules, lsm_list ) { \
 		if (m->module_operations.BASE_FREE) { \
+			atomic_inc(&m->use); \
 			rcu_read_unlock(); \
 			m->module_operations.FREE_WITH_ARGS; \
 			rcu_read_lock(); \
+			if (unlikely(atomic_dec_and_test(&m->use))) \
+				call_rcu(&m->m_rcu, free_mod_fromrcu); \
 		} \
 	} \
 	rcu_read_unlock(); \
 } while (0)
 
 #define ALLOC_SECURITY(BASE_FUNC,FUNC_WITH_ARGS,BASE_FREE,FREE_WITH_ARGS) do { \
-	int result; \
+	int result = 0; \
 	struct module_entry *m, *m2; \
 	rcu_read_lock(); \
 	stack_for_each_entry(m, &stacked_modules, lsm_list) { \
-		if (!m->module_operations.BASE_FUNC) \
-			continue; \
-		rcu_read_unlock(); \
-		result = m->module_operations.FUNC_WITH_ARGS; \
-		rcu_read_lock(); \
+		if (m->module_operations.BASE_FUNC) { \
+			atomic_inc(&m->use); \
+			rcu_read_unlock(); \
+			result = m->module_operations.FUNC_WITH_ARGS; \
+			rcu_read_lock(); \
+			if (unlikely(atomic_dec_and_test(&m->use))) \
+				call_rcu(&m->m_rcu, free_mod_fromrcu); \
+		} \
 		if (result) \
 			goto bad; \
 	} \
 	rcu_read_unlock(); \
 	return 0; \
 bad: \
-	stack_for_each_entry(m2, &all_modules, all_lsms) { \
+	stack_for_each_entry(m2, &stacked_modules, lsm_list) { \
 		if (m == m2) \
 			break; \
 		if (!m2->module_operations.BASE_FREE) \
 			continue; \
+		atomic_inc(&m2->use); \
 		rcu_read_unlock(); \
 		m2->module_operations.FREE_WITH_ARGS; \
 		rcu_read_lock(); \
+		if (unlikely(atomic_dec_and_test(&m2->use))) \
+			call_rcu(&m2->m_rcu, free_mod_fromrcu); \
 	} \
 	rcu_read_unlock(); \
 	return result; \
@@ -251,10 +300,16 @@ static int stacker_vm_enough_memory(long
 
 	rcu_read_lock();
 	stack_for_each_entry(m, &stacked_modules, lsm_list) {
-		if (!m->module_operations.vm_enough_memory)
+		if (!m->module_operations.vm_enough_memory) {
 			continue;
+		}
+		atomic_inc(&m->use);
 		rcu_read_unlock();
 		result = m->module_operations.vm_enough_memory(pages);
+		rcu_read_lock();
+		if (unlikely(atomic_dec_and_test(&m->use)))
+			stacker_free_module(m);
+		rcu_read_unlock();
 		return result;
 	}
 	rcu_read_unlock();
@@ -281,9 +336,12 @@ static int stacker_netlink_send (struct 
 		if (!m->module_operations.netlink_send)
 			continue;
 		NETLINK_CB(skb).eff_cap = ~0;
+		atomic_inc(&m->use);
 		rcu_read_unlock();
 		result = m->module_operations.netlink_send(sk, skb);
 		rcu_read_lock();
+		if (unlikely(atomic_dec_and_test(&m->use)))
+			call_rcu(&m->m_rcu, free_mod_fromrcu);
 		tmpcap &= NETLINK_CB(skb).eff_cap;
 		if (result)
 			break;
@@ -987,33 +1045,42 @@ stacker_getprocattr(struct task_struct *
 	stack_for_each_entry(m, &stacked_modules, lsm_list) {
 		if (!m->module_operations.getprocattr)
 			continue;
+		atomic_inc(&m->use);
 		rcu_read_unlock();
 		ret = m->module_operations.getprocattr(p, name,
 					value+len, size-len);
 		rcu_read_lock();
-		if (ret == -EINVAL)
-			continue;
-		found_noneinval = 1;
-		if (ret < 0) {
+		if (ret > 0) {
+			found_noneinval = 1;
+			len += ret;
+			if (len+m->namelen+4 < size) {
+				char *v = value;
+				if (v[len-1]=='\n')
+					len--;
+				len += sprintf(value+len, " (%s)\n",
+							m->module_name);
+			}
+		} else if (ret != -EINVAL) {
+			found_noneinval = 1;
 			memset(value, 0, len);
 			len = ret;
+		} else
+			ret = 0;
+
+		if (unlikely(atomic_dec_and_test(&m->use)))
+			call_rcu(&m->m_rcu, free_mod_fromrcu);
+
+		if (ret < 0)
 			break;
-		}
-		if (ret == 0)
-			continue;
-		len += ret;
-		if (len+m->namelen+4 < size) {
-			char *v = value;
-			if (v[len-1]=='\n')
-				len--;
-			len += sprintf(value+len, " (%s)\n", m->module_name);
-		}
 	}
 	rcu_read_unlock();
 
 	return found_noneinval ? len : -EINVAL;
 }
 
+/*
+ * find an lsm by name.  If found, increment its use count and return it
+ */
 static struct module_entry *
 find_active_lsm(const char *name, int len)
 {
@@ -1022,6 +1089,7 @@ find_active_lsm(const char *name, int le
 	rcu_read_lock();
 	stack_for_each_entry(m, &stacked_modules, lsm_list) {
 		if (m->namelen == len && !strncmp(m->module_name, name, len)) {
+			atomic_inc(&m->use);
 			ret = m;
 			break;
 		}
@@ -1043,6 +1111,7 @@ stacker_setprocattr(struct task_struct *
 	char *realv = (char *)value;
 	size_t dsize = size;
 	int loc = 0, end_data = size;
+	int ret, free_module = 0;
 
 	if (list_empty(&stacked_modules))
 		return -EINVAL;
@@ -1063,7 +1132,7 @@ stacker_setprocattr(struct task_struct *
 	callm = find_active_lsm(realv+loc+1, dsize-loc-1);
 	if (!callm)
 		goto call;
-
+	free_module = 1;
 
 	loc--;
 	while (loc && realv[loc]==' ')
@@ -1074,8 +1143,14 @@ call:
 	if (!callm || !callm->module_operations.setprocattr)
 		return -EINVAL;
 
-	return callm->module_operations.setprocattr(p, name, value, end_data) +
+	ret = callm->module_operations.setprocattr(p, name, value, end_data) +
 			(size-end_data);
+
+	if (free_module && atomic_dec_and_test(&callm->use))
+		stacker_free_module(callm);
+
+	return ret;
+
 }
 
 /*
@@ -1116,15 +1191,15 @@ static int stacker_register (const char 
 	new_module_entry->module_name = new_module_name;
 	new_module_entry->namelen = namelen;
 
+	atomic_set(&new_module_entry->use, 1);
+
 	INIT_LIST_HEAD(&new_module_entry->lsm_list);
-	INIT_LIST_HEAD(&new_module_entry->all_lsms);
 
 	rcu_read_lock();
 	if (!modules_registered) {
 		modules_registered++;
 		list_del_rcu(&default_module.lsm_list);
 	}
-	list_add_tail_rcu(&new_module_entry->all_lsms, &all_modules);
 	list_add_tail_rcu(&new_module_entry->lsm_list, &stacked_modules);
 	if (strcmp(name, "selinux") == 0)
 		selinux_module = new_module_entry;
@@ -1141,16 +1216,60 @@ out:
 }
 
 /*
- * Currently this version of stacker does not allow for module
- * unregistering.
- * Easy way to allow for this is using rcu ref counting like an older
- * version of stacker did.
- * Another way would be to force stacker_unregister to sleep between
- * removing the module from all_modules and free_modules and unloading it.
+ * find_lsm_module_by_name:
+ * Find a module by name.  Used by stacker_unregister.  Called with
+ * stacker spinlock held.
+ */
+static struct module_entry *
+find_lsm_with_namelen(const char *name, int len)
+{
+	struct module_entry *m, *ret = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(m, &stacked_modules, lsm_list) {
+		atomic_inc(&m->use);
+		rcu_read_unlock();
+		if (m->namelen == len && !strncmp(m->module_name, name, len))
+			ret = m;
+		rcu_read_lock();
+		if (unlikely(atomic_dec_and_test(&m->use)))
+			call_rcu(&m->m_rcu, free_mod_fromrcu);
+		if (ret)
+			break;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+/*
  */
 static int stacker_unregister (const char *name, struct security_operations *ops)
 {
-	return -EPERM;
+	struct module_entry *m;
+	int len = strnlen(name, MAX_MODULE_NAME_LEN);
+	int ret = 0;
+
+	spin_lock(&stacker_lock);
+	m = find_lsm_with_namelen(name, len);
+
+	if (!m) {
+		printk(KERN_INFO "%s: could not find module %s.\n",
+				__FUNCTION__, name);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	list_del_rcu(&m->lsm_list);
+
+	if (strcmp(m->module_name, "selinux") == 0)
+		selinux_module = NULL;
+	call_rcu(&m->m_rcu, stacker_del_module);
+
+out:
+	spin_unlock(&stacker_lock);
+
+	return ret;
 }
 
 static struct security_operations stacker_ops = {
@@ -1407,57 +1526,6 @@ static struct stacker_attribute stacker_
 	.show = listmodules_read,
 };
 
-/* respond to a request to unload a module */
-static ssize_t stacker_unload_write (struct stacker_kobj *obj, const char *name,
-					size_t count)
-{
-	struct module_entry *m;
-	int len = strnlen(name, MAX_MODULE_NAME_LEN);
-	int ret = count;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if (count <= 0)
-		return -EINVAL;
-
-	if (!modules_registered)
-		return -EINVAL;
-
-	spin_lock(&stacker_lock);
-	m = find_active_lsm(name, len);
-
-	if (!m) {
-		printk(KERN_INFO "%s: could not find module %s.\n",
-			__FUNCTION__, name);
-		ret = -ENOENT;
-		goto out;
-	}
-
-	if (strcmp(m->module_name, "selinux") == 0)
-		selinux_module = NULL;
-
-	rcu_read_lock();
-	list_del_rcu(&m->lsm_list);
-	if (list_empty(&stacked_modules)) {
-		INIT_LIST_HEAD(&default_module.lsm_list);
-		list_add_tail_rcu(&default_module.lsm_list, &stacked_modules);
-		modules_registered = 0;
-	}
-	rcu_read_unlock();
-
-out:
-	spin_unlock(&stacker_lock);
-
-	return ret;
-}
-
-static struct stacker_attribute stacker_attr_unload = {
-	.attr = {.name = "unload", .mode = S_IFREG | S_IRUGO | S_IWUSR},
-	.store = stacker_unload_write,
-};
-
-
 /* stop responding to sysfs */
 static ssize_t stop_responding_write (struct stacker_kobj *obj,
 					const char *buff, size_t count)
@@ -1483,7 +1551,6 @@ static void unregister_sysfs_files(void)
 	sysfs_remove_file(kobj, &stacker_attr_lockdown.attr);
 	sysfs_remove_file(kobj, &stacker_attr_listmodules.attr);
 	sysfs_remove_file(kobj, &stacker_attr_stop_responding.attr);
-	sysfs_remove_file(kobj, &stacker_attr_unload.attr);
 
 	sysfsfiles_registered = 0;
 }
@@ -1506,8 +1573,6 @@ static int register_sysfs_files(void)
 			&stacker_attr_listmodules.attr);
 	sysfs_create_file(&stacker_subsys.kset.kobj,
 			&stacker_attr_stop_responding.attr);
-	sysfs_create_file(&stacker_subsys.kset.kobj,
-			&stacker_attr_unload.attr);
 	sysfsfiles_registered = 1;
 	stacker_dbg("sysfs files registered\n");
 	return 0;
@@ -1524,13 +1589,13 @@ static int __init stacker_init (void)
 	sysfsfiles_registered = 0;
 
 	INIT_LIST_HEAD(&stacked_modules);
-	INIT_LIST_HEAD(&all_modules);
 	spin_lock_init(&stacker_lock);
 	default_module.module_name = DEFAULT_MODULE_NAME;
 	default_module.namelen = strlen(DEFAULT_MODULE_NAME);
 	memcpy(&default_module.module_operations, &dummy_security_ops,
 			sizeof(struct security_operations));
 	INIT_LIST_HEAD(&default_module.lsm_list);
+	atomic_set(&default_module.use, 1);
 	list_add_tail(&default_module.lsm_list, &stacked_modules);
 
 	if (register_security (&stacker_ops)) {
