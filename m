Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSE2XZe>; Wed, 29 May 2002 19:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSE2XZd>; Wed, 29 May 2002 19:25:33 -0400
Received: from jalon.able.es ([212.97.163.2]:61144 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315806AbSE2XZa>;
	Wed, 29 May 2002 19:25:30 -0400
Date: Thu, 30 May 2002 01:25:25 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre9
Message-ID: <20020529232525.GE3174@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.21.0205281905260.7798-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.29 Marcelo Tosatti wrote:
>
>So here goes the last -pre. 
>

I still have some small fixes collected from the list, that if really
needed should be included in final...
Can anybody say if they still are valid (they apply fine on -pre9):

********************** 01-fs-pagemap:
--- linux-2.4.19-pre7-jam1/fs/partitions/check.h.orig	2002-04-16 17:22:33.000000000 +0200
+++ linux-2.4.19-pre7-jam1/fs/partitions/check.h	2002-04-16 17:23:08.000000000 +0200
@@ -2,6 +2,9 @@
  * add_partition adds a partitions details to the devices partition
  * description.
  */
+
+#include <linux/pagemap.h>
+
 void add_gd_partition(struct gendisk *hd, int minor, int start, int size);
 
 typedef struct {struct page *v;} Sector;

********************** 02-sock-rmem:
--- linux/net/core/sock.c.orig        Fri Dec 21 09:42:05 2001
+++ linux/net/core/sock.c     Mon May 20 17:35:43 2002
@@ -627,7 +627,7 @@
 		sysctl_wmem_max = 32767;
 		sysctl_rmem_max = 32767;
 		sysctl_wmem_default = 32767;
-		sysctl_wmem_default = 32767;
+		sysctl_rmem_default = 32767;
 	} else if (num_physpages >= 131072) {
 		sysctl_wmem_max = 131071;
 		sysctl_rmem_max = 131071;

********************** 05-exit-reaper-race:
--- linux-2.5.15-orig/kernel/exit.c	Thu May  9 17:23:28 2002
+++ linux-2.5.15-reparent/kernel/exit.c	Fri May 10 13:35:50 2002
@@ -152,7 +152,7 @@
 
 /*
  * When we die, we re-parent all our children.
- * Try to give them to another thread in our process
+ * Try to give them to another thread in our thread
  * group, and if no such member exists, give it to
  * the global child reaper process (ie "init")
  */
@@ -162,8 +162,14 @@
 
 	read_lock(&tasklist_lock);
 
-	/* Next in our thread group */
-	reaper = next_thread(father);
+	/* Next in our thread group, if they're not already exiting */
+	reaper = father;
+	do {
+		reaper = next_thread(reaper);
+		if (!(reaper->flags & PF_EXITING))
+			break;
+	} while (reaper != father);
+
 	if (reaper == father)
 		reaper = child_reaper;

********************** 04-mmx-init:
diff -urN 2.4.19pre7/arch/i386/kernel/i387.c mmx/arch/i386/kernel/i387.c
--- 2.4.19pre7/arch/i386/kernel/i387.c	Sun Apr  1 01:17:07 2001
+++ mmx/arch/i386/kernel/i387.c	Fri Apr 26 10:56:02 2002
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/math_emu.h>
@@ -24,6 +25,29 @@
 #define HAVE_HWFP 1
 #endif
 
+static union i387_union empty_fpu_state;
+
+void __init boot_init_fpu(void)
+{
+	memset(&empty_fpu_state, 0, sizeof(union i387_union));
+
+	if (!cpu_has_fxsr) {
+		empty_fpu_state.fsave.cwd = 0xffff037f;
+		empty_fpu_state.fsave.swd = 0xffff0000;
+		empty_fpu_state.fsave.twd = 0xffffffff;
+		empty_fpu_state.fsave.fos = 0xffff0000;
+	} else {
+		empty_fpu_state.fxsave.cwd = 0x37f;
+		if (cpu_has_xmm)
+			empty_fpu_state.fxsave.mxcsr = 0x1f80;
+	}
+}
+
+void load_empty_fpu(struct task_struct * tsk)
+{
+	memcpy(&tsk->thread.i387, &empty_fpu_state, sizeof(union i387_union));
+}
+
 /*
  * The _current_ task is using the FPU for the first time
  * so initialize it and set the mxcsr to its default
@@ -32,10 +56,10 @@
  */
 void init_fpu(void)
 {
-	__asm__("fninit");
-	if ( cpu_has_xmm )
-		load_mxcsr(0x1f80);
-		
+	if (cpu_has_fxsr)
+		asm volatile("fxrstor %0" : : "m" (empty_fpu_state.fxsave));
+	else
+		__asm__("fninit");
 	current->used_math = 1;
 }
 
diff -urN 2.4.19pre7/arch/i386/kernel/ptrace.c mmx/arch/i386/kernel/ptrace.c
--- 2.4.19pre7/arch/i386/kernel/ptrace.c	Tue Jan 22 18:55:43 2002
+++ mmx/arch/i386/kernel/ptrace.c	Fri Apr 26 10:56:02 2002
@@ -369,12 +369,8 @@
 			break;
 		}
 		ret = 0;
-		if ( !child->used_math ) {
-			/* Simulate an empty FPU. */
-			set_fpu_cwd(child, 0x037f);
-			set_fpu_swd(child, 0x0000);
-			set_fpu_twd(child, 0xffff);
-		}
+		if ( !child->used_math )
+			load_empty_fpu(child);
 		get_fpregs((struct user_i387_struct *)data, child);
 		break;
 	}
@@ -397,13 +393,8 @@
 			ret = -EIO;
 			break;
 		}
-		if ( !child->used_math ) {
-			/* Simulate an empty FPU. */
-			set_fpu_cwd(child, 0x037f);
-			set_fpu_swd(child, 0x0000);
-			set_fpu_twd(child, 0xffff);
-			set_fpu_mxcsr(child, 0x1f80);
-		}
+		if ( !child->used_math )
+			load_empty_fpu(child);
 		ret = get_fpxregs((struct user_fxsr_struct *)data, child);
 		break;
 	}
diff -urN 2.4.19pre7/include/asm-i386/bugs.h mmx/include/asm-i386/bugs.h
--- 2.4.19pre7/include/asm-i386/bugs.h	Fri Apr 26 10:36:12 2002
+++ mmx/include/asm-i386/bugs.h	Fri Apr 26 10:56:52 2002
@@ -204,7 +204,10 @@
 
 static void __init check_bugs(void)
 {
+	extern void __init boot_init_fpu(void);
+
 	identify_cpu(&boot_cpu_data);
+	boot_init_fpu();
 #ifndef CONFIG_SMP
 	printk("CPU: ");
 	print_cpu_info(&boot_cpu_data);
diff -urN 2.4.19pre7/include/asm-i386/i387.h mmx/include/asm-i386/i387.h
--- 2.4.19pre7/include/asm-i386/i387.h	Sat Apr 20 09:43:17 2002
+++ mmx/include/asm-i386/i387.h	Fri Apr 26 10:56:02 2002
@@ -76,6 +76,7 @@
 			struct task_struct *tsk );
 extern int set_fpxregs( struct task_struct *tsk,
 			struct user_fxsr_struct *buf );
+extern void load_empty_fpu(struct task_struct *);
 
 /*
  * FPU state for core dumps...

********************** 06-p4-xeon:
diff -urN 2.4.19pre7ac2/arch/i386/kernel/mpparse.c 2.4.19pre7ac3/arch/i386/kernel/mpparse.c
--- 2.4.19pre7ac2/arch/i386/kernel/mpparse.c	Sat Apr 20 04:07:21 2002
+++ 2.4.19pre7ac3/arch/i386/kernel/mpparse.c	Mon Apr 29 14:07:46 2002
@@ -115,6 +115,8 @@
 		case 0x0F:
 			if (model == 0x00)
 				return("Pentium 4(tm)");
+			if (model == 0x02)
+				return("Pentium 4(tm) XEON(tm)");
 			if (model == 0x0F)
 				return("Special controller");
 	}

********************** 07-scsi-eh-zombie:
diff -Bbu /src/linux/drivers/scsi/scsi_error.c.orig /src/linux/drivers/scsi/scsi_error.c
--- linux/drivers/scsi/scsi_error.c.orig	Sun Sep  9 17:52:35 2001
+++ linux/drivers/scsi/scsi_error.c	Wed May 29 22:41:32 2002
@@ -1868,6 +1868,7 @@
 	 */
 
 	daemonize();
+	reparent_to_init();
 
 	/*
 	 * Set the name of this process.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP mié may 29 02:20:48 CEST 2002 i686
