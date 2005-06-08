Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVFIA4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVFIA4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVFIA4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:56:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:5031 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261596AbVFHXzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:55:17 -0400
Date: Wed, 8 Jun 2005 18:59:41 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>
Subject: [patch 4/11] lsm stacking: stacker documentation
Message-ID: <20050608235941.GD27314@serge.austin.ibm.com>
References: <20050608235505.GA27298@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608235505.GA27298@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about stacker and its usage.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 Documentation/LSM-stacking.txt |  157 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 157 insertions(+)

Index: linux-2.6.12-rc6/Documentation/LSM-stacking.txt
===================================================================
--- /dev/null
+++ linux-2.6.12-rc6/Documentation/LSM-stacking.txt
@@ -0,0 +1,157 @@
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
+You may interact with stacker through its sysfs interface, located
+under /sys/stacker/.  This consists of the following files:
+
+/sys/stacker/lockdown:
+Once you write to this file, you will no longer be able to load
+LSMs.
+
+/sys/stacker/list_modules:
+Reading this file will show which LSMs are being stacked.
+
+/sys/stacker/stop_responding:
+Unregisters the /sys/stacker directory, so that you can no longer
+interact with stacker.
+
+/sys/stacker/unload:
+Disables the specified module.  The module will actually still be
+loaded, but will no longer be asked to mediate accesses or update
+security information.  It will still be consulted on kernel object
+deletions.  Please see further down why.
+
+---------------------------------------------
+Readying an LSM for stacking with other LSMs.
+---------------------------------------------
+
+LSM stacking is not a simple matter.  You must consider the behavior of
+all stacked LSMs very carefully, as well as certain subtle effects of
+the LSM implementation.  Please do not try to stack arbitrary modules!
+For instance, while SELinux and cap-stack should always be used
+together, SELinux cannot be combined with the original capability
+module.  The reason for this is that capability enforces that
+a process must have CAP_SYS_ADMIN when writing "security.*" extended
+attributes.  However selinux requires that non-CAP_SYS_ADMIN processes
+be able to write security.selinux attributes, instead enforcing its
+own permission check.  More subtle interactions are certainly
+imaginable, such as a first security module updating state on a kernel
+object such that a second security module denies or allows the action
+when it otherwise would not have.
+
+If you have any questions about the proper or actual behavior of
+modules, whether existing or ones to be written by yourself, a good
+place to engage in discussion is the lsm mailing list,
+linux-security-module@wirex.com.  Information about the mailing list can
+be found at lsm.immunix.org.
+
+For performance reasons, stacker currently does not permit unloading
+of stacked modules.  They may be disabled while loaded by using the
+/sys/stacker/unload file.  Stacker attempts to prevent the unloads by
+incrementing the usage count on the module's struct security_operations.
+
+If your module will be annotating security information to kernel
+objects, then you should use the provided API.  The functions intended
+for use by modules are defined in include/linux/security.h.  A
+good example of a user of these functions is the SELinux module.  The
+following describes the API usage.
+
+Assume you wish to annotate an instance of the following struct to the
+inode_struct:
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
+unique ID to distinguish information owned by your module.  Usually you
+can just "echo <module_name> | sha1sum" and use the first 8 digits.
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
+security_set_value_type to append the struct to the object's list of
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
+is created.
+
+To get your information back, you may use security_get_value_type.
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
+Finally, data appended to kernel objects must (for now) be removed
+during the security_<KERNEL_OBJECT>_free() function only.  This is a
+limitation for performance reasons.  Allowing data to be freed anytime
+would only be needed if security modules could be unloaded, which would
+then require two additions to the locking scheme:  We would have to
+protect the object->security readers from data deletions, and likewise
+protect the actual security_operations structures from being unloaded
+while one of its member functions is executed.  It is possible that the
+latter is sufficiently taken care of by the module unloading logic.  The
+former would require waiting for a full rcu cycle between removing an
+element from the list, and actually deleting the element.  Additional
+locking (ie a refcount) would be up to the module itself.
