Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbTA3DPk>; Wed, 29 Jan 2003 22:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbTA3DPk>; Wed, 29 Jan 2003 22:15:40 -0500
Received: from fmr02.intel.com ([192.55.52.25]:62926 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267384AbTA3DPh>; Wed, 29 Jan 2003 22:15:37 -0500
Date: Thu, 30 Jan 2003 11:21:54 +0800 (CST)
From: Stanley Wang <stanley.wang@linux.co.intel.com>
X-X-Sender: stanley@manticore.sh.intel.com
To: Greg KH <greg@kroah.com>
cc: Stanley Wang <stanley.wang@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] Replace pcihpfs with sysfs.
In-Reply-To: <20030123045447.GB6584@kroah.com>
Message-ID: <Pine.LNX.4.44.0301301118010.20600-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Greg KH wrote:

> > diff -Nru a/drivers/hotplug/cpci_hotplug_core.c b/drivers/hotplug/cpci_hotplug_core.c
> > --- a/drivers/hotplug/cpci_hotplug_core.c	Wed Jan 22 09:30:20 2003
> > +++ b/drivers/hotplug/cpci_hotplug_core.c	Wed Jan 22 09:30:20 2003
> > @@ -130,7 +130,7 @@
> >  		return -EINVAL;
> >  	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
> >  	info.latch_status = value;
> > -	return pci_hp_change_slot_info(hotplug_slot->name, &info);
> > +	return 0;
> 
> We really need to keep this functionality.  Unfortunatly sysfs doesn't
> support that yet.  I'd keep the call to pci_hp_change_slot_info() around
> to point out that this needs to be fixed in sysfs.
Sorry for my carelessness. I found that we could implement this function
with sysfs. Following the patch against my last patch. And I will resend a
new updated all-in-one patch to you.

Best Regards,
-Stan

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.958   -> 1.959  
#	drivers/hotplug/pci_hotplug_core.c	1.33    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/30	stanley@manticore.sh.intel.com	1.959
# Resotre pci_hp_change_slot_info() in pci_hotlplug_core.c
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Jan 30 11:13:33 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Jan 30 11:13:33 2003
@@ -540,6 +540,35 @@
  */
 int pci_hp_change_slot_info (const char *name, struct hotplug_slot_info *info)
 {
+	struct hotplug_slot *temp;
+
+	if (info == NULL)
+		return -ENODEV;
+
+	spin_lock (&list_lock);
+	temp = get_slot_from_name (name);
+	if (temp == NULL) {
+		spin_unlock (&list_lock);
+		return -ENODEV;
+	}
+
+	/*
+	 * check all fields in the info structure, and update timestamps
+	 * for the files referring to the fields that have now changed.
+	 */
+	if (temp->info->power_status != info->power_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->attention_status != info->attention_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->latch_status != info->latch_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->adapter_status != info->adapter_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->cur_bus_speed != info->cur_bus_speed)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+
+	memcpy (temp->info, info, sizeof (struct hotplug_slot_info));
+	spin_unlock (&list_lock);
 	return 0;
 }
 

-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


