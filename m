Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVCQGnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVCQGnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 01:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVCQGnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 01:43:20 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:11682 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261905AbVCQGkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 01:40:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [PATCH 0/5] I8K driver facelift
Date: Thu, 17 Mar 2005 01:40:48 -0500
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
References: <200502240110.16521.dtor_core@ameritech.net> <4233B65A.4030302@tuxrocks.com> <4238A76A.3040408@tuxrocks.com>
In-Reply-To: <4238A76A.3040408@tuxrocks.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xZSOCedGxeXDHzd"
Message-Id: <200503170140.49328.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xZSOCedGxeXDHzd
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 16 March 2005 16:38, Frank Sorenson wrote:
> Okay, I replaced the sysfs_ops with ops of my own, and now all the show
> and store functions also accept the name of the attribute as a parameter.
> This lets the functions know what attribute is being accessed, and allows
> us to create attributes that share show and store functions, so things
> don't need to be defined at compile time (I feel slightly evil!).

Hrm, can we be a little more explicit and not poke in the sysfs guts right
in the driver? What do you think about the patch below athat implements
"attribute arrays"? And I am attaching cumulative i8k patch using these
arrays so they can be tested.

I am CC-ing Greg to see what he thinks about it.
		 
-- 
Dmitry

===================================================================

sysfs: add support for attribure arrays so it is possible to create
       a (variable) number of similar attributes all sharing the
       same show and store handlers:

          ../<attr_name>/0
          ../<attr_name>/1
               ...
          ../<attr_name>/<n>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 fs/sysfs/Makefile     |    2 
 fs/sysfs/array.c      |  167 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sysfs.h |   20 +++++
 3 files changed, 187 insertions(+), 2 deletions(-)

Index: dtor/fs/sysfs/array.c
===================================================================
--- /dev/null
+++ dtor/fs/sysfs/array.c
@@ -0,0 +1,167 @@
+/*
+ * fs/sysfs/array.c - Operations for adding/removing arrays of attributes.
+ *
+ * Copyright (c) 2005 Dmitry Torokhov <dtor@mail.ru>
+ *
+ * This file is released under the GPL v2.
+ *
+ */
+
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/dcache.h>
+#include <linux/err.h>
+#include "sysfs.h"
+
+struct attr_element {
+	struct attribute attr;
+	unsigned int idx;
+	char name[4];
+};
+#define to_attr_element(e)	container_of(e, struct attr_element, attr)
+
+struct array_object {
+	const struct attribute_array *array;
+	unsigned int n_elements;
+	struct kobject kobj;
+	struct attr_element elements[0];
+};
+#define to_array_object(obj)	container_of(obj, struct array_object, kobj)
+
+static ssize_t
+attr_array_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct attr_element *element = to_attr_element(attr);
+	struct array_object *obj = to_array_object(kobj);
+	ssize_t ret = 0;
+
+	if (obj->array->show) {
+		struct kobject *parent = kobject_get(kobj->parent);
+		ret = obj->array->show(parent, element->idx, buf);
+		kobject_put(parent);
+	}
+
+	return ret;
+}
+
+static ssize_t
+attr_array_store(struct kobject *kobj, struct attribute *attr,
+		 const char *buf, size_t count)
+{
+	struct attr_element *element = to_attr_element(attr);
+	struct array_object *obj = to_array_object(kobj);
+	ssize_t ret = 0;
+
+	if (obj->array->store) {
+		struct kobject *parent = kobject_get(kobj->parent);
+		ret = obj->array->store(parent, element->idx, buf, count);
+		kobject_put(parent);
+	}
+
+	return ret;
+}
+
+static struct sysfs_ops attr_array_sysfs_ops = {
+	.show	= attr_array_show,
+	.store	= attr_array_store,
+};
+
+
+static void attr_array_release(struct kobject *kobj)
+{
+	kfree(to_array_object(kobj));
+}
+
+static struct kobj_type ktype_attr_array = {
+	.release	= attr_array_release,
+	.sysfs_ops	= &attr_array_sysfs_ops,
+};
+
+
+static int create_array_element(struct array_object *obj,
+				unsigned int idx)
+{
+	struct attr_element *element = &obj->elements[idx];
+
+	snprintf(element->name, sizeof(element->name), "%d", idx);
+	element->idx = idx;
+	element->attr = obj->array->attr;
+	element->attr.name = element->name;
+
+	return sysfs_create_file(&obj->kobj, &element->attr);
+}
+
+static inline void remove_array_element(struct array_object *obj,
+					unsigned int idx)
+{
+	sysfs_remove_file(&obj->kobj, &obj->elements[idx].attr);
+}
+
+int sysfs_create_array(struct kobject *kobj,
+		       const struct attribute_array *array,
+		       unsigned int n_elements)
+{
+	struct array_object *obj;
+	size_t size;
+	unsigned int i;
+	int error;
+
+	BUG_ON(!kobj || !kobj->dentry);
+	BUG_ON(!array->attr.name);
+
+	size = sizeof(struct array_object) +
+	       sizeof(struct attr_element) * n_elements;
+
+	obj = kmalloc(size, GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	memset(obj, 0, size);
+	obj->array = array;
+	obj->n_elements = n_elements;
+
+	obj->kobj.ktype = &ktype_attr_array;
+	obj->kobj.parent = kobj;
+	kobject_set_name(&obj->kobj, array->attr.name);
+
+	error = kobject_register(&obj->kobj);
+	if (error)
+		goto fail;
+
+	for (i = 0; i < n_elements; i++) {
+		error = create_array_element(obj, i);
+		if (error) {
+			while (--i)
+				remove_array_element(obj, i);
+			goto fail;
+		}
+	}
+
+	return 0;
+
+ fail:
+	kfree(obj);
+	return error;
+}
+
+void sysfs_remove_array(struct kobject *kobj,
+			const struct attribute_array *array)
+{
+	struct array_object *obj;
+	struct dentry *dir;
+	unsigned int i;
+
+	dir = sysfs_get_dentry(kobj->dentry, array->attr.name);
+
+	if (dir) {
+		obj = to_array_object(to_kobj(dir));
+		for (i = 0; i < obj->n_elements; i++)
+			remove_array_element(obj, i);
+		kobject_unregister(&obj->kobj);
+	}
+
+	dput(dir);
+}
+
+EXPORT_SYMBOL_GPL(sysfs_create_array);
+EXPORT_SYMBOL_GPL(sysfs_remove_array);
Index: dtor/include/linux/sysfs.h
===================================================================
--- dtor.orig/include/linux/sysfs.h
+++ dtor/include/linux/sysfs.h
@@ -26,7 +26,12 @@ struct attribute_group {
 	struct attribute	** attrs;
 };
 
+struct attribute_array {
+	struct attribute	attr;
 
+	ssize_t	(*show)(struct kobject *, unsigned int index, char *);
+	ssize_t	(*store)(struct kobject *, unsigned int index, const char *, size_t);
+};
 
 /**
  * Use these macros to make defining attributes easier. See include/linux/device.h
@@ -102,7 +107,7 @@ sysfs_update_file(struct kobject *, cons
 extern void
 sysfs_remove_file(struct kobject *, const struct attribute *);
 
-extern int 
+extern int
 sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name);
 
 extern void
@@ -114,6 +119,9 @@ int sysfs_remove_bin_file(struct kobject
 int sysfs_create_group(struct kobject *, const struct attribute_group *);
 void sysfs_remove_group(struct kobject *, const struct attribute_group *);
 
+int sysfs_create_array(struct kobject *, const struct attribute_array *, unsigned int);
+void sysfs_remove_array(struct kobject *, const struct attribute_array *);
+
 #else /* CONFIG_SYSFS */
 
 static inline int sysfs_create_dir(struct kobject * k)
@@ -177,6 +185,16 @@ static inline void sysfs_remove_group(st
 	;
 }
 
+static inline int sysfs_create_array(struct kobject * k, const struct attribute_array *a, unsigned int n)
+{
+	return 0;
+}
+
+static inline void sysfs_remove_array(struct kobject * k, const struct attribute_array * a)
+{
+	;
+}
+
 #endif /* CONFIG_SYSFS */
 
 #endif /* _SYSFS_H_ */
Index: dtor/fs/sysfs/Makefile
===================================================================
--- dtor.orig/fs/sysfs/Makefile
+++ dtor/fs/sysfs/Makefile
@@ -3,4 +3,4 @@
 #
 
 obj-y		:= inode.o file.o dir.o symlink.o mount.o bin.o \
-		   group.o
+		   group.o array.o

--Boundary-00=_xZSOCedGxeXDHzd
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="i8k-cumulative.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="i8k-cumulative.patch"

=2D-- dtor/drivers/char/i8k.c.orig	2005-03-17 01:20:04.000000000 -0500
+++ dtor/drivers/char/i8k.c	2005-03-17 01:19:26.000000000 -0500
@@ -20,13 +20,15 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
=2D#include <linux/apm_bios.h>
+#include <linux/seq_file.h>
+#include <linux/dmi.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
=20
 #include <linux/i8k.h>
=20
=2D#define I8K_VERSION		"1.13 14/05/2002"
+#define I8K_VERSION		"1.14 21/02/2005"
=20
 #define I8K_SMM_FN_STATUS	0x0025
 #define I8K_SMM_POWER_STATUS	0x0069
@@ -34,7 +36,8 @@
 #define I8K_SMM_GET_FAN		0x00a3
 #define I8K_SMM_GET_SPEED	0x02a3
 #define I8K_SMM_GET_TEMP	0x10a3
=2D#define I8K_SMM_GET_DELL_SIG	0xffa3
+#define I8K_SMM_GET_DELL_SIG1	0xfea3
+#define I8K_SMM_GET_DELL_SIG2	0xffa3
 #define I8K_SMM_BIOS_VERSION	0x00a6
=20
 #define I8K_FAN_MULT		30
@@ -52,18 +55,7 @@
=20
 #define I8K_TEMPERATURE_BUG	1
=20
=2D#define DELL_SIGNATURE		"Dell Computer"
=2D
=2Dstatic char *supported_models[] =3D {
=2D    "Inspiron",
=2D    "Latitude",
=2D    NULL
=2D};
=2D
=2Dstatic char system_vendor[48] =3D "?";
=2Dstatic char product_name [48] =3D "?";
=2Dstatic char bios_version [4]  =3D "?";
=2Dstatic char serial_number[16] =3D "?";
+static char bios_version[4];
=20
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
 MODULE_DESCRIPTION("Driver for accessing SMM BIOS on Dell laptops");
@@ -73,6 +65,10 @@
 module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Force loading without checking for supported mode=
ls");
=20
+static int ignore_dmi;
+module_param(ignore_dmi, bool, 0);
+MODULE_PARM_DESC(ignore_dmi, "Continue probing hardware even if DMI data d=
oes not match");
+
 static int restricted;
 module_param(restricted, bool, 0);
 MODULE_PARM_DESC(restricted, "Allow fan control if SYS_ADMIN capability se=
t");
@@ -81,69 +77,76 @@
 module_param(power_status, bool, 0600);
 MODULE_PARM_DESC(power_status, "Report power status in /proc/i8k");
=20
=2Dstatic ssize_t i8k_read(struct file *, char __user *, size_t, loff_t *);
+static int i8k_open_fs(struct inode *inode, struct file *file);
 static int i8k_ioctl(struct inode *, struct file *, unsigned int,
 		     unsigned long);
=20
 static struct file_operations i8k_fops =3D {
=2D    .read	=3D i8k_read,
=2D    .ioctl	=3D i8k_ioctl,
+	.open		=3D i8k_open_fs,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+	.ioctl		=3D i8k_ioctl,
 };
=20
=2Dtypedef struct {
=2D    unsigned int eax;
=2D    unsigned int ebx __attribute__ ((packed));
=2D    unsigned int ecx __attribute__ ((packed));
=2D    unsigned int edx __attribute__ ((packed));
=2D    unsigned int esi __attribute__ ((packed));
=2D    unsigned int edi __attribute__ ((packed));
=2D} SMMRegisters;
=2D
=2Dtypedef struct {
=2D    u8	type;
=2D    u8	length;
=2D    u16	handle;
=2D} DMIHeader;
+static struct device_driver i8k_driver =3D {
+	.name		=3D "i8k",
+	.bus		=3D &platform_bus_type,
+};
+
+static struct platform_device *i8k_device;
+
+struct smm_regs {
+	unsigned int eax;
+	unsigned int ebx __attribute__ ((packed));
+	unsigned int ecx __attribute__ ((packed));
+	unsigned int edx __attribute__ ((packed));
+	unsigned int esi __attribute__ ((packed));
+	unsigned int edi __attribute__ ((packed));
+};
+
+static inline char *i8k_get_dmi_data(int field)
+{
+	return dmi_get_system_info(field) ? : "N/A";
+}
=20
 /*
  * Call the System Management Mode BIOS. Code provided by Jonathan Buzzard.
  */
=2Dstatic int i8k_smm(SMMRegisters *regs)
+static int i8k_smm(struct smm_regs *regs)
 {
=2D    int rc;
=2D    int eax =3D regs->eax;
+	int rc;
+	int eax =3D regs->eax;
+
+	asm("pushl %%eax\n\t"
+	    "movl 0(%%eax),%%edx\n\t"
+	    "push %%edx\n\t"
+	    "movl 4(%%eax),%%ebx\n\t"
+	    "movl 8(%%eax),%%ecx\n\t"
+	    "movl 12(%%eax),%%edx\n\t"
+	    "movl 16(%%eax),%%esi\n\t"
+	    "movl 20(%%eax),%%edi\n\t"
+	    "popl %%eax\n\t"
+	    "out %%al,$0xb2\n\t"
+	    "out %%al,$0x84\n\t"
+	    "xchgl %%eax,(%%esp)\n\t"
+	    "movl %%ebx,4(%%eax)\n\t"
+	    "movl %%ecx,8(%%eax)\n\t"
+	    "movl %%edx,12(%%eax)\n\t"
+	    "movl %%esi,16(%%eax)\n\t"
+	    "movl %%edi,20(%%eax)\n\t"
+	    "popl %%edx\n\t"
+	    "movl %%edx,0(%%eax)\n\t"
+	    "lahf\n\t"
+	    "shrl $8,%%eax\n\t"
+	    "andl $1,%%eax\n":"=3Da"(rc)
+	    :    "a"(regs)
+	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
=20
=2D    asm("pushl %%eax\n\t" \
=2D	"movl 0(%%eax),%%edx\n\t" \
=2D	"push %%edx\n\t" \
=2D	"movl 4(%%eax),%%ebx\n\t" \
=2D	"movl 8(%%eax),%%ecx\n\t" \
=2D	"movl 12(%%eax),%%edx\n\t" \
=2D	"movl 16(%%eax),%%esi\n\t" \
=2D	"movl 20(%%eax),%%edi\n\t" \
=2D	"popl %%eax\n\t" \
=2D	"out %%al,$0xb2\n\t" \
=2D	"out %%al,$0x84\n\t" \
=2D	"xchgl %%eax,(%%esp)\n\t"
=2D	"movl %%ebx,4(%%eax)\n\t" \
=2D	"movl %%ecx,8(%%eax)\n\t" \
=2D	"movl %%edx,12(%%eax)\n\t" \
=2D	"movl %%esi,16(%%eax)\n\t" \
=2D	"movl %%edi,20(%%eax)\n\t" \
=2D	"popl %%edx\n\t" \
=2D	"movl %%edx,0(%%eax)\n\t" \
=2D	"lahf\n\t" \
=2D	"shrl $8,%%eax\n\t" \
=2D	"andl $1,%%eax\n" \
=2D	: "=3Da" (rc)
=2D	: "a" (regs)
=2D	: "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
=2D
=2D    if ((rc !=3D 0) || ((regs->eax & 0xffff) =3D=3D 0xffff) || (regs->ea=
x =3D=3D eax)) {
=2D	return -EINVAL;
=2D    }
+	if (rc !=3D 0 || (regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =3D=3D e=
ax)
+		return -EINVAL;
=20
=2D    return 0;
+	return 0;
 }
=20
 /*
@@ -152,24 +155,9 @@
  */
 static int i8k_get_bios_version(void)
 {
=2D    SMMRegisters regs =3D { 0, 0, 0, 0, 0, 0 };
=2D    int rc;
=2D
=2D    regs.eax =3D I8K_SMM_BIOS_VERSION;
=2D    if ((rc=3Di8k_smm(&regs)) < 0) {
=2D	return rc;
=2D    }
=2D
=2D    return regs.eax;
=2D}
+	struct smm_regs regs =3D { .eax =3D I8K_SMM_BIOS_VERSION, };
=20
=2D/*
=2D * Read the machine id.
=2D */
=2Dstatic int i8k_get_serial_number(unsigned char *buff)
=2D{
=2D    strlcpy(buff, serial_number, sizeof(serial_number));
=2D    return 0;
+	return i8k_smm(&regs) ? : regs.eax;
 }
=20
 /*
@@ -177,24 +165,22 @@
  */
 static int i8k_get_fn_status(void)
 {
=2D    SMMRegisters regs =3D { 0, 0, 0, 0, 0, 0 };
=2D    int rc;
+	struct smm_regs regs =3D { .eax =3D I8K_SMM_FN_STATUS, };
+	int rc;
=20
=2D    regs.eax =3D I8K_SMM_FN_STATUS;
=2D    if ((rc=3Di8k_smm(&regs)) < 0) {
=2D	return rc;
=2D    }
=2D
=2D    switch ((regs.eax >> I8K_FN_SHIFT) & I8K_FN_MASK) {
=2D    case I8K_FN_UP:
=2D	return I8K_VOL_UP;
=2D    case I8K_FN_DOWN:
=2D	return I8K_VOL_DOWN;
=2D    case I8K_FN_MUTE:
=2D	return I8K_VOL_MUTE;
=2D    default:
=2D	return 0;
=2D    }
+	if ((rc =3D i8k_smm(&regs)) < 0)
+		return rc;
+
+	switch ((regs.eax >> I8K_FN_SHIFT) & I8K_FN_MASK) {
+	case I8K_FN_UP:
+		return I8K_VOL_UP;
+	case I8K_FN_DOWN:
+		return I8K_VOL_DOWN;
+	case I8K_FN_MUTE:
+		return I8K_VOL_MUTE;
+	default:
+		return 0;
+	}
 }
=20
 /*
@@ -202,20 +188,13 @@
  */
 static int i8k_get_power_status(void)
 {
=2D    SMMRegisters regs =3D { 0, 0, 0, 0, 0, 0 };
=2D    int rc;
+	struct smm_regs regs =3D { .eax =3D I8K_SMM_POWER_STATUS, };
+	int rc;
+
+	if ((rc =3D i8k_smm(&regs)) < 0)
+		return rc;
=20
=2D    regs.eax =3D I8K_SMM_POWER_STATUS;
=2D    if ((rc=3Di8k_smm(&regs)) < 0) {
=2D	return rc;
=2D    }
=2D
=2D    switch (regs.eax & 0xff) {
=2D    case I8K_POWER_AC:
=2D	return I8K_AC;
=2D    default:
=2D	return I8K_BATTERY;
=2D    }
+	return (regs.eax & 0xff) =3D=3D I8K_POWER_AC ? I8K_AC : I8K_BATTERY;
 }
=20
 /*
@@ -223,16 +202,10 @@
  */
 static int i8k_get_fan_status(int fan)
 {
=2D    SMMRegisters regs =3D { 0, 0, 0, 0, 0, 0 };
=2D    int rc;
+	struct smm_regs regs =3D { .eax =3D I8K_SMM_GET_FAN, };
=20
=2D    regs.eax =3D I8K_SMM_GET_FAN;
=2D    regs.ebx =3D fan & 0xff;
=2D    if ((rc=3Di8k_smm(&regs)) < 0) {
=2D	return rc;
=2D    }
=2D
=2D    return (regs.eax & 0xff);
+	regs.ebx =3D fan & 0xff;
+	return i8k_smm(&regs) ? : regs.eax & 0xff;
 }
=20
 /*
@@ -240,16 +213,10 @@
  */
 static int i8k_get_fan_speed(int fan)
 {
=2D    SMMRegisters regs =3D { 0, 0, 0, 0, 0, 0 };
=2D    int rc;
=2D
=2D    regs.eax =3D I8K_SMM_GET_SPEED;
=2D    regs.ebx =3D fan & 0xff;
=2D    if ((rc=3Di8k_smm(&regs)) < 0) {
=2D	return rc;
=2D    }
+	struct smm_regs regs =3D { .eax =3D I8K_SMM_GET_SPEED, };
=20
=2D    return (regs.eax & 0xffff) * I8K_FAN_MULT;
+	regs.ebx =3D fan & 0xff;
+	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * I8K_FAN_MULT;
 }
=20
 /*
@@ -257,532 +224,441 @@
  */
 static int i8k_set_fan(int fan, int speed)
 {
=2D    SMMRegisters regs =3D { 0, 0, 0, 0, 0, 0 };
=2D    int rc;
+	struct smm_regs regs =3D { .eax =3D I8K_SMM_SET_FAN, };
=20
=2D    speed =3D (speed < 0) ? 0 : ((speed > I8K_FAN_MAX) ? I8K_FAN_MAX : s=
peed);
+	speed =3D (speed < 0) ? 0 : ((speed > I8K_FAN_MAX) ? I8K_FAN_MAX : speed);
+	regs.ebx =3D (fan & 0xff) | (speed << 8);
=20
=2D    regs.eax =3D I8K_SMM_SET_FAN;
=2D    regs.ebx =3D (fan & 0xff) | (speed << 8);
=2D    if ((rc=3Di8k_smm(&regs)) < 0) {
=2D	return rc;
=2D    }
=2D
=2D    return (i8k_get_fan_status(fan));
+	return i8k_smm(&regs) ? : i8k_get_fan_status(fan);
 }
=20
 /*
  * Read the cpu temperature.
  */
=2Dstatic int i8k_get_cpu_temp(void)
+static int i8k_get_temp(int sensor)
 {
=2D    SMMRegisters regs =3D { 0, 0, 0, 0, 0, 0 };
=2D    int rc;
=2D    int temp;
+	struct smm_regs regs =3D { .eax =3D I8K_SMM_GET_TEMP, };
+	int rc;
+	int temp;
=20
 #ifdef I8K_TEMPERATURE_BUG
=2D    static int prev =3D 0;
+	static int prev;
 #endif
+	regs.ebx =3D sensor & 0xff;
+	if ((rc =3D i8k_smm(&regs)) < 0)
+		return rc;
=20
=2D    regs.eax =3D I8K_SMM_GET_TEMP;
=2D    if ((rc=3Di8k_smm(&regs)) < 0) {
=2D	return rc;
=2D    }
=2D    temp =3D regs.eax & 0xff;
+	temp =3D regs.eax & 0xff;
=20
 #ifdef I8K_TEMPERATURE_BUG
=2D    /*
=2D     * Sometimes the temperature sensor returns 0x99, which is out of ra=
nge.
=2D     * In this case we return (once) the previous cached value. For exam=
ple:
=2D     # 1003655137 00000058 00005a4b
=2D     # 1003655138 00000099 00003a80 <--- 0x99 =3D 153 degrees
=2D     # 1003655139 00000054 00005c52
=2D     */
=2D    if (temp > I8K_MAX_TEMP) {
=2D	temp =3D prev;
=2D	prev =3D I8K_MAX_TEMP;
=2D    } else {
=2D	prev =3D temp;
=2D    }
+	/*
+	 * Sometimes the temperature sensor returns 0x99, which is out of range.
+	 * In this case we return (once) the previous cached value. For example:
+	 # 1003655137 00000058 00005a4b
+	 # 1003655138 00000099 00003a80 <--- 0x99 =3D 153 degrees
+	 # 1003655139 00000054 00005c52
+	 */
+	if (temp > I8K_MAX_TEMP) {
+		temp =3D prev;
+		prev =3D I8K_MAX_TEMP;
+	} else {
+		prev =3D temp;
+	}
 #endif
=20
=2D    return temp;
+	return temp;
 }
=20
=2Dstatic int i8k_get_dell_signature(void)
+static int i8k_get_dell_signature(int req_fn)
 {
=2D    SMMRegisters regs =3D { 0, 0, 0, 0, 0, 0 };
=2D    int rc;
+	struct smm_regs regs =3D { .eax =3D req_fn, };
+	int rc;
=20
=2D    regs.eax =3D I8K_SMM_GET_DELL_SIG;
=2D    if ((rc=3Di8k_smm(&regs)) < 0) {
=2D	return rc;
=2D    }
+	if ((rc =3D i8k_smm(&regs)) < 0)
+		return rc;
=20
=2D    if ((regs.eax =3D=3D 1145651527) && (regs.edx =3D=3D 1145392204)) {
=2D	return 0;
=2D    } else {
=2D	return -1;
=2D    }
+	return regs.eax =3D=3D 1145651527 && regs.edx =3D=3D 1145392204 ? 0 : -1;
 }
=20
 static int i8k_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
 		     unsigned long arg)
 {
=2D    int val;
=2D    int speed;
=2D    unsigned char buff[16];
=2D    int __user *argp =3D (int __user *)arg;
=2D
=2D    if (!argp)
=2D	return -EINVAL;
=2D
=2D    switch (cmd) {
=2D    case I8K_BIOS_VERSION:
=2D	val =3D i8k_get_bios_version();
=2D	break;
=2D
=2D    case I8K_MACHINE_ID:
=2D	memset(buff, 0, 16);
=2D	val =3D i8k_get_serial_number(buff);
=2D	break;
=2D
=2D    case I8K_FN_STATUS:
=2D	val =3D i8k_get_fn_status();
=2D	break;
=2D
=2D    case I8K_POWER_STATUS:
=2D	val =3D i8k_get_power_status();
=2D	break;
=2D
=2D    case I8K_GET_TEMP:
=2D	val =3D i8k_get_cpu_temp();
=2D	break;
=2D
=2D    case I8K_GET_SPEED:
=2D	if (copy_from_user(&val, argp, sizeof(int))) {
=2D	    return -EFAULT;
=2D	}
=2D	val =3D i8k_get_fan_speed(val);
=2D	break;
+	int val =3D 0;
+	int speed;
+	unsigned char buff[16];
+	int __user *argp =3D (int __user *)arg;
=20
=2D    case I8K_GET_FAN:
=2D	if (copy_from_user(&val, argp, sizeof(int))) {
=2D	    return -EFAULT;
=2D	}
=2D	val =3D i8k_get_fan_status(val);
=2D	break;
+	if (!argp)
+		return -EINVAL;
=20
=2D    case I8K_SET_FAN:
=2D	if (restricted && !capable(CAP_SYS_ADMIN)) {
=2D	    return -EPERM;
=2D	}
=2D	if (copy_from_user(&val, argp, sizeof(int))) {
=2D	    return -EFAULT;
=2D	}
=2D	if (copy_from_user(&speed, argp+1, sizeof(int))) {
=2D	    return -EFAULT;
=2D	}
=2D	val =3D i8k_set_fan(val, speed);
=2D	break;
+	switch (cmd) {
+	case I8K_BIOS_VERSION:
+		val =3D i8k_get_bios_version();
+		break;
=20
=2D    default:
=2D	return -EINVAL;
=2D    }
=2D
=2D    if (val < 0) {
=2D	return val;
=2D    }
=2D
=2D    switch (cmd) {
=2D    case I8K_BIOS_VERSION:
=2D	if (copy_to_user(argp, &val, 4)) {
=2D	    return -EFAULT;
=2D	}
=2D	break;
=2D    case I8K_MACHINE_ID:
=2D	if (copy_to_user(argp, buff, 16)) {
=2D	    return -EFAULT;
=2D	}
=2D	break;
=2D    default:
=2D	if (copy_to_user(argp, &val, sizeof(int))) {
=2D	    return -EFAULT;
=2D	}
=2D	break;
=2D    }
+	case I8K_MACHINE_ID:
+		memset(buff, 0, 16);
+		strlcpy(buff, i8k_get_dmi_data(DMI_PRODUCT_SERIAL), sizeof(buff));
+		break;
=20
=2D    return 0;
=2D}
+	case I8K_FN_STATUS:
+		val =3D i8k_get_fn_status();
+		break;
=20
=2D/*
=2D * Print the information for /proc/i8k.
=2D */
=2Dstatic int i8k_get_info(char *buffer, char **start, off_t fpos, int leng=
th)
=2D{
=2D    int n, fn_key, cpu_temp, ac_power;
=2D    int left_fan, right_fan, left_speed, right_speed;
+	case I8K_POWER_STATUS:
+		val =3D i8k_get_power_status();
+		break;
=20
=2D    cpu_temp     =3D i8k_get_cpu_temp();			/* 11100 =B5s */
=2D    left_fan     =3D i8k_get_fan_status(I8K_FAN_LEFT);	/*   580 =B5s */
=2D    right_fan    =3D i8k_get_fan_status(I8K_FAN_RIGHT);	/*   580 =B5s */
=2D    left_speed   =3D i8k_get_fan_speed(I8K_FAN_LEFT);	/*   580 =B5s */
=2D    right_speed  =3D i8k_get_fan_speed(I8K_FAN_RIGHT);	/*   580 =B5s */
=2D    fn_key       =3D i8k_get_fn_status();			/*   750 =B5s */
=2D    if (power_status) {
=2D	ac_power =3D i8k_get_power_status();		/* 14700 =B5s */
=2D    } else {
=2D	ac_power =3D -1;
=2D    }
=2D
=2D    /*
=2D     * Info:
=2D     *
=2D     * 1)  Format version (this will change if format changes)
=2D     * 2)  BIOS version
=2D     * 3)  BIOS machine ID
=2D     * 4)  Cpu temperature
=2D     * 5)  Left fan status
=2D     * 6)  Right fan status
=2D     * 7)  Left fan speed
=2D     * 8)  Right fan speed
=2D     * 9)  AC power
=2D     * 10) Fn Key status
=2D     */
=2D    n =3D sprintf(buffer, "%s %s %s %d %d %d %d %d %d %d\n",
=2D		I8K_PROC_FMT,
=2D		bios_version,
=2D		serial_number,
=2D		cpu_temp,
=2D		left_fan,
=2D		right_fan,
=2D		left_speed,
=2D		right_speed,
=2D		ac_power,
=2D		fn_key);
=2D
=2D    return n;
=2D}
=2D
=2Dstatic ssize_t i8k_read(struct file *f, char __user *buffer, size_t len,=
 loff_t *fpos)
=2D{
=2D    int n;
=2D    char info[128];
=2D
=2D    n =3D i8k_get_info(info, NULL, 0, 128);
=2D    if (n <=3D 0) {
=2D	return n;
=2D    }
+	case I8K_GET_TEMP:
+		val =3D i8k_get_temp(0);
+		break;
=20
=2D    if (*fpos >=3D n) {
=2D	return 0;
=2D    }
+	case I8K_GET_SPEED:
+		if (copy_from_user(&val, argp, sizeof(int)))
+			return -EFAULT;
=20
=2D    if ((*fpos + len) >=3D n) {
=2D	len =3D n - *fpos;
=2D    }
+		val =3D i8k_get_fan_speed(val);
+		break;
=20
=2D    if (copy_to_user(buffer, info, len) !=3D 0) {
=2D	return -EFAULT;
=2D    }
+	case I8K_GET_FAN:
+		if (copy_from_user(&val, argp, sizeof(int)))
+			return -EFAULT;
=20
=2D    *fpos +=3D len;
=2D    return len;
=2D}
+		val =3D i8k_get_fan_status(val);
+		break;
=20
=2Dstatic char* __init string_trim(char *s, int size)
=2D{
=2D    int len;
=2D    char *p;
+	case I8K_SET_FAN:
+		if (restricted && !capable(CAP_SYS_ADMIN))
+			return -EPERM;
=20
=2D    if ((len =3D strlen(s)) > size) {
=2D	len =3D size;
=2D    }
+		if (copy_from_user(&val, argp, sizeof(int)))
+			return -EFAULT;
=20
=2D    for (p=3Ds+len-1; len && (*p=3D=3D' '); len--,p--) {
=2D	*p =3D '\0';
=2D    }
+		if (copy_from_user(&speed, argp + 1, sizeof(int)))
+			return -EFAULT;
=20
=2D    return s;
=2D}
+		val =3D i8k_set_fan(val, speed);
+		break;
+
+	default:
+		return -EINVAL;
+	}
=20
=2D/* DMI code, stolen from arch/i386/kernel/dmi_scan.c */
+	if (val < 0)
+		return val;
+
+	switch (cmd) {
+	case I8K_BIOS_VERSION:
+		if (copy_to_user(argp, &val, 4))
+			return -EFAULT;
+
+		break;
+	case I8K_MACHINE_ID:
+		if (copy_to_user(argp, buff, 16))
+			return -EFAULT;
+
+		break;
+	default:
+		if (copy_to_user(argp, &val, sizeof(int)))
+			return -EFAULT;
+
+		break;
+	}
+
+	return 0;
+}
=20
 /*
=2D * |<-- dmi->length -->|
=2D * |                   |
=2D * |dmi header    s=3DN  | string1,\0, ..., stringN,\0, ..., \0
=2D *                |                       |
=2D *                +-----------------------+
+ * Print the information for /proc/i8k.
  */
=2Dstatic char* __init dmi_string(DMIHeader *dmi, u8 s)
+static int i8k_proc_show(struct seq_file *seq, void *offset)
 {
=2D    u8 *p;
+	int fn_key, cpu_temp, ac_power;
+	int left_fan, right_fan, left_speed, right_speed;
=20
=2D    if (!s) {
=2D	return "";
=2D    }
=2D    s--;
+	cpu_temp	=3D i8k_get_temp(0);			/* 11100 =B5s */
+	left_fan	=3D i8k_get_fan_status(I8K_FAN_LEFT);	/*   580 =B5s */
+	right_fan	=3D i8k_get_fan_status(I8K_FAN_RIGHT);	/*   580 =B5s */
+	left_speed	=3D i8k_get_fan_speed(I8K_FAN_LEFT);	/*   580 =B5s */
+	right_speed	=3D i8k_get_fan_speed(I8K_FAN_RIGHT);	/*   580 =B5s */
+	fn_key		=3D i8k_get_fn_status();			/*   750 =B5s */
+	if (power_status)
+		ac_power =3D i8k_get_power_status();		/* 14700 =B5s */
+	else
+		ac_power =3D -1;
=20
=2D    p =3D (u8 *)dmi + dmi->length;
=2D    while (s > 0) {
=2D	p +=3D strlen(p);
=2D	p++;
=2D	s--;
=2D    }
+	/*
+	 * Info:
+	 *
+	 * 1)  Format version (this will change if format changes)
+	 * 2)  BIOS version
+	 * 3)  BIOS machine ID
+	 * 4)  Cpu temperature
+	 * 5)  Left fan status
+	 * 6)  Right fan status
+	 * 7)  Left fan speed
+	 * 8)  Right fan speed
+	 * 9)  AC power
+	 * 10) Fn Key status
+	 */
+	return seq_printf(seq, "%s %s %s %d %d %d %d %d %d %d\n",
+			  I8K_PROC_FMT,
+			  bios_version,
+			  dmi_get_system_info(DMI_PRODUCT_SERIAL) ? : "N/A",
+			  cpu_temp,
+			  left_fan, right_fan, left_speed, right_speed,
+			  ac_power, fn_key);
+}
=20
=2D    return p;
+static int i8k_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, i8k_proc_show, NULL);
 }
=20
=2Dstatic void __init dmi_decode(DMIHeader *dmi)
+
+static ssize_t i8k_sysfs_temp_show(struct kobject *kobj, unsigned int idx,=
 char *buf)
 {
=2D    u8 *data =3D (u8 *) dmi;
=2D    char *p;
+	int temp =3D i8k_get_temp(idx);
+	return temp < 0 ? -EIO : sprintf(buf, "%d\n", temp);
+}
=20
=2D#ifdef I8K_DEBUG
=2D    int i;
=2D    printk("%08x ", (int)data);
=2D    for (i=3D0; i<data[1] && i<64; i++) {
=2D	printk("%02x ", data[i]);
=2D    }
=2D    printk("\n");
=2D#endif
+static struct attribute_array i8k_temp_attr =3D
+	__ATTR(temp, 0444, i8k_sysfs_temp_show, NULL);
=20
=2D    switch (dmi->type) {
=2D    case  0:	/* BIOS Information */
=2D	p =3D dmi_string(dmi,data[5]);
=2D	if (*p) {
=2D	    strlcpy(bios_version, p, sizeof(bios_version));
=2D	    string_trim(bios_version, sizeof(bios_version));
=2D	}
=2D	break;=09
=2D    case 1:	/* System Information */
=2D	p =3D dmi_string(dmi,data[4]);
=2D	if (*p) {
=2D	    strlcpy(system_vendor, p, sizeof(system_vendor));
=2D	    string_trim(system_vendor, sizeof(system_vendor));
=2D	}
=2D	p =3D dmi_string(dmi,data[5]);
=2D	if (*p) {
=2D	    strlcpy(product_name, p, sizeof(product_name));
=2D	    string_trim(product_name, sizeof(product_name));
=2D	}
=2D	p =3D dmi_string(dmi,data[7]);
=2D	if (*p) {
=2D	    strlcpy(serial_number, p, sizeof(serial_number));
=2D	    string_trim(serial_number, sizeof(serial_number));
=2D	}
=2D	break;
=2D    }
+static ssize_t i8k_sysfs_fan_show(struct kobject *kobj, unsigned int idx, =
char *buf)
+{
+	int status =3D i8k_get_fan_status(idx);
+	return status < 0 ? -EIO : sprintf(buf, "%d\n", status);
 }
=20
=2Dstatic int __init dmi_table(u32 base, int len, int num, void (*fn)(DMIHe=
ader*))
+static ssize_t i8k_sysfs_fan_set(struct kobject *kobj, unsigned int idx, c=
onst char *buf, size_t count)
 {
=2D    u8 *buf;
=2D    u8 *data;
=2D    DMIHeader *dmi;
=2D    int i =3D 1;
=2D
=2D    buf =3D ioremap(base, len);
=2D    if (buf =3D=3D NULL) {
=2D	return -1;
=2D    }
=2D    data =3D buf;
=2D
=2D    /*
=2D     * Stop when we see al the items the table claimed to have
=2D     * or we run off the end of the table (also happens)
=2D     */
=2D    while ((i<num) && ((data-buf) < len)) {
=2D	dmi =3D (DMIHeader *)data;
=2D	/*
=2D	 * Avoid misparsing crud if the length of the last
=2D	 * record is crap
=2D	 */
=2D	if ((data-buf+dmi->length) >=3D len) {
=2D	    break;
=2D	}
=2D	fn(dmi);
=2D	data +=3D dmi->length;
=2D	/*
=2D	 * Don't go off the end of the data if there is
=2D	 * stuff looking like string fill past the end
=2D	 */
=2D	while (((data-buf) < len) && (*data || data[1])) {
=2D	    data++;
=2D	}
=2D	data +=3D 2;
=2D	i++;
=2D    }
=2D    iounmap(buf);
=2D
=2D    return 0;
=2D}
=2D
=2Dstatic int __init dmi_iterate(void (*decode)(DMIHeader *))
=2D{
=2D	unsigned char buf[20];
=2D	void __iomem *p =3D ioremap(0xe0000, 0x20000), *q;
=2D
=2D	if (!p)
=2D		return -1;
=2D
=2D	for (q =3D p; q < p + 0x20000; q +=3D 16) {
=2D		memcpy_fromio(buf, q, 20);
=2D		if (memcmp(buf, "_DMI_", 5)=3D=3D0) {
=2D			u16 num  =3D buf[13]<<8  | buf[12];
=2D			u16 len  =3D buf [7]<<8  | buf [6];
=2D			u32 base =3D buf[11]<<24 | buf[10]<<16 | buf[9]<<8 | buf[8];
=2D#ifdef I8K_DEBUG
=2D			printk(KERN_INFO "DMI %d.%d present.\n",
=2D			   buf[14]>>4, buf[14]&0x0F);
=2D			printk(KERN_INFO "%d structures occupying %d bytes.\n",
=2D			   buf[13]<<8 | buf[12],
=2D			   buf [7]<<8 | buf[6]);
=2D			printk(KERN_INFO "DMI table at 0x%08X.\n",
=2D			   buf[11]<<24 | buf[10]<<16 | buf[9]<<8 | buf[8]);
=2D#endif
=2D			if (dmi_table(base, len, num, decode)=3D=3D0) {
=2D				iounmap(p);
=2D				return 0;
=2D			}
=2D		}
=2D	}
=2D	iounmap(p);
=2D	return -1;
+	unsigned long state;
+	char *rest;
+
+	if (restricted && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	state =3D simple_strtoul(buf, &rest, 10);
+	if (*rest || state > I8K_FAN_MAX)
+		return -EINVAL;
+
+	if (i8k_set_fan(idx, state) < 0)
+		return -EIO;
+
+	return count;
 }
=2D/* end of DMI code */
=20
=2D/*
=2D * Get DMI information.
=2D */
=2Dstatic int __init i8k_dmi_probe(void)
+static struct attribute_array i8k_fan_state_attr =3D
+	__ATTR(fan_state, 0644, i8k_sysfs_fan_show, i8k_sysfs_fan_set);
+
+static ssize_t i8k_sysfs_fan_speed_show(struct kobject *kobj, unsigned int=
 idx, char *buf)
 {
=2D    char **p;
+	int speed =3D i8k_get_fan_speed(idx);
+	return speed < 0 ? -EIO : sprintf(buf, "%d\n", speed);
+}
=20
=2D    if (dmi_iterate(dmi_decode) !=3D 0) {
=2D	printk(KERN_INFO "i8k: unable to get DMI information\n");
=2D	return -ENODEV;
=2D    }
=2D
=2D    if (strncmp(system_vendor,DELL_SIGNATURE,strlen(DELL_SIGNATURE)) !=
=3D 0) {
=2D	printk(KERN_INFO "i8k: not running on a Dell system\n");
=2D	return -ENODEV;
=2D    }
=2D
=2D    for (p=3Dsupported_models; ; p++) {
=2D	if (!*p) {
=2D	    printk(KERN_INFO "i8k: unsupported model: %s\n", product_name);
=2D	    return -ENODEV;
=2D	}
=2D	if (strncmp(product_name,*p,strlen(*p)) =3D=3D 0) {
=2D	    break;
=2D	}
=2D    }
+static struct attribute_array i8k_fan_speed_attr =3D
+	__ATTR(fan_speed, 0644, i8k_sysfs_fan_speed_show, NULL);
=20
=2D    return 0;
+static ssize_t i8k_sysfs_power_status_show(struct device *dev, char *buf)
+{
+	int status =3D power_status ? i8k_get_power_status() : -1;
+	return status < 0 ? -EIO : sprintf(buf, "%d\n", status);
 }
=20
+static struct device_attribute i8k_power_status_attr =3D
+	__ATTR(power_status, 0444, i8k_sysfs_power_status_show, NULL);
+
+
+static struct dmi_system_id __initdata i8k_dmi_table[] =3D {
+	{
+		.ident =3D "Dell Inspiron",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
+		},
+	},
+	{
+		.ident =3D "Dell Latitude",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude"),
+		},
+	},
+	{
+		.ident =3D "Dell Inspiron 2",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
+		},
+	},
+	{
+		.ident =3D "Dell Latitude 2",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude"),
+		},
+	},
+	{ }
+};
+
 /*
  * Probe for the presence of a supported laptop.
  */
 static int __init i8k_probe(void)
 {
=2D    char buff[4];
=2D    int version;
=2D    int smm_found =3D 0;
=2D
=2D    /*
=2D     * Get DMI information
=2D     */
=2D    if (i8k_dmi_probe() !=3D 0) {
=2D	printk(KERN_INFO "i8k: vendor=3D%s, model=3D%s, version=3D%s\n",
=2D	       system_vendor, product_name, bios_version);
=2D    }
=2D
=2D    /*
=2D     * Get SMM Dell signature
=2D     */
=2D    if (i8k_get_dell_signature() !=3D 0) {
=2D	printk(KERN_INFO "i8k: unable to get SMM Dell signature\n");
=2D    } else {
=2D	smm_found =3D 1;
=2D    }
=2D
=2D    /*
=2D     * Get SMM BIOS version.
=2D     */
=2D    version =3D i8k_get_bios_version();
=2D    if (version <=3D 0) {
=2D	printk(KERN_INFO "i8k: unable to get SMM BIOS version\n");
=2D    } else {
=2D	smm_found =3D 1;
=2D	buff[0] =3D (version >> 16) & 0xff;
=2D	buff[1] =3D (version >>  8) & 0xff;
=2D	buff[2] =3D (version)       & 0xff;
=2D	buff[3] =3D '\0';
+	char buff[4];
+	int version;
+
 	/*
=2D	 * If DMI BIOS version is unknown use SMM BIOS version.
+	 * Get DMI information
 	 */
=2D	if (bios_version[0] =3D=3D '?') {
=2D	    strcpy(bios_version, buff);
+	if (!dmi_check_system(i8k_dmi_table)) {
+		if (!ignore_dmi && !force)
+			return -ENODEV;
+
+		printk(KERN_INFO "i8k: not running on a supported Dell system.\n");
+		printk(KERN_INFO "i8k: vendor=3D%s, model=3D%s, version=3D%s\n",
+			i8k_get_dmi_data(DMI_SYS_VENDOR),
+			i8k_get_dmi_data(DMI_PRODUCT_NAME),
+			i8k_get_dmi_data(DMI_BIOS_VERSION));
 	}
+
+	strlcpy(bios_version, i8k_get_dmi_data(DMI_BIOS_VERSION), sizeof(bios_ver=
sion));
+
 	/*
=2D	 * Check if the two versions match.
+	 * Get SMM Dell signature
 	 */
=2D	if (strncmp(buff,bios_version,sizeof(bios_version)) !=3D 0) {
=2D	    printk(KERN_INFO "i8k: BIOS version mismatch: %s !=3D %s\n",
=2D		   buff, bios_version);
+	if (i8k_get_dell_signature(I8K_SMM_GET_DELL_SIG1) &&
+	    i8k_get_dell_signature(I8K_SMM_GET_DELL_SIG2)) {
+		printk(KERN_ERR "i8k: unable to get SMM Dell signature\n");
+		if (!force)
+			return -ENODEV;
 	}
=2D    }
=20
=2D    if (!smm_found && !force) {
=2D	return -ENODEV;
=2D    }
+	/*
+	 * Get SMM BIOS version.
+	 */
+	version =3D i8k_get_bios_version();
+	if (version <=3D 0) {
+		printk(KERN_ERR "i8k: unable to get SMM BIOS version\n");
+		if (!force)
+			return -ENODEV;
+	} else {
+		buff[0] =3D (version >> 16) & 0xff;
+		buff[1] =3D (version >> 8) & 0xff;
+		buff[2] =3D (version) & 0xff;
+		buff[3] =3D '\0';
+		/*
+		 * If DMI BIOS version is unknown use SMM BIOS version.
+		 */
+		if (!dmi_get_system_info(DMI_BIOS_VERSION))
+			strlcpy(bios_version, buff, sizeof(bios_version));
+
+		/*
+		 * Check if the two versions match.
+		 */
+		if (strncmp(buff, bios_version, sizeof(bios_version)) !=3D 0)
+			printk(KERN_WARNING "i8k: BIOS version mismatch: %s !=3D %s\n",
+				buff, bios_version);
+	}
=20
=2D    return 0;
+	return 0;
 }
=20
=2D#ifdef MODULE
=2Dstatic
=2D#endif
=2Dint __init i8k_init(void)
+static int __init i8k_create_sysfs_files(void)
 {
=2D    struct proc_dir_entry *proc_i8k;
+	int err, num;
+
+	err =3D device_create_file(&i8k_device->dev, &i8k_power_status_attr);
+	if (err)
+		return err;
+
+	for (num =3D 0; i8k_get_fan_status(num) >=3D 0; num++)
+		/* empty */;
+
+	err =3D sysfs_create_array(&i8k_device->dev.kobj, &i8k_fan_state_attr, nu=
m);
+	if (err)
+		goto fail1;
+
+	err =3D sysfs_create_array(&i8k_device->dev.kobj, &i8k_fan_speed_attr, nu=
m);
+	if (err)
+		goto fail2;
=20
=2D    /* Are we running on an supported laptop? */
=2D    if (i8k_probe() !=3D 0) {
=2D	return -ENODEV;
=2D    }
+	for (num =3D 0; i8k_get_temp(num) >=3D 0; num++)
+		/* empty */;
=20
=2D    /* Register the proc entry */
=2D    proc_i8k =3D create_proc_info_entry("i8k", 0, NULL, i8k_get_info);
=2D    if (!proc_i8k) {
=2D	return -ENOENT;
=2D    }
=2D    proc_i8k->proc_fops =3D &i8k_fops;
=2D    proc_i8k->owner =3D THIS_MODULE;
+	err =3D sysfs_create_array(&i8k_device->dev.kobj, &i8k_temp_attr, num);
+	if (err)
+		goto fail3;
=20
=2D    printk(KERN_INFO
=2D	   "Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
=2D	   I8K_VERSION);
+	return 0;
=20
=2D    return 0;
+fail3:	sysfs_remove_array(&i8k_device->dev.kobj, &i8k_fan_speed_attr);
+fail2:	sysfs_remove_array(&i8k_device->dev.kobj, &i8k_fan_state_attr);
+fail1:	device_remove_file(&i8k_device->dev, &i8k_power_status_attr);
+	return err;
 }
=20
=2D#ifdef MODULE
=2Dint init_module(void)
+static void __exit i8k_remove_sysfs_files(void)
 {
=2D    return i8k_init();
+	sysfs_remove_array(&i8k_device->dev.kobj, &i8k_temp_attr);
+	sysfs_remove_array(&i8k_device->dev.kobj, &i8k_fan_state_attr);
+	sysfs_remove_array(&i8k_device->dev.kobj, &i8k_fan_speed_attr);
+	device_remove_file(&i8k_device->dev, &i8k_power_status_attr);
 }
=20
=2Dvoid cleanup_module(void)
+static int __init i8k_init(void)
 {
=2D    /* Remove the proc entry */
=2D    remove_proc_entry("i8k", NULL);
+	struct proc_dir_entry *proc_i8k;
+	int err;
+
+	/* Are we running on an supported laptop? */
+	if (i8k_probe())
+		return -ENODEV;
+
+	/* Register the proc entry */
+	proc_i8k =3D create_proc_entry("i8k", 0, NULL);
+	if (!proc_i8k)
+		return -ENOENT;
+
+	proc_i8k->proc_fops =3D &i8k_fops;
+	proc_i8k->owner =3D THIS_MODULE;
+
+	err =3D driver_register(&i8k_driver);
+	if (err)
+		goto fail1;
+
+	i8k_device =3D platform_device_register_simple("i8k", -1, NULL, 0);
+	if (IS_ERR(i8k_device)) {
+		err =3D PTR_ERR(i8k_device);
+		goto fail2;
+	}
+
+	err =3D i8k_create_sysfs_files();
+	if (err)
+		goto fail3;
=20
=2D    printk(KERN_INFO "i8k: module unloaded\n");
+	printk(KERN_INFO
+	       "Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
+	       I8K_VERSION);
+
+	return 0;
+
+fail3:	platform_device_unregister(i8k_device);
+fail2:	driver_unregister(&i8k_driver);
+fail1:	remove_proc_entry("i8k", NULL);
+	return err;
+}
+
+static void __exit i8k_exit(void)
+{
+	i8k_remove_sysfs_files();
+	platform_device_unregister(i8k_device);
+	driver_unregister(&i8k_driver);
+	remove_proc_entry("i8k", NULL);
 }
=2D#endif
=20
=2D/* end of file */
+module_init(i8k_init);
+module_exit(i8k_exit);
=2D-- dtor/drivers/char/misc.c.orig	2005-03-17 01:24:32.000000000 -0500
+++ dtor/drivers/char/misc.c	2005-03-17 01:24:13.000000000 -0500
@@ -67,7 +67,6 @@
 extern int rtc_MK48T08_init(void);
 extern int pmu_device_init(void);
 extern int tosh_init(void);
=2Dextern int i8k_init(void);
=20
 #ifdef CONFIG_PROC_FS
 static void *misc_seq_start(struct seq_file *seq, loff_t *pos)
@@ -317,9 +316,6 @@
 #ifdef CONFIG_TOSHIBA
 	tosh_init();
 #endif
=2D#ifdef CONFIG_I8K
=2D	i8k_init();
=2D#endif
 	if (register_chrdev(MISC_MAJOR,"misc",&misc_fops)) {
 		printk("unable to get major %d for misc devices\n",
 		       MISC_MAJOR);

--Boundary-00=_xZSOCedGxeXDHzd--
