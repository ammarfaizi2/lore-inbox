Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSKUUzz>; Thu, 21 Nov 2002 15:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbSKUUzz>; Thu, 21 Nov 2002 15:55:55 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:36011 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264755AbSKUUzq>; Thu, 21 Nov 2002 15:55:46 -0500
Message-ID: <3DDD49A0.2050907@us.ibm.com>
Date: Thu, 21 Nov 2002 13:01:20 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] export e820 table on x86
References: <3DDC3E43.2080302@us.ibm.com> <20021121020953.A13644@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------050202050504060503040701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050202050504060503040701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:
> On Wed, Nov 20, 2002 at 06:00:35PM -0800, Dave Hansen wrote:
> 
>>I stole a patch that Arjan did a while ago, and ported it up to 2.5:
>>http://www.kernelnewbies.org/kernels/rh80/SOURCES/linux-2.4.0-e820.patch
>>
>>We need this so avoid making BIOS calls when using kexec.
> 
> It should at least use seq_file, and I'm not sure whether it wouldn't
> better fit into sysfs (don't ask me where exactly :))

Better?

-- 
Dave Hansen
haveblue@us.ibm.com

--------------050202050504060503040701
Content-Type: text/plain;
 name="e820info-2.5.48+bk-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e820info-2.5.48+bk-3.patch"

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Thu Nov 21 12:59:44 2002
+++ b/arch/i386/Kconfig	Thu Nov 21 12:59:44 2002
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
--- a/arch/i386/kernel/Makefile	Thu Nov 21 12:59:44 2002
+++ b/arch/i386/kernel/Makefile	Thu Nov 21 12:59:44 2002
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
+++ b/arch/i386/kernel/e820.c	Thu Nov 21 12:59:44 2002
@@ -0,0 +1,98 @@
+/* Copyright (c) 2001 Red Hat, Inc. All rights reserved.
+ * This software may be freely redistributed under the terms of the
+ * GNU General Public License.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Author: Arjan van de Ven <arjanv@redhat.com
+ * hacked to use seq_file by: Dave Hansen <haveblue@us.ibm.com>
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>      /* for module_init/exit */
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+
+#include <asm/e820.h>
+
+static void* e820info_start(struct seq_file *m, loff_t *pos)
+{
+	if ((unsigned long long)*pos < e820.nr_map ) 
+		return (void *)(unsigned long)((*pos)+1);
+	else 
+		return NULL;
+	
+}
+
+static void* e820info_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	(*pos)++;
+	return e820info_start(m, pos);
+}
+
+static int e820info_show(struct seq_file *m, void *arg)
+{
+	unsigned long off = (unsigned long)arg - 1;
+
+	seq_printf(m, "%016Lx @ %016Lx %lu\n",
+			e820.map[off].size, 
+			e820.map[off].addr, 
+			e820.map[off].type);
+			
+	return 0;
+}
+
+static void e820info_stop(struct seq_file *m, void *arg)
+{
+	kfree(m->private);
+	m->private = NULL;
+}
+
+static struct seq_operations e820info_op = {
+	.start = e820info_start,
+	.next = e820info_next,
+	.stop = e820info_stop,
+	.show = e820info_show,
+};
+
+extern struct seq_operations e820info_op;
+static int e820info_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &e820info_op);
+}
+static struct file_operations proc_e820info_operations = {
+	.open		= e820info_open,
+	.read		= seq_read,
+	.llseek	 	= seq_lseek,
+	.release	= seq_release,
+};
+
+extern struct e820map e820;
+struct proc_dir_entry *e820_proc_entry;
+
+int e820_module_init(void)
+{	
+	/* /proc/e820info probably isn't the best place for it, need
+	   to find a better one */
+	e820_proc_entry = create_proc_entry ("e820info", 0, NULL);
+	if (e820_proc_entry==NULL)
+		return -EIO;
+
+	e820_proc_entry->owner = THIS_MODULE;
+	e820_proc_entry->proc_fops = &proc_e820info_operations;
+
+	return 0;
+}
+
+void e820_module_exit(void)
+{
+	 remove_proc_entry ("e820info", e820_proc_entry);
+}
+
+module_init(e820_module_init);
+module_exit(e820_module_exit);
+

--------------050202050504060503040701--

