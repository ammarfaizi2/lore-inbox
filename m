Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbTABS3n>; Thu, 2 Jan 2003 13:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTABS3n>; Thu, 2 Jan 2003 13:29:43 -0500
Received: from tag.witbe.net ([81.88.96.48]:26629 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S265198AbTABS3j>;
	Thu, 2 Jan 2003 13:29:39 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Khalid Aziz'" <khalid_aziz@hp.com>,
       "'Robert P. J. Day'" <rpjday@mindspring.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: kernel .config support?
Date: Thu, 2 Jan 2003 19:37:56 +0100
Message-ID: <000101c2b28e$120801d0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <3E146E6B.8CCA954E@hp.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Following some advices from the list, here is my patch updated,
to embed the .config in the kernel and give access to a gzip'ed
copy thru /proc/config/config.gz

Regards,
Paul


diff -urN linux-2.5.53-orig/drivers/char/Kconfig
linux-2.5.53/drivers/char/Kconfig
--- linux-2.5.53-orig/drivers/char/Kconfig      Tue Dec 24 06:19:26 2002
+++ linux-2.5.53/drivers/char/Kconfig   Mon Dec 30 08:35:54 2002
@@ -4,6 +4,13 @@

 menu "Character devices"

+config CONFIG
+       bool "Linux Kernel Configuration Driver"
+       ---help---
+         If you say Y here, and if you have /proc support enabled,
you'll find
+         a /proc/config directory that will contain a copy of the
.config used
+         to generate the running kernel.
+
 config VT
        bool "Virtual terminal"
        ---help---
diff -urN linux-2.5.53-orig/drivers/char/Makefile
linux-2.5.53/drivers/char/Makefile
--- linux-2.5.53-orig/drivers/char/Makefile     Tue Dec 24 06:21:17 2002
+++ linux-2.5.53/drivers/char/Makefile  Mon Dec 30 12:06:53 2002
@@ -7,6 +7,9 @@
 #
 FONTMAPFILE = cp437.uni

+EXTRA_TARGETS  := config.h
+host-progs     := dotHmaker
+
 obj-y   += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o

 # All of the (potential) objects that export symbols.
@@ -16,6 +19,7 @@
                        ite_gpio.o keyboard.o misc.o nvram.o random.o
rtc.o \
                        selection.o sonypi.o sysrq.o tty_io.o
tty_ioctl.o

+obj-$(CONFIG_CONFIG) += config.o
 obj-$(CONFIG_VT) += vt_ioctl.o vc_screen.o consolemap.o
consolemap_deftbl.o selection.o keyboard.o
 obj-$(CONFIG_HW_CONSOLE) += vt.o defkeymap.o
 obj-$(CONFIG_MAGIC_SYSRQ) += sysrq.o
@@ -85,7 +89,7 @@


 # Files generated that shall be removed upon make clean
-clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
+clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c dotHmaker
config.txt config.txt.gz config.h

 $(obj)/consolemap_deftbl.c: $(src)/$(FONTMAPFILE)
        $(call do_cmd,CONMK  $@,$(objtree)/scripts/conmakehash $< > $@)
@@ -107,3 +111,13 @@
        rm $@.tmp

 endif
+
+$(obj)/config.o: $(obj)/config.h
+
+$(obj)/config.h: $(obj)/config.txt.gz $(obj)/dotHmaker
+       $(obj)/dotHmaker < $< > $@
+
+$(obj)/config.txt.gz: .config FORCE
+       cp .config $(obj)/config.txt
+       $(call if_changed,gzip)
+
diff -urN linux-2.5.53-orig/drivers/char/config.c
linux-2.5.53/drivers/char/config.c
--- linux-2.5.53-orig/drivers/char/config.c     Thu Jan  1 01:00:00 1970
+++ linux-2.5.53/drivers/char/config.c  Mon Dec 30 08:33:48 2002
@@ -0,0 +1,149 @@
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
+#define DOT_CONFIG_VERSION         "1.0"
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
+                           int size, int *eof, void *data) { return 0; 
+} #else
+
+/* This macro frees the machine specific function from bounds checking 
+and
+ * this like that... */
+#define        PRINT_PROC(fmt,args...)
\
+        do {                                                   \
+          *len += sprintf( buffer+*len, fmt, ##args );         \
+          if (*begin + *len > offset + size)                   \
+            return( 0 );                                       \
+          if (*begin + *len < offset) {
\
+            *begin += *len;                                    \
+            *len = 0;                                          \
+           }                                                   \
+         } while(0)
+
+
+static int config_version_infos(char *buffer, int *len, off_t *begin,
+                                off_t offset, int size)
+{
+  PRINT_PROC("Linux Kernel Configuration driver version %s\n", 
+DOT_CONFIG_VERSION);
+  PRINT_PROC("(c) P. Rolland - Dec 2002\n");
+
+  return(1);
+}
+
+static int config_gz_infos(char *buffer, int *len, off_t *begin, off_t
offset, 
+                           int size)
+{
+  int i;
+ 
+  for (i=0; i<DOT_CONFIG_GZ_SIZE; i++) {
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
+static int config_gz_read_proc( char *buffer, char **start, off_t
offset,
+                                int size, int *eof, void *data ) {
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
+  if
(!create_proc_read_entry("config/version",0,0,config_read_proc,NULL)) {
+    printk(KERN_ERR "config: can't create /proc/config/version\n");
+    return(-ENOMEM);
+  }
+  if
(!create_proc_read_entry("config/config.gz",0,0,config_gz_read_proc,NULL
)) {
+    printk(KERN_ERR "config: can't create /proc/config/config.gz\n");
+    return(-ENOMEM);
+  }
+  
+  printk(KERN_INFO "Linux Kernel Configuration driver v"
DOT_CONFIG_VERSION 
+ " (c) Paul Rolland\n");
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
diff -urN linux-2.5.53-orig/drivers/char/dotHmaker.c
linux-2.5.53/drivers/char/dotHmaker.c
--- linux-2.5.53-orig/drivers/char/dotHmaker.c  Thu Jan  1 01:00:00 1970
+++ linux-2.5.53/drivers/char/dotHmaker.c       Mon Dec 30 08:33:04 2002
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
+ printf(" */\n");  printf("\n");
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
+    printf("  ;\n");
+  } else {
+    printf("\";\n");
+  } /* endif */
+  printf("\n");
+  printf("#define DOT_CONFIG_GZ_SIZE %d\n\n", size);
+
+  exit(0);
+}
+

