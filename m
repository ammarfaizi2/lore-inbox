Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264169AbRGELDx>; Thu, 5 Jul 2001 07:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264204AbRGELDd>; Thu, 5 Jul 2001 07:03:33 -0400
Received: from inetp.rfntr.neva.ru ([195.208.122.152]:39428 "EHLO
	taz.citycat.ru") by vger.kernel.org with ESMTP id <S264169AbRGELD0>;
	Thu, 5 Jul 2001 07:03:26 -0400
Date: Thu, 5 Jul 2001 15:07:25 +0400
From: hac <hac@subscribe.ru>
X-Mailer: The Bat! (v1.49)
X-Priority: 3 (Normal)
Message-ID: <1233018743.20010705150725@subscribe.ru>
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.6: /proc/null - counter for /dev/null traffic
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Below is patch (for 2.4.6, 2.4.5)
to add support /proc/null - a counter for /dev/null's write traffic

Why not ? Some time it shows very ineteresting things.
For example - Mozilla write 22Mb to /dev/null just at start.

Was tested for two weeks on Intel-platfom with help of my friends.

--- drivers/char/mem.c.orig     Thu Jul  5 14:22:28 2001
+++ drivers/char/mem.c  Thu Jul  5 14:22:39 2001
@@ -3,6 +3,21 @@
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
+ *  Added /proc/null support.
+ *    Jun-25-2001, Pavel Yakovlev <hac@subscribe.ru>
+ *
+ *   About:
+ *
+ *    /proc/null - counter for /dev/null's write traffic
+ *    A counter is 4 * unsigned long width (4 is default, configured by WRITE_NULL_LEN)
+ *
+ *   Usage:
+ *
+ *    echo 0 >/proc/null - reset to 0
+ *
+ *    bc </proc/null - bytes writed to /dev/null
+ *
+ *
  *  Added devfs support. 
  *    Jan-11-1998, C. Scott Ananian <cananian@alumni.princeton.edu>
  *  Shared /dev/zero mmaping support, Feb 2000, Kanoj Sarcar <kanoj@sgi.com>
@@ -21,6 +36,7 @@
 #include <linux/raw.h>
 #include <linux/tty.h>
 #include <linux/capability.h>
+#include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -336,9 +352,65 @@
        return 0;
 }
 
+
+
+typedef unsigned long wnc_t;
+
+#define WRITE_NULL_LEN 4
+static wnc_t write_null_count[WRITE_NULL_LEN];
+
 static ssize_t write_null(struct file * file, const char * buf,
                          size_t count, loff_t *ppos)
 {
+       wnc_t old_val;
+       int i;
+       
+       old_val = write_null_count[0];
+       if ((write_null_count[0] += count) < old_val) {
+           for ( i = 1; i < WRITE_NULL_LEN; i++) {
+               old_val = write_null_count[i];
+               if (++write_null_count[i] > old_val)
+                   break;
+
+           }
+           if (i == WRITE_NULL_LEN)
+               printk("/dev/null overflow ;)\n");
+       }
+        
+       return count;
+}
+
+static int null_proc_read(char *buf, char **start, off_t offset,
+                         int count, int *eof, void *data)
+{
+       int len = 0;
+       int i;
+
+       for ( i = 0; i < WRITE_NULL_LEN; i++) {
+           len += sprintf(buf+len,"%lu  *2^%i+\\\n",write_null_count[i],i*sizeof(wnc_t)*8);
+       }
+       len += sprintf(buf+len,"0\n");
+  
+ /* from fs/proc/proc_misc.c::proc_calc_metric() */
+ 
+       if (len <= offset+count) *eof = 1;
+       *start = buf + offset;
+       len -= offset;
+       if (len>count) len = count;
+       if (len<0) len = 0;
+       return len;
+ 
+ /* end from ... */
+}
+
+static int null_proc_write(struct file *file, const char *buf,
+                           unsigned long count, void *data)
+{
+       int i;
+       for ( i = 0; i < WRITE_NULL_LEN; i++) {
+           write_null_count[i] = 0;
+       }
+
        return count;
 }
 
@@ -434,6 +506,12 @@
        return written ? written : -EFAULT;
 }
 
+static ssize_t write_zero(struct file * file, const char * buf,
+                         size_t count, loff_t *ppos)
+{
+       return count;
+}
+
 static int mmap_zero(struct file * file, struct vm_area_struct * vma)
 {
        if (vma->vm_flags & VM_SHARED)
@@ -490,7 +568,6 @@
 #define mmap_kmem      mmap_mem
 #define zero_lseek     null_lseek
 #define full_lseek      null_lseek
-#define write_zero     write_null
 #define read_full       read_zero
 #define open_mem       open_port
 #define open_kmem      open_mem
@@ -609,6 +686,13 @@
 
 int __init chr_dev_init(void)
 {
+       struct proc_dir_entry *ent =  create_proc_entry("null", S_IRUGO | S_IWUSR | S_IWGRP, NULL);
+       if (ent) {
+           ent->read_proc = &null_proc_read;
+           ent->write_proc = &null_proc_write;
+       } else 
+           printk("unable to create /proc/null read entry\n");
+
        if (devfs_register_chrdev(MEM_MAJOR,"mem",&memory_fops))
                printk("unable to get major %d for memory devs\n", MEM_MAJOR);
        memory_devfs_register();  

--------------------------------------
Павел Яковлев
mailto: hac@subscribe.ru ICQ 8085803 PPY-RIPN
технический директор
ЗАО "Интернет-Проекты"
--------------------------------------
"God is real, unless declared integer"


