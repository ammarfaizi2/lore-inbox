Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbSL2R25>; Sun, 29 Dec 2002 12:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbSL2R25>; Sun, 29 Dec 2002 12:28:57 -0500
Received: from APuteaux-102-1-3-2.abo.wanadoo.fr ([193.253.232.2]:52266 "EHLO
	donald.as2917.net") by vger.kernel.org with ESMTP
	id <S266622AbSL2R2t>; Sun, 29 Dec 2002 12:28:49 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Paul Rolland <rol@as2917.net>
Reply-To: rol@as2917.net
To: linux-kernel@vger.kernel.org
Subject: [Patch] Kernel configuration in kernel, kernel 2.5.53
Date: Sun, 29 Dec 2002 18:37:09 +0100
User-Agent: KMail/1.4.3
X-Ncc-Regid: fr.witbe
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212291837.09152.rol@as2917.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is the 2.5.53 version of the patch I just sent to the list for 2.4.20
Main differences are in the Makefile and Kconfig. the C source code hasn't changed.

This has been tested on a standard 2.5.53 without problem, just one important
point : you need to activate /proc support.

This constraint is not present in the Kconfig entry, as I don't know how to do.
Any idea welcome...

Regards,
Paul Rolland, rol@as2917.net

diff -urN --exclude=.tmp --exclude=.config --exclude=include linux-2.5.53-config/drivers/char/config.c linux-2.5.53/drivers/char/config.c
--- linux-2.5.53-config/drivers/char/config.c   1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.53/drivers/char/config.c  2002-12-29 17:26:46.000000000 +0100
@@ -0,0 +1,148 @@
+/*
+ * Linux Configuration Driver
+ * (c) 2002 Paul Rolland
+ *
+ * This driver is intended to give access to the .config file that was
+ * used to compile the kernel.
+ * It does include a gzip'd copy of the file, which can be access thru
+ * /proc/config/config.gz
+ *
+ */
+
+#define CONFIG_VERSION         "1.0"
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/mc146818rtc.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#include "config.h"
+
+static int config_read_proc(char * page, char ** start, off_t off,
+                            int count, int *eof, void *data);
+
+
+#ifndef CONFIG_PROC_FS
+#warn Attention
+static int config_read_proc( char *buffer, char **start, off_t offset,
+                           int size, int *eof, void *data) { return 0; }
+#else
+
+/* This macro frees the machine specific function from bounds checking and
+ * this like that... */
+#define        PRINT_PROC(fmt,args...)                                 \
+        do {                                                   \
+          *len += sprintf( buffer+*len, fmt, ##args );         \
+          if (*begin + *len > offset + size)                   \
+            return( 0 );                                       \
+          if (*begin + *len < offset) {                                \
+            *begin += *len;                                    \
+            *len = 0;                                          \
+           }                                                   \
+         } while(0)
+
+
+static int config_version_infos(char *buffer, int *len, off_t *begin,
+                                off_t offset, int size)
+{
+  PRINT_PROC("Linux Kernel Configuration driver version %s\n", CONFIG_VERSION);
+  PRINT_PROC("(c) P. Rolland - Dec 2002\n");
+
+  return(1);
+}
+
+static int config_gz_infos(char *buffer, int *len, off_t *begin, off_t offset, 
+                           int size)
+{
+  int i;
+ 
+  for (i=0; i<CONFIG_SIZE; i++) {
+    PRINT_PROC("%c", config_gz[i]);
+  }
+
+  return(1);
+}
+
+static int config_read_proc( char *buffer, char **start, off_t offset,
+                            int size, int *eof, void *data )
+{
+  int len = 0;
+  off_t begin = 0;
+
+  *eof = config_version_infos(buffer, &len, &begin, offset, size);
+
+  if (offset >= begin + len)
+    return(0);
+  *start = buffer + (offset - begin);
+  return( size < begin + len - offset ? size : begin + len - offset );
+}
+
+static int config_gz_read_proc( char *buffer, char **start, off_t offset,
+                                int size, int *eof, void *data )
+{
+  int len = 0;
+  off_t begin = 0;
+
+  *eof = config_gz_infos(buffer, &len, &begin, offset, size);
+
+  if (offset >= begin + len)
+    return(0);
+  *start = buffer + (offset - begin);
+  return( size < begin + len - offset ? size : begin + len - offset );
+}
+
+static int __init config_init(void)
+{
+  struct proc_dir_entry * entry;
+  entry = create_proc_entry("config", S_IRUGO|S_IXUGO|S_IFDIR, NULL);
+  if (entry == NULL) {
+    printk(KERN_ERR "config: can't create /proc/config\n");
+    return(-ENOMEM);
+  }
+
+  if (!create_proc_read_entry("config/version",0,0,config_read_proc,NULL)) {
+    printk(KERN_ERR "config: can't create /proc/config/version\n");
+    return(-ENOMEM);
+  }
+  if (!create_proc_read_entry("config/config.gz",0,0,config_gz_read_proc,NULL)) {
+    printk(KERN_ERR "config: can't create /proc/config/config.gz\n");
+    return(-ENOMEM);
+  }
+
+  printk(KERN_INFO "Linux Kernel Configuration driver v" CONFIG_VERSION " (c) Paul Rolland\n");
+
+  return( 0 );
+}
+
+static void __exit config_cleanup_module (void)
+{
+  remove_proc_entry( "config/version", 0 );
+  remove_proc_entry( "config/config.gz", 0 );
+  remove_proc_entry( "config", 0 );
+}
+
+module_init(config_init);
+module_exit(config_cleanup_module);
+
+#endif /* CONFIG_PROC_FS */
+
+MODULE_AUTHOR("Paul Rolland");
+MODULE_DESCRIPTION("Driver for accessing kernel configuration");
+MODULE_LICENSE("GPL");
+
+EXPORT_NO_SYMBOLS;
diff -urN --exclude=.tmp --exclude=.config --exclude=include linux-2.5.53-config/drivers/char/dotHmaker.c linux-2.5.53/drivers/char/dotHmaker.c
--- linux-2.5.53-config/drivers/char/dotHmaker.c        1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.53/drivers/char/dotHmaker.c       2002-12-29 17:43:37.000000000 +0100
@@ -0,0 +1,41 @@
+#include <stdio.h>
+
+int main(void)
+{
+  FILE * in = stdin;
+  int i;
+  unsigned char buf;
+
+  int size = 0;
+
+  printf("/*\n");
+  printf(" * Automagically generated file, please don't edit !\n");
+  printf(" */\n");
+  printf("\n");
+  printf("static char config_gz[] = \\\n");
+
+  i = 0;
+
+  fread(&buf, sizeof(unsigned char), 1, in);
+  while (!feof(in)) {
+    if (i == 0) {
+      printf("  \"");
+    } /* endif */
+    printf("\\x%x", buf);
+    size ++;
+    i ++;
+    if (i == 10) {
+      i = 0;
+      printf("\"\\\n");
+    } /* endif */
+    fread(&buf, sizeof(unsigned char), 1, in);
+  } /* endwhile */
+
+  if (i != 0) {
+    printf("\";\n");
+  } /* endif */
+  printf("\n");
+  printf("#define CONFIG_SIZE %d\n\n", size);
+
+  exit(0);
+}
diff -urN --exclude=.tmp --exclude=.config --exclude=include linux-2.5.53-config/drivers/char/Kconfig linux-2.5.53/drivers/char/Kconfig
--- linux-2.5.53-config/drivers/char/Kconfig    2002-12-24 06:19:26.000000000 +0100
+++ linux-2.5.53/drivers/char/Kconfig   2002-12-29 17:22:12.000000000 +0100
@@ -4,6 +4,13 @@
 
 menu "Character devices"
 
+config CONFIG
+       bool "Linux Kernel Configuration Driver"
+       ---help---
+         If you say Y here, and if you have /proc support enabled, you'll find
+         a /proc/config directory that will contain the .config used to generate
+         the running kernel.
+
 config VT
        bool "Virtual terminal"
        ---help---
diff -urN --exclude=.tmp --exclude=.config --exclude=include linux-2.5.53-config/drivers/char/Makefile linux-2.5.53/drivers/char/Makefile
--- linux-2.5.53-config/drivers/char/Makefile   2002-12-24 06:21:17.000000000 +0100
+++ linux-2.5.53/drivers/char/Makefile  2002-12-29 17:43:53.000000000 +0100
@@ -16,6 +16,7 @@
                        ite_gpio.o keyboard.o misc.o nvram.o random.o rtc.o \
                        selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o
 
+obj-$(CONFIG_CONFIG) += config.o
 obj-$(CONFIG_VT) += vt_ioctl.o vc_screen.o consolemap.o consolemap_deftbl.o selection.o keyboard.o
 obj-$(CONFIG_HW_CONSOLE) += vt.o defkeymap.o
 obj-$(CONFIG_MAGIC_SYSRQ) += sysrq.o
@@ -85,7 +86,7 @@
 
 
 # Files generated that shall be removed upon make clean
-clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
+clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c config.h
 
 $(obj)/consolemap_deftbl.c: $(src)/$(FONTMAPFILE)
        $(call do_cmd,CONMK  $@,$(objtree)/scripts/conmakehash $< > $@)
@@ -107,3 +108,14 @@
        rm $@.tmp
 
 endif
+
+$(obj)/config.o: $(obj)/config.h
+
+$(obj)/config.h: $(obj)/config.txt.gz
+       cc -o $(obj)/dotHmaker $(obj)/dotHmaker.c
+       $(obj)/./dotHmaker < $(obj)/config.txt.gz > $(obj)/config.h
+
+$(obj)/config.txt.gz::
+       cp .config $(obj)/config.txt
+       gzip -f $(obj)/config.txt
+
