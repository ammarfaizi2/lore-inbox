Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279547AbRKMOAK>; Tue, 13 Nov 2001 09:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279274AbRKMOAA>; Tue, 13 Nov 2001 09:00:00 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:12036 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S279547AbRKMN7s>; Tue, 13 Nov 2001 08:59:48 -0500
Date: Tue, 13 Nov 2001 16:59:11 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Richard Henderson <rth@twiddle.net>
Cc: Donald Maner <donjr@maner.org>,
        "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Compile error 2.4.15-pre4 on alpha
Message-ID: <20011113165911.A1007@jurassic.park.msu.ru>
In-Reply-To: <C033B4C3E96AF74A89582654DEC664DB5576@aruba.maner.org> <3BF09ED5.54176F4F@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF09ED5.54176F4F@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Nov 12, 2001 at 11:17:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 11:17:25PM -0500, Jeff Garzik wrote:
> > fs/fs.o(.text+0x2cf88): undefined reference to `cpuinfo_op'
> > make: *** [vmlinux] Error 1
> 
> looks like alpha needs to implement /proc/cpuinfo as seqfile, as Linus
> said.

Patch appended.

Ivan.

--- 2.4.15p4/arch/alpha/kernel/setup.c	Sat Nov  3 04:39:20 2001
+++ linux/arch/alpha/kernel/setup.c	Tue Nov 13 15:00:54 2001
@@ -30,6 +30,7 @@
 #include <linux/ioport.h>
 #include <linux/bootmem.h>
 #include <linux/pci.h>
+#include <linux/seq_file.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
@@ -1043,10 +1044,8 @@ get_nr_processors(struct percpu_struct *
 }
 
 
-/*
- * BUFFER is PAGE_SIZE bytes long.
- */
-int get_cpuinfo(char *buffer)
+static int
+show_cpuinfo(struct seq_file *f, void *slot)
 {
 	extern struct unaligned_stat {
 		unsigned long count, va, pc;
@@ -1058,14 +1057,15 @@ int get_cpuinfo(char *buffer)
 		"EV68CX", "EV7", "EV79", "EV69"
 	};
 
-	struct percpu_struct *cpu;
+	struct percpu_struct *cpu = slot;
 	unsigned int cpu_index;
 	char *cpu_name;
 	char *systype_name;
 	char *sysvariation_name;
-	int len, nr_processors;
+	int nr_processors;
 
-	cpu = (struct percpu_struct*)((char*)hwrpb + hwrpb->processor_offset);
+	if (!cpu)
+		return 1;
 	cpu_index = (unsigned) (cpu->type - 1);
 	cpu_name = "Unknown";
 	if (cpu_index < N(cpu_names))
@@ -1076,8 +1076,7 @@ int get_cpuinfo(char *buffer)
 
 	nr_processors = get_nr_processors(cpu, hwrpb->nr_processors);
 
-	len = sprintf(buffer,
-		      "cpu\t\t\t: Alpha\n"
+	seq_printf(f, "cpu\t\t\t: Alpha\n"
 		      "cpu model\t\t: %s\n"
 		      "cpu variation\t\t: %ld\n"
 		      "cpu revision\t\t: %ld\n"
@@ -1114,11 +1113,41 @@ int get_cpuinfo(char *buffer)
 		       platform_string(), nr_processors);
 
 #ifdef CONFIG_SMP
-	len += smp_info(buffer+len);
+	seq_printf(f, "cpus active\t\t: %d\n"
+		      "cpu active mask\t\t: %016lx\n",
+		       smp_num_cpus, cpu_present_mask);
 #endif
 
-	return len;
+	return 0;
+}
+
+/*
+ * We show only CPU #0 info.
+ */
+static void *
+c_start(struct seq_file *f, loff_t *pos)
+{
+	return *pos ? NULL : (char *)hwrpb + hwrpb->processor_offset;
+}
+
+static void *
+c_next(struct seq_file *f, void *v, loff_t *pos)
+{
+	return NULL;
 }
+
+static void
+c_stop(struct seq_file *f, void *v)
+{
+}
+
+struct seq_operations cpuinfo_op = {
+	start:	c_start,
+	next:	c_next,
+	stop:	c_stop,
+	show:	show_cpuinfo,
+};
+
 
 static int alpha_panic_event(struct notifier_block *this,
 			     unsigned long event,
--- 2.4.15p4/arch/alpha/kernel/proto.h	Fri Mar  2 22:12:07 2001
+++ linux/arch/alpha/kernel/proto.h	Tue Nov 13 13:50:59 2001
@@ -91,7 +91,6 @@ extern void unregister_srm_console(void)
 
 /* smp.c */
 extern void setup_smp(void);
-extern int smp_info(char *buffer);
 extern void handle_ipi(struct pt_regs *);
 extern void smp_percpu_timer_interrupt(struct pt_regs *);
 
--- 2.4.15p4/arch/alpha/kernel/smp.c	Mon Oct  8 23:37:11 2001
+++ linux/arch/alpha/kernel/smp.c	Tue Nov 13 13:10:48 2001
@@ -1091,15 +1091,6 @@ flush_icache_page(struct vm_area_struct 
 	}
 }
 
-int
-smp_info(char *buffer)
-{
-	return sprintf(buffer,
-		       "cpus active\t\t: %d\n"
-		       "cpu active mask\t\t: %016lx\n",
-		       smp_num_cpus, cpu_present_mask);
-}
-
 #if DEBUG_SPINLOCK
 void
 spin_unlock(spinlock_t * lock)
