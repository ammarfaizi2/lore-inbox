Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbUKWDKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbUKWDKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 22:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbUKWDIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 22:08:45 -0500
Received: from [211.58.254.17] ([211.58.254.17]:57742 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262558AbUKWDET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 22:04:19 -0500
Date: Tue, 23 Nov 2004 12:04:17 +0900
From: Tejun Heo <tj@home-tj.org>
To: greg@kroah.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc2 3/4] module sysfs: sections attr reimplemented using attr group
Message-ID: <20041123030417.GD7326@home-tj.org>
References: <20041123024537.GA7326@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123024537.GA7326@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 03_module_sections_attr_grp.patch
> 	Reimplement section attributes using attribute group.  This
> 	makes more sense, for, while they reside in a separate
> 	subdirectory, they belong to the ownig module and their
> 	lifetime exactly equals the lifetime of the owning module,
> 	and it's simpler.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/module.h
===================================================================
--- linux-export.orig/include/linux/module.h	2004-11-23 11:32:13.000000000 +0900
+++ linux-export/include/linux/module.h	2004-11-23 11:32:28.000000000 +0900
@@ -227,14 +227,14 @@ enum module_state
 #define MODULE_SECT_NAME_LEN 32
 struct module_sect_attr
 {
-	struct attribute attr;
+	struct module_attribute mattr;
 	char name[MODULE_SECT_NAME_LEN];
 	unsigned long address;
 };
 
-struct module_sections
+struct module_sect_attrs
 {
-	struct kobject kobj;
+	struct attribute_group grp;
 	struct module_sect_attr attrs[0];
 };
 
@@ -313,7 +313,7 @@ struct module
 	char *strtab;
 
 	/* Section attributes */
-	struct module_sections *sect_attrs;
+	struct module_sect_attrs *sect_attrs;
 #endif
 
 	/* Per-cpu data. */
Index: linux-export/kernel/module.c
===================================================================
--- linux-export.orig/kernel/module.c	2004-11-23 11:32:13.000000000 +0900
+++ linux-export/kernel/module.c	2004-11-23 11:32:28.000000000 +0900
@@ -937,76 +937,71 @@ static unsigned long resolve_symbol(Elf_
  * J. Corbet <corbet@lwn.net>
  */
 #ifdef CONFIG_KALLSYMS
-static void module_sect_attrs_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct module_sections, kobj));
-}
-
-static ssize_t module_sect_show(struct kobject *kobj, struct attribute *attr,
-		char *buf)
+static ssize_t module_sect_show(struct module_attribute *mattr,
+				struct module *mod, char *buf)
 {
 	struct module_sect_attr *sattr =
-		container_of(attr, struct module_sect_attr, attr);
+		container_of(mattr, struct module_sect_attr, mattr);
 	return sprintf(buf, "0x%lx\n", sattr->address);
 }
 
-static struct sysfs_ops module_sect_ops = {
-	.show = module_sect_show,
-};
-
-static struct kobj_type module_sect_ktype = {
-	.sysfs_ops = &module_sect_ops,
-	.release =   module_sect_attrs_release,
-};
-
 static void add_sect_attrs(struct module *mod, unsigned int nsect,
 		char *secstrings, Elf_Shdr *sechdrs)
 {
-	unsigned int nloaded = 0, i;
+	unsigned int nloaded = 0, i, size[2];
+	struct module_sect_attrs *sect_attrs;
 	struct module_sect_attr *sattr;
+	struct attribute **gattr;
 	
 	/* Count loaded sections and allocate structures */
 	for (i = 0; i < nsect; i++)
 		if (sechdrs[i].sh_flags & SHF_ALLOC)
 			nloaded++;
-	mod->sect_attrs = kmalloc(sizeof(struct module_sections) +
-			nloaded*sizeof(mod->sect_attrs->attrs[0]), GFP_KERNEL);
-	if (! mod->sect_attrs)
+	size[0] = ALIGN(sizeof(*sect_attrs)
+			+ nloaded * sizeof(sect_attrs->attrs[0]),
+			sizeof(sect_attrs->grp.attrs[0]));
+	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.attrs[0]);
+	if (! (sect_attrs = kmalloc(size[0] + size[1], GFP_KERNEL)))
 		return;
 
-	/* sections entry setup */
-	memset(mod->sect_attrs, 0, sizeof(struct module_sections));
-	if (kobject_set_name(&mod->sect_attrs->kobj, "sections"))
-		goto out;
-	mod->sect_attrs->kobj.parent = &mod->mkobj.kobj;
-	mod->sect_attrs->kobj.ktype = &module_sect_ktype;
-	if (kobject_register(&mod->sect_attrs->kobj))
-		goto out;
+	/* Setup section attributes. */
+	sect_attrs->grp.name = "sections";
+	sect_attrs->grp.attrs = (void *)sect_attrs + size[0];
 
-	/* And the section attributes. */
-	sattr = &mod->sect_attrs->attrs[0];
+	sattr = &sect_attrs->attrs[0];
+	gattr = &sect_attrs->grp.attrs[0];
 	for (i = 0; i < nsect; i++) {
 		if (! (sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 		sattr->address = sechdrs[i].sh_addr;
 		strlcpy(sattr->name, secstrings + sechdrs[i].sh_name,
-				MODULE_SECT_NAME_LEN);
-		sattr->attr.name = sattr->name;
-		sattr->attr.owner = mod;
-		sattr->attr.mode = S_IRUGO;
-		(void) sysfs_create_file(&mod->sect_attrs->kobj, &sattr->attr);
-		sattr++;
+			MODULE_SECT_NAME_LEN);
+		sattr->mattr.show = module_sect_show;
+		sattr->mattr.store = NULL;
+		sattr->mattr.attr.name = sattr->name;
+		sattr->mattr.attr.owner = mod;
+		sattr->mattr.attr.mode = S_IRUGO;
+		*(gattr++) = &(sattr++)->mattr.attr;
 	}
+	*gattr = NULL;
+
+	if (sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp))
+		goto out;
+
+	mod->sect_attrs = sect_attrs;
 	return;
   out:
-	kfree(mod->sect_attrs);
-	mod->sect_attrs = NULL;
+	kfree(sect_attrs);
 }
 
 static void remove_sect_attrs(struct module *mod)
 {
 	if (mod->sect_attrs) {
-		kobject_unregister(&mod->sect_attrs->kobj);
+		sysfs_remove_group(&mod->mkobj.kobj,
+				   &mod->sect_attrs->grp);
+		/* We are positive that no one is using any sect attrs
+		 * at this point.  Deallocate immediately. */
+		kfree(mod->sect_attrs);
 		mod->sect_attrs = NULL;
 	}
 }
