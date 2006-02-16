Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWBPVuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWBPVuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWBPVuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:50:40 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:14817
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932362AbWBPVui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:50:38 -0500
Date: Thu, 16 Feb 2006 13:50:23 -0800
From: Greg KH <greg@kroah.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs-related oops during module unload (2.6.16-rc2)
Message-ID: <20060216215023.GA30417@kroah.com>
References: <20060211220351.GA3293@localhost.localdomain> <20060211224526.GA25237@kroah.com> <20060212052751.GB3293@localhost.localdomain> <20060212053849.GA27587@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212053849.GA27587@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 09:38:49PM -0800, Greg KH wrote:
> On Sat, Feb 11, 2006 at 11:27:52PM -0600, Nathan Lynch wrote:
> > Greg KH wrote:
> > > On Sat, Feb 11, 2006 at 04:03:53PM -0600, Nathan Lynch wrote:
> > > > If the refcnt attribute of a module is open when the module is
> > > > unloaded, we get an oops when the file is closed.  I used ide_cd for
> > > > this report but I don't think the oops is caused by the driver itself.
> > > > This bug seems to be restricted to the /sys/module hierarchy; it
> > > > doesn't happen with /sys/class etc.
> > > > 
> > > > I suspect it's an extra put or a missing get somewhere, but the fix
> > > > isn't obvious to me after looking at it for a little while, so I'm
> > > > punting.
> > > > 
> > > > I'm pretty sure this happens with 2.6.15; I can double-check if
> > > > needed.
> > > 
> > > Ugh, we aren't setting the owner of these fields properly, good catch.
> > > 
> > > Does the patch below (built tested only), solve this for you?
> > 
> > Thanks, but no, I get the same oops.  The refcnt attribute isn't part
> > of the modinfo_attrs array.
> 
> Ah, crap, you're right.  We really need to dynamically create these
> attributes for every module to get the owner right.  That will be a
> bigger patch that I'll work on on Monday...

Ok, turns out the code was trying to increment the module reference
count correctly, but it wasn't working right at all.  And we were not
showing a few things in sysfs if module unload was not selected, which
isn't right.

So here's a patch that fixes all of this, and your original problem.
Bonus is that it actually removes more code than it adds :)

Can you test it out to verify that it works for you?

thanks,

greg k-h


---
 include/linux/module.h |    1 
 kernel/module.c        |   77 +++++++++++++++++++------------------------------
 kernel/params.c        |   10 ------
 3 files changed, 32 insertions(+), 56 deletions(-)

--- gregkh-2.6.orig/include/linux/module.h
+++ gregkh-2.6/include/linux/module.h
@@ -242,6 +242,7 @@ struct module
 	/* Sysfs stuff. */
 	struct module_kobject mkobj;
 	struct module_param_attrs *param_attrs;
+	struct module_attribute *modinfo_attrs;
 	const char *version;
 	const char *srcversion;
 
--- gregkh-2.6.orig/kernel/module.c
+++ gregkh-2.6/kernel/module.c
@@ -379,7 +379,6 @@ static inline void percpu_modcopy(void *
 }
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_MODULE_UNLOAD
 #define MODINFO_ATTR(field)	\
 static void setup_modinfo_##field(struct module *mod, const char *s)  \
 {                                                                     \
@@ -411,12 +410,7 @@ static struct module_attribute modinfo_#
 MODINFO_ATTR(version);
 MODINFO_ATTR(srcversion);
 
-static struct module_attribute *modinfo_attrs[] = {
-	&modinfo_version,
-	&modinfo_srcversion,
-	NULL,
-};
-
+#ifdef CONFIG_MODULE_UNLOAD
 /* Init the unload section of the module. */
 static void module_unload_init(struct module *mod)
 {
@@ -731,6 +725,15 @@ static inline void module_unload_init(st
 }
 #endif /* CONFIG_MODULE_UNLOAD */
 
+static struct module_attribute *modinfo_attrs[] = {
+	&modinfo_version,
+	&modinfo_srcversion,
+#ifdef CONFIG_MODULE_UNLOAD
+	&refcnt,
+#endif
+	NULL,
+};
+
 #ifdef CONFIG_OBSOLETE_MODPARM
 /* Bounds checking done below */
 static int obsparm_copy_string(const char *val, struct kernel_param *kp)
@@ -1056,37 +1059,28 @@ static inline void remove_sect_attrs(str
 }
 #endif /* CONFIG_KALLSYMS */
 
-
-#ifdef CONFIG_MODULE_UNLOAD
-static inline int module_add_refcnt_attr(struct module *mod)
-{
-	return sysfs_create_file(&mod->mkobj.kobj, &refcnt.attr);
-}
-static void module_remove_refcnt_attr(struct module *mod)
-{
-	return sysfs_remove_file(&mod->mkobj.kobj, &refcnt.attr);
-}
-#else
-static inline int module_add_refcnt_attr(struct module *mod)
-{
-	return 0;
-}
-static void module_remove_refcnt_attr(struct module *mod)
-{
-}
-#endif
-
-#ifdef CONFIG_MODULE_UNLOAD
 static int module_add_modinfo_attrs(struct module *mod)
 {
 	struct module_attribute *attr;
+	struct module_attribute *temp_attr;
 	int error = 0;
 	int i;
 
+	mod->modinfo_attrs = kzalloc((sizeof(struct module_attribute) *
+					(ARRAY_SIZE(modinfo_attrs) + 1)),
+					GFP_KERNEL);
+	if (!mod->modinfo_attrs)
+		return -ENOMEM;
+
+	temp_attr = mod->modinfo_attrs;
 	for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
 		if (!attr->test ||
-		    (attr->test && attr->test(mod)))
-			error = sysfs_create_file(&mod->mkobj.kobj,&attr->attr);
+		    (attr->test && attr->test(mod))) {
+			memcpy(temp_attr, attr, sizeof(*temp_attr));
+			temp_attr->attr.owner = mod;
+			error = sysfs_create_file(&mod->mkobj.kobj,&temp_attr->attr);
+			++temp_attr;
+		}
 	}
 	return error;
 }
@@ -1096,12 +1090,16 @@ static void module_remove_modinfo_attrs(
 	struct module_attribute *attr;
 	int i;
 
-	for (i = 0; (attr = modinfo_attrs[i]); i++) {
+	for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
+		/* pick a field to test for end of list */
+		if (!attr->attr.name)
+			break;
 		sysfs_remove_file(&mod->mkobj.kobj,&attr->attr);
-		attr->free(mod);
+		if (attr->free)
+			attr->free(mod);
 	}
+	kfree(mod->modinfo_attrs);
 }
-#endif
 
 static int mod_sysfs_setup(struct module *mod,
 			   struct kernel_param *kparam,
@@ -1119,19 +1117,13 @@ static int mod_sysfs_setup(struct module
 	if (err)
 		goto out;
 
-	err = module_add_refcnt_attr(mod);
-	if (err)
-		goto out_unreg;
-
 	err = module_param_sysfs_setup(mod, kparam, num_params);
 	if (err)
 		goto out_unreg;
 
-#ifdef CONFIG_MODULE_UNLOAD
 	err = module_add_modinfo_attrs(mod);
 	if (err)
 		goto out_unreg;
-#endif
 
 	return 0;
 
@@ -1143,10 +1135,7 @@ out:
 
 static void mod_kobject_remove(struct module *mod)
 {
-#ifdef CONFIG_MODULE_UNLOAD
 	module_remove_modinfo_attrs(mod);
-#endif
-	module_remove_refcnt_attr(mod);
 	module_param_sysfs_remove(mod);
 
 	kobject_unregister(&mod->mkobj.kobj);
@@ -1424,7 +1413,6 @@ static char *get_modinfo(Elf_Shdr *sechd
 	return NULL;
 }
 
-#ifdef CONFIG_MODULE_UNLOAD
 static void setup_modinfo(struct module *mod, Elf_Shdr *sechdrs,
 			  unsigned int infoindex)
 {
@@ -1439,7 +1427,6 @@ static void setup_modinfo(struct module 
 						attr->attr.name));
 	}
 }
-#endif
 
 #ifdef CONFIG_KALLSYMS
 int is_exported(const char *name, const struct module *mod)
@@ -1755,10 +1742,8 @@ static struct module *load_module(void _
 	if (strcmp(mod->name, "driverloader") == 0)
 		add_taint(TAINT_PROPRIETARY_MODULE);
 
-#ifdef CONFIG_MODULE_UNLOAD
 	/* Set up MODINFO_ATTR fields */
 	setup_modinfo(mod, sechdrs, infoindex);
-#endif
 
 	/* Fix up syms, so that st_value is a pointer to location. */
 	err = simplify_symbols(sechdrs, symindex, strtab, versindex, pcpuindex,
--- gregkh-2.6.orig/kernel/params.c
+++ gregkh-2.6/kernel/params.c
@@ -638,13 +638,8 @@ static ssize_t module_attr_show(struct k
 	if (!attribute->show)
 		return -EIO;
 
-	if (!try_module_get(mk->mod))
-		return -ENODEV;
-
 	ret = attribute->show(attribute, mk->mod, buf);
 
-	module_put(mk->mod);
-
 	return ret;
 }
 
@@ -662,13 +657,8 @@ static ssize_t module_attr_store(struct 
 	if (!attribute->store)
 		return -EIO;
 
-	if (!try_module_get(mk->mod))
-		return -ENODEV;
-
 	ret = attribute->store(attribute, mk->mod, buf, len);
 
-	module_put(mk->mod);
-
 	return ret;
 }
 
