Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSJOFXW>; Tue, 15 Oct 2002 01:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSJOFXW>; Tue, 15 Oct 2002 01:23:22 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:25863 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262416AbSJOFXO>;
	Tue, 15 Oct 2002 01:23:14 -0400
Date: Mon, 14 Oct 2002 22:29:17 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
Message-ID: <20021015052916.GA11190@kroah.com>
References: <3DAB1007.6040400@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAB1007.6040400@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:42:15AM -0700, Steven Dake wrote:
> 
> I welcome comments questions or code to be added to the sourceforge project.

Hi,

Here's some specific comments on your different patches.

--- linux-2.4.19/Documentation/Configure.help	Fri Aug  2 17:39:42 2002
+++ linux-2.4.19-gamap/Documentation/Configure.help	Mon Oct 14 11:16:22 2002
@@ -6795,6 +6795,19 @@
   module if your root file system (the one containing the directory /)
   is located on a SCSI device.
 
+Geographical Address Mapping support
+CONFIG_GAMAP
+  This driver will provide device filesystem dynamic mapping of WWNs
+  to their logical geographical address.  The result is that block
+  storage devices can be accessed using:
+
+      /dev/scsi/chassis/slot/host
+
+  This feature also works after an fdisk updating the appropriate files
+  to match the state of the system.
+
+  This feature is only supported by the Qlogic V6 driver.
+

In looking at this patch (and the others) it looks like you are relying
on devfs being in the system.  Is this true?  What about the other 99%
of machines out there with devfs disabled?

diff -uNr linux-2.4.19/Documentation/devices.txt linux-2.4.19-gamap/Documentation/devices.txt
--- linux-2.4.19/Documentation/devices.txt	Wed Nov  7 15:46:01 2001
+++ linux-2.4.19-gamap/Documentation/devices.txt	Mon Oct 14 11:06:00 2002
@@ -417,8 +417,8 @@
 		218 = /dev/kchuid	Inter-process chuid control
 		219 = /dev/modems/mwave	MWave modem firmware upload
 		220 = /dev/mptctl	Message passing technology (MPT) control
-		221 = /dev/mvista/hssdsi	Montavista PICMG hot swap system driver
-		222 = /dev/mvista/hasi		Montavista PICMG high availability
+		221 = /dev/scsi/hotswap	MontaVista SCSI/FC hotswap driver
+		222 = /dev/scsi/gamap	MontaVista SCSI/FC geographical address mapping driver
 		240-255			Reserved for local use
 
  11 char	Raw keyboard device

You are re-using minors that have previously been reserved.  Does this
mean Montavista is dropping their PICMG patches?

diff -uNr linux-2.4.19/drivers/scsi/gamap.c linux-2.4.19-gamap/drivers/scsi/gamap.c
--- linux-2.4.19/drivers/scsi/gamap.c	Wed Dec 31 17:00:00 1969
+++ linux-2.4.19-gamap/drivers/scsi/gamap.c	Mon Oct 14 11:06:00 2002
<snip>
+#define __KERNEL_SYSCALLS__
+
+#include <linux/unistd.h>

Any reason for this?  I didn't see any internal syscalls being made, but
I might have missed them.

+int ioctl_gamap_getga_from_fc_wwn (unsigned long parameters);
+int ioctl_gamap_getwwn_from_ga (unsigned long parameters);
+int ioctl_gamap_insert_by_scsi_id (unsigned long parameters);
+int ioctl_gamap_remove_by_scsi_id (unsigned long parameters);
+int ioctl_gamap_insert_by_fc_wwn (unsigned long parameters);
+int ioctl_gamap_remove_by_fc_wwn (unsigned long parameters);

These should all be static (along with being a little shorter).

+int gamap_insert_by_fc_wwn (int chassis, int slot, unsigned long long wwn) {
+int i = 0;
+struct Scsi_Host *hba_p;
+Scsi_Device *scsi_device;
+int host, channel, lun, id;
+char devname[32];
+struct gendisk *gendisk;
+int part;
+
+	/*
+	 * Ensure entry not already present in map
+	 * chassis and slot are a match, wwn is seperate match
+	 */

This style is all through the patches.  It is a SCSI way of defining
local variables?  I'd really recommend indenting them to follow the rest
of the kernel style.

+static int gamap_ioctl (struct inode *inode,
+	struct file *file,
+	unsigned int cmd,
+	unsigned long parameters) {
+
+int result = -EINVAL;
+
+	switch (cmd) {

So you let any user do an ioctl command on the device (this goes for the
other patch too.)  You should restrict this to CAP_SYS_ADMIN users only.

All of these ioctl commands look like they can easily be done through a
ramfs like interface.  

+EXPORT_SYMBOL (gamap_getga_from_fc_wwn);
+EXPORT_SYMBOL (gamap_getwwn_from_ga);
+EXPORT_SYMBOL (gamap_insert_by_scsi_id);
+EXPORT_SYMBOL (gamap_remove_by_scsi_id);
+EXPORT_SYMBOL (gamap_insert_by_fc_wwn);
+EXPORT_SYMBOL (gamap_remove_by_fc_wwn);

I don't see any other code using these functions.  Is there a need to
export them?

diff -uNr linux-2.4.19/fs/partitions/check.c linux-2.4.19-gamap/fs/partitions/check.c
--- linux-2.4.19/fs/partitions/check.c	Fri Aug  2 17:39:45 2002
+++ linux-2.4.19-gamap/fs/partitions/check.c	Mon Oct 14 11:06:21 2002
@@ -334,6 +334,35 @@
 }
 #endif  /*  CONFIG_DEVFS_FS  */
 
+#ifdef CONFIG_GAMAP
+static void devfs_gamap_register_partition (struct gendisk *gendisk, int minor, int part) {
+char devname[16];

You shouldn't use a #ifdef within this .c file.  I think you could move
it to your specific file, and then use #ifdef within a .h file.  This
also goes for your other change to this file.

diff -uNr linux-2.4.19/include/linux/genhd.h linux-2.4.19-gamap/include/linux/genhd.h
--- linux-2.4.19/include/linux/genhd.h	Fri Aug  2 17:39:45 2002
+++ linux-2.4.19-gamap/include/linux/genhd.h	Mon Oct 14 11:14:20 2002
@@ -63,6 +63,8 @@
 	unsigned long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
 	int number;                     /* stupid old code wastes space  */
+	devfs_handle_t de_gamap;	/* ga map device entry */
+
 
 	/* Performance stats: */
 	unsigned int ios_in_flight;
@@ -98,6 +100,8 @@
 	struct gendisk *next;
 	struct block_device_operations *fops;
 
+	devfs_handle_t de_gadir;	/* GA device entry directory chassis/slot/host */
+	devfs_handle_t de_gamap[17];	/* for GA Mapping, need 17 entries  (disc + 16 parts ) */
 	devfs_handle_t *de_arr;         /* one per physical disc */
 	char *flags;                    /* one per physical disc */
 };


Ouch, do you really need all of these handles?

As the gendisk interface has been cleaned up a _lot_ in 2.5, I'm not so
sure how well this implementation will now work.

Pretty much the same comments apply for your scsi-hotswap-main.patch
(devfs reliance, coding style, loads of ioctls, long ioctl function
names, global functions that don't need to be, etc.)

I also noticed that this code is included in the CGL CVS tree.  What is
MontaVista's (and yours) future plans for this feature?  Do you want it
in the main kernel tree, and are you willing to port it to 2.5?

thanks,

greg k-h
