Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVAHHlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVAHHlO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVAHHjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:39:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:44933 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261862AbVAHFsR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:17 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632613738@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:41 -0800
Message-Id: <11051632613761@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.20, 2004/12/21 10:36:35-08:00, tj@home-tj.org

[PATCH] module sysfs: sections attr reimplemented using attr group

        Reimplement section attributes using attribute group.  This
        makes more sense, for, while they reside in a separate
        subdirectory, they belong to the ownig module and their
        lifetime exactly equals the lifetime of the owning module,
        and it's simpler.


Signed-off-by: Tejun Heo <tj@home-tj.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/module.h |    8 ++---
 kernel/module.c        |   75 ++++++++++++++++++++++---------------------------
 2 files changed, 39 insertions(+), 44 deletions(-)


diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	2005-01-07 15:41:32 -08:00
+++ b/include/linux/module.h	2005-01-07 15:41:32 -08:00
@@ -227,14 +227,14 @@
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
 
@@ -313,7 +313,7 @@
 	char *strtab;
 
 	/* Section attributes */
-	struct module_sections *sect_attrs;
+	struct module_sect_attrs *sect_attrs;
 #endif
 
 	/* Per-cpu data. */
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	2005-01-07 15:41:32 -08:00
+++ b/kernel/module.c	2005-01-07 15:41:32 -08:00
@@ -937,76 +937,71 @@
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

