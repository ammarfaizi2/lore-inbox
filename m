Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbTAWK2B>; Thu, 23 Jan 2003 05:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTAWK2B>; Thu, 23 Jan 2003 05:28:01 -0500
Received: from fmr02.intel.com ([192.55.52.25]:47059 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265092AbTAWK14>; Thu, 23 Jan 2003 05:27:56 -0500
Date: Thu, 23 Jan 2003 18:34:42 +0800 (CST)
From: Stanley Wang <stanley.wang@linux.co.intel.com>
X-X-Sender: stanley@manticore.sh.intel.com
To: Greg KH <greg@kroah.com>
cc: Stanley Wang <stanley.wang@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] Replace pcihpfs with sysfs.
In-Reply-To: <20030123045447.GB6584@kroah.com>
Message-ID: <Pine.LNX.4.44.0301231814110.28943-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg
My patch is in the end of mail.

On Wed, 22 Jan 2003, Greg KH wrote:

> On Wed, Jan 22, 2003 at 09:39:01AM +0800, Stanley Wang wrote:
> > Hi, Grep
> 
> "Grep"?  Who's that?  :)
I'm so sorry for misspelling your name. Please forgive me :)
 
> > diff -Nru a/drivers/hotplug/cpci_hotplug_core.c 
> b/drivers/hotplug/cpci_hotplug_core.c
> > --- a/drivers/hotplug/cpci_hotplug_core.c     Wed Jan 22 09:30:20 2003
> > +++ b/drivers/hotplug/cpci_hotplug_core.c     Wed Jan 22 09:30:20 2003
> > @@ -130,7 +130,7 @@
> >               return -EINVAL;
> >       memcpy(&info, hotplug_slot->info, sizeof(struct 
> hotplug_slot_info));
> >        info.latch_status = value;
> > -     return pci_hp_change_slot_info(hotplug_slot->name, &info);
> > +     return 0;
>
> We really need to keep this functionality.  Unfortunatly sysfs doesn't
> support that yet.  I'd keep the call to pci_hp_change_slot_info() around
> to point out that this needs to be fixed in sysfs.
I've restore it as an empty function. We can stuff it when we have sysfs 
support.

> >  /* Random magic number */
> >  #define PCIHPFS_MAGIC 0x52454541
> 
> You can also remove this #define now, right?
>

Done.
 
> > +static struct subsystem hotplug_slot_subsys;
> 
> You need to initialize this structure to something, and give it a name.
> Otherwise all of the slots show up in the top of sysfs, right?  I would
> really like to see these directories show up in /sys/bus/pci/slots/ if
> you can get them to go there.
>
Done. I move it from "/sys/hotplug_slot" to "/sys/bus/pci/hotplug_slots".
Is it OK ? 
 
> Why change from simple_strtoul() to sscanf()?  Is this a needed change?
You are right :) I've restored them.

> 
> >  static void __exit pci_hotplug_exit (void)
> >  {
> > -	cpci_hotplug_exit();
> > -
> > -	unregister_filesystem(&pcihpfs_type);
> > -
> >  #ifdef CONFIG_PROC_FS
> >  	if (slotdir)
> >  		remove_proc_entry(slotdir_name, proc_bus_pci_dir);
> >  #endif
> > +
> > +	cpci_hotplug_exit();
> > +	subsystem_unregister(&hotplug_slot_subsys);
> >  }
> >  
> >  module_init(pci_hotplug_init);
> 
> Why reorder these calls?  Also, the whole slotdir_name stuff can be
> ripped out, as we will not be needing that proc directory anymore.
I think it would look better that we call these functions in reverse
order according to the order in the initializing function.
How do you think about this?

Best Regards,
-Stan


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.958   -> 1.959  
#	drivers/hotplug/cpqphp_ctrl.c	1.7     -> 1.8    
#	drivers/hotplug/pci_hotplug.h	1.5     -> 1.6    
#	drivers/hotplug/cpci_hotplug_core.c	1.3     -> 1.4    
#	drivers/hotplug/pci_hotplug_core.c	1.33    -> 1.34   
#	drivers/hotplug/ibmphp_core.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/23	stanley@manticore.sh.intel.com	1.959
# Restore pci_hp_change_slot_info() and move the place of hotplug_slot entry in sysfs.
# A little changes according to Greg's comments.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/cpci_hotplug_core.c b/drivers/hotplug/cpci_hotplug_core.c
--- a/drivers/hotplug/cpci_hotplug_core.c	Thu Jan 23 18:04:40 2003
+++ b/drivers/hotplug/cpci_hotplug_core.c	Thu Jan 23 18:04:40 2003
@@ -130,7 +130,7 @@
 		return -EINVAL;
 	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
 	info.latch_status = value;
-	return 0;
+	return pci_hp_change_slot_info(hotplug_slot->name, &info);
 }
 
 static int
@@ -142,7 +142,7 @@
 		return -EINVAL;
 	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
 	info.adapter_status = value;
-	return 0;
+	return pci_hp_change_slot_info(hotplug_slot->name, &info);
 }
 
 static int
diff -Nru a/drivers/hotplug/cpqphp_ctrl.c b/drivers/hotplug/cpqphp_ctrl.c
--- a/drivers/hotplug/cpqphp_ctrl.c	Thu Jan 23 18:04:40 2003
+++ b/drivers/hotplug/cpqphp_ctrl.c	Thu Jan 23 18:04:40 2003
@@ -1766,6 +1766,7 @@
 {
 	struct hotplug_slot_info *info;
 	char buffer[SLOT_NAME_SIZE];
+	int result;
 
 	info = kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
 	if (!info)
@@ -1776,8 +1777,9 @@
 	info->attention_status = cpq_get_attention_status(ctrl, slot);
 	info->latch_status = cpq_get_latch_status(ctrl, slot);
 	info->adapter_status = get_presence_status(ctrl, slot);
+	result = pci_hp_change_slot_info(buffer, info);
 	kfree (info);
-	return 0;
+	return result;
 }
 
 static void interrupt_event_handler(struct controller *ctrl)
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Thu Jan 23 18:04:40 2003
+++ b/drivers/hotplug/ibmphp_core.c	Thu Jan 23 18:04:40 2003
@@ -687,6 +687,7 @@
 {
 	struct hotplug_slot_info *info;
 	char buffer[30];
+	int rc;
 	u8 bus_speed;
 	u8 mode;
 
@@ -734,8 +735,9 @@
 	info->max_bus_speed = slot_cur->hotplug_slot->info->max_bus_speed;
 	// To do: bus_names 
 	
+	rc = pci_hp_change_slot_info (buffer, info);
 	kfree (info);
-	return 0;
+	return rc;
 }
 
 
diff -Nru a/drivers/hotplug/pci_hotplug.h b/drivers/hotplug/pci_hotplug.h
--- a/drivers/hotplug/pci_hotplug.h	Thu Jan 23 18:04:40 2003
+++ b/drivers/hotplug/pci_hotplug.h	Thu Jan 23 18:04:40 2003
@@ -139,6 +139,8 @@
 
 extern int pci_hp_register		(struct hotplug_slot *slot);
 extern int pci_hp_deregister		(struct hotplug_slot *slot);
+extern int pci_hp_change_slot_info	(const char *name,
+					 struct hotplug_slot_info *info);
 
 struct pci_dev_wrapped {
 	struct pci_dev	*dev;
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Jan 23 18:04:40 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Jan 23 18:04:40 2003
@@ -69,14 +69,11 @@
 
 //////////////////////////////////////////////////////////////////
 
-/* Random magic number */
-#define PCIHPFS_MAGIC 0x52454541
-
 static spinlock_t list_lock;
 
 static LIST_HEAD(pci_hotplug_slot_list);
 
-static struct subsystem hotplug_slot_subsys;
+static struct subsystem hotplug_slots_subsys;
 
 static ssize_t hotplug_slot_attr_show(struct kobject *kobj,
 		struct attribute *attr, char *buf)
@@ -107,7 +104,7 @@
 	.sysfs_ops = &hotplug_slot_sysfs_ops
 };
 
-static decl_subsys(hotplug_slot, &hotplug_slot_ktype);
+static decl_subsys(hotplug_slots, &hotplug_slot_ktype);
 
 
 /* these strings match up with the values in pci_bus_speed */
@@ -187,16 +184,13 @@
 static ssize_t power_write_file (struct hotplug_slot *slot, const char *buf,
 		size_t count)
 {
-	unsigned long power;
+	unsigned long lpower;
+	u8 power;
 	int retval = 0;
 
-	retval = sscanf(buf, "%ld", &power);
-	if (retval != 1) {
-		err("Illegla value specified for power\n");
-		retval = -EINVAL;
-		goto exit;
-	}
-	dbg ("power = %ld\n", power);
+	lpower = simple_strtoul (buf, NULL, 10);
+	power = (u8)(lpower & 0xff);
+	dbg ("power = %d\n", power);
 
 	if (!try_module_get(slot->ops->owner)) {
 		retval = -ENODEV;
@@ -252,13 +246,8 @@
 	u8 attention;
 	int retval = 0;
 
-	retval = sscanf (buf, "%ld", &lattention);
-	if (retval != 1) {
-		err("Illegla value specified for power\n");
-		retval = -EINVAL;
-		goto exit;
-	}
-	attention = (u8)(lattention & 0xff );
+	lattention = simple_strtoul (buf, NULL, 10);
+	attention = (u8)(lattention & 0xff);
 	dbg (" - attention = %d\n", attention);
 
 	if (!try_module_get(slot->ops->owner)) {
@@ -376,15 +365,12 @@
 static ssize_t test_write_file (struct hotplug_slot *slot, const char *buf,
 		size_t count)
 {
+	unsigned long ltest;
 	u32 test;
 	int retval = 0;
 
-	retval = sscanf (buf, "%d", &test);
-	if (retval != 1) {
-		err("Illegla value specified for power\n");
-		retval = -EINVAL;
-		goto exit;
-	}
+        ltest = simple_strtoul (buf, NULL, 10);
+	test = (u32)(ltest & 0xffffffff);
 	dbg ("test = %d\n", test);
 
 	if (!try_module_get(slot->ops->owner)) {
@@ -500,7 +486,7 @@
 	}
 
 	strncpy(slot->kobj.name, slot->name, KOBJ_NAME_LEN);
-	slot->kobj.kset = &hotplug_slot_subsys.kset;
+	slot->kobj.kset = &hotplug_slots_subsys.kset;
 
 	if (kobject_register(&slot->kobj)) {
 		err("Unable to register kobject");
@@ -548,13 +534,30 @@
 	return 0;
 }
 
+/**
+ * pci_hp_change_slot_info - changes the slot's information structure in the core
+ * @name: the name of the slot whose info has changed
+ * @info: pointer to the info copy into the slot's info structure
+ *
+ * A slot with @name must have been registered with the pci 
+ * hotplug subsystem previously with a call to pci_hp_register().
+ *
+ * Returns 0 if successful, anything else for an error.
+ * Not supported by sysfs now.
+ */
+int pci_hp_change_slot_info (const char *name, struct hotplug_slot_info *info)
+{
+	return 0;
+}
+
 static int __init pci_hotplug_init (void)
 {
 	int result;
 
 	spin_lock_init(&list_lock);
 
-	result = subsystem_register(&hotplug_slot_subsys);
+	kset_set_kset_s(&hotplug_slots_subsys, pci_bus_type.subsys);
+	result = subsystem_register(&hotplug_slots_subsys);
 	if (result) {
 		err("Register subsys with error %d\n", result);
 		goto exit;
@@ -574,7 +577,7 @@
 	goto exit;
 	
 err_subsys:
-	subsystem_unregister(&hotplug_slot_subsys);
+	subsystem_unregister(&hotplug_slots_subsys);
 exit:
 	return result;
 }
@@ -587,7 +590,7 @@
 #endif
 
 	cpci_hotplug_exit();
-	subsystem_unregister(&hotplug_slot_subsys);
+	subsystem_unregister(&hotplug_slots_subsys);
 }
 
 module_init(pci_hotplug_init);
@@ -601,3 +604,4 @@
 
 EXPORT_SYMBOL_GPL(pci_hp_register);
 EXPORT_SYMBOL_GPL(pci_hp_deregister);
+EXPORT_SYMBOL_GPL(pci_hp_change_slot_info);



-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


