Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbUDTJPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUDTJPD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 05:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUDTJPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 05:15:02 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:37269 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262442AbUDTJKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 05:10:40 -0400
Message-ID: <4084E8A9.14A8F215@nospam.org>
Date: Tue, 20 Apr 2004 11:08:57 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Dynamic System Calls & System Call Hijacking
 	 - patch
Content-Type: multipart/mixed;
 boundary="------------5FCC92470DB48B0E1CC0DEFB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5FCC92470DB48B0E1CC0DEFB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 
--------------5FCC92470DB48B0E1CC0DEFB
Content-Type: text/plain; charset=us-ascii;
 name="dyn_syscall-2004-apr-19"
Content-Disposition: inline;
 filename="dyn_syscall-2004-apr-19"
Content-Transfer-Encoding: 7bit

diff -ruN 2.6.4.ref/arch/ia64/Kconfig 2.6.4.mig2-tmp/arch/ia64/Kconfig
--- 2.6.4.ref/arch/ia64/Kconfig	Tue Mar 16 13:36:30 2004
+++ 2.6.4.mig2-tmp/arch/ia64/Kconfig	Mon Apr 19 10:41:55 2004
@@ -218,6 +218,14 @@
 	  Access).  This option is for configuring high-end multiprocessor
 	  server systems.  If in doubt, say N.
 
+config DYN_SYSCALL
+        tristate "Support for dynamic system calls"
+	default m
+	help
+	  Say m if you want a module supporting to register / unregister or
+	  to hijack / restore system calls.
+	  This stuff is not foreseen to run inside the kernel.
+
 config VIRTUAL_MEM_MAP
 	bool "Virtual mem map"
 	default y if !IA64_HP_SIM
diff -ruN 2.6.4.ref/arch/ia64/kernel/Makefile 2.6.4.mig2-tmp/arch/ia64/kernel/Makefile
--- 2.6.4.ref/arch/ia64/kernel/Makefile	Tue Mar 16 13:36:30 2004
+++ 2.6.4.mig2-tmp/arch/ia64/kernel/Makefile	Mon Apr 19 10:14:14 2004
@@ -18,8 +18,11 @@
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_PERFMON)		+= perfmon_default_smpl.o
+obj-$(CONFIG_DYN_SYSCALL)	+= dyn_syscall.o
 obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 
+dyn_syscall-objs := dyn_syscall_asm.o dyn_syscall_main.o
+
 # The gate DSO image is built using a special linker script.
 targets += gate.so gate-syms.o
 
diff -ruN 2.6.4.ref/arch/ia64/kernel/dyn_syscall_asm.S 2.6.4.mig2-tmp/arch/ia64/kernel/dyn_syscall_asm.S
--- 2.6.4.ref/arch/ia64/kernel/dyn_syscall_asm.S	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig2-tmp/arch/ia64/kernel/dyn_syscall_asm.S	Mon Apr 19 10:14:19 2004
@@ -0,0 +1,252 @@
+/*
+ * Dynamic System Calls & System Call Hijacking
+ * ============================================
+ *
+ * Version 0.1, 19th of April 2004
+ * By Zoltan Menyhart, Bull S.A. <Zoltan.Menyhart@bull.net>
+ * The usual GPL applies.
+ *
+ * See also "Documentation/dyn_syscall.txt".
+ */
+ 
+
+#include <asm/asmmacro.h>
+#include <asm/unistd.h>
+#define	_SOME_PRIVATE_DEFS_
+#include <asm/dyn_syscall.h>
+
+
+	.text
+	.align		32
+
+
+/*
+ * This is the link table for the dynamic / hijacked system calls:
+ *
+ *	struct {
+ *		<link code>;
+ *	} x_module_link[NR_syscalls];
+ *
+ * For a dynamic / hijacked system call, "sys_call_table[i]" is modified to
+ * point at "x_module_link[i]", where "i = <syscall number> - __NR_ni_syscall".
+ *
+ * Each "x_module_link[i].<link code>" puts "i * sizeof(assembler's long)" into
+ * "R2" and jumps to the common link routine.
+ */
+x_module_link:
+	.global		x_module_link
+	.set		tmp, 0
+	.rept		NR_syscalls
+	mov		r2 = tmp
+	br.sptk.few	common_link
+	;;
+	.set		tmp, tmp + 4		// sizeof(assembler's long)
+	.endr
+x_module_ln_end:
+	.global		x_module_ln_end
+
+
+/*
+ * This is the return linkage table for the dynamic / hijacked system calls:
+ *
+ *	struct {
+ *		<link code>;
+ *	} x_module_ret[NR_syscalls];
+ *
+ * A system call is invoked with "B0" pointing at "x_module_ret[i].<link code>",
+ *  where "i = <syscall number> - __NR_ni_syscall".
+ *
+ * Each "x_module_ret[i].<link code>" puts "i * sizeof(assembler's long)" into
+ * "R2" and jumps to the common return linkage routine.
+ */
+x_module_ret:
+	.set		tmp, 0
+	.rept		NR_syscalls
+	mov		r2 = tmp
+	br.sptk.few	common_ret
+	;;
+	.set		tmp, tmp + 4		// sizeof(assembler's long)
+	.endr
+
+
+/*
+ * Common link routine for the dynamic / hijacked system calls.
+ *
+ * Save "B0" in "x_module_b0_tab[i]" and jump at the function pointed at
+ * by "x_module_fp_tab[i]" if "x_module_sem_tab[i]" can be taken.
+ *
+ * Input:	R2:	(System call number - __NR_ni_syscall) *
+ *							sizeof(assembler's long)
+ * Output:	B0:	-> "x_module_ret[i].<link code>"
+ *
+ * Pseudo code:
+ *
+ *	int	tmp = x_module_sem_tab[i];
+ *
+ *	if (!(_SEM_WRITE_ & tmp))
+ *		if (cmpxchg_acq(&x_module_sem_tab[i], tmp, tmp + _SEM_RD_DELTA_)
+ *									== tmp){
+ *			(* x_module_fp_tab[i])(args, ...);
+ *			goto x_module_ret[i];
+ *		}
+ *	goto sys_ni_syscall;
+ */
+
+	.set		fp_tab_off, x_module_fp_tab - common_link
+	.set		b0_tab_off, x_module_b0_tab - common_link
+	.set		ret_off, x_module_ret - common_link
+	.set		sem_off, x_module_sem_tab - common_link
+	.set		sys_ni_off, x_module_sys_ni - common_link
+
+common_link:
+	mov		r15 = ip
+        movl		r14 = _SEM_WRITE_
+	mov		r8 = b0
+	;;
+	shladd		r20 = r2, 1, r15
+	shladd		r3 = r2, 2, r15
+	add		r18 = r2, r15
+	;;
+	add		r20 = b0_tab_off, r20	// -> x_module_b0_tab[i]
+	add		r17 = fp_tab_off, r3	// -> x_module_fp_tab[i].IP
+	add		r2 = fp_tab_off + 8, r3	// -> x_module_fp_tab[i].GP
+	add		r16 = ret_off, r3	// -> x_module_ret[i]
+	add		r18 = sem_off, r18	// -> x_module_sem_tab[i]
+	;;
+	st8		[r20] = r8		// Save old B0
+	ld8		r17 = [r17]		// New IP
+	mov		b0 = r16
+	ld4		r3 = [r18]		// Old x_module_sem_tab[i] value
+	;;
+	zxt4		r20 = r3
+	and		r14 = r3, r14		// if (!(_SEM_WRITE_ & tmp))
+	mov		b6 = r17
+	;;
+	cmp4.eq		p8, p9 = 0, r14
+	add		r17 = _SEM_RD_DELTA_, r20
+	mov		ar.ccv = r20
+	;;
+(p8)	cmpxchg4.acq	r3 = [r18], r17, ar.ccv
+	;;
+(p8)	cmp4.eq		p8, p9 = r3, r20
+	;;
+(p8)	ld8		r1 = [r2]
+(p8)	br.sptk.few	b6
+(p9)	add		r14 = sys_ni_off, r15
+	;;
+(p9)	ld8		r17 = [r14]		// -> sys_ni_syscall()
+	;;
+(p9)	mov		b6 = r17
+(p9)	br.sptk.few	b6
+
+
+/*
+ * Common return linkage routine for the dynamic / hijacked system calls.
+ *
+ * Restore "B0" from "x_module_b0_tab[i]", load the kernel "GP" and release
+ * "x_module_sem_tab[i]".
+ *
+ * Input:	R2:	(System call number - __NR_ni_syscall) *
+ *							sizeof(assembler's long)
+ *
+ * We are sure that "x_module_sem_tab[i]" is not taken and cannot be taken in
+ * the mean time, for write. However, "_SEM_WRITE_" can be OR-ed to the
+ * semaphore indicating that writer is waiting.
+ *
+ * Pseudo code:
+ *
+ *	int	tmp;
+ *
+ *	do {
+ *		tmp = x_module_sem_tab[i];
+ *	} while (cmpxchg_rel(&x_module_sem_tab[i], tmp, tmp - _SEM_RD_DELTA_)
+ *									!= tmp);
+ *	return;
+ */
+	.set		b0_tab_off_r, x_module_b0_tab - common_ret
+	.set		k_gp_off, x_module_k_gp - common_ret
+	.set		sem_off_r, x_module_sem_tab - common_ret
+
+common_ret:
+	mov		r15 = ip
+	;;
+	add		r16 = k_gp_off, r15	// -> kernel GP
+	shladd		r20 = r2, 1, r15
+	add		r18 = r2, r15
+	;;
+	add		r20 = b0_tab_off_r, r20	// -> x_module_b0_tab[i]
+	add		r18 = sem_off_r, r18	// -> x_module_sem_tab[i]
+	ld8		r1 = [r16]
+	;;
+	ld8		r20 = [r20]
+	;;
+1:	ld4		r3 = [r18]		// Old x_module_sem_tab[i] value
+	mov		b0 = r20
+	;;
+	zxt4		r3 = r3
+	;;
+	sub		r17 = _SEM_RD_DELTA_, r3
+	mov		ar.ccv = r3
+	;;
+	cmpxchg4.rel	r16 = [r18], r17, ar.ccv
+	;;
+	cmp4.eq		p8, p9 = r3, r16
+(p8)	br.sptk.few	b0
+(p9)	br.cond.dptk	1b
+	;;
+
+
+/*
+ * The GP of the kernel is saved here. Yes, in the text segment.
+ */
+x_module_k_gp:
+	.global		x_module_k_gp
+	.quad		0
+
+
+/*
+ * Address of "sys_ni_syscall()"
+ */
+x_module_sys_ni:
+	.global		x_module_sys_ni
+	.quad		0
+
+
+/*
+ * Pointers to the dynamic / hijacked system calls:
+ *
+ *	struct fdesc {
+ *		unsigned long	ip;
+ *		unsigned long	gp;
+ *	} x_module_fp_tab[NR_syscalls];
+ */
+x_module_fp_tab:
+	.global		x_module_fp_tab
+	.rept		NR_syscalls
+	.quad		0			// New IP
+	.quad		0			// New GP
+	.endr
+
+
+/*
+ * Table for saving the return addresses to the kernel:
+ *
+ *	unsigned long x_module_b0_tab[NR_syscalls];
+ */
+x_module_b0_tab:
+	.rept		NR_syscalls
+	.quad		0			// Old return address
+	.endr
+
+
+/*
+ * Semaphores:
+ *
+ *	x_mod_sem_t x_module_sem_tab[NR_syscalls];
+ */
+x_module_sem_tab:
+	.global		x_module_sem_tab
+	.rept		NR_syscalls
+	.long		_SEM_WRITE_		// Locked for write
+	.endr
+
diff -ruN 2.6.4.ref/arch/ia64/kernel/dyn_syscall_main.c 2.6.4.mig2-tmp/arch/ia64/kernel/dyn_syscall_main.c
--- 2.6.4.ref/arch/ia64/kernel/dyn_syscall_main.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig2-tmp/arch/ia64/kernel/dyn_syscall_main.c	Mon Apr 19 13:17:30 2004
@@ -0,0 +1,903 @@
+#define	_TEST_
+
+
+/*
+ * Dynamic System Calls & System Call Hijacking
+ * ============================================
+ *
+ * This loadable kernel module "dyn_syscall.ko" is a wrapper module that provides
+ * for registering / unregistering or hijacking / restoring system calls.
+ *
+ * This wrapper module includes a shadow system call table that is spitted between
+ * "dyn_syscall_main.c" and in "dyn_syscall_asm.S", in order to facilitate assembly
+ * programming :-)
+ *
+ * The shadow system call table consists of:
+ *
+ *	"sh_syscall[NR_syscalls]" in "dyn_syscall_main.c":
+ *
+ *		- The name of the system call
+ *		- The saved entry from "sys_call_table"
+ *		- A pointer to "sys/kernel/dynamic_syscalls" or to
+ *		  to "sys/kernel/hijacked_syscalls" directory in the "/proc"
+ *		  file system
+ *		- A pointer to "sys/kernel/dynamic_syscalls/<name>" or to
+ *		  to "sys/kernel/hijacked_syscalls/<name>" entry in the "/proc"
+ *		  file system
+ *
+ *	in "dyn_syscall_asm.S":
+ *
+ *		- "x_module_sem_tab[]": table of the semaphores, see the man
+ *		  page of "syscall_unlock()" and "syscall_trylock()"
+ *		- "x_module_fp_tab[]": table of the function descriptors of the
+ *		  new system calls
+ *		- "x_module_b0_tab[]": room to save the return address to the
+ *		  kernel (from the register "B0")
+ *		- "x_module_link[]": contains linkage code used to invoke the
+ *		  new system calls
+ *		- "x_module_ret[]": contains linkage code used to return from
+ *		  the new system calls to the kernel
+ *
+ * Some notes about the synchronization strategy:
+ *
+ * - Dynamically assigned and hijacked system call entries form two distinct sets.
+ *   + For dynamic system call assignment:
+ *     * Atomically check & decrement "free_entries"
+ *     * If a specific system call number is requested, then reserve the
+ *       corresponding "sh_syscall[]" entry by use of a compare & swap
+ *       atomic operation
+ *     * Otherwise select a free entry in "sh_syscall[]" by use of a
+ *       compare & swap atomic operation
+ *   + For system call hijacking:
+ *     * Reserve the corresponding entry in "sh_syscall[]" by use of a
+ *       compare & swap atomic operation
+ *     * No nested hijacking
+ *
+ * - First the selected entry in "sh_syscall[i]" is prepared, including
+ *   "x_module_fp_tab[i]"
+ *
+ * - Then "sys_call_table[i]" is modified to point at the linkage code in
+ *   "x_module_link[i]"
+ *
+ * - Undo operations work in the reverse order
+ *
+ * Note that "dyn_syscall.ko" can be unloaded but it is unsafe.
+ * On the other hand, unloading modules which have correctly unregistered their
+ * system calls is 100% safe.
+ *
+ * See also "Documentation/dyn_syscall.txt".
+ *
+ * 19th of April 2004
+ */
+
+
+#include <linux/module.h>
+#include <linux/pagemap.h>	/* For IA64_GRANULE_SIZE */
+#include <linux/proc_fs.h>
+#include <asm/unistd.h>
+#include <linux/syscalls.h>
+#define	_SOME_PRIVATE_DEFS_
+#include <asm/dyn_syscall.h>
+
+
+MODULE_DESCRIPTION("Dynamic System Call Support Module");
+MODULE_VERSION("0.1");
+MODULE_AUTHOR("Zoltan Menyhart, Bull S.A., <Zoltan.Menyhart@bull.net>");
+MODULE_LICENSE("GPL");
+
+
+#if	defined(_TEST_)
+#define	STATIC
+#define	INLINE
+#else
+#define	STATIC		static
+#define	INLINE		inline
+#endif
+
+#define	PRINT(args...)	printk(args)
+
+
+static const char	headline[] = "Dynamic System Call Support Module";
+static const char	ill_syscall_no[] = "Illegal syscall no.: %d\n";
+static const char	syscall_inuse[] = "Syscall %d in use\n";
+static const char	not_free[] = "Not a free syscall, no.: %d\n";
+static const char	not_yours[] = "Syscall #%d is not yours\n";
+static const char	not_locked[] = "Syscall %d not locked\n";
+static const char	kernel_syms[] = "/proc/kallsyms";
+static const char	cant_find[] = "Can't find %s\n";
+static const char	_sys_call_table[] = "sys_call_table";
+static const char	_sys_ni_syscall[] = "sys_ni_syscall";
+static const char	_kernel_gp[] = "__gp";
+
+
+/* "sys_call_table" entries should have been declared as ones of this type */
+typedef	unsigned long	entry_t;
+
+/* "sys_call_table[]" defined in "itv.S */
+entry_t			*sys_call_table_addr;
+
+/* Address of the "syscall not implemented" function - not a function pointer */
+entry_t			sys_ni_syscall_addr;
+
+
+static atomic_t			free_entries = ATOMIC_INIT(0);
+static char			dyn_scall_dir[] = "sys/kernel/dynamic_syscalls";
+static struct proc_dir_entry	*dyn_pde_p;
+static char			hijack_dir[] = "sys/kernel/hijacked_syscalls";
+static struct proc_dir_entry	*hi_pde_p;
+
+
+/*
+ * Decrement "var" only if the condition (e.g. "> 0") is met.
+ *
+ * Returns TRUE if the operation has been successfully carried out.
+ */
+#define atomic_check_and_dec(var, condition)				\
+({									\
+	__s32	___old;							\
+	int	___rc;							\
+									\
+	do {								\
+		___old = atomic_read(var);				\
+		if (!(___rc = (___old condition)))			\
+			break;						\
+	} while	(cmpxchg(var, ___old, ___old - 1) != ___old);		\
+	___rc;								\
+})
+
+
+/*
+ * Returns the *OLD* value as usually one would expect.
+ */
+#define	my_fetch_add64(delta, v)					\
+	ia64_fetchadd(delta, &atomic64_read(v), rel);
+
+
+/*
+ * Shadow system call table.
+ *
+ * In order to facilitate assembly programming, several structure members have
+ * been moved into "dyn_syscall_asm.S":
+ * - System call semafores
+ * - Pointers to the dynamic / hijacked system calls
+ * - Saved the return addresses to the kernel
+ *
+ * A comment says in the "ivt.S" file where "sys_call_table" is defined, that
+ * the very first element must be "sys_ni_syscall()" => we shall not
+ * use "sh_syscall[0]".
+ *
+ * Usage of "entry":
+ *	- 0 means not in use
+ *	- 1 means reserved (going to be used)
+ *	- original "sys_call_table" entry | 1 means preparing to undo
+ *	- Otherwise saves the original "sys_call_table" entry (not an odd value)
+ */
+typedef struct {
+	const char		*name;
+	atomic64_t		entry;		/* Saved from "sys_call_table" */
+	struct proc_dir_entry	*pdentry;
+	struct proc_dir_entry	*p_pdentry;	/* Parent of "pdentry" */
+} sh_syscall_t;
+static sh_syscall_t sh_syscall[NR_syscalls];
+
+
+/*
+ * System call semafores.
+ */
+typedef unsigned int		x_mod_sem_t;		/* 4 byte quantity */
+extern x_mod_sem_t		x_module_sem_tab[];
+
+
+/*
+ * Pointers to the dynamic / hijacked system calls:
+ *
+ *	fdesc_t x_module_fp_tab[NR_syscalls];
+ */
+extern fdesc_t			x_module_fp_tab[];
+
+
+/*
+ * The linkage tables in "dyn_syscall_asm.S" are something like:
+ *
+ * The link table for the dynamic / hijacked system calls:
+ *
+ *	struct {
+ *		<link code>;
+ *	} x_module_link[NR_syscalls];
+ *
+ * For a dynamic / hijacked system call, "sys_call_table[i]" is modified to
+ * point at "x_module_link[i]", where "i = <syscall number> - __NR_ni_syscall".
+ */
+extern char			x_module_link[],
+				x_module_ln_end[];
+/* & x_module_link[i] */
+unsigned int			x_module_link_entry_size;
+#define	X_MODULE_LINK(i)	(x_module_link + i * x_module_link_entry_size)
+
+
+extern unsigned long		x_module_k_gp;		/* Kernel GP */
+extern unsigned long		x_module_sys_ni;	/* -> sys_ni_syscall() */
+
+
+STATIC INLINE int
+gimme_a_syscall(void);
+
+STATIC void
+install_syscall(const unsigned int, const dyn_syscall_t);
+
+STATIC int
+dsc_read_func(char *page, char **start, off_t off, int count, int *eof,
+								void *data);
+
+STATIC int
+make_proc_entry(struct proc_dir_entry * const, const char * const,
+							const unsigned int);
+
+
+/*
+ * Unlock a system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+int
+syscall_unlock(const char * const name, const unsigned int scall_no)
+{
+	const int	scn = scall_no - __NR_ni_syscall;
+
+	if (scn < 1 || scn >= NR_syscalls){
+		PRINT(ill_syscall_no, scall_no);
+		return -EINVAL;
+	}
+	if ((entry_t) atomic64_read(&sh_syscall[scn].entry) <= 1 ||
+		sys_call_table_addr[scn] != (entry_t) X_MODULE_LINK(scn) ||
+				strcmp(sh_syscall[scn].name, name) != 0){
+		PRINT(not_yours, scall_no);
+		return -EBADF;
+	}
+	if (x_module_sem_tab[scn] != _SEM_WRITE_){
+		PRINT(not_locked, scall_no);
+		return -ENOLCK;
+	}
+	PRINT("Unlocking syscall \"%s\": No = %d\n", sh_syscall[scn].name,
+							scn + __NR_ni_syscall);
+	x_module_sem_tab[scn] = _SEM_FREE_;
+	return 0;
+}
+
+EXPORT_SYMBOL(syscall_unlock);
+
+
+/*
+ * Internal version of system call trylock.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scn:		System call number - __NR_ni_syscall
+ *
+ * Returns:	-EAGAIN is returned if we've failed to take lock. Can be retried.
+ *		As usual, -Exxx in case of errors
+ */
+STATIC int
+intern_trylock(const char * const name, const unsigned int scn)
+{
+	x_mod_sem_t	tmp;
+
+	tmp = x_module_sem_tab[scn];
+	/* No problem OR-ing more than once "_SEM_WRITE_" */
+	if (cmpxchg_acq(&x_module_sem_tab[scn], tmp, tmp | _SEM_WRITE_) != tmp)
+		return -EAGAIN;
+	if ((tmp & _READER_MASK_) != _SEM_FREE_)
+		return -EAGAIN;
+	PRINT("Successfully locking syscall \"%s\": No = %d\n",
+				sh_syscall[scn].name, scn + __NR_ni_syscall);
+	return 0;
+}
+
+
+/*
+ * Try to lock a system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *
+ * Returns:	-EAGAIN is returned if we've failed to take lock. Can be retried.
+ *		As usual, -Exxx in case of errors
+ */
+int
+syscall_trylock(const char * const name, const unsigned int scall_no)
+{
+	const int	scn = scall_no - __NR_ni_syscall;
+	entry_t		addr = (entry_t) atomic64_read(&sh_syscall[scn].entry);
+
+	if (scn < 1 || scn >= NR_syscalls){
+		PRINT(ill_syscall_no, scall_no);
+		return -EINVAL;
+	}
+	if (addr < KERNEL_START || !(addr & 1) ||
+				sys_call_table_addr[scn] != addr - 1 ||
+				strcmp(sh_syscall[scn].name, name) != 0){
+		PRINT(not_yours, scall_no);
+		return -EBADF;
+	}
+	return intern_trylock(name, scn);
+}
+
+EXPORT_SYMBOL(syscall_trylock);
+
+
+/*
+ * Register a dynamic system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *				(should persist while the system call is alive)
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *				(if it is 0, then I'll choose a number for you)
+ *		fp:		-> new system call
+ *
+ * Returns:	The system call number accepted / assigned.
+ *		As usual, -Exxx in case of errors
+ *
+ * Note:	A comment says in the "ivt.S" file where "sys_call_table" is
+ *		defined, that the very first element must be
+ *		"sys_ni_syscall()".
+ */
+int
+dyn_syscall_reg(const char * const name, const unsigned int scall_no,
+							const dyn_syscall_t fp)
+{
+	int	scn;		/* System call number - __NR_ni_syscall */
+	int	rc;
+
+	if (!atomic_check_and_dec(&free_entries, > 0)){
+		PRINT("No more free syscall entry\n");
+		return -ENOENT;
+	}
+	mb();			/* Make sure the new "free_entries" is seen */
+	if (scall_no == 0){
+		scn = gimme_a_syscall();
+		/* "h_syscall[scn]" has been marked as in use */
+	} else {
+		scn = scall_no - __NR_ni_syscall;
+		if (scn < 1 || scn >= NR_syscalls){
+			atomic_add(1, &free_entries);
+			PRINT(ill_syscall_no, scall_no);
+			return -EINVAL;
+		}
+		/* Try to mark the entry as in use */
+		if (cmpxchg(&sh_syscall[scn].entry, 0, 1) != 0){
+			atomic_add(1, &free_entries);
+			PRINT(syscall_inuse, scall_no);
+			return -EBUSY;
+		}
+		if (sys_call_table_addr[scn] != sys_ni_syscall_addr){
+			atomic64_set(&sh_syscall[scn].entry, 0);
+			mb();
+			atomic_add(1, &free_entries);
+			PRINT(not_free, scall_no);
+			return -EBUSY;
+		}
+	}
+	/* Create "/proc/sys/kernel/dynamic_syscalls/<name>" */
+	if ((rc = make_proc_entry(dyn_pde_p, name, scn)) < 0){
+		atomic64_set(&sh_syscall[scn].entry, 0);
+		mb();
+		atomic_add(1, &free_entries);
+		return rc;
+	}
+	sh_syscall[scn].name = name;
+	install_syscall(scn, fp);
+//	MOD_INC_USE_COUNT;
+	return scn + __NR_ni_syscall;
+}
+
+EXPORT_SYMBOL(dyn_syscall_reg);
+
+
+/*
+ * Allocate a free ("sys_ni_syscall()") and mark it as in use.
+ *
+ * Returns:	A system call number - __NR_ni_syscall
+ *
+ * Note:	A comment says in the "ivt.S" file where "sys_call_table" is
+ *		defined, that the very first element must be
+ *		"sys_ni_syscall()" => we shall not use "sh_syscall[0]".
+ */
+STATIC INLINE int
+gimme_a_syscall(void)
+{
+	unsigned int 	i;
+
+	/* Most of the usable entries are at the high indices */
+	for (i = NR_syscalls - 1; i > 0; i--){
+		if (sys_call_table_addr[i] != sys_ni_syscall_addr)
+			continue;
+		/* Try to mark the entry as in use */
+		if (cmpxchg(&sh_syscall[i].entry, 0, 1) != 0)
+			continue;
+		return i;
+	}
+	panic("\nWe've lost the \"sys_ni_syscall()\"-s ???\n");
+}
+
+
+/*
+ * Do install a dynamic system call.
+ *
+ * Arguments:	scn:		System call number - __NR_ni_syscall
+ *		fp:		-> new system call
+ */
+STATIC void
+install_syscall(const unsigned int scn, const dyn_syscall_t fp)
+
+{
+	PRINT("Syscall \"%s\": No = %d IP = 0x%lx GP = 0x%lx\n",
+				sh_syscall[scn].name, scn + __NR_ni_syscall,
+				((fdesc_t *) fp)->ip, ((fdesc_t *) fp)->gp);
+	x_module_fp_tab[scn] = * (fdesc_t *) fp;
+	atomic64_set(&sh_syscall[scn].entry,
+			sys_call_table_addr[scn]);	/* Must not be 0 */
+	mb();		/* "sys_call_table_addr[scn] =" must be the last */
+	sys_call_table_addr[scn] = (entry_t) X_MODULE_LINK(scn);
+}
+
+
+/*
+ * Do prepare to uninstall a dynamic / hijacked system call.
+ *
+ * Arguments:	scn:		System call number - __NR_ni_syscall
+ */
+STATIC INLINE void
+prepare_to_uninstall_syscall(const unsigned int scn)
+{
+	PRINT("Original IP = 0x%lx\n", atomic64_read(&sh_syscall[scn].entry));
+	sys_call_table_addr[scn] = my_fetch_add64(1, &sh_syscall[scn].entry);
+	mb();			/* "sys_call_table_addr[scn] =" must be seen */
+}
+
+
+/*
+ * Do uninstall a dynamic / hijacked system call.
+ *
+ * Arguments:	scn:		System call number - __NR_ni_syscall
+ */
+STATIC INLINE void
+uninstall_syscall(const unsigned int scn)
+{
+	PRINT("Restoring syscall \"%s\": No = %d\n", sh_syscall[scn].name,
+							scn + __NR_ni_syscall);
+	sh_syscall[scn].name = NULL;
+	mb();	/* "atomic64_set(&sh_syscall[scn].entry, 0)" must be the last */
+	atomic64_set(&sh_syscall[scn].entry, 0);
+}
+
+
+/*
+ * Common "/proc" read function. Outputs the system call number.
+ *
+ * System call number - __NR_ni_syscall is stored in "->data".
+ */
+#define MIN(a,b)	((a) < (b) ? (a) : (b))
+STATIC int
+read_func(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	char		buff[6];		/* For "1234\n\0" */
+	unsigned int	ch_count;
+
+	sprintf(buff, "%4d\n", ((int) (long) data) + __NR_ni_syscall);
+	if (off >= sizeof(buff) - 1){
+		*eof = 1;
+		return 0;
+	}
+	ch_count = MIN(count, sizeof(buff) - 1 - off);
+	memcpy(page + off, &buff[off], ch_count);
+	return ch_count;
+}
+
+
+/*
+ * Create "/proc/sys/kernel/.../<name>" showing the actual system call number.
+ *
+ * Arguments:	p_pde_p:	-> parent /proc directory entry
+ *		name:		-> system call name
+ *		scn:		System call number - __NR_ni_syscall
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+STATIC int
+make_proc_entry(struct proc_dir_entry * const p_pde_p, const char * const name,
+							const unsigned int scn)
+{
+	struct proc_dir_entry	*pde_p;
+
+	if ((pde_p = create_proc_entry(name, S_IRUSR | S_IRGRP | S_IROTH,
+							p_pde_p)) == NULL){
+		PRINT("Cannot create /proc/sys/kernel/.../%s entry\n", name);
+		return -ENOMEM;
+	}
+	pde_p->read_proc = read_func;
+	pde_p->data = (void *) (long) scn;
+	pde_p->owner = THIS_MODULE;
+	sh_syscall[scn].pdentry = pde_p;
+	sh_syscall[scn].p_pdentry = p_pde_p;
+	return 0;
+}
+
+
+/*
+ * Hijack a system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *				(should persist while the system call is alive)
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *		fp:		-> new system call
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ *
+ * Note:	A comment says in the "ivt.S" file where "sys_call_table" is
+ *		defined, that the very first element must be
+ *		"sys_ni_syscall()".
+ */
+int
+hijack_syscall(const char * const name, const unsigned int scall_no,
+							const dyn_syscall_t fp)
+{
+	const int	scn = scall_no - __NR_ni_syscall;
+	int		rc;
+
+	if (scn < 1 || scn >= NR_syscalls){
+		PRINT(ill_syscall_no, scall_no);
+		return -EINVAL;
+	}
+	/* Try to mark the entry as in use */
+	if (cmpxchg(&sh_syscall[scn].entry, 0, 1) != 0){
+		PRINT(syscall_inuse, scall_no);
+		return -EBUSY;
+	}
+	if (sys_call_table_addr[scn] == sys_ni_syscall_addr){
+		PRINT("Syscall is \"ni\"\n");
+		atomic64_set(&sh_syscall[scn].entry, 0);
+		return -ENOENT;
+	}
+	/* Create "/proc/sys/kernel/hijacked_syscalls/<name>" */
+	if ((rc = make_proc_entry(hi_pde_p, name, scn)) < 0){
+		atomic64_set(&sh_syscall[scn].entry, 0);
+		return rc;
+	}
+	sh_syscall[scn].name = name;
+	install_syscall(scn, fp);
+//	MOD_INC_USE_COUNT;
+	return 0;
+}
+
+EXPORT_SYMBOL(hijack_syscall);
+
+
+/*
+ * Prepare to restore a previously dynamic / hijacked dynamic system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *
+ * Returns:	-EAGAIN is returned if we've failed to take lock. Can be retried.
+ *		As usual, -Exxx in case of errors
+ */
+int
+prep_restore_syscall(const char * const name, const unsigned int scall_no)
+{
+	const int	scn = scall_no - __NR_ni_syscall;
+
+	if (scn < 1 || scn >= NR_syscalls){
+		PRINT(ill_syscall_no, scall_no);
+		return -EINVAL;
+	}
+	if ((entry_t) atomic64_read(&sh_syscall[scn].entry) <= 1 ||
+		sys_call_table_addr[scn] != (entry_t) X_MODULE_LINK(scn) ||
+				strcmp(sh_syscall[scn].name, name) != 0){
+		PRINT(not_yours, scall_no);
+		return -EBADF;
+	}
+	PRINT("Preparing to restore syscall \"%s\": No = %d\n",
+						sh_syscall[scn].name, scall_no);
+	remove_proc_entry(name, sh_syscall[scn].p_pdentry);
+	sh_syscall[scn].pdentry = sh_syscall[scn].p_pdentry = NULL;
+	prepare_to_uninstall_syscall(scn);
+	return intern_trylock(name, scn);
+}
+
+EXPORT_SYMBOL(prep_restore_syscall);
+
+
+/*
+ * Finish restoring a previously hijacked dynamic system call.
+ * (Used by "dyn_syscall_unreg()", too.)
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+int
+restore_syscall(const char * const name, const unsigned int scall_no)
+{
+	const int	scn = scall_no - __NR_ni_syscall;
+	entry_t		addr = (entry_t) atomic64_read(&sh_syscall[scn].entry);
+
+	if (scn < 1 || scn >= NR_syscalls){
+		PRINT(ill_syscall_no, scall_no);
+		return -EINVAL;
+	}
+	if (addr < KERNEL_START || !(addr & 1) ||
+				sys_call_table_addr[scn] != addr - 1 ||
+				strcmp(sh_syscall[scn].name, name) != 0){
+		PRINT(not_yours, scall_no);
+		return -EBADF;
+	}
+	if (x_module_sem_tab[scn] != _SEM_WRITE_){
+		PRINT(not_locked, scall_no);
+		return -ENOLCK;
+	}
+	uninstall_syscall(scn);
+//	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+EXPORT_SYMBOL(restore_syscall);
+
+
+/*
+ * Finish restoring a previously registered dynamic system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+int
+dyn_syscall_unreg(const char * const name, const unsigned int scall_no)
+{
+	int	rc;
+
+	if (( rc = restore_syscall(name, scall_no)) == 0){
+		mb();	/* "atomic_add(1, &free_entries)" must be the last */
+		atomic_add(1, &free_entries);
+	}
+	return rc;
+}
+
+EXPORT_SYMBOL(dyn_syscall_unreg);
+
+
+/*
+ * Count the "free" entries in "sys_call_table".
+ *
+ * Returns:	The system call number accepted / assigned.
+ *		As usual, -Exxx in case of errors
+ *
+ * Note:	A comment says in the "ivt.S" file where "sys_call_table" is
+ *		defined, that the very first element must be
+ *		"sys_ni_syscall()".
+ */
+STATIC INLINE int
+count_free_syscalls(void)
+{
+	unsigned int	i;
+	entry_t		*p;
+
+	p = (entry_t *) sys_call_table_addr;
+	if (*p++ != sys_ni_syscall_addr){
+		PRINT("The 1st one must be sys_ni_syscall(), see ivt.S\n");
+		return -ENOENT;
+	}
+	for (i = 1; i < NR_syscalls; i++, p++)
+		if (*p == sys_ni_syscall_addr)
+			atomic_add(1, &free_entries);
+	PRINT("Number of free entries:\t%d\n", atomic_read(&free_entries));
+	if (atomic_read(&free_entries) < 1){
+		PRINT("Not enough free sys_call_table[] entries\n");
+		return -ENOENT;
+	}
+	return 0;
+}
+
+
+/*
+ * Set up the following "/proc" directories:
+ *	- "sys/kernel/dynamic_syscalls"
+ *	- "sys/kernel/hijacked_syscalls"
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+STATIC INLINE int
+init_proc_entries(void)
+{
+	if ((dyn_pde_p = proc_mkdir(dyn_scall_dir, NULL)) == NULL){
+		PRINT("Cannot create /proc/%s directory\n", dyn_scall_dir);
+		return -ENOMEM;
+	}
+	if ((hi_pde_p = proc_mkdir(hijack_dir, NULL)) == NULL){
+		PRINT("Cannot create /proc/%s directory\n", hijack_dir);
+		remove_proc_entry(dyn_scall_dir, NULL);
+		return -ENOMEM;
+	}
+	dyn_pde_p->owner = THIS_MODULE;
+	hi_pde_p->owner = THIS_MODULE;
+	return 0;
+}
+
+
+#define	RD_BUF_SIZE	80
+
+
+/*
+ * Read the next line from the "/proc/kallsyms" file.
+ * Truncate the lines longer than the buffer size.
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+STATIC INLINE int
+read_truncate_line(const int fd, char *buff)
+{
+	char	*p;
+	int	rc;
+
+	for (p = buff; p < &buff[RD_BUF_SIZE];){
+		if ((rc = sys_read(fd, p, 1)) < 0)
+			return rc;
+		if (rc == 0)
+			return -ENODATA;
+		if (*p++ == '\n')
+			break;
+	}
+	p--;
+	while (*p != '\n'){
+		if ((rc = sys_read(fd, p, 1)) < 0)
+			return rc;
+		if (rc == 0)
+			return -ENODATA;
+	}
+	*p = '\0';
+	return 0;
+}
+
+
+/*
+ * Check to see if the line contains any of the following symbols:
+ *	- address of "sys_ni_syscall()"
+ *	- address of "sys_call_table"
+ *	- the GP of the kernel "__gp"
+ *
+ * Returns:	TRUE if all the 3 symbols have already been found
+ */
+STATIC INLINE int
+check_line(char * const line)
+{
+	unsigned long	tmp;
+	char		*p, *q;
+
+	tmp = simple_strtoul(line, &p, 16);
+	for (p += 3, q = p; *p != '\0' && *p != '\t' && *p != ' '; p++);
+	*p = '\0';
+	if (strcmp(q, _sys_call_table) == 0){
+		sys_call_table_addr = (entry_t *) tmp;
+		PRINT("%s:\t\t0x%p\n", _sys_call_table, sys_call_table_addr);
+	} else if (strcmp(q, _sys_ni_syscall) == 0){
+		sys_ni_syscall_addr = tmp;
+		PRINT("%s():\t0x%lx\n", _sys_ni_syscall, sys_ni_syscall_addr);
+	} else if (strcmp(q, _kernel_gp) == 0){
+		x_module_k_gp = tmp;
+		PRINT("%s:\t\t\t0x%lx\n", _kernel_gp, x_module_k_gp);
+	}
+	return sys_call_table_addr != NULL &&
+			sys_ni_syscall_addr != 0 && x_module_k_gp != 0;
+}
+
+
+/*
+ * Pick up some kernel symbols from "/proc/kallsyms" which happen not be
+ * exported :-)
+ *	- address of "sys_ni_syscall()"
+ *	- address of "sys_call_table"
+ *	- the GP of the kernel "__gp"
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+STATIC INLINE int
+get_kernel_syms(void)
+{
+	char		buf[RD_BUF_SIZE];
+	int		fd;
+	int		rc;
+	mm_segment_t	orig_address_limit = get_fs();
+	mm_segment_t	tmp_address_limit = KERNEL_DS;
+
+	set_fs(tmp_address_limit);		/* Make "sys_open()" happy */
+	if ((fd = sys_open(kernel_syms, O_RDONLY, 0)) < 0){
+		PRINT("Can't open %s, error code: %d\n", kernel_syms, fd);
+		set_fs(orig_address_limit);
+		return fd;
+	}
+	while ((rc = read_truncate_line(fd, buf)) == 0)
+		if (check_line(buf))
+			break;
+	sys_close(fd);
+	set_fs(orig_address_limit);
+	if (rc != 0 && rc != -ENODATA)
+		return rc;
+	if (sys_call_table_addr == NULL){
+		PRINT(cant_find, _sys_call_table);
+		return -ENOENT;
+	}
+	if (sys_ni_syscall_addr == 0){
+		PRINT(cant_find, _sys_ni_syscall);
+		return -ENOENT;
+	}
+	if (x_module_k_gp == 0){
+		PRINT(cant_find, _kernel_gp);
+		return -ENOENT;
+	}
+	return 0;
+}
+
+
+/*
+ * Acquire some kernel symbols which happen not be exported :-)
+ *
+ * Set up the following "/proc" directories:
+ *	- "sys/kernel/dynamic_syscalls"
+ *	- "sys/kernel/hijacked_syscalls"
+ */
+STATIC int __init
+init_dyn_syscall(void)
+{
+	int	rc;
+
+	PRINT("\n%s\n", headline);
+	if ((rc = get_kernel_syms()) < 0)
+		return rc;
+	if (sys_call_table_addr < (entry_t *) KERNEL_START ||
+			sys_call_table_addr >= (entry_t *) (KERNEL_START +
+			IA64_GRANULE_SIZE - NR_syscalls * sizeof(entry_t))){
+		PRINT("Illegal %s address\n", "sys_call_table");
+		return -EFAULT;
+	}
+	if (sys_ni_syscall_addr < KERNEL_START || sys_ni_syscall_addr >=
+						(entry_t) sys_call_table_addr){
+		PRINT("Illegal %s address\n", "sys_ni_syscall()");
+		return -EFAULT;
+	}
+	if ((rc = count_free_syscalls()) < 0)
+		return rc;
+	/* Needed for "#define	X_MODULE_LINK(i)" */
+	x_module_link_entry_size = (x_module_ln_end - x_module_link) /
+								NR_syscalls;
+	if (x_module_k_gp < KERNEL_START || x_module_k_gp >=
+					KERNEL_START + IA64_GRANULE_SIZE){
+		PRINT("Illegal kernel GP\n");
+		return -EFAULT;
+	}
+	x_module_sys_ni = sys_ni_syscall_addr;
+	return init_proc_entries();
+}
+
+
+STATIC void __exit
+exit_dyn_syscall(void)
+{
+	PRINT("\n%s getting unloaded\n", headline);
+	remove_proc_entry(dyn_scall_dir, NULL);
+	remove_proc_entry(hijack_dir, NULL);
+}
+
+
+module_init(init_dyn_syscall);
+module_exit(exit_dyn_syscall);
+
diff -ruN 2.6.4.ref/include/asm-ia64/dyn_syscall.h 2.6.4.mig2-tmp/include/asm-ia64/dyn_syscall.h
--- 2.6.4.ref/include/asm-ia64/dyn_syscall.h	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig2-tmp/include/asm-ia64/dyn_syscall.h	Mon Apr 19 11:00:15 2004
@@ -0,0 +1,151 @@
+/*
+ * Dynamic System Calls & System Call Hijacking
+ * ============================================
+ *
+ * Version 0.1, 19th of April 2004
+ * By Zoltan Menyhart, Bull S.A. <Zoltan.Menyhart@bull.net>
+ * The usual GPL applies.
+ *
+ * See also "Documentation/dyn_syscall.txt".
+ */
+
+
+#if	!defined(__ASSEMBLY__)
+
+
+#define	PROC_DYN_SYSCALL_DIR	"sys/kernel/dynamic_syscalls"
+#define	PROC_HIJCK_SYSCALL_DIR	"sys/kernel/hijacked_syscalls"
+
+
+typedef	long (* dyn_syscall_t)(const int, ...);
+
+
+/*
+ * Function pointer - why isn't it defined in an "official" .h file ?
+ */
+typedef struct fdesc {
+	unsigned long	ip;
+	unsigned long	gp;
+} fdesc_t;
+
+
+/*
+ * Register a dynamic system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *				(should persist while the system call is alive)
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *				(if it is 0, then I'll choose a number for you)
+ *		fp:		-> new system call
+ *
+ * Returns:	The system call number accepted / assigned.
+ *		As usual, -Exxx in case of errors
+ *
+ * Note:	A comment says in the "ivt.S" file where "sys_call_table" is
+ *		defined, that the very first element must be
+ *		"sys_ni_syscall()".
+ */
+extern int
+dyn_syscall_reg(const char * const name, const unsigned int scall_no,
+							const dyn_syscall_t fp);
+
+
+/*
+ * Hijack a system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *				(should persist while the system call is alive)
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *		fp:		-> new system call
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ *
+ * Note:	A comment says in the "ivt.S" file where "sys_call_table" is
+ *		defined, that the very first element must be
+ *		"sys_ni_syscall()".
+ */
+extern int
+hijack_syscall(const char * const name, const unsigned int scall_no,
+							const dyn_syscall_t fp);
+
+
+/*
+ * Prepare to restore a previously dynamic / hijacked dynamic system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+extern int
+prep_restore_syscall(const char * const name, const unsigned int scall_no);
+
+
+/*
+ * Finish restoring a previously hijacked dynamic system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+extern int
+restore_syscall(const char * const name, const unsigned int scall_no);
+
+
+/*
+ * Finish restoring a previously registered dynamic system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+extern int
+dyn_syscall_unreg(const char * const name, const unsigned int scall_no);
+
+
+/*
+ * Unlock a system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *
+ * Returns:	As usual, -Exxx in case of errors
+ */
+extern int
+syscall_unlock(const char * const name, const unsigned int scall_no);
+
+
+/*
+ * Try to lock a system call.
+ *
+ * Arguments:	name:		-> unique ASCII string
+ *		scall_no:	System call number in the [__NR_ni_syscall + 1...
+ *				__NR_ni_syscall + NR_syscalls) range
+ *
+ * Returns:	-EAGAIN is returned if we've failed to take lock. Can be retried.
+ *		As usual, -Exxx in case of errors
+ */
+extern int
+syscall_trylock(const char * const name, const unsigned int scall_no);
+
+
+#endif	/* #if	!defined(__ASSEMBLY__) */
+
+
+#if	defined(_SOME_PRIVATE_DEFS_)
+
+#define	_SEM_WRITE_	0x80000000	/* Locked for write */
+#define	_READER_MASK_	0x7fffffff	/* Mask of the reader counter */
+#define	_SEM_FREE_	0		/* Unlocked */
+#define	_SEM_RD_DELTA_	1		/* Reades increment by one */
+
+#endif	/* #if	defined(_SOME_PRIVATE_DEFS_) */
+
diff -ruN 2.6.4.ref/Documentation/dyn_syscall.txt 2.6.4.mig2-tmp/Documentation/dyn_syscall.txt
--- 2.6.4.ref/D*/dyn*txt	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig2/Documentation/dyn_syscall.txt	Tue Apr 20 10:27:00 2004
@@ -0,0 +1,303 @@
+Dynamic System Calls & System Call Hijacking
+============================================
+
+Version 0.1, 19th of April 2004
+Zoltan Menyhart, Bull S.A., <Zoltan.Menyhart@bull.net>
+
+
+- Disappointed, 'cause they don't wanna take your brand new syscall into the
+  kernel ?
+
+  + No problem, I'll do it for you.
+
+- Can't recompile the kernel, otherwise you gonna lose RedHat guarantee ?
+  Or some ISVs like whose name starts with an "O" and terminates with "racle"
+  ain't gonna support it ?
+
+  + No problem, I'll load your syscall in a module.
+
+- Got a syscall number conflict 'cause of an exotic patch slipped in before
+  your one ?
+
+  + No problem, I'll find a free syscall number for you dynamically.
+
+- Wanna try your own version of a syscall without recompiling the kernel or
+  rebooting it ?
+
+  + No problem, I'll hijack the syscall for you.
+
+- Fed up with the infinite number of different kernel configurations ?
+  Can't follow any more what .config you've done for which of your clients ?
+
+  + No problem, make a minimal kernel with almost nothing in it and load
+    dynamically the syscalls actually needed. 
+
+My loadable kernel module "dyn_syscall.ko" provides for
+registering / unregistering or hijacking / restoring system calls.
+
+Sure, it's a loadable kernel module, who wants to modify the kernel ? :-)
+
+My patch is against the version 2.6.4. As there is not much in the way of
+direct dependency on the kernel, it should work with more recent versions, too.
+
+Playing with the system call mechanism is very much architecture dependent.
+Its key element is written in assembly.
+I've got an IA64 version only.
+
+
+How can it be used ?
+--------------------
+
+Assuming you've got a system call like "asmlinkage long sys_foo(...)" in a
+loadable kernel module. 
+You can register it with an unused system call number:
+
+	const char name[] = "foo";
+	rc = dyn_syscall_reg(name, syscall_no, (dyn_syscall_t) sys_foo);
+
+If "syscall_no" is zero, I'll find a free system call number for you.
+(Do check the return code. On success, it's your system call number.)
+Or you can register your system call over an existing one:
+
+	rc = hijack_syscall(name, syscall_no, (dyn_syscall_t) sys_foo);
+
+Having fully initialized your system call, you can make it available:
+
+	rc = syscall_unlock(name, syscall_no);
+
+This sequence is usually included in the "module_init(...)" function.
+
+User applications can find out what your system call number is by consulting
+"/proc/sys/kernel/dynamic_syscalls/foo" or
+"/proc/sys/kernel/hijacked_syscalls/foo", respectively.
+
+Having played enough with your system call, you can launch the module unload
+procedure, without worrying about the "living calls" which may be "part way"
+through your module:
+
+	rc = prep_restore_syscall(name, syscall_no);
+
+This function locks out further calls to the "syscall_no" (they will be refused
+with the return code "-ENOSYS"). It returns "-EAGAIN" if there is still someone
+inside your system call.
+In this latter case you can wait until your last client leaves:
+
+	while((rc = syscall_trylock(name, syscall)) == -EAGAIN)
+		schedule();
+
+If you have a blocking system call, then instead of busy waiting, wake up the
+waiting tasks and go to sleep a bit in the mean time.
+Finally, you can invoke:
+
+	rc = dyn_syscall_unreg(name, syscall_no);
+
+or
+
+	rc = restore_syscall(name, syscall_no);
+
+to remove completely your registered or hijacked system call, respectively.
+
+This sequence is usually included in the "module_exit(...)" function.
+
+The function prototypes are in "asm/dyn_syscall.h".
+
+In order to configure this module, say "m" in:
+
+        Processor type and features:
+                Support for dynamic system calls
+
+
+man pages:
+----------
+
+
+--------------------------------------------------------------------------------
+
+
+NAME
+
+	dyn_syscall_reg, hijack_syscall - Register a system call
+
+SYNOPSIS
+
+	#include <asm/dyn_syscall.h>
+
+	int
+	dyn_syscall_reg(const char *name,
+			const unsigned int syscall_no,
+			const dyn_syscall_t fp);
+	int
+	hijack_syscall(const char *name,
+			const unsigned int syscall_no,
+			const dyn_syscall_t fp);
+
+DESCRIPTION
+
+	"dyn_syscall_reg()" and "hijack_syscall()" are exported services
+	available for loadable kernel modules.
+
+	"dyn_syscall_reg()" registers a new, dynamic system call.
+	If "syscall_no" is zero, then an otherwise unused system call number
+	will be assigned.
+
+	"hijack_syscall()" registers a system call which overloads an
+	existing one.
+
+	"name" points to a string that shall persist while the system call is
+	alive.
+
+	"syscall_no" should be in the range of
+	[__NR_ni_syscall + 1... __NR_ni_syscall + NR_syscalls).
+
+	"fp" refers to the new system call.
+	For the IA64 architecture, the function descriptor "dyn_syscall_t"
+	refers to a structure containing the program counter and the global
+	pointer.
+
+	User applications can find this system call number in
+	"/proc/sys/kernel/dynamic_syscalls/<name>" or in
+	"/proc/sys/kernel/hijacked_syscalls/<name>", respectively.
+	On read, each of these files contains a 4 digit decimal number
+	terminated with a '\n' character.
+
+RETURN VALUE
+
+	On success, the system call number accepted / assigned is returned.
+
+	On error, the following codes may be returned:
+
+	-ENOENT:	No more free system call is available -
+			"dyn_syscall_reg()" only
+	-EINVAL:	Illegal system call number - both
+	-EBUSY:		System call is already in use - "dyn_syscall_reg()" only
+	-ENOMEM:	Cannot create "/proc/..." - both
+
+SEE ALSO
+
+	syscall_unlock, prep_restore_syscall, syscall_trylock,
+	dyn_syscall_unreg, restore_syscall
+
+
+--------------------------------------------------------------------------------
+
+
+NAME
+
+	syscall_unlock, syscall_trylock - Unlock / try to lock a system call
+	prep_restore_syscall - Prepare to unregister a system call
+
+SYNOPSIS
+
+	#include <asm/dyn_syscall.h>
+
+	int
+	syscall_unlock(const char *name,
+			const unsigned int syscall_no);
+	int
+	syscall_trylock(const char *name,
+			const unsigned int syscall_no);
+
+	int
+	prep_restore_syscall(const char *name,
+			const unsigned int syscall_no);
+
+DESCRIPTION
+
+	"syscall_unlock()", "syscall_trylock()" and "prep_restore_syscall()"
+	are exported services available for loadable kernel modules.
+
+	Each system call is protected by a semaphore.
+
+	When a new system call is added, it is locked for write.
+	Regular system call invocation tries to take the semaphore for read.
+	Unless it is "syscall_unlock()"-ed, any attempt to use the system call
+         will be refused and "-ENOSYS" will be reported.
+
+	Before undoing a system call registration, it is necessary to lock out
+	any further invocation of the system call by re-locking it for write.
+	(They will be refused by returning "-ENOSYS".)
+	Apart from some small administration task, "prep_restore_syscall()"
+	attempts to do it. If it fails (indicated by "-EAGAIN" returned), then
+	there is at least one "living call" which may be "part way" through
+	the system call code.
+
+	"syscall_trylock()" should be invoked repeatedly while it returns
+	"-EAGAIN". In order not to over penalise other tasks, "schedule()"
+	should be invoked at each iteration. If the system call is blocking,
+         i.e. there can be tasks sleeping inside the system call, then they have
+         to be woke up. In such a case, it is recommended to sleep a bit
+         between two iterations of "syscall_trylock()".
+
+	"name" should be the same as that was used during the registration.
+
+	"syscall_no" should be in the range of
+	[__NR_ni_syscall + 1... __NR_ni_syscall + NR_syscalls).
+
+RETURN VALUE
+
+	On success, zero is returned.
+
+	"syscall_trylock()" and "prep_restore_syscall()" return "-EAGAIN" if
+         they have failed to take the semaphore for write.
+	
+	On error, the following codes can be returned:
+
+	-EBADF:		Name or system call number does not match the parameters
+			which was used during the system call registration
+	-EINVAL:	Illegal system call number
+
+SEE ALSO
+
+	dyn_syscall_reg, hijack_syscall, dyn_syscall_unreg, restore_syscall
+
+
+--------------------------------------------------------------------------------
+
+
+NAME
+
+	dyn_syscall_unreg, restore_syscall - Unregister a system call
+
+SYNOPSIS
+
+	#include <asm/dyn_syscall.h>
+
+	int
+	dyn_syscall_unreg(const char *name,
+			const unsigned int syscall_no);
+	int
+	restore_syscall(const char *name,
+			const unsigned int syscall_no);
+
+DESCRIPTION
+
+	"dyn_syscall_unreg()" and "restore_syscall()" are exported services
+	available for loadable kernel modules.
+
+	"dyn_syscall_unreg()" unregisters a dynamic system call.
+
+	"restore_syscall()" restores a hijacked system call.
+
+	"name" should be the same as that was used during the registration.
+
+	"syscall_no" should be in the range of
+	[__NR_ni_syscall + 1... __NR_ni_syscall + NR_syscalls).
+
+RETURN VALUE
+
+	On success, zero is returned.
+
+	On error, the following codes can be returned:
+
+	-EBADF:		Name or system call number does not match the parameters
+			which was used during the system call registration
+	-EINVAL:	Illegal system call number
+
+SEE ALSO
+
+	dyn_syscall_reg, hijack_syscall,
+	syscall_unlock, syscall_trylock,  prep_restore_syscall
+
+
+--------------------------------------------------------------------------------
+

--------------5FCC92470DB48B0E1CC0DEFB--

