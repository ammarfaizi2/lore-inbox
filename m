Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262970AbTCNASr>; Thu, 13 Mar 2003 19:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbTCNASq>; Thu, 13 Mar 2003 19:18:46 -0500
Received: from verein.lst.de ([212.34.181.86]:8967 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262970AbTCNASm>;
	Thu, 13 Mar 2003 19:18:42 -0500
Date: Fri, 14 Mar 2003 01:29:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] switch over /proc/bus/i2c to seq_file interface
Message-ID: <20030314012926.A27098@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.20/drivers/i2c/i2c-core.c	Tue Mar 11 15:21:11 2003
+++ edited/drivers/i2c/i2c-core.c	Fri Mar 14 00:56:08 2003
@@ -30,6 +30,7 @@
 #include <linux/proc_fs.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 #include <asm/uaccess.h>
 
 
@@ -443,45 +444,7 @@
 	return 0;
 }
 
-/* ----------------------------------------------------
- * The /proc functions
- * ----------------------------------------------------
- */
-
 #ifdef CONFIG_PROC_FS
-/* This function generates the output for /proc/bus/i2c */
-static int read_bus_i2c(char *buf, char **start, off_t offset,
-			int len, int *eof, void *private)
-{
-	int i;
-	int nr = 0;
-
-	/* Note that it is safe to write a `little' beyond len. Yes, really. */
-	/* Fuck you.  Will convert this to seq_file later.  --hch */
-
-	down(&core_lists);
-	for (i = 0; (i < I2C_ADAP_MAX) && (nr < len); i++) {
-		if (adapters[i]) {
-			nr += sprintf(buf+nr, "i2c-%d\t", i);
-			if (adapters[i]->algo->smbus_xfer) {
-				if (adapters[i]->algo->master_xfer)
-					nr += sprintf(buf+nr,"smbus/i2c");
-				else
-					nr += sprintf(buf+nr,"smbus    ");
-			} else if (adapters[i]->algo->master_xfer)
-				nr += sprintf(buf+nr,"i2c       ");
-			else
-				nr += sprintf(buf+nr,"dummy     ");
-			nr += sprintf(buf+nr,"\t%-32s\t%-32s\n",
-			              adapters[i]->name,
-			              adapters[i]->algo->name);
-		}
-	}
-	up(&core_lists);
-
-	return nr;
-}
-
 /* This function generates the output for /proc/bus/i2c-? */
 static ssize_t i2cproc_bus_read(struct file *file, char *buf,
 				size_t count, loff_t *ppos)
@@ -551,6 +514,50 @@
 	.read		= i2cproc_bus_read,
 };
 
+/* This function generates the output for /proc/bus/i2c */
+static int bus_i2c_show(struct seq_file *s, void *p)
+{
+	int i;
+
+	down(&core_lists);
+	for (i = 0; i < I2C_ADAP_MAX; i++) {
+		struct i2c_adapter *adapter = adapters[i];
+
+		if (!adapter)
+			continue;
+
+		seq_printf(s, "i2c-%d\t", i);
+
+		if (adapter->algo->smbus_xfer) {
+			if (adapter->algo->master_xfer)
+				seq_printf(s, "smbus/i2c");
+			else
+				seq_printf(s, "smbus    ");
+		} else if (adapter->algo->master_xfer)
+			seq_printf(s ,"i2c       ");
+		else
+			seq_printf(s, "dummy     ");
+
+		seq_printf(s, "\t%-32s\t%-32s\n",
+			      adapter->name, adapter->algo->name);
+	}
+	up(&core_lists);
+
+	return 0;
+}
+
+static int bus_i2c_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, bus_i2c_show, NULL);
+}
+
+static struct file_operations bus_i2c_fops = {
+	.open		= bus_i2c_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+ };
+
 static int i2cproc_register(struct i2c_adapter *adap, int bus)
 {
 	struct proc_dir_entry *proc_entry;
@@ -583,15 +590,16 @@
 {
 	struct proc_dir_entry *proc_bus_i2c;
 
-	proc_bus_i2c = create_proc_entry("i2c",0,proc_bus);
-	if (!proc_bus_i2c) {
-		printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/i2c");
-		return -ENOENT;
- 	}
+	proc_bus_i2c = create_proc_entry("i2c", 0, proc_bus);
+	if (!proc_bus_i2c)
+		goto fail;
+	proc_bus_i2c->proc_fops = &bus_i2c_fops;
+ 	proc_bus_i2c->owner = THIS_MODULE;
+ 	return 0;
 
-	proc_bus_i2c->read_proc = &read_bus_i2c;
-	proc_bus_i2c->owner = THIS_MODULE;
-	return 0;
+ fail:
+	printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/i2c");
+	return -ENOENT;
 }
 
 static void __exit i2cproc_cleanup(void)
