Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbUKDWXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbUKDWXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUKDWXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:23:40 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:28595 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262449AbUKDWCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:02:35 -0500
Subject: Re: [RFC] [PATCH] [6/6] LSM Stacking: temporary setprocattr hack
From: Serge Hallyn <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1099609471.2096.10.camel@serge.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1099609971.2096.26.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 17:12:51 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stacker assumes that data written to /proc/<pid>/attr/* is of the
form:

module_name: data

Until the SELinux tools are rewritten to use this form, or it is decided
other LSMs should use a different way of communicating with userspace,
this patch will assume that data not in this form is intended for SELinux.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-rc1-bk14/security/stacker.c
===================================================================
--- linux-2.6.10-rc1-bk14.orig/security/stacker.c	2004-11-04
12:31:02.636390608 -0600
+++ linux-2.6.10-rc1-bk14/security/stacker.c	2004-11-04
12:31:12.248929280 -0600
@@ -91,6 +91,8 @@
    pointed to by stacked_modules. It's initially NULL (an empty list).
*/
 struct module_entry *stacked_modules;
 
+static struct module_entry *selinux_module;
+static int selinux_is_loaded;
 
 /* penultimate_stacked_module points to the next-to-last
  * entry in the stacked list if there are 2+ entries, else it's NULL;
@@ -1007,12 +1009,20 @@
 
 	s = value;
 	e = strnchr(s, size, ':');
+	if (!e && selinux_is_loaded) {
+		m = selinux_module;
+		goto cont;
+	}
 	if (!e) {
 		printk(KERN_INFO "%s: couln't find module name end\n",
 			__FUNCTION__);
 		return -EINVAL;
 	}
 	m = find_lsm_module_by_name(s,e);
+	if (!m && selinux_is_loaded) {
+		m = selinux_module;
+		goto cont;
+	}
 	if (!m) {
 		strncpy(modname, s, 50);
 		modname[49] = '\0';
@@ -1021,6 +1031,7 @@
 		return -EINVAL;
 	}
 	s = e+1;
+cont:
 	while ((void *)s < value+size && *s == ' ')
 		s++;
 	if (s == value+size) {
@@ -1028,9 +1039,7 @@
 		return -EINVAL;
 	}
 	len = size - (int)((void *)s - value);
-	printk(KERN_INFO "%s: sending to module\n", __FUNCTION__);
 	ret = m->module_operations.setprocattr(p,name,s,len);
-	printk(KERN_INFO "%s: ret was %d, returning %d\n", __FUNCTION__, ret,
ret+(size-len));
 	if (ret < 0)
 		return ret;
 	return ret + (size-len);
@@ -1092,6 +1101,10 @@
 	new_module_entry->namelen = namelen;
 
 	add_module_entry(new_module_entry);
+	if (strcmp(name, "selinux") == 0) {
+		selinux_is_loaded = 1;
+		selinux_module = new_module_entry;
+	}
 
 	/* One more write barrier; this one is to _ensure_ that the
 	 * inactive list is valid before releasing the locking. */
@@ -1139,6 +1152,10 @@
 			penultimate_stacked_module = bb;
 	}
 	num_stacked_modules--;
+	if (strcmp(m->module_name, "selinux") == 0) {
+		selinux_is_loaded = 0;
+		selinux_module = NULL;
+	}
 	kfree(m->module_name);
 	kfree(m);
 out:
@@ -1567,6 +1584,9 @@
 	sysfsfiles_registered = 0;
 	num_stacked_modules = 0;
 
+	selinux_is_loaded = 0;
+	selinux_module = NULL;
+
 	INIT_STACKER_LOCKING;
 
 	if (register_security (&stacker_ops)) {


