Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVKSQnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVKSQnd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 11:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVKSQnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 11:43:33 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:18600 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S1750712AbVKSQnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 11:43:32 -0500
Subject: [Patch 2/2] 2.6.15-rc1-mm2: disabling the pagecache for doing
	benchmarks
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 19 Nov 2005 17:43:02 +0100
Message-Id: <1132418582.11657.18.camel@home.sweethome>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The module to get acces over the proc-fs

Signed-off-by: Dirk Gerdes <mail@dirk-gerdes.de>

--
diff -pruN linux-2.6.15-rc1-mm2/block/Kconfig
linux-2.6.15-rc1-mm2-pagecache/block/Kconfig
--- linux-2.6.15-rc1-mm2/block/Kconfig	2005-11-19 12:31:42.000000000
+0100
+++ linux-2.6.15-rc1-mm2-pagecache/block/Kconfig	2005-11-19
13:29:44.000000000 +0100
@@ -23,3 +23,9 @@ config BLK_DEV_IO_TRACE
 	  git://brick.kernel.dk/data/git/blktrace.git
 
 source block/Kconfig.iosched
+
+config PAGECACHE_TOGGLE
+	bool "toggle for using pagecache reading from block-devices"
+	help
+	  This is very useful if you would likr to do benchmarks on the 
+	  performance of the I/O-Schedulers.
diff -pruN linux-2.6.15-rc1-mm2/block/Makefile
linux-2.6.15-rc1-mm2-pagecache/block/Makefile
--- linux-2.6.15-rc1-mm2/block/Makefile	2005-11-19 12:31:42.000000000
+0100
+++ linux-2.6.15-rc1-mm2-pagecache/block/Makefile	2005-11-19
13:29:44.000000000 +0100
@@ -10,3 +10,4 @@ obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadli
 obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
 
 obj-$(CONFIG_BLK_DEV_IO_TRACE)	+= blktrace.o
+obj-$(CONFIG_PAGECACHE_TOGGLE)	+= pagecache.o
diff -pruN linux-2.6.15-rc1-mm2/block/pagecache.c
linux-2.6.15-rc1-mm2-pagecache/block/pagecache.c
--- linux-2.6.15-rc1-mm2/block/pagecache.c	1970-01-01 01:00:00.000000000
+0100
+++ linux-2.6.15-rc1-mm2-pagecache/block/pagecache.c	2005-11-19
13:29:44.000000000 +0100
@@ -0,0 +1,76 @@
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/uaccess.h>
+//#include <linux/pagecache.h>
+
+
+MODULE_LICENSE("GPL");
+
+extern int pagecache;
+
+
+static struct proc_dir_entry 	*benchmark_dir, 
+				*pagecache_entry;
+		
+				
+				
+
+			
+				
+static int pagecache_entry_read(char *buf, char **start,off_t
offset,int size, int *eof, void *data)
+{
+	printk("%i__\n",pagecache);
+	int bytes_written = 0;
+	if (pagecache) 
+		bytes_written = snprintf(buf, size, "[on] off\n");
+	else
+		bytes_written = snprintf(buf, size, " on [off]\n");
+	return bytes_written;
+}
+
+static int pagecache_entry_write(struct file * instanz, const char
__user *userbuffer, unsigned long count, void *data)
+{	
+	char *kernel_buffer;
+	int not_copied;
+		
+	kernel_buffer = kmalloc(count, GFP_KERNEL);
+	if (!kernel_buffer)
+		return -ENOMEM;
+	not_copied = copy_from_user(kernel_buffer, userbuffer, count);
+	if (strncmp (kernel_buffer,"on",2)==0){
+	 	pagecache=1;
+	}
+	else if (strncmp (kernel_buffer,"off",3)==0){
+		pagecache=0;
+	}
+
+	kfree(kernel_buffer);
+	return count-not_copied;
+}
+
+static int __init my_init(void)
+{
+	
+	
+	benchmark_dir = proc_mkdir("benchmark",NULL);
+	pagecache_entry = create_proc_entry("pagecache",S_IRUGO,
benchmark_dir);
+	if (pagecache_entry){
+		pagecache_entry->read_proc  = pagecache_entry_read;
+		pagecache_entry->write_proc = pagecache_entry_write;
+		
+		pagecache_entry->data      = NULL;	
+	}
+	
+	return 0;
+}
+static void __exit my_exit(void){
+	if (pagecache_entry) 	remove_proc_entry("pagecache",benchmark_dir);
+	if (benchmark_dir)	remove_proc_entry("benchmark",NULL);
+}
+
+
+module_init(my_init);
+module_exit(my_exit);
+


