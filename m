Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270519AbTGNDp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270524AbTGNDp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:45:59 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:46271 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270519AbTGNDpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:45:10 -0400
Subject: [PATCH] /proc/bus/pci* changes
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@digeo.com, torvalds@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1058154708.747.1391.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Jul 2003 23:51:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The existing /proc/bus/pci/*/* files are a
hack involving ioctl and out-of-bounds mmap.
The following patch starts a transition to
something sane while keeping compatibility.

Typical user-space drivers for polled devices
should be easy to port to the new interface.
The X server will need some per-arch enhancements
to handle write-combining (non-x86 lack MTRRs)
and the use of multiple VGA-style devices.

In the new interface, pci/00/00.0 is a symbolic
link to a ../../pci*/bus0/dev0/fn0/config-space
file, where the '*' is typically 0. (PCI domain)
Simple and direct per-resource mmap() is provided,
via pci0/bus0/dev0/fn0/bar0 and so on.


diff -Naurd old/drivers/pci/proc.c new/drivers/pci/proc.c
--- old/drivers/pci/proc.c	2003-07-13 23:10:29.000000000 -0400
+++ new/drivers/pci/proc.c	2003-07-13 23:09:06.000000000 -0400
@@ -199,6 +199,14 @@
 	int write_combine;
 };
 
+
+/*
+ * 2001-05-20 Alexander Viro "BTW, -pre4 got new bunch of ioctls. On
procfs, no less."
+ * 2001-05-20 Linus Torvalds "This particular braindamage is not too
late to fix.."
+ * 2003-06-30 Matthew Wilcox "The current fugly ioctl really has to
go."
+ *
+ * Damn, this lives in 2.6.xx, but at least a new interface is in
place.
+ */
 static int proc_bus_pci_ioctl(struct inode *inode, struct file *file,
unsigned int cmd, unsigned long arg)
 {
 	const struct proc_dir_entry *dp = PDE(inode);
@@ -240,6 +248,7 @@
 }
 
 #ifdef HAVE_PCI_MMAP
+/* old interface */
 static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct
*vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -379,43 +388,215 @@
 
 struct proc_dir_entry *proc_bus_pci_dir;
 
+
+#ifdef HAVE_PCI_MMAP
+
+struct pci_bar_private {
+	struct pci_dev *pdev;
+	int bar;
+};
+
+
+/* For now, a wrapper. Next fixes: do a proper per-arch version of
this, plus mmap flags. */
+static int pci_bar_mmap_page_range(struct pci_dev *pdev, struct
vm_area_struct *vma, int bar)
+{
+	enum pci_mmap_state type;  /* which PCI address space, MMIO or IO
ports? */
+	unsigned busaddr;
+	unsigned npages;
+	int ret;
+	
+	type = pci_resource_flags(pdev,bar) & IORESOURCE_MEM ? pci_mmap_mem :
pci_mmap_io;
+
+	/* check size limit */
+	npages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	if(npages + vma->vm_pgoff > pci_resource_len(pdev,bar) >> PAGE_SHIFT)
+		return -EINVAL;
+
+	/* Eeew. Make the old per-arch interface happy. */
+	/* Too bad  "busaddr = pci_resource_start(pdev,bar)"  only works on
i386 */
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0 + bar * 4, &busaddr);
+	vma->vm_pgoff += busaddr >> PAGE_SHIFT;
+
+	/* vma ought to choose: uncache, write-combine, write-back... */
+	ret = pci_mmap_page_range(pdev, vma, type, 0);
+	if (ret<0)
+		return ret;
+	return 0;
+}
+
+
+static int proc_pci_bar_mmap(struct file *file, struct vm_area_struct
*vma)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	const struct proc_dir_entry *dp = PDE(inode);
+	struct pci_bar_private *private = dp->data;
+
+	int ret;
+
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	ret = pci_bar_mmap_page_range(private->pdev, vma, private->bar);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int proc_pci_bar_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int proc_pci_bar_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	file->private_data = NULL;
+
+	return 0;
+}
+#endif /* HAVE_PCI_MMAP */
+
+static struct file_operations proc_pci_bar_operations = {
+#ifdef HAVE_PCI_MMAP
+	.open		= proc_pci_bar_open,
+	.release	= proc_pci_bar_release,
+	.mmap		= proc_pci_bar_mmap,
+#ifdef HAVE_ARCH_PCI_GET_UNMAPPED_AREA
+	.get_unmapped_area = get_pci_unmapped_area,
+#endif /* HAVE_ARCH_PCI_GET_UNMAPPED_AREA */
+#endif /* HAVE_PCI_MMAP */
+};
+
+/* TODO: per-arch way to hang a proc_dir_entry off of a pci domain */
+#ifdef CONFIG_PCI_DOMAINS
+static struct proc_dir_entry *procdom[0x10000];
+#else
+static struct proc_dir_entry *procdom[1];
+#endif
+
 int pci_proc_attach_device(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
 	struct proc_dir_entry *de, *e;
 	char name[16];
+	char target[48];  /* sized for
../../pci65535/bus255/dev31/fn7/config-space */
+	int i;
 
 	if (!proc_initialized)
 		return -EACCES;
 
-	if (!(de = bus->procdir)) {
-		if (pci_name_bus(name, bus))
-			return -EEXIST;
-		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
+	/* Create new-style /proc/bus/pci65535/bus255/dev31/fn7/config-space &
friends. */
+	if (!(de = bus->procbus)) {
+		if (!( de = procdom[pci_domain_nr(bus)] )) {
+			sprintf(name, "pci%u", pci_domain_nr(bus));
+			de = procdom[pci_domain_nr(bus)] = proc_mkdir(name, proc_bus);
+			if (!de)
+				return -ENOMEM;
+		}
+		sprintf(name, "bus%u", bus->number);
+		de = bus->procbus = proc_mkdir(name, de);
 		if (!de)
 			return -ENOMEM;
 	}
-	sprintf(name, "%02x.%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	e = dev->procent = create_proc_entry(name, S_IFREG | S_IRUGO |
S_IWUSR, de);
+
+	if (!( de = bus->procdevs[PCI_SLOT(dev->devfn)] )) {
+		sprintf(name, "dev%u", PCI_SLOT(dev->devfn));
+		de = bus->procdevs[PCI_SLOT(dev->devfn)] = proc_mkdir(name,
bus->procbus);
+		if (!de)
+			return -ENOMEM;
+	}
+
+	sprintf(name, "fn%u", PCI_FUNC(dev->devfn));
+	de = dev->procfn = proc_mkdir(name, de);
+	if (!de)
+		return -ENOMEM;
+
+	e = dev->proccfg = create_proc_entry("config-space", S_IFREG | S_IRUGO
| S_IWUSR, de);
 	if (!e)
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
 	e->size = PCI_CFG_SPACE_SIZE;
 
+	/* one entry per resource */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE && pci_resource_start(dev,i);
i++) {
+		struct pci_bar_private *private;
+		private = kmalloc(sizeof(*private), GFP_KERNEL);
+		if (!private)
+			return -ENOMEM;
+		private->pdev = dev;
+		private->bar = i;
+		sprintf(name, "bar%u", i);
+		e = dev->procbar[i] = create_proc_entry(name, S_IFREG | S_IRUGO |
S_IWUSR, dev->procfn);
+		if (!e)
+			return -ENOMEM;
+		e->proc_fops = &proc_pci_bar_operations;
+		e->data = private;
+		e->size = pci_resource_len(dev,i);
+	}
+
+	/* Create old-style /proc/bus/pci/ff/1f.7 entry as a symlink. */
+	if (!(de = bus->procdir)) {
+		if (pci_name_bus(name, bus))
+			return -EEXIST;     /* fail if name taken by some other PCI domain
*/
+		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
+		if (!de)
+			return -ENOMEM;
+	}
+	sprintf(name, "%02x.%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	sprintf(target, "../../pci%d/bus%d/dev%d/fn%d/config-space",
pci_domain_nr(bus), bus->number, PCI_SLOT(dev->devfn),
PCI_FUNC(dev->devfn));
+	dev->procent = proc_symlink(name, de, target);
+	if (!dev->procent)
+		return -ENOMEM;
+
 	return 0;
 }
 
 int pci_proc_detach_device(struct pci_dev *dev)
 {
 	struct proc_dir_entry *e;
+	int i;
 
+	/* old-style */
 	if ((e = dev->procent)) {
 		if (atomic_read(&e->count))
 			return -EBUSY;
 		remove_proc_entry(e->name, dev->bus->procdir);
 		dev->procent = NULL;
 	}
+	/* the config-space file */
+	if ((e = dev->proccfg)) {
+		if (atomic_read(&e->count))
+			return -EBUSY;
+		remove_proc_entry(e->name, dev->procfn);
+		dev->proccfg = NULL;
+	}
+	/* one entry per resource */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE && pci_resource_start(dev,i);
i++) {
+		e = dev->procbar[i];
+		if(!e)
+			continue;
+		if(atomic_read(&e->count))
+			return -EBUSY;
+		remove_proc_entry(e->name, dev->procfn);
+		dev->procbar[i] = NULL;
+	}
+	/* the per-fn directory */
+	if ((e = dev->procfn)) {
+		if (atomic_read(&e->count))
+			return -EBUSY;
+		kfree(e->data);
+		remove_proc_entry(e->name, dev->bus->procdevs[PCI_SLOT(dev->devfn)]);
+		dev->procfn = NULL;
+	}
+	/* the per-dev directory */
+	if ((e = dev->bus->procdevs[PCI_SLOT(dev->devfn)])) {
+		if (atomic_read(&e->count))
+			return -EBUSY;
+		remove_proc_entry(e->name, dev->bus->procbus);
+		dev->bus->procdevs[PCI_SLOT(dev->devfn)] = NULL;
+	}
 	return 0;
 }
 
@@ -441,6 +622,9 @@
 	struct proc_dir_entry *de = bus->procdir;
 	if (de)
 		remove_proc_entry(de->name, proc_bus_pci_dir);
+	de = bus->procbus;
+	if (de)
+		remove_proc_entry(de->name, procdom[pci_domain_nr(bus)]);
 	return 0;
 }
 
diff -Naurd old/include/linux/pci.h new/include/linux/pci.h
--- old/include/linux/pci.h	2003-07-13 23:09:45.000000000 -0400
+++ new/include/linux/pci.h	2003-07-13 23:09:17.000000000 -0400
@@ -371,7 +371,10 @@
 	struct pci_bus	*subordinate;	/* bus this device bridges to */
 
 	void		*sysdata;	/* hook for sys-specific extension */
-	struct proc_dir_entry *procent;	/* device entry in /proc/bus/pci */
+	struct proc_dir_entry *procent;	/* in /proc/bus/pci (old-style) */
+	struct proc_dir_entry *procfn;	/* in /proc/bus/pci* (new-style) */
+	struct proc_dir_entry *proccfg;	/* config-space (new-style) */
+	struct proc_dir_entry *procbar[DEVICE_COUNT_RESOURCE];	/* per-bar
entries */
 
 	unsigned int	devfn;		/* encoded device & function index */
 	unsigned short	vendor;
@@ -454,7 +457,9 @@
 
 	struct pci_ops	*ops;		/* configuration access functions */
 	void		*sysdata;	/* hook for sys-specific extension */
-	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/pci */
+	struct proc_dir_entry *procdir;	/* old-style /proc/bus/pci entry */
+	struct proc_dir_entry *procbus;	/* new-style /proc/bus/pci* entry */
+	struct proc_dir_entry *procdevs[32];	/* new-style /proc/bus/pci*
per-slot */
 
 	unsigned char	number;		/* bus number */
 	unsigned char	primary;	/* number of primary bridge */



