Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTDCAC0>; Wed, 2 Apr 2003 19:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263227AbTDCACZ>; Wed, 2 Apr 2003 19:02:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:2010 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263204AbTDCACL> convert rfc822-to-8bit;
	Wed, 2 Apr 2003 19:02:11 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10493289581592@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <1049328958105@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:58 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.977.29.11, 2003/04/02 13:54:45-08:00, greg@kroah.com

i2c: remove all proc code from the i2c core, as it's no longer needed.


 drivers/i2c/i2c-core.c |  187 -------------------------------------------------
 1 files changed, 1 insertion(+), 186 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Wed Apr  2 16:00:37 2003
+++ b/drivers/i2c/i2c-core.c	Wed Apr  2 16:00:37 2003
@@ -29,7 +29,6 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <linux/proc_fs.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
@@ -46,15 +45,6 @@
 /**** debug level */
 static int i2c_debug;
 
-#ifdef CONFIG_PROC_FS
-static int i2cproc_register(struct i2c_adapter *adap, int bus);
-static void i2cproc_remove(int bus);
-#else
-# define i2cproc_register(adap, bus)	0
-# define i2cproc_remove(bus)		do { } while (0)
-#endif /* CONFIG_PROC_FS */
-
-
 int i2c_device_probe(struct device *dev)
 {
 	return -ENODEV;
@@ -98,10 +88,6 @@
 		goto out_unlock;
 	}
 
-	res = i2cproc_register(adap, i);
-	if (res)
-		goto out_unlock;
-
 	adapters[i] = adap;
 
 	init_MUTEX(&adap->bus);
@@ -180,8 +166,6 @@
 		}
 	}
 
-	i2cproc_remove(i);
-
 	/* clean up the sysfs representation */
 	device_unregister(&adap->dev);
 
@@ -495,173 +479,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-/* This function generates the output for /proc/bus/i2c-? */
-static ssize_t i2cproc_bus_read(struct file *file, char *buf,
-				size_t count, loff_t *ppos)
-{
-	struct inode *inode = file->f_dentry->d_inode;
-	char *kbuf;
-	struct i2c_client *client;
-	int i,j,k,order_nr,len=0;
-	size_t len_total;
-	int order[I2C_CLIENT_MAX];
-#define OUTPUT_LENGTH_PER_LINE 70
-
-	len_total = file->f_pos + count;
-	if (len_total > (I2C_CLIENT_MAX * OUTPUT_LENGTH_PER_LINE) )
-		/* adjust to maximum file size */
-		len_total = (I2C_CLIENT_MAX * OUTPUT_LENGTH_PER_LINE);
-	for (i = 0; i < I2C_ADAP_MAX; i++)
-		if (adapters[i]->inode == inode->i_ino) {
-		/* We need a bit of slack in the kernel buffer; this makes the
-		   sprintf safe. */
-			if (! (kbuf = kmalloc(len_total +
-			                      OUTPUT_LENGTH_PER_LINE,
-			                      GFP_KERNEL)))
-				return -ENOMEM;
-			/* Order will hold the indexes of the clients
-			   sorted by address */
-			order_nr=0;
-			for (j = 0; j < I2C_CLIENT_MAX; j++) {
-				if ((client = adapters[i]->clients[j]) && 
-				    (client->driver->id != I2C_DRIVERID_I2CDEV))  {
-					for(k = order_nr; 
-					    (k > 0) && 
-					    adapters[i]->clients[order[k-1]]->
-					             addr > client->addr; 
-					    k--)
-						order[k] = order[k-1];
-					order[k] = j;
-					order_nr++;
-				}
-			}
-
-
-			for (j = 0; (j < order_nr) && (len < len_total); j++) {
-				client = adapters[i]->clients[order[j]];
-				len += sprintf(kbuf+len,"%02x\t%-32s\t%-32s\n",
-				              client->addr,
-				              client->dev.name,
-				              client->driver->name);
-			}
-			len = len - file->f_pos;
-			if (len > count)
-				len = count;
-			if (len < 0) 
-				len = 0;
-			if (copy_to_user (buf,kbuf+file->f_pos, len)) {
-				kfree(kbuf);
-				return -EFAULT;
-			}
-			file->f_pos += len;
-			kfree(kbuf);
-			return len;
-		}
-	return -ENOENT;
-}
-
-static struct file_operations i2cproc_operations = {
-	.read		= i2cproc_bus_read,
-};
-
-/* This function generates the output for /proc/bus/i2c */
-static int bus_i2c_show(struct seq_file *s, void *p)
-{
-	int i;
-
-	down(&core_lists);
-	for (i = 0; i < I2C_ADAP_MAX; i++) {
-		struct i2c_adapter *adapter = adapters[i];
-
-		if (!adapter)
-			continue;
-
-		seq_printf(s, "i2c-%d\t", i);
-
-		if (adapter->algo->smbus_xfer) {
-			if (adapter->algo->master_xfer)
-				seq_printf(s, "smbus/i2c");
-			else
-				seq_printf(s, "smbus    ");
-		} else if (adapter->algo->master_xfer)
-			seq_printf(s ,"i2c       ");
-		else
-			seq_printf(s, "dummy     ");
-
-		seq_printf(s, "\t%-32s\t%-32s\n",
-			      adapter->dev.name, adapter->algo->name);
-	}
-	up(&core_lists);
-
-	return 0;
-}
-
-static int bus_i2c_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, bus_i2c_show, NULL);
-}
-
-static struct file_operations bus_i2c_fops = {
-	.open		= bus_i2c_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
- };
-
-static int i2cproc_register(struct i2c_adapter *adap, int bus)
-{
-	struct proc_dir_entry *proc_entry;
-	char name[8];
-
-	sprintf(name, "i2c-%d", bus);
-
-	proc_entry = create_proc_entry(name, 0, proc_bus);
-	if (!proc_entry)
-		goto fail;
-
-	proc_entry->proc_fops = &i2cproc_operations;
-	proc_entry->owner = adap->owner;
-	adap->inode = proc_entry->low_ino;
-	return 0;
- fail:
-	printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/%s\n", name);
-	return -ENOENT;
-}
-
-static void i2cproc_remove(int bus)
-{
-	char name[8];
-
-	sprintf(name,"i2c-%d", bus);
-	remove_proc_entry(name, proc_bus);
-}
-
-static int __init i2cproc_init(void)
-{
-	struct proc_dir_entry *proc_bus_i2c;
-
-	proc_bus_i2c = create_proc_entry("i2c", 0, proc_bus);
-	if (!proc_bus_i2c)
-		goto fail;
-	proc_bus_i2c->proc_fops = &bus_i2c_fops;
- 	proc_bus_i2c->owner = THIS_MODULE;
- 	return 0;
-
- fail:
-	printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/i2c");
-	return -ENOENT;
-}
-
-static void __exit i2cproc_cleanup(void)
-{
-	remove_proc_entry("i2c",proc_bus);
-}
-#else
-static int __init i2cproc_init(void) { return 0; }
-static void __exit i2cproc_cleanup(void) { }
-#endif /* CONFIG_PROC_FS */
-
 /* match always succeeds, as we want the probe() to tell if we really accept this match */
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
@@ -676,13 +493,11 @@
 
 static int __init i2c_init(void)
 {
-	bus_register(&i2c_bus_type);
-	return i2cproc_init();
+	return bus_register(&i2c_bus_type);
 }
 
 static void __exit i2c_exit(void)
 {
-	i2cproc_cleanup();
 	bus_unregister(&i2c_bus_type);
 }
 

