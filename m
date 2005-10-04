Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVJDFiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVJDFiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 01:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJDFiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 01:38:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:37035 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751198AbVJDFiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 01:38:20 -0400
Subject: [PATCH] ppc64: Support retreiving missing SMU partitions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 15:34:33 +1000
Message-Id: <1128404073.31063.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SMU chip has an EEPROM that contains various informations about the
motherboard, like thermal calibration infos, etc... This EEPROM is
divided in "partitions", and the firmware only extracts some of these
and publish them in the device-tree. This patch adds a mecanism to
retreive the missing ones which is necessary for the upcoming thermal
control patch. In order to make this accessible to userland as well, the
patch adds the ability to the /proc/device-tree code to get new
properties added at runtime and simplify the code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/macintosh/smu.c
===================================================================
--- linux-work.orig/drivers/macintosh/smu.c	2005-09-29 16:56:59.000000000 +1000
+++ linux-work/drivers/macintosh/smu.c	2005-09-29 17:06:05.000000000 +1000
@@ -47,13 +47,13 @@
 #include <asm/uaccess.h>
 #include <asm/of_device.h>
 
-#define VERSION "0.6"
+#define VERSION "0.7"
 #define AUTHOR  "(c) 2005 Benjamin Herrenschmidt, IBM Corp."
 
 #undef DEBUG_SMU
 
 #ifdef DEBUG_SMU
-#define DPRINTK(fmt, args...) do { printk(KERN_DEBUG fmt , ##args); } while (0)
+#define DPRINTK(fmt, args...) do { udbg_printf(KERN_DEBUG fmt , ##args); } while (0)
 #else
 #define DPRINTK(fmt, args...) do { } while (0)
 #endif
@@ -92,7 +92,7 @@
  * for now, just hard code that
  */
 static struct smu_device	*smu;
-
+static DECLARE_MUTEX(smu_part_access);
 
 /*
  * SMU driver low level stuff
@@ -113,9 +113,11 @@
 
 	DPRINTK("SMU: starting cmd %x, %d bytes data\n", cmd->cmd,
 		cmd->data_len);
-	DPRINTK("SMU: data buffer: %02x %02x %02x %02x ...\n",
+	DPRINTK("SMU: data buffer: %02x %02x %02x %02x %02x %02x %02x %02x\n",
 		((u8 *)cmd->data_buf)[0], ((u8 *)cmd->data_buf)[1],
-		((u8 *)cmd->data_buf)[2], ((u8 *)cmd->data_buf)[3]);
+		((u8 *)cmd->data_buf)[2], ((u8 *)cmd->data_buf)[3],
+		((u8 *)cmd->data_buf)[4], ((u8 *)cmd->data_buf)[5],
+		((u8 *)cmd->data_buf)[6], ((u8 *)cmd->data_buf)[7]);
 
 	/* Fill the SMU command buffer */
 	smu->cmd_buf->cmd = cmd->cmd;
@@ -438,7 +440,7 @@
 EXPORT_SYMBOL(smu_present);
 
 
-int smu_init (void)
+int __init smu_init (void)
 {
 	struct device_node *np;
 	u32 *data;
@@ -843,16 +845,154 @@
 	return 0;
 }
 
-struct smu_sdbp_header *smu_get_sdb_partition(int id, unsigned int *size)
+/*
+ * Handling of "partitions"
+ */
+
+static int smu_read_datablock(u8 *dest, unsigned int addr, unsigned int len)
+{
+	DECLARE_COMPLETION(comp);
+	unsigned int chunk;
+	struct smu_cmd cmd;
+	int rc;
+	u8 params[8];
+
+	/* We currently use a chunk size of 0xe. We could check the
+	 * SMU firmware version and use bigger sizes though
+	 */
+	chunk = 0xe;
+
+	while (len) {
+		unsigned int clen = min(len, chunk);
+
+		cmd.cmd = SMU_CMD_MISC_ee_COMMAND;
+		cmd.data_len = 7;
+		cmd.data_buf = params;
+		cmd.reply_len = chunk;
+		cmd.reply_buf = dest;
+		cmd.done = smu_done_complete;
+		cmd.misc = &comp;
+		params[0] = SMU_CMD_MISC_ee_GET_DATABLOCK_REC;
+		params[1] = 0x4;
+		*((u32 *)&params[2]) = addr;
+		params[6] = clen;
+
+		rc = smu_queue_cmd(&cmd);
+		if (rc)
+			return rc;
+		wait_for_completion(&comp);
+		if (cmd.status != 0)
+			return rc;
+		if (cmd.reply_len != clen) {
+			printk(KERN_DEBUG "SMU: short read in "
+			       "smu_read_datablock, got: %d, want: %d\n",
+			       cmd.reply_len, clen);
+			return -EIO;
+		}
+		len -= clen;
+		addr += clen;
+		dest += clen;
+	}
+	return 0;
+}
+
+static struct smu_sdbp_header *smu_create_sdb_partition(int id)
+{
+	DECLARE_COMPLETION(comp);
+	struct smu_simple_cmd cmd;
+	unsigned int addr, len, tlen;
+	struct smu_sdbp_header *hdr;
+	struct property *prop;
+
+	/* First query the partition info */
+	smu_queue_simple(&cmd, SMU_CMD_PARTITION_COMMAND, 2,
+			 smu_done_complete, &comp,
+			 SMU_CMD_PARTITION_LATEST, id);
+	wait_for_completion(&comp);
+
+	/* Partition doesn't exist (or other error) */
+	if (cmd.cmd.status != 0 || cmd.cmd.reply_len != 6)
+		return NULL;
+
+	/* Fetch address and length from reply */
+	addr = *((u16 *)cmd.buffer);
+	len = cmd.buffer[3] << 2;
+	/* Calucluate total length to allocate, including the 17 bytes
+	 * for "sdb-partition-XX" that we append at the end of the buffer
+	 */
+	tlen = sizeof(struct property) + len + 18;
+
+	prop = kcalloc(tlen, 1, GFP_KERNEL);
+	if (prop == NULL)
+		return NULL;
+	hdr = (struct smu_sdbp_header *)(prop + 1);
+	prop->name = ((char *)prop) + tlen - 18;
+	sprintf(prop->name, "sdb-partition-%02x", id);
+	prop->length = len;
+	prop->value = (unsigned char *)hdr;
+	prop->next = NULL;
+
+	/* Read the datablock */
+	if (smu_read_datablock((u8 *)hdr, addr, len)) {
+		printk(KERN_DEBUG "SMU: datablock read failed while reading "
+		       "partition %02x !\n", id);
+		goto failure;
+	}
+
+	/* Got it, check a few things and create the property */
+	if (hdr->id != id) {
+		printk(KERN_DEBUG "SMU: Reading partition %02x and got "
+		       "%02x !\n", id, hdr->id);
+		goto failure;
+	}
+	if (prom_add_property(smu->of_node, prop)) {
+		printk(KERN_DEBUG "SMU: Failed creating sdb-partition-%02x "
+		       "property !\n", id);
+		goto failure;
+	}
+
+	return hdr;
+ failure:
+	kfree(prop);
+	return NULL;
+}
+
+/* Note: Only allowed to return error code in pointers (using ERR_PTR)
+ * when interruptible is 1
+ */
+struct smu_sdbp_header *__smu_get_sdb_partition(int id, unsigned int *size,
+						int interruptible)
 {
 	char pname[32];
+	struct smu_sdbp_header *part;
 
 	if (!smu)
 		return NULL;
 
 	sprintf(pname, "sdb-partition-%02x", id);
-	return (struct smu_sdbp_header *)get_property(smu->of_node,
+
+	if (interruptible) {
+		int rc;
+		rc = down_interruptible(&smu_part_access);
+		if (rc)
+			return ERR_PTR(rc);
+	} else
+		down(&smu_part_access);
+
+	part = (struct smu_sdbp_header *)get_property(smu->of_node,
 						      pname, size);
+	if (part == NULL) {
+		part = smu_create_sdb_partition(id);
+		if (part != NULL && size)
+			*size = part->len << 2;
+	}
+	up(&smu_part_access);
+	return part;
+}
+
+struct smu_sdbp_header *smu_get_sdb_partition(int id, unsigned int *size)
+{
+	return __smu_get_sdb_partition(id, size, 0);
 }
 EXPORT_SYMBOL(smu_get_sdb_partition);
 
@@ -928,6 +1068,14 @@
 	else if (hdr.cmdtype == SMU_CMDTYPE_WANTS_EVENTS) {
 		pp->mode = smu_file_events;
 		return 0;
+	} else if (hdr.cmdtype == SMU_CMDTYPE_GET_PARTITION) {
+		struct smu_sdbp_header *part;
+		part = __smu_get_sdb_partition(hdr.cmd, NULL, 1);
+		if (part == NULL)
+			return -EINVAL;
+		else if (IS_ERR(part))
+			return PTR_ERR(part);
+		return 0;
 	} else if (hdr.cmdtype != SMU_CMDTYPE_SMU)
 		return -EINVAL;
 	else if (pp->mode != smu_file_commands)
Index: linux-work/include/asm-ppc64/smu.h
===================================================================
--- linux-work.orig/include/asm-ppc64/smu.h	2005-09-29 16:56:59.000000000 +1000
+++ linux-work/include/asm-ppc64/smu.h	2005-09-29 17:06:05.000000000 +1000
@@ -20,10 +20,23 @@
 /*
  * Partition info commands
  *
- * I do not know what those are for at this point
+ * These commands are used to retreive the sdb-partition-XX datas from
+ * the SMU. The lenght is always 2. First byte is the subcommand code
+ * and second byte is the partition ID.
+ *
+ * The reply is 6 bytes:
+ *
+ *  - 0..1 : partition address
+ *  - 2    : a byte containing the partition ID
+ *  - 3    : length (maybe other bits are rest of header ?)
+ *
+ * The data must then be obtained with calls to another command:
+ * SMU_CMD_MISC_ee_GET_DATABLOCK_REC (described below).
  */
 #define SMU_CMD_PARTITION_COMMAND		0x3e
-
+#define   SMU_CMD_PARTITION_LATEST		0x01
+#define   SMU_CMD_PARTITION_BASE		0x02
+#define   SMU_CMD_PARTITION_UPDATE		0x03
 
 /*
  * Fan control
@@ -176,6 +189,25 @@
  * Misc commands
  *
  * This command seem to be a grab bag of various things
+ *
+ * SMU_CMD_MISC_ee_GET_DATABLOCK_REC is used, among others, to
+ * transfer blocks of data from the SMU. So far, I've decrypted it's
+ * usage to retreive partition data. In order to do that, you have to
+ * break your transfer in "chunks" since that command cannot transfer
+ * more than a chunk at a time. The chunk size used by OF is 0xe bytes,
+ * but it seems that the darwin driver will let you do 0x1e bytes if
+ * your "PMU" version is >= 0x30. You can get the "PMU" version apparently
+ * either in the last 16 bits of property "smu-version-pmu" or as the 16
+ * bytes at offset 1 of "smu-version-info"
+ *
+ * For each chunk, the command takes 7 bytes of arguments:
+ *  byte 0: subcommand code (0x02)
+ *  byte 1: 0x04 (always, I don't know what it means, maybe the address
+ *                space to use or some other nicety. It's hard coded in OF)
+ *  byte 2..5: SMU address of the chunk (big endian 32 bits)
+ *  byte 6: size to transfer (up to max chunk size)
+ *
+ * The data is returned directly
  */
 #define SMU_CMD_MISC_ee_COMMAND			0xee
 #define   SMU_CMD_MISC_ee_GET_DATABLOCK_REC	0x02
@@ -357,13 +389,13 @@
  * 32 bits integers are usually encoded with 2x16 bits swapped,
  * this demangles them
  */
-#define SMU_U32_MIX(x)	((((x) << 16) & 0xffff0000u) | (((x) >> 16) & 0xffffu))
+//#define SMU_U32_MIX(x)	((((x) << 16) & 0xffff0000u) | (((x) >> 16) & 0xffffu))
 
 /* This is the definition of the SMU sdb-partition-0x12 table (called
  * CPU F/V/T operating points in Darwin). The definition for all those
  * SMU tables should be moved to some separate file
  */
-#define SMU_SDB_FVT_ID		0x12
+#define SMU_SDB_FVT_ID			0x12
 
 struct smu_sdbp_fvt {
 	__u32	sysclk;			/* Base SysClk frequency in Hz for
@@ -380,6 +412,9 @@
 					 */
 };
 
+/* Other partitions without known structures */
+#define SMU_SDB_DEBUG_SWITCHES_ID	0x05
+
 #ifdef __KERNEL__
 /*
  * This returns the pointer to an SMU "sdb" partition data or NULL
@@ -417,14 +452,22 @@
  * It is illegal to send SMU commands through a file descriptor configured
  * for events reception
  *
+ * The special SMU_CMDTYPE_GET_PARTITION command can be used to retreive
+ * SMU sdb-partition's from the SMU when not available. The command will also
+ * cause the new partition to be added to the device-tree. That command has
+ * a data_len of 0, you pass the partition ID in the "cmd" field. It will
+ * not trigger any reply and is not asynchronous. Just fetch the partition
+ * from the device-tree after it's done.
  */
 struct smu_user_cmd_hdr
 {
 	__u32		cmdtype;
 #define SMU_CMDTYPE_SMU			0	/* SMU command */
 #define SMU_CMDTYPE_WANTS_EVENTS	1	/* switch fd to events mode */
+#define SMU_CMDTYPE_GET_PARTITION	2	/* retreive an sdb partition */
 
 	__u8		cmd;			/* SMU command byte */
+	__u8		pad[3];			/* padding */
 	__u32		data_len;		/* Lenght of data following */
 };
 
Index: linux-work/arch/ppc64/kernel/prom.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/prom.c	2005-09-29 16:56:59.000000000 +1000
+++ linux-work/arch/ppc64/kernel/prom.c	2005-09-29 17:06:05.000000000 +1000
@@ -31,6 +31,7 @@
 #include <linux/initrd.h>
 #include <linux/bitops.h>
 #include <linux/module.h>
+#include <linux/module.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -1893,17 +1894,32 @@
 EXPORT_SYMBOL(get_property);
 
 /*
- * Add a property to a node
+ * Add a property to a node.
  */
-void
+int
 prom_add_property(struct device_node* np, struct property* prop)
 {
-	struct property **next = &np->properties;
+	struct property **next;
 
 	prop->next = NULL;	
-	while (*next)
+	write_lock(&devtree_lock);
+	next = &np->properties;
+	while (*next) {
+		if (strcmp(prop->name, (*next)->name) == 0) {
+			/* duplicate ! don't insert it */
+			write_unlock(&devtree_lock);
+			return -1;
+		}
 		next = &(*next)->next;
+	}
 	*next = prop;
+	write_unlock(&devtree_lock);
+
+	/* try to add to proc as well if it was initialized */
+	if (np->pde)
+		proc_device_tree_add_prop(np->pde, prop);
+
+	return 0;
 }
 
 #if 0
Index: linux-work/fs/proc/proc_devtree.c
===================================================================
--- linux-work.orig/fs/proc/proc_devtree.c	2005-09-29 16:56:59.000000000 +1000
+++ linux-work/fs/proc/proc_devtree.c	2005-09-29 17:06:05.000000000 +1000
@@ -49,6 +49,39 @@
  */
 
 /*
+ * Add a property to a node
+ */
+static struct proc_dir_entry *
+__proc_device_tree_add_prop(struct proc_dir_entry *de, struct property *pp)
+{
+	struct proc_dir_entry *ent;
+
+	/*
+	 * Unfortunately proc_register puts each new entry
+	 * at the beginning of the list.  So we rearrange them.
+	 */
+	ent = create_proc_read_entry(pp->name,
+				     strncmp(pp->name, "security-", 9)
+				     ? S_IRUGO : S_IRUSR, de,
+				     property_read_proc, pp);
+	if (ent == NULL)
+		return NULL;
+
+	if (!strncmp(pp->name, "security-", 9))
+		ent->size = 0; /* don't leak number of password chars */
+	else
+		ent->size = pp->length;
+
+	return ent;
+}
+
+
+void proc_device_tree_add_prop(struct proc_dir_entry *pde, struct property *prop)
+{
+	__proc_device_tree_add_prop(pde, prop);
+}
+
+/*
  * Process a node, adding entries for its children and its properties.
  */
 void proc_device_tree_add_node(struct device_node *np,
@@ -57,11 +90,9 @@
 	struct property *pp;
 	struct proc_dir_entry *ent;
 	struct device_node *child;
-	struct proc_dir_entry *list = NULL, **lastp;
 	const char *p;
 
 	set_node_proc_entry(np, de);
-	lastp = &list;
 	for (child = NULL; (child = of_get_next_child(np, child));) {
 		p = strrchr(child->full_name, '/');
 		if (!p)
@@ -71,9 +102,6 @@
 		ent = proc_mkdir(p, de);
 		if (ent == 0)
 			break;
-		*lastp = ent;
-		ent->next = NULL;
-		lastp = &ent->next;
 		proc_device_tree_add_node(child, ent);
 	}
 	of_node_put(child);
@@ -84,7 +112,7 @@
 		 * properties are quite unimportant for us though, thus we
 		 * simply "skip" them here, but we do have to check.
 		 */
-		for (ent = list; ent != NULL; ent = ent->next)
+		for (ent = de->subdir; ent != NULL; ent = ent->next)
 			if (!strcmp(ent->name, pp->name))
 				break;
 		if (ent != NULL) {
@@ -94,25 +122,10 @@
 			continue;
 		}
 
-		/*
-		 * Unfortunately proc_register puts each new entry
-		 * at the beginning of the list.  So we rearrange them.
-		 */
-		ent = create_proc_read_entry(pp->name,
-					     strncmp(pp->name, "security-", 9)
-					     ? S_IRUGO : S_IRUSR, de,
-					     property_read_proc, pp);
+		ent = __proc_device_tree_add_prop(de, pp);
 		if (ent == 0)
 			break;
-		if (!strncmp(pp->name, "security-", 9))
-		     ent->size = 0; /* don't leak number of password chars */
-		else
-		     ent->size = pp->length;
-		ent->next = NULL;
-		*lastp = ent;
-		lastp = &ent->next;
 	}
-	de->subdir = list;
 }
 
 /*
Index: linux-work/include/asm-ppc/prom.h
===================================================================
--- linux-work.orig/include/asm-ppc/prom.h	2005-09-29 16:56:59.000000000 +1000
+++ linux-work/include/asm-ppc/prom.h	2005-09-29 17:06:05.000000000 +1000
@@ -93,7 +93,7 @@
 extern int machine_is_compatible(const char *compat);
 extern unsigned char *get_property(struct device_node *node, const char *name,
 				   int *lenp);
-extern void prom_add_property(struct device_node* np, struct property* prop);
+extern int prom_add_property(struct device_node* np, struct property* prop);
 extern void prom_get_irq_senses(unsigned char *, int, int);
 extern int prom_n_addr_cells(struct device_node* np);
 extern int prom_n_size_cells(struct device_node* np);
Index: linux-work/include/asm-ppc64/prom.h
===================================================================
--- linux-work.orig/include/asm-ppc64/prom.h	2005-09-29 16:56:59.000000000 +1000
+++ linux-work/include/asm-ppc64/prom.h	2005-09-29 17:06:05.000000000 +1000
@@ -201,6 +201,6 @@
 extern int prom_n_size_cells(struct device_node* np);
 extern int prom_n_intr_cells(struct device_node* np);
 extern void prom_get_irq_senses(unsigned char *senses, int off, int max);
-extern void prom_add_property(struct device_node* np, struct property* prop);
+extern int prom_add_property(struct device_node* np, struct property* prop);
 
 #endif /* _PPC64_PROM_H */
Index: linux-work/include/linux/proc_fs.h
===================================================================
--- linux-work.orig/include/linux/proc_fs.h	2005-09-29 16:56:59.000000000 +1000
+++ linux-work/include/linux/proc_fs.h	2005-09-29 17:06:05.000000000 +1000
@@ -139,15 +139,12 @@
 /*
  * proc_devtree.c
  */
+#ifdef CONFIG_PROC_DEVICETREE
 struct device_node;
+struct property;
 extern void proc_device_tree_init(void);
-#ifdef CONFIG_PROC_DEVICETREE
 extern void proc_device_tree_add_node(struct device_node *, struct proc_dir_entry *);
-#else /* !CONFIG_PROC_DEVICETREE */
-static inline void proc_device_tree_add_node(struct device_node *np, struct proc_dir_entry *pde)
-{
-	return;
-}
+extern void proc_device_tree_add_prop(struct proc_dir_entry *pde, struct property *prop);
 #endif /* CONFIG_PROC_DEVICETREE */
 
 extern struct proc_dir_entry *proc_symlink(const char *,
Index: linux-work/arch/ppc/syslib/prom.c
===================================================================
--- linux-work.orig/arch/ppc/syslib/prom.c	2005-09-29 16:56:59.000000000 +1000
+++ linux-work/arch/ppc/syslib/prom.c	2005-09-29 17:06:05.000000000 +1000
@@ -1165,7 +1165,7 @@
 /*
  * Add a property to a node
  */
-void __openfirmware
+int __openfirmware
 prom_add_property(struct device_node* np, struct property* prop)
 {
 	struct property **next = &np->properties;
@@ -1174,6 +1174,8 @@
 	while (*next)
 		next = &(*next)->next;
 	*next = prop;
+
+	return 0;
 }
 
 /* I quickly hacked that one, check against spec ! */


