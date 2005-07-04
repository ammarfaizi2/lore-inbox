Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVGDDWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVGDDWr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 23:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVGDDWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 23:22:47 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:49608 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S261205AbVGDDWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 23:22:41 -0400
Date: Sun, 3 Jul 2005 20:18:20 -0700
From: Tony Jones <tonyj@suse.de>
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050704031820.GA6871@immunix.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20050630195043.GE23538@serge.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Serge,

I don't think your symbol_get() is doing what you think it is ;-)

> + * Add the stacked module (as specified by name and ops).
> + * If the module is not compiled in, the symbol_get at the end will
> + * prevent the the module from being unloaded.
> +*/
> +static int stacker_register (const char *name, struct security_operations *ops)
> +{
 ...
> +	symbol_get(ops);
> +
> +out:
> +	spin_unlock(&stacker_lock);
> +	return ret;
> +}


Seemed useful to be able to view which modules had been unloaded.
Easier to maintain them on their own list than to compute the difference
of <stacked_modules> and <all_modules>.  Patch attached, not sure if you
are cool with reusing the 'unload' file.

> +static struct stacker_attribute stacker_attr_unload = {
> +	.attr = {.name = "unload", .mode = S_IFREG | S_IRUGO | S_IWUSR},
> +	.store = stacker_unload_write,
> +};


Apart from this, looks good.  I ran it against our regression tests using
AppArmor (SubDomain) composed with Capability and everything was functionally
as expected.   I still need to run it through our SMP stress tests.

Thanks

Tony

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stacker_v2.diff"

--- stacker.c.orig	2005-07-03 19:57:21.000000000 -0700
+++ stacker.c	2005-07-03 19:55:40.000000000 -0700
@@ -39,6 +39,7 @@
 	struct security_operations module_operations;
 };
 static struct list_head stacked_modules;  /* list of stacked modules */
+static struct list_head unloaded_modules; /* list of unloaded modules */
 static struct list_head all_modules;  /* list of all modules, including freed */
 
 static short sysfsfiles_registered;
@@ -1439,6 +1440,7 @@
 
 	rcu_read_lock();
 	list_del_rcu(&m->lsm_list);
+	list_add_tail_rcu(&m->lsm_list, &unloaded_modules);
 	if (list_empty(&stacked_modules)) {
 		INIT_LIST_HEAD(&default_module.lsm_list);
 		list_add_tail_rcu(&default_module.lsm_list, &stacked_modules);
@@ -1452,9 +1454,26 @@
 	return ret;
 }
 
+/* list unloaded modules */
+static ssize_t stacker_unload_read (struct stacker_kobj *obj, char *buff)
+{
+	ssize_t len = 0;
+	struct module_entry *m;
+
+	rcu_read_lock();
+	stack_for_each_entry(m, &unloaded_modules, lsm_list) {
+		len += snprintf(buff+len, PAGE_SIZE - len, "%s\n",
+			m->module_name);
+	}
+	rcu_read_unlock();
+
+	return len;
+}
+
 static struct stacker_attribute stacker_attr_unload = {
 	.attr = {.name = "unload", .mode = S_IFREG | S_IRUGO | S_IWUSR},
 	.store = stacker_unload_write,
+	.show =  stacker_unload_read,
 };
 
 
@@ -1525,6 +1544,7 @@
 
 	INIT_LIST_HEAD(&stacked_modules);
 	INIT_LIST_HEAD(&all_modules);
+	INIT_LIST_HEAD(&unloaded_modules);
 	spin_lock_init(&stacker_lock);
 	default_module.module_name = DEFAULT_MODULE_NAME;
 	default_module.namelen = strlen(DEFAULT_MODULE_NAME);

--LQksG6bCIzRHxTLp--
