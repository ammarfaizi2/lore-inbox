Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbTA3FQ5>; Thu, 30 Jan 2003 00:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267406AbTA3FQ5>; Thu, 30 Jan 2003 00:16:57 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:10255 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267300AbTA3FQz>;
	Thu, 30 Jan 2003 00:16:55 -0500
Date: Wed, 29 Jan 2003 21:23:13 -0800
From: Greg KH <greg@kroah.com>
To: Stanley Wang <stanley.wang@linux.co.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] Replace pcihpfs with sysfs.
Message-ID: <20030130052313.GK12898@kroah.com>
References: <20030123045447.GB6584@kroah.com> <Pine.LNX.4.44.0301301118010.20600-100000@manticore.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301301118010.20600-100000@manticore.sh.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 11:21:54AM +0800, Stanley Wang wrote:
> On Wed, 22 Jan 2003, Greg KH wrote:
> 
> > > diff -Nru a/drivers/hotplug/cpci_hotplug_core.c b/drivers/hotplug/cpci_hotplug_core.c
> > > --- a/drivers/hotplug/cpci_hotplug_core.c	Wed Jan 22 09:30:20 2003
> > > +++ b/drivers/hotplug/cpci_hotplug_core.c	Wed Jan 22 09:30:20 2003
> > > @@ -130,7 +130,7 @@
> > >  		return -EINVAL;
> > >  	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
> > >  	info.latch_status = value;
> > > -	return pci_hp_change_slot_info(hotplug_slot->name, &info);
> > > +	return 0;
> > 
> > We really need to keep this functionality.  Unfortunatly sysfs doesn't
> > support that yet.  I'd keep the call to pci_hp_change_slot_info() around
> > to point out that this needs to be fixed in sysfs.
> Sorry for my carelessness. I found that we could implement this function
> with sysfs. Following the patch against my last patch. And I will resend a
> new updated all-in-one patch to you.

No, this patch does not update the proper file within sysfs, only the
directory entry, which isn't what we really want.  I just sent off the
following patch to Pat Mochel that adds sysfs_update_file() to sysfs,
and modified the pci hotplug core to use it.  I've already applied your
previous patches, so you don't have to resend anything to me :)

thanks,

greg k-h


# sysfs: add sysfs_update_file() function.

diff -Nru a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c	Wed Jan 29 14:05:17 2003
+++ b/fs/sysfs/inode.c	Wed Jan 29 14:05:17 2003
@@ -37,6 +37,7 @@
 #include <linux/backing-dev.h>
 #include <linux/kobject.h>
 #include <linux/mount.h>
+#include <linux/dnotify.h>
 #include <asm/uaccess.h>
 
 /* Random magic number */
@@ -714,6 +715,46 @@
 		dput(victim);
 	}
 	up(&dir->d_inode->i_sem);
+}
+
+/**
+ * sysfs_update_file - update the modified timestamp on an object attribute.
+ * @kobj: object we're acting for.
+ * @attr: attribute descriptor.
+ *
+ * Also call dnotify for the dentry, which lots of userspace programs
+ * use.
+ */
+int sysfs_update_file(struct kobject * kobj, struct attribute * attr)
+{
+	struct dentry * dir = kobj->dentry;
+	struct dentry * victim;
+	int res = -ENOENT;
+
+	down(&dir->d_inode->i_sem);
+	victim = get_dentry(dir, attr->name);
+	if (!IS_ERR(victim)) {
+		/* make sure dentry is really there */
+		if (victim->d_inode && 
+		    (victim->d_parent->d_inode == dir->d_inode)) {
+			victim->d_inode->i_mtime = CURRENT_TIME;
+			dnotify_parent(victim, DN_MODIFY);
+
+			/**
+			 * Drop reference from initial get_dentry().
+			 */
+			dput(victim);
+			res = 0;
+		}
+		
+		/**
+		 * Drop the reference acquired from get_dentry() above.
+		 */
+		dput(victim);
+	}
+	up(&dir->d_inode->i_sem);
+
+	return res;
 }
 
 
diff -Nru a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h	Wed Jan 29 14:05:17 2003
+++ b/include/linux/sysfs.h	Wed Jan 29 14:05:17 2003
@@ -30,6 +30,9 @@
 extern int
 sysfs_create_file(struct kobject *, struct attribute *);
 
+extern int
+sysfs_update_file(struct kobject *, struct attribute *);
+
 extern void
 sysfs_remove_file(struct kobject *, struct attribute *);
 
