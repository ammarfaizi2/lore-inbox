Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbSKUByf>; Wed, 20 Nov 2002 20:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbSKUByf>; Wed, 20 Nov 2002 20:54:35 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28596 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266270AbSKUByb>;
	Wed, 20 Nov 2002 20:54:31 -0500
Message-ID: <3DDC3E43.2080302@us.ibm.com>
Date: Wed, 20 Nov 2002 18:00:35 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] export e820 table on x86
Content-Type: multipart/mixed;
 boundary="------------090808000702000502040600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090808000702000502040600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I stole a patch that Arjan did a while ago, and ported it up to 2.5:
http://www.kernelnewbies.org/kernels/rh80/SOURCES/linux-2.4.0-e820.patch

We need this so avoid making BIOS calls when using kexec.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------090808000702000502040600
Content-Type: text/plain;
 name="e820info-2.5.48+bk-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e820info-2.5.48+bk-0.patch"

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Wed Nov 20 17:47:54 2002
+++ b/arch/i386/Kconfig	Wed Nov 20 17:47:54 2002
@@ -636,6 +636,11 @@
 	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
 	  /dev/cpu/31/cpuid.
 
+config E820_PROC
+	bool 'E820 proc support' 
+	help
+	  This exports the BIOS memory map.  It is used by kexec
+
 config EDD
 	tristate "BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Wed Nov 20 17:47:54 2002
+++ b/arch/i386/kernel/Makefile	Wed Nov 20 17:47:54 2002
@@ -14,6 +14,7 @@
 obj-y				+= timers/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
+obj-$(CONFIG_E820_PROC)  	+= e820.o
 obj-$(CONFIG_X86_MSR)		+= msr.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
diff -Nru a/arch/i386/kernel/e820.c b/arch/i386/kernel/e820.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/e820.c	Wed Nov 20 17:47:54 2002
@@ -0,0 +1,75 @@
+/* Copyright (c) 2001 Red Hat, Inc. All rights reserved.
+ * This software may be freely redistributed under the terms of the
+ * GNU General Public License.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Author: Arjan van de Ven <arjanv@redhat.com
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>      /* for module_init/exit */
+#include <linux/proc_fs.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+
+#include <asm/e820.h>
+
+extern struct e820map e820;
+struct proc_dir_entry *e820_proc_entry;
+
+static int e820_proc_output(char *buffer, int bufsize)
+{
+        int i,bufpos=0;
+
+        for (i = 0; i < e820.nr_map; i++) {
+		/* FIXME: check for overflow */
+                bufpos += sprintf(buffer+bufpos,"%016Lx @ %016Lx ", 
+                        e820.map[i].size, e820.map[i].addr);
+		bufpos += sprintf(buffer+bufpos," %lu\n", e820.map[i].type);
+        }
+	return bufpos;
+}
+
+
+
+
+
+
+static int e820_read_proc(char *page, char **start, off_t off,
+                         int count, int *eof, void *data)
+{
+        int len = e820_proc_output (page,4096);
+        if (len <= off+count) *eof = 1;
+        *start = page + off;
+        len -= off;
+        if (len>count) len = count;
+        if (len<0) len = 0;
+        return len;
+}
+
+int e820_module_init(void)
+{        
+        /* /proc/e820info probably isn't the best place for it, need
+           to find a better one */
+	e820_proc_entry = create_proc_entry ("e820info", 0, NULL);
+	if (e820_proc_entry==NULL)
+		return -EIO;
+
+	e820_proc_entry->read_proc = e820_read_proc;
+	e820_proc_entry->owner = THIS_MODULE;
+
+	return 0;
+}
+
+
+void e820_module_exit(void)
+{
+	 remove_proc_entry ("e820info", e820_proc_entry);
+}
+
+module_init(e820_module_init);
+module_exit(e820_module_exit);
+

--------------090808000702000502040600--

