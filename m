Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266560AbSL2RAA>; Sun, 29 Dec 2002 12:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbSL2RAA>; Sun, 29 Dec 2002 12:00:00 -0500
Received: from APuteaux-102-1-3-2.abo.wanadoo.fr ([193.253.232.2]:8746 "EHLO
	donald.as2917.net") by vger.kernel.org with ESMTP
	id <S266560AbSL2Q7z>; Sun, 29 Dec 2002 11:59:55 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Paul Rolland <rol@as2917.net>
Reply-To: rol@as2917.net
To: linux-kernel@vger.kernel.org
Subject: [Patch] Kernel configuration in kernel, kernel 2.4.20
Date: Sun, 29 Dec 2002 18:08:08 +0100
User-Agent: KMail/1.4.3
Cc: marcelo@conectiva.com.br
X-Ncc-Regid: fr.witbe
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212291808.08302.rol@as2917.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Tired of keeping copy of the kernel .config file, I decided to create a kernel
patch to have a 
/proc/config/config.gz
entry that would be created at boot time and that would
allow a :
zcat /proc/config/config.gz
to recover the .config file used to create the kernel.

Juste below is a patch, created against a 2.4.19, but that can also be
applied to a 2.4.20 (with a few warning).
Result is :
1 [17:53] rol@donald:~> ls -l /proc/config/
total 0
-r--r--r--    1 root     root            0 Dec 29 18:00 config.gz
-r--r--r--    1 root     root            0 Dec 29 18:00 version

Feedback welcome,
Regards,
Paul Rolland, rol@as2917.net

diff -urN linux-2.4.19/drivers/char/Config.in linux/drivers/char/Config.in
--- linux-2.4.19/drivers/char/Config.in Thu Dec 19 13:48:19 2002
+++ linux/drivers/char/Config.in        Thu Dec 19 13:47:19 2002
@@ -4,6 +4,7 @@
 mainmenu_option next_comment
 comment 'Character devices'
 
+bool 'Linux Kernel Configuration Driver' CONFIG_CONFIG
 bool 'Virtual terminal' CONFIG_VT
 if [ "$CONFIG_VT" = "y" ]; then
    bool '  Support for console on virtual terminal' CONFIG_VT_CONSOLE
diff -urN linux-2.4.19/drivers/char/Makefile linux/drivers/char/Makefile
--- linux-2.4.19/drivers/char/Makefile  Thu Dec 19 13:48:32 2002
+++ linux/drivers/char/Makefile Thu Dec 19 15:17:31 2002
@@ -136,6 +136,7 @@
   KEYBD = dummy_keyb.o
 endif
 
+obj-$(CONFIG_CONFIG) += config.o
 obj-$(CONFIG_VT) += vt.o vc_screen.o consolemap.o consolemap_deftbl.o $(CONSOLE) selection.o
 obj-$(CONFIG_SERIAL) += $(SERIAL)
 obj-$(CONFIG_SERIAL_HCDP) += hcdp_serial.o
@@ -287,3 +288,14 @@
 
 qtronixmap.c: qtronixmap.map
        set -e ; loadkeys --mktable $< | sed -e 's/^static *//' > $@
+
+config.o: config.h
+
+config.h: config.txt.gz
+       @cc -o dotHmaker dotHmaker.c
+       @./dotHmaker
+
+config.txt.gz::
+       @cp ../../.config config.txt
+       @gzip -f config.txt
+
diff -urN linux-2.4.19/drivers/char/config.c linux/drivers/char/config.c
--- linux-2.4.19/drivers/char/config.c  Thu Jan  1 00:00:00 1970
+++ linux/drivers/char/config.c Thu Dec 19 13:47:24 2002
@@ -0,0 +1,156 @@
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
+
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
+  printk(KERN_INFO "Linux Kernel Configuration driver v" CONFIG_VERSION " (c)Paul Rolland\n");
+  return(0);
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
+
+/*
+ * Local variables:
+ *  c-indent-level: 4
+ *  tab-width: 4
+ * End:
+ */
+
diff -urN linux-2.4.19/drivers/char/dotHmaker.c linux/drivers/char/dotHmaker.c
--- linux-2.4.19/drivers/char/dotHmaker.c       Thu Jan  1 00:00:00 1970
+++ linux/drivers/char/dotHmaker.c      Thu Dec 19 13:47:24 2002
@@ -0,0 +1,57 @@
+#include <stdio.h>
+
+int main(void)
+{
+  FILE * in;
+  FILE * out;
+  int i;
+  unsigned char buf;
+
+  int size = 0;
+
+  in = fopen("config.txt.gz", "r");
+  if (in == NULL) {
+    printf("Unable to open config.txt.gz\n");
+    exit(-1);
+  } /* endif */
+
+  out = fopen("config.h", "w");
+  if (out == NULL) {
+    printf("Unable to create config.h\n");
+    exit(-1);
+  } /* endif */
+
+  fprintf(out, "/*\n");
+  fprintf(out, " * Automagically generated file, please don't edit !\n");
+  fprintf(out, " */\n");
+  fprintf(out, "\n");
+  fprintf(out, "static char config_gz[] = \\\n");
+
+  i = 0;
+
+  fread(&buf, sizeof(unsigned char), 1, in);
+  while (!feof(in)) {
+    if (i == 0) {
+      fprintf(out, "  \"");
+    } /* endif */
+    fprintf(out, "\\x%x", buf);
+    size ++;
+    i ++;
+    if (i == 10) {
+      i = 0;
+      fprintf(out, "\"\\\n");
+    } /* endif */
+    fread(&buf, sizeof(unsigned char), 1, in);
+  } /* endwhile */
+
+  if (i != 0) {
+    fprintf(out, "\";\n");
+  } /* endif */
+  fprintf(out, "\n");
+  fprintf(out, "#define CONFIG_SIZE %d\n\n", size);
+
+  fclose(in);
+  fclose(out);
+
+  exit(0);
+}
