Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWDSR4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWDSR4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWDSR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:56:35 -0400
Received: from mail.suse.de ([195.135.220.2]:20689 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751059AbWDSRy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:54:27 -0400
From: Tony Jones <tonyj@suse.de>
To: linux-kernel@vger.kernel.org
Cc: chrisw@sous-sol.org, Tony Jones <tonyj@suse.de>,
       linux-security-module@vger.kernel.org
Date: Wed, 19 Apr 2006 10:50:02 -0700
Message-Id: <20060419175002.29149.86725.sendpatchset@ermintrude.int.wirex.com>
In-Reply-To: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
Subject: [RFC][PATCH 7/11] security: AppArmor - Misc (capabilities, data structures)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements three distinct chunks.
- list management, for profiles loaded into the system (profile_list) and for 
  the set of confined tasks (subdomain_list)
- the proc/pid/attr interface used by userspace for setprofile (forcing
  a task into a new profile) and changehat (switching a task into one of it's
  defined sub profiles).  Access to change_hat is normally via code provided
  in libapparmor. See the overview posting for more information in change hat.
- capability utility functions (for displaying capability names)


Signed-off-by: Tony Jones <tonyj@suse.de>

---
 security/apparmor/capabilities.c |   54 ++++++
 security/apparmor/list.c         |  268 +++++++++++++++++++++++++++++++
 security/apparmor/procattr.c     |  327 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 649 insertions(+)

--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/capabilities.c
@@ -0,0 +1,54 @@
+/*
+ *	Copyright (C) 2005 Novell/SUSE
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2 of the
+ *	License.
+ *
+ *	AppArmor capability definitions
+ */
+
+#include "apparmor.h"
+
+static const char *cap_names[] = {
+	"chown",
+	"dac_override",
+	"dac_read_search",
+	"fowner",
+	"fsetid",
+	"kill",
+	"setgid",
+	"setuid",
+	"setpcap",
+	"linux_immutable",
+	"net_bind_service",
+	"net_broadcast",
+	"net_admin",
+	"net_raw",
+	"ipc_lock",
+	"ipc_owner",
+	"sys_module",
+	"sys_rawio",
+	"sys_chroot",
+	"sys_ptrace",
+	"sys_pacct",
+	"sys_admin",
+	"sys_boot",
+	"sys_nice",
+	"sys_resource",
+	"sys_time",
+	"sys_tty_config",
+	"mknod",
+	"lease"
+};
+
+const char *capability_to_name(unsigned int cap)
+{
+	const char *name;
+
+	name = (cap < (sizeof(cap_names) / sizeof(char *))
+		   ? cap_names[cap] : "invalid-capability");
+
+	return name;
+}
--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/list.c
@@ -0,0 +1,268 @@
+/*
+ *	Copyright (C) 1998-2005 Novell/SUSE
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2 of the
+ *	License.
+ *
+ *	AppArmor Profile List Management
+ */
+
+#include <linux/seq_file.h>
+#include "apparmor.h"
+#include "inline.h"
+
+/* list of all profiles and lock */
+static LIST_HEAD(profile_list);
+static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
+
+/* list of all subdomains and lock */
+static LIST_HEAD(subdomain_list);
+static rwlock_t subdomain_lock = RW_LOCK_UNLOCKED;
+
+/**
+ * aa_profilelist_find
+ * @name: profile name (program name)
+ *
+ * Search the profile list for profile @name.  Return refcounted profile on
+ * success, NULL on failure.
+ */
+struct aaprofile *aa_profilelist_find(const char *name)
+{
+	struct aaprofile *p = NULL;
+	if (name) {
+		read_lock(&profile_lock);
+		p = __aa_find_profile(name, &profile_list);
+		read_unlock(&profile_lock);
+	}
+	return p;
+}
+
+/**
+ * aa_profilelist_add - add new profile to list
+ * @profile: new profile to add to list
+ *
+ * NOTE: Caller must allocate necessary reference count that will be used
+ * by the profile_list.  This is because profile allocation alloc_aaprofile()
+ * returns an unreferenced object with a initial count of %1.
+ *
+ * Return %1 on success, %0 on failure (already exists)
+ */
+int aa_profilelist_add(struct aaprofile *profile)
+{
+	struct aaprofile *old_profile;
+	int ret = 0;
+
+	if (!profile)
+		goto out;
+
+	write_lock(&profile_lock);
+	old_profile = __aa_find_profile(profile->name, &profile_list);
+	if (old_profile) {
+		put_aaprofile(old_profile);
+		goto out;
+	}
+
+	list_add(&profile->list, &profile_list);
+	ret = 1;
+ out:
+	write_unlock(&profile_lock);
+	return ret;
+}
+
+/**
+ * aa_profilelist_remove - remove a profile from the list by name
+ * @name: name of profile to be removed
+ *
+ * If the profile exists remove profile from list and return its reference.
+ * The reference count on profile is not decremented and should be decremented
+ * when the profile is no longer needed
+ */
+struct aaprofile *aa_profilelist_remove(const char *name)
+{
+	struct aaprofile *profile = NULL;
+	struct aaprofile *p, *tmp;
+
+	if (!name)
+		goto out;
+
+	write_lock(&profile_lock);
+	list_for_each_entry_safe(p, tmp, &profile_list, list) {
+		if (!strcmp(p->name, name)) {
+			list_del_init(&p->list);
+			/* mark old profile as stale */
+			p->isstale = 1;
+			profile = p;
+			break;
+		}
+	}
+	write_unlock(&profile_lock);
+
+out:
+	return profile;
+}
+
+/**
+ * aa_profilelist_replace - replace a profile on the list
+ * @profile: new profile
+ *
+ * Replace a profile on the profile list.  Find the old profile by name in
+ * the list, and replace it with the new profile.   NOTE: Caller must allocate
+ * necessary initial reference count for new profile as aa_profilelist_add().
+ *
+ * This is an atomic list operation.  Returns the old profile (which is still
+ * refcounted) if there was one, or NULL.
+ */
+struct aaprofile *aa_profilelist_replace(struct aaprofile *profile)
+{
+	struct aaprofile *oldprofile;
+
+	write_lock(&profile_lock);
+	oldprofile = __aa_find_profile(profile->name, &profile_list);
+	if (oldprofile) {
+		list_del_init(&oldprofile->list);
+		/* mark old profile as stale */
+		oldprofile->isstale = 1;
+
+		/* __aa_find_profile incremented count, so adjust down */
+		put_aaprofile(oldprofile);
+	}
+
+	list_add(&profile->list, &profile_list);
+	write_unlock(&profile_lock);
+
+	return oldprofile;
+}
+
+/**
+ * aa_profilelist_release - Remove all profiles from profile_list
+ */
+void aa_profilelist_release(void)
+{
+	struct aaprofile *p, *tmp;
+
+	write_lock(&profile_lock);
+	list_for_each_entry_safe(p, tmp, &profile_list, list) {
+		list_del_init(&p->list);
+		put_aaprofile(p);
+	}
+	write_unlock(&profile_lock);
+}
+
+/**
+ * aa_subdomainlist_add - Add subdomain to subdomain_list
+ * @sd: new subdomain
+ */
+void aa_subdomainlist_add(struct subdomain *sd)
+{
+	unsigned long flags;
+
+	if (!sd) {
+		AA_INFO("%s: bad subdomain\n", __FUNCTION__);
+		return;
+	}
+
+	write_lock_irqsave(&subdomain_lock, flags);
+	/* new subdomains must be added to the end of the list due to a
+	 * subtle interaction between fork and profile replacement.
+	 */
+	list_add_tail(&sd->list, &subdomain_list);
+	write_unlock_irqrestore(&subdomain_lock, flags);
+}
+
+/**
+ * aa_subdomainlist_remove - Remove subdomain from subdomain_list
+ * @sd: subdomain to be removed
+ */
+void aa_subdomainlist_remove(struct subdomain *sd)
+{
+	unsigned long flags;
+
+	if (sd) {
+		write_lock_irqsave(&subdomain_lock, flags);
+		list_del_init(&sd->list);
+		write_unlock_irqrestore(&subdomain_lock, flags);
+	}
+}
+
+/**
+ * aa_subdomainlist_iterate - iterate over the subdomain list applying @func
+ * @func: method to be called for each element
+ * @cookie: user passed data
+ *
+ * Iterate over subdomain list applying @func, stop when @func returns
+ * non zero
+ */
+void aa_subdomainlist_iterate(aa_iter func, void *cookie)
+{
+	struct subdomain *node;
+	int ret = 0;
+	unsigned long flags;
+
+	read_lock_irqsave(&subdomain_lock, flags);
+	list_for_each_entry(node, &subdomain_list, list) {
+		ret = (*func) (node, cookie);
+		if (ret != 0)
+			break;
+	}
+	read_unlock_irqrestore(&subdomain_lock, flags);
+}
+
+/**
+ * aa_subdomainlist_release - Remove all subdomains from subdomain_list
+ */
+void aa_subdomainlist_release()
+{
+	struct subdomain *node, *tmp;
+	unsigned long flags;
+
+	write_lock_irqsave(&subdomain_lock, flags);
+	list_for_each_entry_safe(node, tmp, &subdomain_list, list) {
+		list_del_init(&node->list);
+	}
+	write_unlock_irqrestore(&subdomain_lock, flags);
+}
+
+/* seq_file helper routines
+ * Used by apparmorfs.c to iterate over profile_list
+ */
+static void *p_start(struct seq_file *f, loff_t *pos)
+{
+	struct aaprofile *node;
+	loff_t l = *pos;
+
+	read_lock(&profile_lock);
+	list_for_each_entry(node, &profile_list, list)
+		if (!l--)
+			return node;
+	return NULL;
+}
+
+static void *p_next(struct seq_file *f, void *p, loff_t *pos)
+{
+	struct list_head *lh = ((struct aaprofile *)p)->list.next;
+	(*pos)++;
+	return lh == &profile_list ?
+			NULL : list_entry(lh, struct aaprofile, list);
+}
+
+static void p_stop(struct seq_file *f, void *v)
+{
+	read_unlock(&profile_lock);
+}
+
+static int seq_show_profile(struct seq_file *f, void *v)
+{
+	struct aaprofile *profile = (struct aaprofile *)v;
+	seq_printf(f, "%s (%s)\n", profile->name,
+		   PROFILE_COMPLAIN(profile) ? "complain" : "enforce");
+	return 0;
+}
+
+struct seq_operations apparmorfs_profiles_op = {
+	.start =	p_start,
+	.next =		p_next,
+	.stop =		p_stop,
+	.show =		seq_show_profile,
+};
--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/procattr.c
@@ -0,0 +1,327 @@
+/*
+ *	Copyright (C) 2005 Novell/SUSE
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2 of the
+ *	License.
+ *
+ *	AppArmor /proc/pid/attr handling
+ */
+
+/* for isspace */
+#include <linux/ctype.h>
+
+#include "apparmor.h"
+#include "inline.h"
+
+size_t aa_getprocattr(struct aaprofile *active, char *str, size_t size)
+{
+	int error = -EACCES;	/* default to a perm denied */
+	size_t len;
+
+	if (active) {
+		size_t lena, lenm, lenp = 0;
+		const char *enforce_str = " (enforce)";
+		const char *complain_str = " (complain)";
+		const char *mode_str =
+			PROFILE_COMPLAIN(active) ? complain_str : enforce_str;
+
+		lenm = strlen(mode_str);
+
+		lena = strlen(active->name);
+
+		len = lena;
+		if (IN_SUBPROFILE(active)) {
+			lenp = strlen(BASE_PROFILE(active)->name);
+			len += (lenp + 1);	/* +1 for ^ */
+		}
+		/* DONT null terminate strings we output via proc */
+		len += (lenm + 1);	/* for \n */
+
+		if (len <= size) {
+			if (lenp) {
+				memcpy(str, BASE_PROFILE(active)->name,
+				       lenp);
+				str += lenp;
+				*str++ = '^';
+			}
+
+			memcpy(str, active->name, lena);
+			str += lena;
+			memcpy(str, mode_str, lenm);
+			str += lenm;
+			*str++ = '\n';
+			error = len;
+		} else {
+			error = -ERANGE;
+		}
+	} else {
+		const char *unconstrained_str = "unconstrained\n";
+		len = strlen(unconstrained_str);
+
+		/* DONT null terminate strings we output via proc */
+		if (len <= size) {
+			memcpy(str, unconstrained_str, len);
+			error = len;
+		} else {
+			error = -ERANGE;
+		}
+	}
+
+	return error;
+
+}
+
+int aa_setprocattr_changehat(char *hatinfo, size_t infosize)
+{
+	int error = -EINVAL;
+	char *token = NULL, *hat, *smagic, *tmp;
+	u32 magic;
+	int rc, len, consumed;
+	unsigned long flags;
+
+	AA_DEBUG("%s: %p %zd\n", __FUNCTION__, hatinfo, infosize);
+
+	/* strip leading white space */
+	while (infosize && isspace(*hatinfo)) {
+		hatinfo++;
+		infosize--;
+	}
+
+	if (infosize == 0)
+		goto out;
+
+	/*
+	 * Copy string to a new buffer so we can play with it
+	 * It may be zero terminated but we add a trailing 0
+	 * for 100% safety
+	 */
+	token = kmalloc(infosize + 1, GFP_KERNEL);
+
+	if (!token) {
+		error = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(token, hatinfo, infosize);
+	token[infosize] = 0;
+
+	/* error is INVAL until we have at least parsed something */
+	error = -EINVAL;
+
+	tmp = token;
+	while (*tmp && *tmp != '^') {
+		tmp++;
+	}
+
+	if (!*tmp || tmp == token) {
+		AA_WARN("%s: Invalid input '%s'\n", __FUNCTION__, token);
+		goto out;
+	}
+
+	/* split magic and hat into two strings */
+	*tmp = 0;
+	smagic = token;
+
+	/*
+	 * Initially set consumed=strlen(magic), as if sscanf
+	 * consumes all input via the %x it will not process the %n
+	 * directive. Otherwise, if sscanf does not consume all the
+	 * input it will process the %n and update consumed.
+	 */
+	consumed = len = strlen(smagic);
+
+	rc = sscanf(smagic, "%x%n", &magic, &consumed);
+
+	if (rc != 1 || consumed != len) {
+		AA_WARN("%s: Invalid hex magic %s\n",
+			__FUNCTION__,
+			smagic);
+		goto out;
+	}
+
+	hat = tmp + 1;
+
+	if (!*hat)
+		hat = NULL;
+
+	if (!hat && !magic) {
+		AA_WARN("%s: Invalid input, NULL hat and NULL magic\n",
+			__FUNCTION__);
+		goto out;
+	}
+
+	AA_DEBUG("%s: Magic 0x%x Hat '%s'\n",
+		 __FUNCTION__, magic, hat ? hat : NULL);
+
+	spin_lock_irqsave(&sd_lock, flags);
+	error = aa_change_hat(hat, magic);
+	spin_unlock_irqrestore(&sd_lock, flags);
+
+out:
+	if (token) {
+		memset(token, 0, infosize);
+		kfree(token);
+	}
+
+	return error;
+}
+
+int aa_setprocattr_setprofile(struct task_struct *p, char *profilename,
+			      size_t profilesize)
+{
+	int error = -EINVAL;
+	struct aaprofile *profile = NULL;
+	struct subdomain *sd;
+	char *name = NULL;
+	unsigned long flags;
+
+	AA_DEBUG("%s: current %s(%d)\n",
+		 __FUNCTION__, current->comm, current->pid);
+
+	/* strip leading white space */
+	while (profilesize && isspace(*profilename)) {
+		profilename++;
+		profilesize--;
+	}
+
+	if (profilesize == 0)
+		goto out;
+
+	/*
+	 * Copy string to a new buffer so we guarantee it is zero
+	 * terminated
+	 */
+	name = kmalloc(profilesize + 1, GFP_KERNEL);
+
+	if (!name) {
+		error = -ENOMEM;
+		goto out;
+	}
+
+	strncpy(name, profilename, profilesize);
+	name[profilesize] = 0;
+
+ repeat:
+	if (strcmp(name, "unconstrained") != 0) {
+		profile = aa_profilelist_find(name);
+		if (!profile) {
+			AA_WARN("%s: Unable to switch task %s(%d) to profile"
+				"'%s'. No such profile.\n",
+				__FUNCTION__,
+				p->comm, p->pid,
+				name);
+
+			error = -EINVAL;
+			goto out;
+		}
+	}
+
+	spin_lock_irqsave(&sd_lock, flags);
+
+	sd = AA_SUBDOMAIN(p->security);
+
+	/* switch to unconstrained */
+	if (!profile) {
+		if (__aa_is_confined(sd)) {
+			AA_WARN("%s: Unconstraining task %s(%d) "
+				"profile %s active %s\n",
+				__FUNCTION__,
+				p->comm, p->pid,
+				BASE_PROFILE(sd->active)->name,
+				sd->active->name);
+
+			aa_switch_unconfined(sd);
+		} else {
+			AA_WARN("%s: task %s(%d) "
+				"is already unconstrained\n",
+				__FUNCTION__, p->comm, p->pid);
+		}
+	} else {
+		if (!sd) {
+			/* this task was created before module was
+			 * loaded, allocate a subdomain
+			 */
+			AA_WARN("%s: task %s(%d) has no subdomain\n",
+				__FUNCTION__, p->comm, p->pid);
+
+			/* unlock so we can safely GFP_KERNEL */
+			spin_unlock_irqrestore(&sd_lock, flags);
+
+			sd = alloc_subdomain(p);
+			if (!sd) {
+				AA_WARN("%s: Unable to allocate subdomain for "
+					"task %s(%d). Cannot confine task to "
+					"profile %s\n",
+					__FUNCTION__,
+					p->comm, p->pid,
+					name);
+
+				error = -ENOMEM;
+				put_aaprofile(profile);
+
+				goto out;
+			}
+
+			spin_lock_irqsave(&sd_lock, flags);
+			if (!AA_SUBDOMAIN(p->security)) {
+				p->security = sd;
+			} else { /* race */
+				free_subdomain(sd);
+				sd = AA_SUBDOMAIN(p->security);
+			}
+		}
+
+		/* ensure the profile hasn't been replaced */
+
+		if (unlikely(profile->isstale)) {
+			WARN_ON(profile == null_complain_profile);
+
+			/* drop refcnt obtained from earlier get_aaprofile */
+			put_aaprofile(profile);
+			profile = aa_profilelist_find(name);
+
+			if (!profile) {
+				/* Race, profile was removed. */
+				spin_unlock_irqrestore(&sd_lock, flags);
+				goto repeat;
+			}
+		}
+
+		/* we do not do a normal task replace since we are not
+		 * replacing with the same profile.
+		 * If existing process is in a hat, it will be moved
+		 * into the new parent profile, even if this new
+		 * profile has a identical named hat.
+		 */
+
+		AA_WARN("%s: Switching task %s(%d) "
+			"profile %s active %s to new profile %s\n",
+			__FUNCTION__,
+			p->comm, p->pid,
+			sd->active ? BASE_PROFILE(sd->active)->name :
+				"unconstrained",
+			sd->active ? sd->active->name : "unconstrained",
+			name);
+
+		aa_switch(sd, profile);
+
+		put_aaprofile(profile); /* drop ref we obtained above
+					 * from aa_profilelist_find
+					 */
+
+		/* Reset magic in case we were in a subhat before
+		 * This is the only case where we zero the magic after
+		 * calling aa_switch
+		 */
+		sd->hat_magic = 0;
+	}
+
+	spin_unlock_irqrestore(&sd_lock, flags);
+
+out:
+	kfree(name);
+
+	return error;
+}
