Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVG0S2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVG0S2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVG0S0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:26:05 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:949 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262371AbVG0SYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:24:04 -0400
Date: Wed, 27 Jul 2005 13:24:28 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Emily Ratliff <emilyr@us.ibm.com>
Subject: [patch 6/15] lsm stacking v0.3: stacker documentation
Message-ID: <20050727182428.GG22483@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050727181921.GB22483@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727181921.GB22483@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about stacker and its usage.

Changelog:

	[Jul 26]: Update with information regarding safe LSM unloading,
		and added the stacker locking rationale.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
 LSM-stacker-locking.txt |   77 ++++++++++++++++++++++
 LSM-stacking.txt        |  166 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 243 insertions(+)

Index: linux-2.6.13-rc3/Documentation/LSM-stacking.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc3/Documentation/LSM-stacking.txt	2005-07-27 16:19:06.000000000 -0500
@@ -0,0 +1,166 @@
+------------
+LSM stacking
+------------
+
+This document consists of two parts.  The first describes the stacker LSM.
+The second describes what is needed from an LSM in order to permit it to
+stack with other LSMs.
+
+--------------------------------------------------------
+stacker LSM - enable stacking multiple security modules.
+--------------------------------------------------------
+
+Stacker is compiled into the kernel.  Find the "Stacker" option under
+the Security submenu, and say 'Y'.  Now, any security modules which are
+loaded or compiled into the kernel will be managed by stacker.
+
+You may interact with stacker through its securityfs interface, located
+under /sys/kernel/security/stacker/ (henceforth simply /security/stacker).
+This consists of the following files:
+
+/security/stacker/lockdown:
+Once you write to this file, you will no longer be able to load
+LSMs.
+
+/security/stacker/list_modules:
+Reading this file will show which LSMs are being stacked.
+
+/security/stacker/stop_responding:
+Unregisters the /security/stacker directory, so that you can no longer
+interact with stacker.
+
+/security/stacker/unload:
+Disables the specified module.  The module will actually still be
+loaded, but will no longer be asked to mediate accesses or update
+security information.  Stacker will release it's refcount on the
+module, so that after this you are able to rmmod the module.  By
+separating unload into these two steps, no cpu should be executing
+any of the module's hooks by the time you rmmod, so that the module
+can be safely freed.
+
+---------------------------------------------
+Readying an LSM for stacking with other LSMs.
+---------------------------------------------
+
+LSM stacking is not a simple matter.  You must consider the cumulative
+behavior of all stacked LSMs very carefully, as well as certain subtle
+effects of the LSM implementation.  Please do not try to stack arbitrary
+modules!  For instance, while SELinux and cap-stack should always be
+used together, SELinux cannot be combined with the original capability
+module.  The reason for this is that capability enforces that a process
+must have CAP_SYS_ADMIN when writing "security.*" extended attributes.
+However selinux requires that non-CAP_SYS_ADMIN processes be able to
+write security.selinux attributes, instead enforcing its own permission
+check.  More subtle interactions are certainly imaginable, such as a
+first security module updating state on a kernel object such that a
+second security module denies or allows the action when it otherwise
+would not have.
+
+If you have any questions about the proper or actual behavior of
+modules, whether existing or ones to be written by yourself, a good
+place to engage in discussion is the lsm mailing list,
+linux-security-module@wirex.com.  Information about the mailing list can
+be found at lsm.immunix.org.
+
+If your module will be annotating security information to kernel
+objects, then you must use the provided API.  The functions intended
+for use by modules are defined in include/linux/security.h.  A
+good example of a user of these functions is the SELinux module.  The
+following describes the API usage.
+
+Assume you wish to annotate an instance of the following struct to an
+inode:
+
+struct my_security_info {
+	int a;
+	struct list_head some_list;
+	spinlock_t lock;
+};
+
+At the top of the struct, you must add a struct security_list lsm_list,
+as follows:
+
+struct my_security_info {
++	struct security_list lsm_list;
+	int count;
+	struct list_head some_list;
+	spinlock_t lock;
+};
+
+This will add the information which the API will need to tell your
+information apart from that of other modules.  You also need to define a
+unique ID to distinguish information owned by your module.  Usually
+people "echo <module_name> | sha1sum" and use the first several digits.
+For instance, if
+#echo seclvl | sha1sum | awk --field-separator="" '{ print \
+$1$2$3$4$5$6$7$8 '}
+40e81e47
+
+then in your my_lsm.h, add
+#define MY_LSM_ID 0x40e81e47
+
+Do make sure that no other module happens to have the same ID.
+
+Now when the kernel object is created, you may use
+security_set_value_type() to append the struct to the object's list of
+security information.  Note that you may ONLY use this while the kernel
+object is being created, ie during the security_<KERNEL_OBJECT>_alloc
+function.  Since you are appending my_security_info to the inode, you
+will do so during the security_inode_alloc() hook.  For instance,
+
+static inline int my_inode_alloc(struct inode *inode)
+{
+	struct my_security_info *my_data;
+
+	my_data = kmalloc(sizeof(struct my_security_info), GFP_KERNEL);
+	if (!my_data)
+		return -ENOMEM;
+	init_inode_data(my_data);
+
+	security_set_value_type(&inode->i_security, MY_LSM_ID, my_data);
+}
+
+If you need to append your information after the kernel object has been
+created, you may do so using security_add_value_type() hook.  However,
+for both performance and security reasons, it is preferable to compile
+your module into the kernel and always append your info while the object
+is created.  See security/seclvl.c or the digsig stacking patch for
+examples of this usage.
+
+To get your information back, you may use security_get_value_type().
+For instance,
+
+static inline int my_inode_create(struct inode *dir,
+				  struct dentry *dentry,
+				  int mode)
+{
+	struct my_security_info *my_data;
+
+	my_data = security_get_value_type(&dir->i_security,
+			MY_LSM_ID, struct my_security_info);
+	if (!my_data || my_data->count)
+		return -EPERM;
+	return 0;
+}
+
+There are two ways of removing kernel object data for freeing.
+If you can wait until security_<object>_free(), ie security_inode_free,()
+then you may use
+
+	my_data = security_del_value_type(&dir->i_security,
+			MY_LSM_ID, struct my_security_info);
+	kfree(my_data);
+
+See security/selinux/hooks.c for example usage.
+
+If you must free the data before the object is freed, because your
+module is being unloaded, then you must use
+
+	security_unlink_value(&dir->i_security->lsm_list.list);
+
+and wait a full rcu cycle before freeing the data in order to
+ensure proper locking.  See security/seclvl.c and the digsig
+stacking patch for sample usage.  Both of these modules simply
+link together all the objects in one list_head chain, and, if
+unloaded, unlink each object from the object, wait a full rcu
+cycle, then walk the same chain again to free the objects.
Index: linux-2.6.13-rc3/Documentation/LSM-stacker-locking.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc3/Documentation/LSM-stacker-locking.txt	2005-07-27 16:59:45.000000000 -0500
@@ -0,0 +1,77 @@
+The following describes the locking used by the lsm stacker as of
+July 1, 2005:
+
+Things which require locking include:
+
+	1. module list
+	2. per-kernel-object security lists
+
+Clearly, the safety of the data being appended itself is up to
+the module.  For instance, digsig uses a single spinlock to
+protect the inode security data, while securelevel uses a
+spinlock located in the inode security object itself.
+
+The module list is protected as follows:
+
+	Walking the list is done under a partial rcu_read_lock.  We
+	cannot hold the rcu_read_lock while calling a
+	module_entry->lsm_hook(), as these are very likely to sleep.
+	Therefore we call rcu_read_lock() only when we rcu_dereference
+	module_entry->next.
+
+	We must be careful about deleting module_entries.  Stacker does
+	a try_module_get() on each LSM as it is stacked, to prevent its
+	being unloaded.  It will module_put the LSM when stacker_unload
+	is called for the module.  At that time the module is removed
+	from the stacked_modules list.  The forward pointer on the
+	struct module_entry is not changed, so that any stacker hook
+	which is currently on module_entry can safely and correctly
+	dereference module_entry->next.  The module_entry remains on the
+	all_modules list, which is used to find the module when it is
+	actually unregistered.  In this way any task which is executing
+	any of the module's hooks should have finished execution between
+	stacker_unload() and stacker_unregister(), making it safe to
+	delete the module_entry.
+
+The kernel object security lists are protected as follows:
+
+	The security_set_value and security_del_value are only to
+	be called during security_alloc_object and security_del_object,
+	respectively.  Since these are automatically safe from
+	concurrent accesses, no locking is required here.
+
+	The security_add_value() function is protected from concurrent
+	access using the stacker_value_spinlock.  security_get_value()
+	is protected from security_add_value() using rcu.
+
+	To allow module deletion, it is desirable for modules to be
+	able to delete kernel object security entries at any time.
+	This is supported using security_unlink_value().  This
+	function will remove the object under the
+	stacker_value_spinlock.  In order to protect racing readers,
+	however, the module must wait an rcu cycle before deleting
+	the object, either using call_rcu to call the deletion
+	function, or simply calling synchronize_rcu() as is done by
+	digsig.  In order to minimize the performance impact, both
+	digsig and securelevel call security_unlink_value() on each
+	to be deleted item in a loop, then wait an rcu cycle, and
+	then delete the objects.
+
+	This dynamic object deletion scheme still has one potential
+	race.  In order to minimize the performance impact on the
+	expected case, security_del_value() does not take the
+	stacker_value_spinlock.  This is generally safe because this
+	function must only be called while the kernel object is being
+	freed, so that this function is naturally serialized with
+	respect to write (no writes are possible).  However, the
+	following may be possible:
+
+	1. echo -n lsm1 > /security/stacker/unload  (CPU 0)
+	2. rmmod lsm1  (CPU 0)
+	At the same time, a file object is being freed on CPU 1.
+	While lsm2 is calling security_del_value() on the file, lsm1
+	is calling security_unlink_value().
+
+	One solution is to call the spinlock during the object
+	deletion.  The performance of this approach will be
+	measured.
