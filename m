Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbSJOBfR>; Mon, 14 Oct 2002 21:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbSJOBfQ>; Mon, 14 Oct 2002 21:35:16 -0400
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:62336 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262408AbSJOBfN>;
	Mon, 14 Oct 2002 21:35:13 -0400
Date: Mon, 14 Oct 2002 21:43:34 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       jdthood@yahoo.co.uk, boissiere@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Layer Rewrite V0.7 - 2.4.42
Message-ID: <20021014214334.GA315@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jaroslav Kysela <perex@perex.cz>, torvalds@transmeta.com,
	alan@lxorguk.ukuu.org.uk, greg@kroah.com, jdthood@yahoo.co.uk,
	boissiere@nl.linux.org, linux-kernel@vger.kernel.org
References: <20021014135452.GB444@neo.rr.com> <Pine.LNX.4.33.0210142101000.7202-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210142101000.7202-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 09:10:04PM +0200, Jaroslav Kysela wrote:
> On Mon, 14 Oct 2002, Adam Belay wrote:
> 
> > Linux Plug and Play Rewrite V0.7
> >
> > After much testing the Linux PnP Rewrite is ready to be included. For
> > those who would like to try it, be sure to enable debugging or else it
> > will operate silently. Also enable both PnP protocols.
> 
> A few notes. Please, could you leave the raw proc interface for ISA PnP?

Sure, a patch is included at the end of the email.  Let me know what you
think.

> I mean isapnp_proc_bus_read() function. Also, encoding device/vendor to
> 7-byte string seems like wasting bytes and CPU cycles. If you use 2/2 byte 
> format, you'll spare 3 bytes and comparing of two short values (or one 
> int value) is always less expensive.

Actually I've been thinking about this for quite some time.
I see two advantages in using ASCII text.

1.)  It allows for wildcards, for example.

the following is from the serial pnp driver:
	/* Unkown PnP modems */
	{	"PNPCXXX",		UNKNOWN_DEV	},

this will match with any device that begins as PNPC.

2.) It makes dev_id tables easier to enter and maintain.

I'll look into this some more.

>
> Anyway, I like this code. It seems that you don't use standard pci_dev /
> pci_bus structures as I was forced by Linus at ISA PnP code inclusion
> time. But it's true that we have new device model, so these things might
> be private. Also, don't forget to remove additional ISA PnP members from
> pci structures when Linus approves pnp_dev and pnp_card structures.

I appreciate your comments and recommendations.

Thanks,
Adam



diff -ur --new-file --exclude *.flags a/drivers/pnp/isapnp/Makefile b/drivers/pnp/isapnp/Makefile
--- a/drivers/pnp/isapnp/Makefile	Mon Oct 14 21:18:31 2002
+++ b/drivers/pnp/isapnp/Makefile	Mon Oct 14 18:31:04 2002
@@ -4,6 +4,6 @@
 
 export-objs := core.o
 
-obj-y := core.o
+obj-y := core.o proc.o
 
 include $(TOPDIR)/Rules.make
diff -ur --new-file --exclude *.flags a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Mon Oct 14 21:18:32 2002
+++ b/drivers/pnp/isapnp/core.c	Mon Oct 14 19:32:46 2002
@@ -1053,7 +1053,7 @@
 	return 0;
 }

-static struct pnp_protocol isapnp_protocol = {
+struct pnp_protocol isapnp_protocol = {
 	name:	"ISA Plug and Play",
 	get:	isapnp_get_resources,
 	set:	isapnp_set_resources,
@@ -1164,7 +1164,7 @@
 	isapnp_init_device_tree();
 
 #ifdef CONFIG_PROC_FS
-	/*isapnp_proc_init();*/
+	isapnp_proc_init();
 #endif
 	return 0;
 }
diff -ur --new-file --exclude *.flags a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
--- a/drivers/pnp/isapnp/proc.c	Thu Jan  1 00:00:00 1970
+++ b/drivers/pnp/isapnp/proc.c	Mon Oct 14 19:20:39 2002
@@ -0,0 +1,171 @@
+/*
+ *  ISA Plug & Play support
+ *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+
+#include <linux/isapnp.h>
+#include <linux/pnp.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <asm/uaccess.h>
+
+
+static struct proc_dir_entry *isapnp_proc_bus_dir = NULL;
+
+static loff_t isapnp_proc_bus_lseek(struct file *file, loff_t off, int whence)
+{
+	loff_t new = -1;
+
+	lock_kernel();
+	switch (whence) {
+	case 0:
+		new = off;
+		break;
+	case 1:
+		new = file->f_pos + off;
+		break;
+	case 2:
+		new = 256 + off;
+		break;
+	}
+	if (new < 0 || new > 256) {
+		unlock_kernel();
+		return -EINVAL;
+	}
+	unlock_kernel();
+	return (file->f_pos = new);
+}
+
+static ssize_t isapnp_proc_bus_read(struct file *file, char *buf, size_t nbytes, loff_t *ppos)
+{
+	struct inode *ino = file->f_dentry->d_inode;
+	struct proc_dir_entry *dp = PDE(ino);
+	struct pnp_dev *dev = dp->data;
+	int pos = *ppos;
+	int cnt, size = 256;
+
+	if (pos >= size)
+		return 0;
+	if (nbytes >= size)
+		nbytes = size;
+	if (pos + nbytes > size)
+		nbytes = size - pos;
+	cnt = nbytes;
+
+	if (!access_ok(VERIFY_WRITE, buf, cnt))
+		return -EINVAL;
+
+	isapnp_cfg_begin(dev->card->number, dev->number);
+	for ( ; pos < 256 && cnt > 0; pos++, buf++, cnt--) {
+		unsigned char val;
+		val = isapnp_read_byte(pos);
+		__put_user(val, buf);
+	}
+	isapnp_cfg_end();
+
+	*ppos = pos;
+	return nbytes;
+}
+
+static struct file_operations isapnp_proc_bus_file_operations =
+{
+	llseek:		isapnp_proc_bus_lseek,
+	read:		isapnp_proc_bus_read,
+};
+
+static int isapnp_proc_attach_device(struct pnp_dev *dev)
+{
+	struct pnp_card *bus = dev->card;
+	struct proc_dir_entry *de, *e;
+	char name[16];
+
+	if (!(de = bus->procdir)) {
+		sprintf(name, "%02x", bus->number);
+		de = bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
+		if (!de)
+			return -ENOMEM;
+	}
+	sprintf(name, "%02x", dev->number);
+	e = dev->procent = create_proc_entry(name, S_IFREG | S_IRUGO, de);
+	if (!e)
+		return -ENOMEM;
+	e->proc_fops = &isapnp_proc_bus_file_operations;
+	e->owner = THIS_MODULE;
+	e->data = dev;
+	e->size = 256;
+	return 0;
+}
+
+#ifdef MODULE
+static int __exit isapnp_proc_detach_device(struct pnp_dev *dev)
+{
+	struct pnp_card *bus = dev->card;
+	struct proc_dir_entry *de;
+	char name[16];
+
+	if (!(de = bus->procdir))
+		return -EINVAL;
+	sprintf(name, "%02x", dev->number);
+	remove_proc_entry(name, de);
+	return 0;
+}
+
+static int __exit isapnp_proc_detach_bus(struct pnp_card *bus)
+{
+	struct proc_dir_entry *de;
+	char name[16];
+
+	if (!(de = bus->procdir))
+		return -EINVAL;
+	sprintf(name, "%02x", bus->number);
+	remove_proc_entry(name, isapnp_proc_bus_dir);
+	return 0;
+}
+#endif /* MODULE */
+
+int __init isapnp_proc_init(void)
+{
+	struct pnp_dev *dev;
+	isapnp_proc_bus_dir = proc_mkdir("isapnp", proc_bus);
+	isapnp_for_each_dev(dev) {
+		isapnp_proc_attach_device(dev);
+	}
+	return 0;
+}
+
+#ifdef MODULE
+int __exit isapnp_proc_done(void)
+{
+	struct pnp_dev *dev;
+	struct pnp_bus *card;
+
+	isapnp_for_each_dev(dev) {
+		isapnp_proc_detach_device(dev);
+	}
+	isapnp_for_each_card(card) {
+		isapnp_proc_detach_bus(card);
+	}
+	if (isapnp_proc_bus_dir)
+		remove_proc_entry("isapnp", proc_bus);
+	return 0;
+}
+#endif /* MODULE */
diff -ur --new-file --exclude *.flags a/include/linux/isapnp.h b/include/linux/isapnp.h
--- a/include/linux/isapnp.h	Mon Oct 14 21:18:32 2002
+++ b/include/linux/isapnp.h	Mon Oct 14 19:29:17 2002
@@ -220,11 +220,12 @@
 
 extern struct list_head isapnp_cards;
 extern struct list_head isapnp_devices;
+extern struct pnp_protocol isapnp_protocol;

 #define isapnp_for_each_card(card) \
 	for(card = to_pnp_card(isapnp_cards.next); card != to_pnp_card(&isapnp_cards); card = to_pnp_card(card->node.next))
 #define isapnp_for_each_dev(dev) \
-	for(dev = pci_dev_g(isapnp_devices.next); dev != pci_dev_g(&isapnp_devices); dev = pci_dev_g(dev->global_list.next))
+	for(dev = protocol_to_pnp_dev(isapnp_protocol.devices.next); dev != protocol_to_pnp_dev(&isapnp_protocol.devices); dev = protocol_to_pnp_dev(dev->dev_list.next))

 #else /* !CONFIG_ISAPNP */
 
diff -ur --new-file --exclude *.flags a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Mon Oct 14 21:18:32 2002
+++ b/include/linux/pnp.h	Mon Oct 14 19:23:34 2002
@@ -26,6 +26,7 @@
 	unsigned char	productver;	/* product version */
 	unsigned int	serial;		/* serial number */
 	unsigned char	checksum;	/* if zero - checksum passed */
+	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/isapnp */
 };

 #define to_pnp_card(n) list_entry(n, struct pnp_card, node)
@@ -52,10 +53,12 @@
 	struct	device	    dev;	/* Driver Model device interface */
 	void  		  * driver_data;/* data private to the driver */
 	void		  * protocol_data;
+	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
 };
 
 #define global_to_pnp_dev(n) list_entry(n, struct pnp_dev, global_list)
 #define card_to_pnp_dev(n) list_entry(n, struct pnp_dev, card_list)
+#define protocol_to_pnp_dev(n) list_entry(n, struct pnp_dev, dev_list)
 #define	to_pnp_dev(n) container_of(n, struct pnp_dev, dev)
 #define pnp_for_each_dev(dev) \
 	for(dev = global_to_pnp_dev(pnp_global.next); \

