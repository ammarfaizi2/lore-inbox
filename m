Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTALOLX>; Sun, 12 Jan 2003 09:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267028AbTALOLX>; Sun, 12 Jan 2003 09:11:23 -0500
Received: from tag.witbe.net ([81.88.96.48]:34312 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S267023AbTALOLT>;
	Sun, 12 Jan 2003 09:11:19 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Miles Bader'" <miles@gnu.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel .config support?
Date: Sun, 12 Jan 2003 15:20:05 +0100
Message-ID: <00a301c2ba45$b4aad700$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20030106150219.GA22895@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miles,

> On Mon, Jan 06, 2003 at 08:15:07AM +0100, Paul Rolland wrote:
> > > probability of a feature printing a copyright notice at init
> > > time is inversely proportional to its importance!]
> >
> > This can be removed too, in fact I don't care. I just put 
> it because 
> > many others are doing so
> 
> That's the problem.... :-)
> 

Well, here is a new copy of the patch... I've implemented the changes
you requested :
 - no more messages at boot time,
 - one level /proc entry (/proc/config.gz)
 - no more unnecessary version entry.

I've also added a Kconfig dependancy on PROC_FS. Compiling without
PROC_FS support is fine without this dependancy, but result in 
nothing being present, which may be puzzling.

Regards,
Paul

diff -urN -S config.c linux-2.5.56/drivers/char/config.c
linux-2.5.56-work/drivers/char/config.c
--- linux-2.5.56/drivers/char/config.c  1970-01-01 01:00:00.000000000
+0100
+++ linux-2.5.56-work/drivers/char/config.c     2003-01-12
15:12:41.000000000 +0100
@@ -0,0 +1,107 @@
+/*
+ * Linux Configuration Driver
+ * (c) 2002-2003 Paul Rolland, rol@as2917.net
+ *
+ * This driver is intended to give access to the .config file that was
+ * used to compile the kernel.
+ * It does include a gzip'd copy of the file, which can be access thru
+ * /proc/config.gz
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
+#ifndef CONFIG_PROC_FS
+static int config_read_proc( char *buffer, char **start, off_t offset,
+                           int size, int *eof, void *data) 
+{ 
+  return 0; 
+} 
+#else
+
+#include "config.h"
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
+  if
(!create_proc_read_entry("config.gz",0,0,config_gz_read_proc,NULL)) {
+    printk(KERN_ERR "config: can't create /proc/config.gz\n");
+    return(-ENOMEM);
+  }
+
+  return( 0 );
+}
+
+static void __exit config_cleanup_module (void)
+{
+  remove_proc_entry( "config.gz", 0 );
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
diff -urN -S config.c linux-2.5.56/drivers/char/dotHmaker.c
linux-2.5.56-work/drivers/char/dotHmaker.c
--- linux-2.5.56/drivers/char/dotHmaker.c       1970-01-01
01:00:00.000000000 +0100
+++ linux-2.5.56-work/drivers/char/dotHmaker.c  2003-01-12
15:12:33.000000000 +0100
@@ -0,0 +1,54 @@
+/*
+ * Linux Configuration Driver
+ * (c) 2002-2003 Paul Rolland, rol@as2917.net
+ *
+ * This is a part of the /proc/config.gz module.
+ * this program is used to transform a config.txt.gz file to
+ * a variable that can then be included in config.c
+ *
+ */
+
+#include <stdio.h>
+#include <unistd.h>
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
+  if (i == 0) {
+    printf("  ;\n");
+  } else {
+    printf("\";\n");
+  } /* endif */
+  printf("\n");
+  printf("#define DOT_CONFIG_GZ_SIZE %d\n\n", size);
+
+  return(0);
+}
+
--- linux-2.5.56/drivers/char/Kconfig   2003-01-10 21:11:20.000000000
+0100
+++ linux-2.5.56-work/drivers/char/Kconfig      2003-01-12
14:50:40.000000000 +0100
@@ -4,6 +4,16 @@
 
 menu "Character devices"
 
+config CONFIG
+       bool "Linux Kernel Configuration Driver" 
+        depends on PROC_FS
+       ---help---
+         If you say Y here, and if you have /proc support enabled,
you'll find
+         a /proc/config.gz entry that will contain a gzipped copy of
the 
+          .config used to generate the running kernel.
+
+          This adds about 4KB to the kernel size.
+
 config VT
        bool "Virtual terminal"
        ---help---
diff -urN -S config.c linux-2.5.56/drivers/char/Makefile
linux-2.5.56-work/drivers/char/Makefile
--- linux-2.5.56/drivers/char/Makefile  2003-01-10 21:12:21.000000000
+0100
+++ linux-2.5.56-work/drivers/char/Makefile     2003-01-12
11:30:39.000000000 +0100
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

