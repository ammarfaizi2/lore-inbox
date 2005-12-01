Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVLANXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVLANXc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVLANXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:23:32 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:63916 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S932224AbVLANXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:23:31 -0500
Subject: [PATCH 2/4] linux-2.6-block: deactivating pagecache for benchmarks
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 14:23:20 +0100
Message-Id: <1133443400.6110.39.camel@noti>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the code for the /proc/benchmark/pagecache

Signed-Off-By: Dirk Gerdes <mail@dirk-gerdes.de>
---

--- linux-2.6-block_clean/block/pagecache.c	2005-12-01
12:24:30.000000000 +0100
+++ linux-2.6-block-pagecache-clean/block/pagecache.c	2005-11-30 17:14:40.000000000 +0100
@@ -0,0 +1,75 @@
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
+static int pagecache_entry_read(char *buf, char **start,off_t offset,int size, int *eof, void *data)
+{
+	int bytes_written = 0;
+	if (pagecache) 
+		bytes_written = snprintf(buf, size, "[on] off\n");
+	else
+		bytes_written = snprintf(buf, size, " on [off]\n");
+	return bytes_written;
+}
+
+static int pagecache_entry_write(struct file * instanz, const char __user *userbuffer, unsigned long count, void *data)
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
+	pagecache_entry = create_proc_entry("pagecache",S_IRUGO, benchmark_dir);
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

