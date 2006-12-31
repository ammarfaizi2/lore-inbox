Return-Path: <linux-kernel-owner+w=401wt.eu-S932582AbWLaBpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWLaBpc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 20:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWLaBpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 20:45:32 -0500
Received: from rs27.luxsci.com ([66.216.127.24]:55892 "EHLO rs27.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932582AbWLaBpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 20:45:30 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Dec 2006 20:45:29 EST
Message-ID: <459714A6.4000406@firmworks.com>
Date: Sat, 30 Dec 2006 15:38:46 -1000
From: Mitch Bradley <wmb@firmworks.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: "OLPC Developer's List" <devel@laptop.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
CC: Jim Gettys <jg@laptop.org>
Subject: [PATCH] Open Firmware device tree virtual filesystem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Request for comments.

This patch creates a virtual filesystem that represents an Open Firmware
device tree.  It has been tested on an OLPC x86 system, but the code is
not processor-specific (apart from its current location under arch/i386).

It requires an Open Firmware implementation that can stay resident during
Linux startup.

It is similar in some respect to fs/proc/proc_devtree.c , but does not
use procfs, nor does it require an intermediate layer of code to
create a flattened representation of the device tree.

The patch applies cleanly against the current version of
git://dev.laptop.org/olpc-2.6 . (commit 5b9429be6056864b938ff6f39e5df3cecbbfcf4b).

Please cc me (Mitch Bradley <wmb@firmworks.com>) on comments.

OLPC users will need to upgrade their firmware to
http://wiki.laptop.org/go/OLPC_Firmware_Q2B14 to use this.


diff --git a/.config b/.config
index 6087ae7..f15900f 100644
--- a/.config
+++ b/.config
@@ -246,6 +246,7 @@ # CONFIG_MCA is not set
 # CONFIG_SCx200 is not set
 CONFIG_OLPC=y
 CONFIG_OLPC_PM=y
+CONFIG_OFW_FS=y
 
 #
 # PCCARD (PCMCIA/CardBus) support
diff --git a/Documentation/filesystems/ofwfs.txt b/Documentation/filesystems/ofwfs.txt
new file mode 100644
index 0000000..9dd94de
--- /dev/null
+++ b/Documentation/filesystems/ofwfs.txt
@@ -0,0 +1,115 @@
+		ofwfs - Open Firmware File System
+
+ofwfs makes the Open Firmware device tree available to Linux as
+a mountable virtual filesystem.
+
+== Introduction ==
+
+Open Firmware (OFW) is boot firmware as defined by IEEE Standard
+1275-1994*. It is common on SPARC (where it is called "Open Boot", a
+Sun trademark) and PowerPC processors, and is available for several
+other processors.  In the x86 realm, the highest profile platform that
+uses Open Firmware is the One Laptop Per Child system.  Open source
+implemenations can be found at openbios.org.
+
+The Open Firmware device tree is a hierarchical description of the
+system hardware, plus a few other bits of information about the
+firmware itself.  The root of the device tree represents the main
+system bus.  There are child nodes for bridges to subordinate buses,
+for individual peripheral devices, and for "pseudo devices" representing
+other useful information.
+
+Each device tree node contains a set of properties that describe the
+object in question.  They specify such things as the name and type of
+the device, its address ranges within the address space of its parent
+bus, the interrupts that it uses, clock frequencies, and other
+information that is useful for device identification and configuration.
+
+== Filesystem Representation ==
+
+ofwfs exports the OFW device tree as a Linux filesystem.  Filesystem
+directories correspond to a device tree nodes, with the directory name
+being the fully-qualifed (name@address) node name.  Regular files
+correspond to properties, with file name being the same as the property name
+and the file contents being the verbatim property value.
+
+== Property Value Encoding ==
+
+OFW property values are encoded using a well-defined format that is the
+concatenation of some number of items, each encoded in a platform-independent
+manner according to its type.  For example, a 32-bit integer is encoded
+as 4 binary bytes in big-endian order (i.e. network byte order), whereas
+a text string is encoded as a null-terminated sequence of bytes.  There
+is no padding between concatenated items; each item within a composite
+property value begins immediately after the preceding item, without regard
+to any alignment restrictions that may exist on a particular processor.
+
+Composite property values that contain mixed types (e.g. a 32-bit integer 
+followed by several strings) exist, but are rare.  Most property values
+are either a single item (e.g. a string or a number) or an array of similar
+items (e.g. a list of numbers).
+
+A regular file in ofwfs contains the exact byte sequence that comprises the
+OFW property value.  Properties are not reformatted into text form, so numeric
+property values appear as binary integers.  While this is inconvenient
+for viewing, it is generally easier for programs that read property values,
+and it means that Open Firmware documentation about property values applies
+directly, without having to separately document an ASCII transformation
+(which would have to separately specified for different kinds of properties).
+
+== Environment Assumptions ==
+
+The ofwfs code assumes that the Open Firmware client interface callback
+can be executed during Linux kernel startup (specifically, at "core_initcall"
+time).  When ofwfs is initialized, it copies out the property values, so that
+subsequent accesses to the tree do not require callbacks into OFW.
+
+After initialization, ofwfs can be used by kernel components such as drivers,
+and it can be mounted so that userspace applications can access it.
+
+== Recommended Mount Point ==
+
+The recommended mount point for ofwfs is /ofw.  (TBD: Should it be mounted
+somewhere under /sys instead?)
+
+== Related Work ==
+
+fs/proc/proc_devtree.c is an existing interface to the Open Firmware device
+tree that is used for the PowerPC and SPARC architectures.  Using the
+procfs infrastructure, it creates /proc/device-tree as the root of the
+device tree.  proc_devtree.c assumes that the device tree information has
+already been copied out of Open Firmware into a "flattened device tree"
+data structure.
+
+The ofwfs development began as a attempt to use proc_devtree.c, but
+got bogged down in the complexity of the interface code to create the
+flattened tree.  A direct callback interface turned out to be much
+simpler, resulting in a small, elegant implementation of /proc/device-tree .
+
+That morphed into ofwfs as a result of discussions with kernel developers,
+who said that /proc was falling into disfavor, so that a separate virtual
+filesystem would be more likely to meet the approval of the kernel team.
+
+== Specific Tree Items ==
+
+Specifications for required and optional properties for various kinds
+of processors, buses, and devices may be found in the various "bindings"
+documents on the Open Firmware Working Group site at
+http://playground.sun.com/1275 .
+
+
+(* The IEEE standard expired in 1999.  IEEE standards automatically expire
+after 5 years unless renewed, and the Open Firmware working group decided
+not to undertake the considerable effort necessary for a reaffirmation
+ballot.  Nevertheless, Open Firmware as defined by the IEEE document
+remains in use on many PowerPC and SPARC systems, and on a smaller scale
+for other processors.)
+
+
+== Acknowledgements ==
+
+* Paul Mackerras wrote proc_devtree.c, which we used as a starting point.
+* David Kahn converted proc_devtree.c to use a direct interface to OFW.
+* Arnd Bergmann wrote a virtual filesystem version of proc_devtree.c
+* Mitch Bradley put all the pieces together, got it working, and wrote
+  this document.
diff --git a/Documentation/i386/zero-page.txt b/Documentation/i386/zero-page.txt
index c04a421..8c9ab88 100644
--- a/Documentation/i386/zero-page.txt
+++ b/Documentation/i386/zero-page.txt
@@ -28,7 +28,8 @@ Offset	Type		Description
 
  0xa0	16 bytes	System description table truncated to 16 bytes.
 			( struct sys_desc_table_struct )
- 0xb0 - 0x13f		Free. Add more parameters here if you really need them.
+ 0xb0   16 bytes	Open Firmware information (magic, version, callback, idt)
+ 0xc0 - 0x13f		Free. Add more parameters here if you really need them.
  0x140- 0x1be		EDID_INFO Video mode setup
 
 0x1c4	unsigned long	EFI system table pointer
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 3a2eccf..01fdd40 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -1141,6 +1141,15 @@ config OLPC_PM
          Add support for the Geode power management facilities on the
 	 OLPC Childrens Machine
 
+config OFW_FS
+	bool "Support for Open Firmware device tree filesystem"
+	default y if OLPC
+	help
+	  This option adds a virtual filesystem which contains an
+	  image of the Open Firmware device tree (a description of
+	  the system hardware that is exported from the boot firmware).
+	  If unsure, say N here.
+
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index 8b365db..718b3cf 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -45,6 +45,7 @@ EXTRA_AFLAGS   := -traditional
 obj-$(CONFIG_SCx200)		+= scx200.o
 obj-$(CONFIG_OLPC)		+= olpc.o
 obj-$(CONFIG_OLPC_PM)		+= olpc-pm.o
+obj-$(CONFIG_OFW_FS)		+= callofw.o ofw_fs.o
 
 # vsyscall.o contains the vsyscall DSO images as __initdata.
 # We must build both images before we can assemble it.
diff --git a/arch/i386/kernel/callofw.c b/arch/i386/kernel/callofw.c
new file mode 100644
index 0000000..b2c7a0e
--- /dev/null
+++ b/arch/i386/kernel/callofw.c
@@ -0,0 +1,96 @@
+/*
+ * callofw.c - Open Firmware client interface for 32-bit systems.
+ * This code is intended to be portable to any 32-bit Open Firmware
+ * implementation with a standard client interface that can be
+ * called when Linux is running.
+ */
+
+#include <stdarg.h>
+#include <asm/callofw.h>
+#include <linux/spinlock.h>
+
+int (*call_firmware)(int *);
+
+static DEFINE_SPINLOCK(prom_lock);
+
+#define MAXARGS 20
+int callofw(char *name, int numargs, int numres, ...)
+{
+	va_list ap;
+	int argarray[MAXARGS+3];
+	int argnum = 3;
+	int retval;
+	int *intp;
+	unsigned long flags;
+
+//	printk(KERN_WARNING "CALLOFW: %s\n", name);
+	if (call_firmware == NULL)
+		return (-1);
+
+	argarray[0] = (int)name;
+	argarray[1] = numargs;
+	argarray[2] = numres;
+
+	if ((numargs + numres) > MAXARGS) {
+		return (-1);
+	}
+
+	va_start(ap, numres);
+	while (numargs--) {
+		argarray[argnum++] = va_arg(ap, int);
+	}
+
+	spin_lock_irqsave(&prom_lock, flags);
+	retval = call_firmware(argarray);
+	spin_unlock_irqrestore(&prom_lock, flags);
+
+	if (retval == 0) {
+		while (numres--) {
+			intp = va_arg(ap, int *);
+			*intp = argarray[argnum++];
+		}
+	}
+	va_end(ap);
+	return (retval);
+}
+#undef	MAXARGS
+
+#if 0
+
+The return value from callofw in all cases is 0 if the attempt to call the
+function succeeded, nonzero otherwise.  That return value is from the
+gateway function only.  Any results from the called function are returned
+via output argument pointers.
+
+Here are call templates for all the standard OFW client services.
+
+callofw("test", 1, 1, namestr, &missing);
+callofw("peer", 1, 1, phandle, &sibling_phandle);
+callofw("child", 1, 1, phandle, &child_phandle);
+callofw("parent", 1, 1, phandle, &parent_phandle);
+callofw("instance_to_package", 1, 1, ihandle, &phandle);
+callofw("getproplen", 2, 1, phandle, namestr, &proplen);
+callofw("getprop", 4, 1, phandle, namestr, bufaddr, buflen, &size);
+callofw("nextprop", 3, 1, phandle, previousstr, bufaddr, &flag);
+callofw("setprop", 4, 1, phandle, namestr, bufaddr, len, &size);
+callofw("canon", 3, 1, devspecstr, bufaddr, buflen, &length);
+callofw("finddevice", 1, 1, devspecstr, &phandle);
+callofw("instance-to-path", 3, 1, ihandle, bufaddr, buflen, &length);
+callofw("package-to-path", 3, 1, phandle, bufaddr, buflen, &length);
+callofw("call_method", numin, numout, in0, in1, ..., &out0, &out1, ...);
+callofw("open", 1, 1, devspecstr, &ihandle);
+callofw("close", 1, 0, ihandle);
+callofw("read", 3, 1, ihandle, addr, len, &actual);
+callofw("write", 3, 1, ihandle, addr, len, &actual);
+callofw("seek", 3, 1, ihandle, pos_hi, pos_lo, &status);
+callofw("claim", 3, 1, virtaddr, size, align, &baseaddr);
+callofw("release", 2, 0, virtaddr, size);
+callofw("boot", 1, 0, bootspecstr);
+callofw("enter", 0, 0);
+callofw("exit", 0, 0);
+callofw("chain", 5, 0, virtaddr, size, entryaddr, argsaddr, len);
+callofw("interpret", numin+1, numout+1, cmdstr, in0, ..., &catchres, &out0, ...);
+callofw("set-callback", 1, 1, newfuncaddr, &oldfuncaddr);
+callofw("set-symbol-lookup", 2, 0, symtovaladdr, valtosymaddr);
+callofw("milliseconds", 0, 1, &ms);
+#endif
diff --git a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
index ca31f18..a0ac805 100644
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -113,6 +113,32 @@ ENTRY(startup_32)
  * Warning: don't use %esi or the stack in this code.  However, %esp
  * can be used as a GPR if you really need it...
  */
+#ifdef CONFIG_OFW_FS
+/*
+ * If Open Firmware booted us, save the OFW client interface callback address
+ * and preserve the OFW page mappings by priming the kernel's new page
+ * directory area with a copy of the OFW page directory.  That lets OFW stay
+ * resident in high memory (high in both the virtual and physical spaces)
+ * for at least long enough to copy out the device tree.
+ */
+	movl $(boot_params - __PAGE_OFFSET + OFW_INFO_OFFSET), %ebp
+	cmpl $0x2057464F, (%ebp)	/* Magic number "OFW " */
+	jne 1f
+
+	mov 0x8(%ebp), %eax	/* Save callback address */
+	mov %eax, call_firmware - __PAGE_OFFSET
+
+	/* Copy the OFW pdir into swapper_pg_dir */
+	movl %esi, %edx		/* save %esi */
+	movl $(swapper_pg_dir - __PAGE_OFFSET), %edi
+	movl %cr3, %esi		/* Source is current pg_dir base address */
+	movl $1024, %ecx	/* Number of page directory entries */
+	rep
+	movsl
+	movl %edx, %esi		/* restore %esi */
+1:      
+#endif
+
 page_pde_offset = (__PAGE_OFFSET >> 20);
 
 	movl $(pg0 - __PAGE_OFFSET), %edi
diff --git a/arch/i386/kernel/ofw_fs.c b/arch/i386/kernel/ofw_fs.c
new file mode 100644
index 0000000..30ca359
--- /dev/null
+++ b/arch/i386/kernel/ofw_fs.c
@@ -0,0 +1,261 @@
+/*
+ * Open Firmware Device Tree Filesystem
+ *
+ * By Mitch Bradley (wmb@firmworks.com), with assistance from David Kahn.
+ * Most of the basic virtual file system structure was taken from a
+ * "promfs" example written by Arnd Bergmann.  
+ *
+ * This code should be portable to any system (regardless of CPU) that
+ * has an Open Firmware client interface that can be called when this
+ * module is initialized.
+ */
+
+#include <linux/dcache.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+
+#include <asm/callofw.h>
+
+/* 1275 in little-endian ASCII (for IEEE 1275 - the Open Firmware Standard) */
+#define OFWFS_MAGIC 0x35373231
+
+struct propval {
+	int length;
+	char value[];
+};
+
+static ssize_t ofwfs_read(struct file *file, char __user *data,
+		size_t len, loff_t *ppos)
+{
+	struct propval *propval = file->f_dentry->d_inode->i_private;
+
+	return simple_read_from_buffer(data, len, ppos,
+			propval->value, propval->length);
+}
+
+static struct file_operations ofwfs_property_operations = {
+	.read = ofwfs_read,
+};
+
+static struct inode *ofwfs_new_inode(struct super_block *sb,
+		int mode, void *data)
+{
+	struct inode *inode;
+
+	inode = new_inode(sb);
+	if (!inode)
+		goto out;
+
+	inode->i_mode = mode;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_blkbits = PAGE_CACHE_SHIFT;
+	inode->i_blocks = 0;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_private = data;
+	switch (mode & S_IFMT) {
+	case S_IFDIR:
+		inode->i_op = &simple_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		break;
+	case S_IFREG:
+		inode->i_fop = &ofwfs_property_operations;
+		inode->i_bytes = ((struct propval *)data)->length;
+		inode->i_size = (loff_t)(((struct propval *)data)->length);
+		break;
+	}
+out:
+	return inode;
+}
+
+static int ofwfs_create_prop(struct super_block *sb, struct dentry *dir,
+				char *propname, struct propval *propval)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	int ret;
+
+	ret = -ENOMEM;
+	inode = ofwfs_new_inode(sb, S_IFREG | 0444, propval);
+	if (!inode)
+		goto out;
+	dentry = d_alloc_name(dir, propname);
+	if (!dentry)
+		goto out_iput;
+	d_add(dentry, inode);
+	return 0;
+
+out_iput:
+	iput(inode);
+out:
+	return ret;
+}
+
+static int ofwfs_create_props(struct super_block *sb, struct dentry *dir,
+		phandle node)
+{
+	char propname[32];
+	int security, len;
+	struct propval *propval;
+	int ret = 0;
+	int flag;
+
+	propname[0] = '\0';
+
+	while ((void)callofw("nextprop", 3, 1, node, propname, propname,
+                             &flag), flag == 1) {
+		security = strncmp(propname, "security-", 9) == 0;
+		len = 0;
+		if (!security)
+			(void)callofw("getproplen", 2, 1, node, propname, &len);
+
+		propval = kmalloc(sizeof(struct propval) + len, GFP_KERNEL);
+
+		propval->length = len;
+		(void) callofw("getprop", 4, 1, node, propname, propval->value,
+		    len, &len);
+
+		ret = ofwfs_create_prop(sb, dir, propname, propval);
+		if (ret)
+			goto out;
+	}
+
+out:
+	if (ret) {
+		WARN_ON(1);
+/*
+		ofwfs_remove_props(sb, dir);
+*/
+	}
+
+	return ret;
+}
+
+static int ofwfs_create_dir(struct super_block *sb,
+		struct dentry *parent, phandle node)
+{
+	int ret;
+	int pathlen;
+	int i;
+	phandle child = 0;
+	struct dentry *dentry = NULL;
+	struct inode *inode = NULL;
+	char *path;
+
+	ret = -ENOMEM;
+
+	inode = ofwfs_new_inode(sb, S_IFDIR | 0555, node);
+	if (!inode)
+		goto out;
+
+	if (parent) {
+		(void) callofw("package-to-path", 3, 1, node, NULL, 0,
+		    &pathlen);
+
+		path = kmalloc((size_t) pathlen + 1, GFP_KERNEL);
+		if (!path)
+			goto out_iput;
+
+		(void) callofw("package-to-path", 3, 1, node, path,
+		    pathlen + 1, &i);
+
+		dentry = d_alloc_name(parent, strrchr(path, '/') + 1);
+		kfree(path);
+		if (!dentry)
+			goto out_iput;
+		d_add(dentry, inode);
+	} else {
+		dentry = d_alloc_root(inode);
+		if (!dentry)
+			goto out_iput;
+		sb->s_root = dentry;
+	}
+
+	ret = ofwfs_create_props(sb, dentry, node);
+	if (ret)
+		goto out_cleanup;
+
+	(void) callofw("child", 1, 1, node, &child);
+	while (child) {
+		ret = ofwfs_create_dir(sb, dentry, child);
+		if (ret)
+			goto out;
+		(void) callofw("peer", 1, 1, child, &child);
+	}
+	return 0;
+
+out_cleanup:
+	WARN_ON(1);
+//	ofwfs_remove_dirs();
+	dput(dentry);
+out_iput:
+	iput(inode);
+out:
+	return ret;
+}
+
+static int ofwfs_create_root(struct super_block *sb, void *data)
+{
+	phandle root;
+
+	root = 0;
+	(void) callofw("peer", 1, 1, 0, &root);
+	    
+	if (root == 0) {
+		printk(KERN_ERR "ofwfs: can't find device tree root\n");
+		return -ENOENT;
+	}
+
+	return ofwfs_create_dir(sb, NULL, root);
+}
+
+static struct super_operations ofwfs_super_operations = {
+	.statfs = simple_statfs,
+	.drop_inode = generic_delete_inode,
+};
+
+static int ofwfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = OFWFS_MAGIC;
+	sb->s_op = &ofwfs_super_operations;
+	return ofwfs_create_root(sb, data);
+}
+
+static int ofwfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *name, void *data, struct vfsmount *mnt)
+{
+	return get_sb_single(fs_type, flags, data, ofwfs_fill_super, mnt);
+}
+
+static struct file_system_type ofwfs_type = {
+	.owner = THIS_MODULE,
+	.name = "ofwfs",
+	.get_sb = ofwfs_get_sb,
+	.kill_sb = kill_litter_super,
+};
+
+static int __init ofwfs_init(void)
+{
+	int ret;
+
+	ret = register_filesystem(&ofwfs_type);
+	if (ret)
+		return ret;
+
+	kern_mount(&ofwfs_type);
+	return 0;
+}
+
+core_initcall(ofwfs_init);
+
+static void __exit ofwfs_exit(void)
+{
+	unregister_filesystem(&ofwfs_type);
+}
+// module_exit(ofwfs_exit);
diff --git a/include/asm-i386/callofw.h b/include/asm-i386/callofw.h
new file mode 100644
index 0000000..594cb63
--- /dev/null
+++ b/include/asm-i386/callofw.h
@@ -0,0 +1,22 @@
+#ifndef _I386_PROM_H
+#define _I386_PROM_H
+#ifdef __KERNEL__
+
+/*
+ * Definitions for Open Firmware client interface on 32-bit system.
+ * OF Cell size is 4. Integer properties are encoded big endian,
+ * as with all OF implementations.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/types.h>
+
+typedef void *phandle;
+
+extern int callofw(char *, int, int, ...);
+
+#endif /* __KERNEL__ */
+#endif /* _I386_PROM_H */
diff --git a/include/asm-i386/setup.h b/include/asm-i386/setup.h
index 2734909..397dc6d 100644
--- a/include/asm-i386/setup.h
+++ b/include/asm-i386/setup.h
@@ -24,6 +24,7 @@ #define OLD_CL_MAGIC		0xA33F
 #define OLD_CL_BASE_ADDR	0x90000
 #define OLD_CL_OFFSET		0x90022
 #define NEW_CL_POINTER		0x228	/* Relative to real mode data */
+#define OFW_INFO_OFFSET		0xb0 	/* Relative to real mode data */
 
 #ifndef __ASSEMBLY__
 /*
@@ -41,6 +42,7 @@ #define APM_BIOS_INFO (*(struct apm_bios
 #define IST_INFO   (*(struct ist_info *) (PARAM+0x60))
 #define DRIVE_INFO (*(struct drive_info_struct *) (PARAM+0x80))
 #define SYS_DESC_TABLE (*(struct sys_desc_table_struct*)(PARAM+0xa0))
+/* OFW INFO is 0x10 bytes starting at offset 0xb0 */
 #define EFI_SYSTAB ((efi_system_table_t *) *((unsigned long *)(PARAM+0x1c4)))
 #define EFI_MEMDESC_SIZE (*((unsigned long *) (PARAM+0x1c8)))
 #define EFI_MEMDESC_VERSION (*((unsigned long *) (PARAM+0x1cc)))


