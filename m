Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVAREIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVAREIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 23:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVAREIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 23:08:09 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:33205 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261225AbVAREHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 23:07:38 -0500
Subject: Re: [RFC/PATCH] add support for sysdev class attributes
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050111192909.GA4623@kroah.com>
References: <1105136891.13391.20.camel@pants.austin.ibm.com>
	 <20050108050729.GA7587@kroah.com>
	 <1105372684.27280.3.camel@localhost.localdomain>
	 <20050111192909.GA4623@kroah.com>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 22:02:44 -0600
Message-Id: <1106020965.11566.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 11:29 -0800, Greg KH wrote:
> On Mon, Jan 10, 2005 at 09:58:03AM -0600, Nathan Lynch wrote:
> > On Fri, 2005-01-07 at 21:07 -0800, Greg KH wrote:
> > > On Fri, Jan 07, 2005 at 04:28:12PM -0600, Nathan Lynch wrote:
> > > > @@ -88,6 +123,12 @@ int sysdev_class_register(struct sysdev_
> > > >  	INIT_LIST_HEAD(&cls->drivers);
> > > >  	cls->kset.subsys = &system_subsys;
> > > >  	kset_set_kset_s(cls, system_subsys);
> > > > +
> > > > +	/* I'm not going to claim to understand this; see
> > > > +	 * fs/sysfs/file::check_perm for how sysfs_ops are selected
> > > > +	 */
> > > > +	cls->kset.kobj.ktype = &sysdev_class_ktype;
> > > > +
> > > 
> > > I think you need to understand this, and then submit a patch without
> > > such a comment :)
> > > 
> > > And probably without such code, as I don't think you need to do that.
> > 
> > Sure, now I'm not sure how I convinced myself that bit was needed.
> > Things work fine without it.

OK I'm an idiot, because things certainly do not work without somehow
associating the new sysfs_ops with the sysdev_class being registered.
Otherwise, sysfs winds up using sysdev_store/sysdev_show, since
ktype_sysdev is the kobj_type for the "system" subsystem.

Since sysdev_register is explicitly associating ktype_sysdev with the
sysdev being registered anyway, I think it should be fine to define
system_subsys with sysdev_class_ktype for its kobj_type.  What do you
say?

> > Before I repatch, does sysdev_class_ktype need a release function?
> 
> Why would it not?

I'm not sure what it would actually do...  it seems that we would need
it if sysdevs were dynamically allocated, but they're not.  Not that
they couldn't be, but that's existing practice afaict.  In any case,
it's a matter for a separate patch, I would say.

Updated patch below:


Add support for system device class attributes.  I would like to have
this for doing cpu add and remove on ppc64, and I think the memory
hotplug people probably will want it, too.

o  Add the necessary show and store methods and related data
   structures.

o  Add sysdev_create_file and sysdev_remove_file.

o  Make the "system" subsys' ktype ktype_sysdev_class instead of
   ktype_sysdev, which should be used only for sysdevs.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN drivers/base/sys.c~sysdev_class-attr-support drivers/base/sys.c
--- linux-2.6.11-rc1-bk1/drivers/base/sys.c~sysdev_class-attr-support	2005-01-17 17:04:16.000000000 -0600
+++ linux-2.6.11-rc1-bk1-nathanl/drivers/base/sys.c	2005-01-17 17:32:25.000000000 -0600
@@ -76,10 +76,45 @@ void sysdev_remove_file(struct sys_devic
 EXPORT_SYMBOL_GPL(sysdev_create_file);
 EXPORT_SYMBOL_GPL(sysdev_remove_file);
 
+#define to_sysdev_class(k) container_of(to_kset(k), struct sysdev_class, kset)
+#define to_sysdev_class_attr(a) container_of(a, struct sysdev_class_attribute, attr)
+
+static ssize_t
+sysdev_class_show(struct kobject * kobj, struct attribute * attr, char * buffer)
+{
+	struct sysdev_class * sysdev_class = to_sysdev_class(kobj);
+	struct sysdev_class_attribute * sysdev_class_attr = to_sysdev_class_attr(attr);
+
+	if (sysdev_class_attr->show)
+		return sysdev_class_attr->show(sysdev_class, buffer);
+	return 0;
+}
+
+static ssize_t
+sysdev_class_store(struct kobject * kobj, struct attribute * attr,
+	     const char * buffer, size_t count)
+{
+	struct sysdev_class * sysdev_class = to_sysdev_class(kobj);
+	struct sysdev_class_attribute * sysdev_class_attr = to_sysdev_class_attr(attr);
+
+	if (sysdev_class_attr->store)
+		return sysdev_class_attr->store(sysdev_class, buffer, count);
+	return 0;
+}
+
+static struct sysfs_ops sysdev_class_sysfs_ops = {
+	.show	= sysdev_class_show,
+	.store	= sysdev_class_store,
+};
+
+static struct kobj_type sysdev_class_ktype = {
+	.sysfs_ops	= &sysdev_class_sysfs_ops,
+};
+
 /*
  * declare system_subsys
  */
-decl_subsys(system, &ktype_sysdev, NULL);
+decl_subsys(system, &sysdev_class_ktype, NULL);
 
 int sysdev_class_register(struct sysdev_class * cls)
 {
@@ -98,6 +133,19 @@ void sysdev_class_unregister(struct sysd
 	kset_unregister(&cls->kset);
 }
 
+int sysdev_class_create_file(struct sysdev_class *s, struct sysdev_class_attribute *a)
+{
+	return sysfs_create_file(&s->kset.kobj, &a->attr);
+}
+
+
+void sysdev_class_remove_file(struct sysdev_class *s, struct sysdev_class_attribute *a)
+{
+	sysfs_remove_file(&s->kset.kobj, &a->attr);
+}
+
+EXPORT_SYMBOL_GPL(sysdev_class_create_file);
+EXPORT_SYMBOL_GPL(sysdev_class_remove_file);
 EXPORT_SYMBOL_GPL(sysdev_class_register);
 EXPORT_SYMBOL_GPL(sysdev_class_unregister);
 
diff -puN include/linux/sysdev.h~sysdev_class-attr-support include/linux/sysdev.h
--- linux-2.6.11-rc1-bk1/include/linux/sysdev.h~sysdev_class-attr-support	2005-01-17 17:04:16.000000000 -0600
+++ linux-2.6.11-rc1-bk1-nathanl/include/linux/sysdev.h	2005-01-17 17:04:16.000000000 -0600
@@ -40,6 +40,21 @@ struct sysdev_class {
 extern int sysdev_class_register(struct sysdev_class *);
 extern void sysdev_class_unregister(struct sysdev_class *);
 
+struct sysdev_class_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct sysdev_class *, char *);
+	ssize_t (*store)(struct sysdev_class *, const char *, size_t);
+};
+
+#define SYSDEV_CLASS_ATTR(_name,_mode,_show,_store) 		\
+struct sysdev_class_attribute attr_##_name = { 			\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,					\
+	.store	= _store,					\
+};
+
+extern int sysdev_class_create_file(struct sysdev_class *, struct sysdev_class_attribute *);
+extern void sysdev_class_remove_file(struct sysdev_class *, struct sysdev_class_attribute *);
 
 /**
  * Auxillary system device drivers.

_


