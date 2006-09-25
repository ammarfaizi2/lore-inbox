Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWIYQvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWIYQvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWIYQvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:51:21 -0400
Received: from xenotime.net ([66.160.160.81]:13701 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751246AbWIYQvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:51:19 -0400
Date: Mon, 25 Sep 2006 09:52:23 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Message-Id: <20060925095223.515d9f2b.rdunlap@xenotime.net>
In-Reply-To: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 11:32:57 +0800 Luke Yang wrote:

> Hi everyone,
> 
>   This is the blackfin architecture for 2.6.18, again. As we promised,
> we fixed some issues in our old patches as following.
> 
> - use serial core in that driver
> 
> - Fix up that ioctl so it a) doesn't sleep in spinlock and b) compiles
> 
> - Use generic IRQ framework
> 
> - Review all the volatiles, consolidate them in some helper-in-header-file.
> 
>   And we also fixed a lot of other issues and ported it to 2.6.18 now.
> As usual, this architecture patch is too big so I just give a link
> here. Please review it and give you comments, we really appreciate.
> 
> http://blackfin.uclinux.org/frs/download.php/1010/blackfin_arch_2.6.18.patch

Hi,

Here are the rest of my comments (on .c files now).
(Did you also look at my comments inside this file?
  http://www.xenotime.net/linux/doc/blackfin-arch-meta.patch )


1.  As Arnd commented, eliminate the multiple versions of
DPRINTK() and friends macros.  Just use pr_debug() as much as possible.

2.  Re-read Documentation/CodingStyle and frame it.

3.  There are lots of function descriptions that need only small
changes to be in kernel-doc format
(see Documentation/kernel-doc-nano-HOWTO.txt).

4.  Try to keep source lines <= 80 columns.

5.  Lots of printk() calls could use some KERN_* levels in them.

Details below.
---
~Randy


diff -urN linux-2.6.18/arch/blackfin/kernel/bfin_dma_5xx.c linux-2.6.18.patch1/arch/blackfin/kernel/bfin_dma_5xx.c
--- linux-2.6.18/arch/blackfin/kernel/bfin_dma_5xx.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/bfin_dma_5xx.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,749 @@
+
+int dma_channel_active(unsigned int channel)
+{
+	if (dma_ch[channel].chan_status == DMA_CHANNEL_FREE) {
+		return 0;
+	} else {
+		return 1;
+	}

Drop all of those braces.  Not needed nor wanted (see Doc/CodingStyle).

+}
+
+/*------------------------------------------------------------------------------
+*		Set the Start Address register for the specific DMA channel
+* 		This function can be used for register based DMA,
+*		to setup the start address
+*		addr:		Starting address of the DMA Data to be transferred.
+*-----------------------------------------------------------------------------*/

Please convert that to kernel-doc format.

+void set_dma_start_addr(unsigned int channel, unsigned long addr)
+{
+	DMA_DBG("set_dma_start_addr() : BEGIN \n");
+
+	assert(dma_ch[channel].chan_status != DMA_CHANNEL_FREE
+	       && channel < MAX_BLACKFIN_DMA_CHANNEL);
+
+	dma_ch[channel].regs->start_addr = addr;
+	SSYNC;
+	DMA_DBG("set_dma_start_addr() : END\n");
+}

Ideally, non-static functions (and static ones that have pointer/method
access) would be documented via kernel-doc....

+void set_dma_next_desc_addr(unsigned int channel, unsigned long addr)
+{
+	DMA_DBG("set_dma_next_desc_addr() : BEGIN \n");
+
+	assert(dma_ch[channel].chan_status != DMA_CHANNEL_FREE
+	       && channel < MAX_BLACKFIN_DMA_CHANNEL);
+
+	dma_ch[channel].regs->next_desc_ptr = addr;
+	SSYNC;
+	DMA_DBG("set_dma_start_addr() : END\n");
+}
diff -urN linux-2.6.18/arch/blackfin/kernel/bfin_ksyms.c linux-2.6.18.patch1/arch/blackfin/kernel/bfin_ksyms.c
--- linux-2.6.18/arch/blackfin/kernel/bfin_ksyms.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/bfin_ksyms.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,114 @@

Current practice is to put EXPORTs in the source file where they are
defined, preferably immediately after each function (or data), not
in a group at one place in the source file.

+EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strncmp);
+EXPORT_SYMBOL(dump_thread);
+
+EXPORT_SYMBOL(ip_fast_csum);
+
+EXPORT_SYMBOL(kernel_thread);
+
+EXPORT_SYMBOL(__up);
+EXPORT_SYMBOL(__down);
+EXPORT_SYMBOL(__down_trylock);
+EXPORT_SYMBOL(__down_interruptible);
+
+EXPORT_SYMBOL(is_in_rom);
+
+/* Networking helper routines. */
+EXPORT_SYMBOL(csum_partial_copy);
+
+/* The following are special because they're not called
+   explicitly (the C compiler generates them).  Fortunately,
+   their interface isn't gonna change any time soon now, so
+   it's OK to leave it out of version control.  */
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(memchr);
+EXPORT_SYMBOL(get_wchan);
diff -urN linux-2.6.18/arch/blackfin/kernel/init_task.c linux-2.6.18.patch1/arch/blackfin/kernel/init_task.c
--- linux-2.6.18/arch/blackfin/kernel/init_task.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/init_task.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,63 @@
+
+union thread_union init_thread_union
+    __attribute__ ((__section__(".data.init_task"))) = {
+INIT_THREAD_INFO(init_task)};

last line needs to be indented.

diff -urN linux-2.6.18/arch/blackfin/kernel/irqchip.c linux-2.6.18.patch1/arch/blackfin/kernel/irqchip.c
--- linux-2.6.18/arch/blackfin/kernel/irqchip.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/irqchip.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,150 @@
+
+void ack_bad_irq(unsigned int irq)
+{
+	irq_err_count += 1;
+	printk(KERN_ERR "IRQ: spurious interrupt %d\n", irq);

If these happen at all, you may need to rate-limit the printk() call by
using printk_ratelimit() instead.

+}
+EXPORT_SYMBOL(ack_bad_irq);
+
diff -urN linux-2.6.18/arch/blackfin/kernel/module.c linux-2.6.18.patch1/arch/blackfin/kernel/module.c
--- linux-2.6.18/arch/blackfin/kernel/module.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/module.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,469 @@
+
+static uint32_t reloc_stack_operate(unsigned int oper, struct module *mod)
+{
+	uint32_t value;
+	switch (oper) {
+	case R_add:

Save one indentation level for the entire block (here & below) by putting the
braces at the same column as the word "case".

+		{
+			value =
+			    reloc_stack[reloc_stack_tos - 2] +
+			    reloc_stack[reloc_stack_tos - 1];
+			reloc_stack_tos -= 2;
+			break;
+		}
+	case R_sub:
+		{
+			value =
+			    reloc_stack[reloc_stack_tos - 2] -
+			    reloc_stack[reloc_stack_tos - 1];
+			reloc_stack_tos -= 2;
+			break;
+		}
+	case R_mult:
+		{
+			value =
+			    reloc_stack[reloc_stack_tos -
+					2] * reloc_stack[reloc_stack_tos - 1];
+			reloc_stack_tos -= 2;
+			break;
+		}
+	case R_div:
+		{
+			value =
+			    reloc_stack[reloc_stack_tos -
+					2] / reloc_stack[reloc_stack_tos - 1];
+			reloc_stack_tos -= 2;
+			break;
+		}
+	case R_mod:
+		{
+			value =
+			    reloc_stack[reloc_stack_tos -
+					2] % reloc_stack[reloc_stack_tos - 1];
+			reloc_stack_tos -= 2;
+			break;
+		}
+	default:
+		{
+			printk(KERN_WARNING "module %s: unhandled reloction\n",
+			       mod->name);
+			return 0;
+		}
+	}
+}
+
+/*************************************************************************/
+/* FUNCTION : apply_relocate_add                                         */
+/* ABSTRACT : Blackfin specific relocation handling for the loadable     */
+/*            modules. Modules are expected to be .o files.              */
+/*            Arithmetic relocations are handled.                        */
+/*            We do not expect LSETUP to be split and hence is not       */
+/*            handled.                                                   */
+/*            R_byte and R_byte2 are also not handled as the gas         */
+/*            does not generate it.                                      */
+/*************************************************************************/

Using kernel-doc doc/comment format would be much better for everyone.
See Documentation/kernel-doc-nano-HOWTO.txt for info/details.

+int
+apply_relocate_add(Elf_Shdr * sechdrs, const char *strtab,
+		   unsigned int symindex, unsigned int relsec,
+		   struct module *mod)
+{
+		case R_luimm16:

Align braces with "case".

+			{
+				unsigned short tmp;
+				DEBUGP("before %x after %x\n", *location16,
+				       (value & 0xffff));
+				tmp = (value & 0xffff);
+				dma_memcpy(location16, &tmp, 2);
+			}
+			break;
+}
+
diff -urN linux-2.6.18/arch/blackfin/kernel/process.c linux-2.6.18.patch1/arch/blackfin/kernel/process.c
--- linux-2.6.18/arch/blackfin/kernel/process.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/process.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,346 @@
+
+/*
+ * sys_execve() executes a new program.
+ */
+
+asmlinkage int sys_execve(char *name, char **argv, char **envp)
+{
+	int error;
+	char *filename;
+	struct pt_regs *regs = (struct pt_regs *)((&name) + 6);
+
+	lock_kernel();
+	filename = getname(name);
+	error = PTR_ERR(filename);
+	if (IS_ERR(filename))
+		goto out;
+	error = do_execve(filename, argv, envp, regs);
+	putname(filename);
+      out:

Unindent the label:

+	unlock_kernel();
+	return error;
+}
+
+unsigned long get_wchan(struct task_struct *p)
+{
+	unsigned long fp, pc;
+	unsigned long stack_page;
+	int count = 0;
+	if (!p || p == current || p->state == TASK_RUNNING)
+		return 0;
+
+	stack_page = (unsigned long)p;
+	fp = p->thread.usp;
+	do {
+		if (fp < stack_page + sizeof(struct thread_info) ||
+		    fp >= 8184 + stack_page)
+			return 0;
+		pc = ((unsigned long *)fp)[1];
+		if (!in_sched_functions(pc))
+			return pc;
+		fp = *(unsigned long *)fp;
+	}
+	while (count++ < 16);

	} while (count++ < 16);
See Documentation/CodingStyle :)

+	return 0;
+}
+
diff -urN linux-2.6.18/arch/blackfin/kernel/ptrace.c linux-2.6.18.patch1/arch/blackfin/kernel/ptrace.c
--- linux-2.6.18/arch/blackfin/kernel/ptrace.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/ptrace.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,431 @@
+
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+{
+	int ret;
+	int add = 0;
+
+	switch (request) {
+		/* when I and D space are separate, these will need to be fixed. */
+	case PTRACE_PEEKDATA:
+#ifdef DEBUG
+		printk("PTRACE_PEEKDATA\n");
+#endif
+		add = MAX_SHARED_LIBS * 4;	/* space between text and data */
+		/* fall through */
+	case PTRACE_PEEKTEXT:	/* read word at location addr. */
+		{

Braces at same column as "case".

+			unsigned long tmp = 0;
+			int copied;
+
+			ret = -EIO;
+		}
+
+		/* read the word at location addr in the USER area. */
+	case PTRACE_PEEKUSR:
+		{

ditto

+			unsigned long tmp;
+			break;
+		}
+
+		/* when I and D space are separate, this will have to be fixed. */
+	case PTRACE_POKEDATA:
+		printk(KERN_NOTICE "ptrace: PTRACE_PEEKDATA\n");
+		/* fall through */
+	case PTRACE_POKETEXT:	/* write the word at location addr. */
+		{

ditto

+			break;
+		}
+
+	case PTRACE_SYSCALL:	/* continue and stop at next (return from) syscall */
+	case PTRACE_CONT:
+		{		/* restart after signal. */

ditto

+			long tmp;
+			break;
+		}
+
+/*
+ * make the child exit.  Best I can do is send it a sigkill.
+ * perhaps it should be put in the status that it wants to
+ * exit.
+ */
+	case PTRACE_KILL:

Put braces at same column as "case" and then undent the entire block.
(many of these)

+		{
+			long tmp;
+			ret = 0;
+			if (child->exit_state == EXIT_ZOMBIE)	/* already dead */
+				break;
+			child->exit_code = SIGKILL;
+			/* make sure the single step bit is not set. */
+			tmp = get_reg(child, PT_SYSCFG) & ~(TRACE_BITS);
+			put_reg(child, PT_SYSCFG, tmp);
+			wake_up_process(child);
+			break;
+		}
+
+	default:
+		printk(KERN_NOTICE "ptrace: *** Unhandled case **** %d\n",
+		       (int)request);
+		ret = -EIO;
+		break;
+	}
+
+	return ret;
+}
+
diff -urN linux-2.6.18/arch/blackfin/kernel/setup.c linux-2.6.18.patch1/arch/blackfin/kernel/setup.c
--- linux-2.6.18/arch/blackfin/kernel/setup.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/setup.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,941 @@
+
+u_long get_sclk()
+{
+	u_long ssel;
+
+	if (bfin_read_PLL_STAT() & 0x1)
+		return CONFIG_CLKIN_HZ;
+
+	ssel = (bfin_read_PLL_DIV() & 0xf);
+	if (0 == ssel) {

in Linux kernel, put constant on the right hand side:
	if (ssel == 0)

+		printk(KERN_WARNING "Invalid System Clock\n");
+		ssel = 1;
+	}
+
+	return get_vco() / ssel;
+}
+
+EXPORT_SYMBOL(get_sclk);
+
diff -urN linux-2.6.18/arch/blackfin/kernel/signal.c linux-2.6.18.patch1/arch/blackfin/kernel/signal.c
--- linux-2.6.18/arch/blackfin/kernel/signal.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/signal.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,715 @@
+
+asmlinkage void do_signal(struct pt_regs *regs);

unneeded prototype.

+static inline int
+restore_sigcontext(struct pt_regs *regs, struct sigcontext *usc, int *pr0)
+{
+	struct sigcontext context;
+	int err = 0;
+
+	/* get previous context */
+	if (copy_from_user(&context, usc, sizeof(context)))
+		goto badframe;
+	if (context.sc_pc == 0)
+		goto badframe;
+	/* restore passed registers */
+	wrusp(context.sc_usp);
+
+	*pr0 = context.sc_r0;
+	return err;
+
+      badframe:

Don't indent labels so much (either not at all or may 1-2 spaces).
Basically they should stand out (be easy to see), unlike this one.

+	return 1;
+}
+
+static inline int
+rt_restore_ucontext(struct pt_regs *regs, struct ucontext *uc, int *pr0)
+{
+	int temp;
+	greg_t *gregs = uc->uc_mcontext.gregs;
+	unsigned long usp;
+	int err;
+
+	err = __get_user(temp, &uc->uc_mcontext.version);
+	if (temp != MCONTEXT_VERSION)
+		goto badframe;
+	/* restore passed registers */
+	wrusp(usp);
+
+	if (do_sigaltstack(&uc->uc_stack, NULL, usp) == -EFAULT)
+		goto badframe;
+
+	*pr0 = regs->r0;
+	return err;
+
+      badframe:

Label indented too much.
(global comment, for this and other source files)

+	return 1;
+}
+
diff -urN linux-2.6.18/arch/blackfin/kernel/sys_bfin.c linux-2.6.18.patch1/arch/blackfin/kernel/sys_bfin.c
--- linux-2.6.18/arch/blackfin/kernel/sys_bfin.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/sys_bfin.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,254 @@
+
+/* common code for old and new mmaps */
+static inline long
+do_mmap2(unsigned long addr, unsigned long len,
+	 unsigned long prot, unsigned long flags,
+	 unsigned long fd, unsigned long pgoff)
+{
+	int error = -EBADF;
+	struct file *file = NULL;
+
+	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	if (!(flags & MAP_ANONYMOUS)) {
+		file = fget(fd);
+		if (!file)
+			goto out;
+	}
+
+	down_write(&current->mm->mmap_sem);
+	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	up_write(&current->mm->mmap_sem);
+
+	if (file)
+		fput(file);
+      out:

Undent (or outdent) label.
(more in same file)

+	return error;
+}
+
+/*
+ * sys_ipc() is the de-multiplexer for the SysV IPC calls..
+ *
+ * This is really horribly ugly.
+ */
+asmlinkage int
+sys_ipc(uint call, int first, int second, int third, void *ptr, long fifth)
+{
+	int version, ret;
+
+	version = call >> 16;	/* hack for backward compatibility */
+	call &= 0xffff;
+
+	if (call <= SEMCTL)
+		switch (call) {
+		case SEMOP:
+			return sys_semop(first, (struct sembuf *)ptr, second);
+		case SEMGET:
+			return sys_semget(first, second, third);
+		case SEMCTL:

Align braces and "case" and then outdent the rest of the block.
More below [deleted].

+			{
+				union semun fourth;
+				if (!ptr)
+					return -EINVAL;
+				if (get_user(fourth.__pad, (void **)ptr))
+					return -EFAULT;
+				return sys_semctl(first, second, third, fourth);
+			}
+		default:
+			return -ENOSYS;
+		}
+}
+
diff -urN linux-2.6.18/arch/blackfin/kernel/time.c linux-2.6.18.patch1/arch/blackfin/kernel/time.c
--- linux-2.6.18/arch/blackfin/kernel/time.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/kernel/time.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,336 @@
+
+static void
+time_sched_init(irqreturn_t(*timer_routine) (int, void *, struct pt_regs *))
+{
+	u32 tcount;
+
+	/* power up the timer, but don't enable it just yet */
+	bfin_write_TCNTL(1);
+	__builtin_bfin_csync();
+
+	/*
+	 * the TSCALE prescaler counter.
+	 */
+	bfin_write_TSCALE((TIME_SCALE - 1));
+
+	tcount = ((get_cclk() / (HZ * TIME_SCALE)) - 1);
+	bfin_write_TPERIOD(tcount);
+	bfin_write_TCOUNT(tcount);
+
+	/* now enable the timer */
+	__builtin_bfin_csync();
+
+	bfin_write_TCNTL(7);
+
+	bfin_timer_irq.handler = timer_routine;
+	/* call setup_irq instead of request_irq because request_irq calls kmalloc which has not been initialized yet */

Split comment onto multiple lines (line is too long).

+	setup_irq(IRQ_CORETMR, &bfin_timer_irq);
+}
+
+void do_gettimeofday(struct timeval *tv)
+{
+	unsigned long flags;
+	unsigned long lost, seq;
+	unsigned long usec, sec;
+
+	do {
+		seq = read_seqbegin_irqsave(&xtime_lock, flags);
+		usec = gettimeoffset();
+		lost = jiffies - wall_jiffies;
+		if (unlikely(lost))
+			usec += lost * (USEC_PER_SEC / HZ);
+		sec = xtime.tv_sec;
+		usec += (xtime.tv_nsec / NSEC_PER_USEC);
+	}
+	while (read_seqretry_irqrestore(&xtime_lock, seq, flags));

Combine } and while(expression) onto one line.

+
+	while (usec >= USEC_PER_SEC) {
+		usec -= USEC_PER_SEC;
+		sec++;
+	}
+
+	tv->tv_sec = sec;
+	tv->tv_usec = usec;
+}
+
+EXPORT_SYMBOL(do_gettimeofday);
+
diff -urN linux-2.6.18/arch/blackfin/lib/checksum.c linux-2.6.18.patch1/arch/blackfin/lib/checksum.c
--- linux-2.6.18/arch/blackfin/lib/checksum.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/lib/checksum.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,139 @@
+
+/*
+ * computes the checksum of a memory block at buff, length len,
+ * and adds in "sum" (32-bit)
+ *
+ * returns a 32-bit number suitable for feeding into itself
+ * or csum_tcpudp_magic
+ *
+ * this function must be called with even lengths, except
+ * for the last fragment, which may be odd
+ *
+ * it's best to have buff aligned on a 32-bit boundary
+ */

Please just use kernel-doc notation for that function comment block.

+unsigned int csum_partial(const unsigned char *buff, int len, unsigned int sum)
+{
+	/*
+	 * Just in case we get nasty checksum data...
+	 * Like 0xffff6ec3 in the case of our IPv6 multicast header.
+	 * We fold to begin with, as well as at the end.
+	 */
+	sum = (sum & 0xffff) + (sum >> 16);
+
+	sum += do_csum(buff, len);
+
+	sum = (sum & 0xffff) + (sum >> 16);
+
+	return sum;
+}
+
diff -urN linux-2.6.18/arch/blackfin/mach-bf533/boards/cm_bf533.c linux-2.6.18.patch1/arch/blackfin/mach-bf533/boards/cm_bf533.c
--- linux-2.6.18/arch/blackfin/mach-bf533/boards/cm_bf533.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf533/boards/cm_bf533.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,236 @@
+
+#if defined(CONFIG_SPI_BFIN) || defined(CONFIG_SPI_BFIN_MODULE)
+/* all SPI perpherals info goes here */

peripherals

+static int __init cm_bf533_init(void)
+{
+	printk("%s(): registering device resources\n", __FUNCTION__);

KERN_INFO ?

+	return platform_add_devices(cm_bf533_devices,
+				    ARRAY_SIZE(cm_bf533_devices));
+}
+
diff -urN linux-2.6.18/arch/blackfin/mach-bf533/boards/ezkit.c linux-2.6.18.patch1/arch/blackfin/mach-bf533/boards/ezkit.c
--- linux-2.6.18/arch/blackfin/mach-bf533/boards/ezkit.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf533/boards/ezkit.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,213 @@
+
+#if defined(CONFIG_SPI_BFIN) || defined(CONFIG_SPI_BFIN_MODULE)
+/* all SPI perpherals info goes here */

peripherals

+static int __init ezkit_init(void)
+{
+	printk("%s(): registering device resources\n", __FUNCTION__);

KERN_INFO ?

+	platform_add_devices(ezkit_devices, ARRAY_SIZE(ezkit_devices));
+#if defined(CONFIG_SPI_BFIN) || defined(CONFIG_SPI_BFIN_MODULE)
+	spi_register_board_info(bfin_spi_board_info,
+				ARRAY_SIZE(bfin_spi_board_info));
+#endif
+	return 0;
+}
+
diff -urN linux-2.6.18/arch/blackfin/mach-bf533/boards/generic_board.c linux-2.6.18.patch1/arch/blackfin/mach-bf533/boards/generic_board.c
--- linux-2.6.18/arch/blackfin/mach-bf533/boards/generic_board.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf533/boards/generic_board.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,78 @@
+
+#include <linux/device.h>
+#include <asm/irq.h>
+
+{
+	printk("%s(): registering device resources\n", __FUNCTION__);

KERN_INFO ?

+	return platform_add_devices(generic_board_devices,
+				    ARRAY_SIZE(generic_board_devices));
+}
+
+arch_initcall(generic_board_init);
diff -urN linux-2.6.18/arch/blackfin/mach-bf533/boards/stamp.c linux-2.6.18.patch1/arch/blackfin/mach-bf533/boards/stamp.c
--- linux-2.6.18/arch/blackfin/mach-bf533/boards/stamp.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf533/boards/stamp.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,265 @@
+
+static int __init stamp_init(void)
+{
+	printk("%s(): registering device resources\n", __FUNCTION__);

KERN_INFO ?

+	platform_add_devices(stamp_devices, ARRAY_SIZE(stamp_devices));
+#if defined(CONFIG_SPI_BFIN) || defined(CONFIG_SPI_BFIN_MODULE)
+	spi_register_board_info(bfin_spi_board_info,
+				ARRAY_SIZE(bfin_spi_board_info));
+#endif
+	return 0;
+}
diff -urN linux-2.6.18/arch/blackfin/mach-bf533/cpu.c linux-2.6.18.patch1/arch/blackfin/mach-bf533/cpu.c
--- linux-2.6.18/arch/blackfin/mach-bf533/cpu.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf533/cpu.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,169 @@
+
+ /**/

Drop comment above.
Don't indent the function intro below.

+    static int bf533_target(struct cpufreq_policy *policy,
+			    unsigned int target_freq, unsigned int relation)
+{
+}
+
diff -urN linux-2.6.18/arch/blackfin/mach-bf533/ints-priority.c linux-2.6.18.patch1/arch/blackfin/mach-bf533/ints-priority.c
--- linux-2.6.18/arch/blackfin/mach-bf533/ints-priority.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf533/ints-priority.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,69 @@
+
+void program_IAR(void);

Don't really need a function prototype when the function follows
immediately after it.

+/*Program the IAR registers*/
+
+void program_IAR(void)
+{
+};
diff -urN linux-2.6.18/arch/blackfin/mach-bf533/pm.c linux-2.6.18.patch1/arch/blackfin/mach-bf533/pm.c
--- linux-2.6.18/arch/blackfin/mach-bf533/pm.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf533/pm.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,152 @@
+
+#include <asm/io.h>
+
+/*
+ * When we call pm_suspend, that code  enters into idle state.
+ * When there is any interrupt,the core will resume

space after comma

+ */
+void bf533_pm_suspend(void)
+{
+}
+
+/*

Change /* to /** and it will be in kernel-doc format.

+ *	bf533_pm_prepare - Do preliminary suspend work.
+ *	@state:		suspend state we're entering.
+ *
+ */
+
+static int bf533_pm_prepare(suspend_state_t state)
+{
+}
+
+/*

Change /* to /**

+ *	bf533_pm_enter - Actually enter a sleep state.
+ *	@state:		State we're entering.
+ *
+ */
+
+static int bf533_pm_enter(suspend_state_t state)
+{
+}
+
+/**

Ditto.

+ *	bf533_pm_finish - Finish up suspend sequence.
+ *	@state:		State we're coming out of.
+ *
+ *	This is called after we wake back up (or if entering the sleep state
+ *	failed).
+ */
+
+static int bf533_pm_finish(suspend_state_t state)
+{
+	return 0;
+}
+
diff -urN linux-2.6.18/arch/blackfin/mach-bf537/boards/cm_bf537.c linux-2.6.18.patch1/arch/blackfin/mach-bf537/boards/cm_bf537.c
--- linux-2.6.18/arch/blackfin/mach-bf537/boards/cm_bf537.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf537/boards/cm_bf537.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,268 @@
+
+#if defined(CONFIG_SPI_BFIN) || defined(CONFIG_SPI_BFIN_MODULE)
+/* all SPI perpherals info goes here */

peripherals

diff -urN linux-2.6.18/arch/blackfin/mach-bf537/boards/generic_board.c linux-2.6.18.patch1/arch/blackfin/mach-bf537/boards/generic_board.c
--- linux-2.6.18/arch/blackfin/mach-bf537/boards/generic_board.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf537/boards/generic_board.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,469 @@
+
+#if defined(CONFIG_SPI_BFIN) || defined(CONFIG_SPI_BFIN_MODULE)
+/* all SPI perpherals info goes here */

peripherals

diff -urN linux-2.6.18/arch/blackfin/mach-bf537/boards/stamp.c linux-2.6.18.patch1/arch/blackfin/mach-bf537/boards/stamp.c
--- linux-2.6.18/arch/blackfin/mach-bf537/boards/stamp.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf537/boards/stamp.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,489 @@
+
+#if defined(CONFIG_SPI_BFIN) || defined(CONFIG_SPI_BFIN_MODULE)
+/* all SPI perpherals info goes here */

peripherals

diff -urN linux-2.6.18/arch/blackfin/mach-bf537/cpu.c linux-2.6.18.patch1/arch/blackfin/mach-bf537/cpu.c
--- linux-2.6.18/arch/blackfin/mach-bf537/cpu.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf537/cpu.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,169 @@
+
+ /**/

Lose the comment above and don't indent the function intro below.

+    static int bf537_target(struct cpufreq_policy *policy,
+			    unsigned int target_freq, unsigned int relation)
+{
+	unsigned long cclk_mhz;
+	unsigned long vco_mhz;
+	unsigned long flags;
+	unsigned int index, vco_index;
+	int i;
+
+	struct cpufreq_freqs freqs;
+#if defined(BF533_CPU_DEBUG)
+	printk

KERN_DEBUG ?

+	    ("cclk begin change to cclk %d,vco=%d,index=%d,target=%d,oldfreq=%d\n",
+	     cclk_mhz, vco_mhz, index, target_freq, freqs.old);
+#endif
+}
+
+/* make sure that only the "userspace" governor is run -- anything else wouldn't make sense on

line above is too long.

+ * this platform, anyway.
+ */
+static int bf537_verify_speed(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, &bf537_freq_table);
+}
diff -urN linux-2.6.18/arch/blackfin/mach-bf537/ints-priority.c linux-2.6.18.patch1/arch/blackfin/mach-bf537/ints-priority.c
--- linux-2.6.18/arch/blackfin/mach-bf537/ints-priority.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf537/ints-priority.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,79 @@
+
+void program_IAR(void);

Don't need the prototype.

+/*Program the IAR registers*/
+
+void program_IAR()
+{
+}
diff -urN linux-2.6.18/arch/blackfin/mach-bf537/pm.c linux-2.6.18.patch1/arch/blackfin/mach-bf537/pm.c
--- linux-2.6.18/arch/blackfin/mach-bf537/pm.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf537/pm.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,150 @@
+
+#include <asm/io.h>
+
+/*

Use /** for kernel-doc format.

+ *	bf537_pm_prepare - Do preliminary suspend work.
+ *	@state:		suspend state we're entering.
+ *
+ */
+
+static int bf537_pm_prepare(suspend_state_t state)
+{
+}
+
+/*

Use /** for kernel-doc format.

+ *	bf537_pm_enter - Actually enter a sleep state.
+ *	@state:		State we're entering.
+ *
+ */
+
+static int bf537_pm_enter(suspend_state_t state)
+{
+}
+
+/**

Good.

+ *	bf537_pm_finish - Finish up suspend sequence.
+ *	@state:		State we're coming out of.
+ *
+ *	This is called after we wake back up (or if entering the sleep state
+ *	failed).
+ */
+
+static int bf537_pm_finish(suspend_state_t state)
+{
+}
+
diff -urN linux-2.6.18/arch/blackfin/mach-bf561/boards/ezkit.c linux-2.6.18.patch1/arch/blackfin/mach-bf561/boards/ezkit.c
--- linux-2.6.18/arch/blackfin/mach-bf561/boards/ezkit.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf561/boards/ezkit.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,84 @@
+
+static int __init ezkit_init(void)
+{
+	printk("%s(): registering device resources\n", __FUNCTION__);

KERN_INFO

+	return platform_add_devices(ezkit_devices, ARRAY_SIZE(ezkit_devices));
+}
+
+arch_initcall(ezkit_init);
diff -urN linux-2.6.18/arch/blackfin/mach-bf561/boards/generic_board.c linux-2.6.18.patch1/arch/blackfin/mach-bf561/boards/generic_board.c
--- linux-2.6.18/arch/blackfin/mach-bf561/boards/generic_board.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf561/boards/generic_board.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,78 @@
+
+static int __init generic_board_init(void)
+{
+	printk("%s(): registering device resources\n", __FUNCTION__);

KERN_INFO

+	return platform_add_devices(generic_board_devices,
+				    ARRAY_SIZE(generic_board_devices));
+}
diff -urN linux-2.6.18/arch/blackfin/mach-bf561/coreb.c linux-2.6.18.patch1/arch/blackfin/mach-bf561/coreb.c
--- linux-2.6.18/arch/blackfin/mach-bf561/coreb.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf561/coreb.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,413 @@
+
+int __init bf561_coreb_init(void)
+{
+
Don't indent labels so much:

+      release_dma_src:
+	free_dma(CH_MEM_STREAM2_SRC);
+      release_dma_dest:
+	free_dma(CH_MEM_STREAM2_DEST);
+      release_data_a_sram:
+	release_mem_region(0xff400000, 0x8000);
+      release_data_b_sram:
+	release_mem_region(0xff500000, 0x8000);
+      release_instruction_b_sram:
+	release_mem_region(0xff610000, 0x4000);
+      release_instruction_a_sram:
+	release_mem_region(0xff600000, 0x4000);
+      exit:
+	return -ENOMEM;
+}
+
diff -urN linux-2.6.18/arch/blackfin/mach-bf561/ints-priority.c linux-2.6.18.patch1/arch/blackfin/mach-bf561/ints-priority.c
--- linux-2.6.18/arch/blackfin/mach-bf561/ints-priority.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-bf561/ints-priority.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,113 @@
+
+void program_IAR(void);

Drop the prototype.

+/*Program the IAR registers*/
+
+void program_IAR()
+{
+}
diff -urN linux-2.6.18/arch/blackfin/mach-common/bf5xx_rtc.c linux-2.6.18.patch1/arch/blackfin/mach-common/bf5xx_rtc.c
--- linux-2.6.18/arch/blackfin/mach-common/bf5xx_rtc.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-common/bf5xx_rtc.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,140 @@
+
+/* Read the time from the RTC_STAT.
+ * time_in_seconds is seconds since Jan 1970
+ */
+int rtc_get(time_t * time_in_seconds)

No space after '*':  just use:  time_t *time_in_seconds

+{
+	unsigned long cur_rtc_stat = 0;
+	int tm_sec = 0, tm_min = 0, tm_hour = 0, tm_day = 0;
+
+	if (time_in_seconds == NULL) {
+		return -1;
+	}

Drop the unneeded braces.

+	/* Read the RTC_STAT register */
+	cur_rtc_stat = bfin_read_RTC_STAT();
+}
diff -urN linux-2.6.18/arch/blackfin/mach-common/cplbinfo.c linux-2.6.18.patch1/arch/blackfin/mach-common/cplbinfo.c
--- linux-2.6.18/arch/blackfin/mach-common/cplbinfo.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-common/cplbinfo.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,212 @@
+
+static int cplbinfo_write_proc(struct file *file, const char *buffer,
+			       unsigned long count, void *data)
+{
+	printk("Reset the CPLB swap in/out counts.\n");
+	memset(ipdt_swapcount_table, 0, 100 * sizeof(unsigned long));
+	memset(dpdt_swapcount_table, 0, 120 * sizeof(unsigned long));

Could you eliminate those magic numbers (100, 120) ?

+	return count;
+}
diff -urN linux-2.6.18/arch/blackfin/mach-common/ints-priority-dc.c linux-2.6.18.patch1/arch/blackfin/mach-common/ints-priority-dc.c
--- linux-2.6.18/arch/blackfin/mach-common/ints-priority-dc.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-common/ints-priority-dc.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,545 @@
+
+static void bf561_core_mask_irq(unsigned int irq)
+{
+	irq_flags &= ~(1 << irq);
+	if (!irqs_disabled())
+		local_irq_enable();

should that be local_irq_disable() ?
or you use local_irq_enable() in both core_mask_irq() and
core_unmask_irq() ?

+}
+
+static void bf561_core_unmask_irq(unsigned int irq)
+{
+	irq_flags |= 1 << irq;
+	/*
+	 * If interrupts are enabled, IMASK must contain the same value
+	 * as irq_flags.  Make sure that invariant holds.  If interrupts
+	 * are currently disabled we need not do anything; one of the
+	 * callers will take care of setting IMASK to the proper value
+	 * when reenabling interrupts.
+	 * local_irq_enable just does "STI irq_flags", so it's exactly
+	 * what we need.
+	 */
+	if (!irqs_disabled())
+		local_irq_enable();
+	return;
+}
+
diff -urN linux-2.6.18/arch/blackfin/mach-common/ints-priority-sc.c linux-2.6.18.patch1/arch/blackfin/mach-common/ints-priority-sc.c
--- linux-2.6.18/arch/blackfin/mach-common/ints-priority-sc.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-common/ints-priority-sc.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,619 @@
+
+volatile unsigned long irq_flags = 0;
+
+/* The number of spurious interrupts */
+volatile unsigned int num_spurious;

too much volatile.

+static void search_IAR(void);

Function prototype not needed.

+/*
+ * Search SIC_IAR and fill tables with the irqvalues
+ * and their positions in the SIC_ISR register.
+ */
+static void __init search_IAR(void)
+{
+	unsigned ivg, irq_pos = 0;
+	for (ivg = 0; ivg <= IVG13 - IVG7; ivg++) {
+		int irqn;
+
+		ivg7_13[ivg].istop = ivg7_13[ivg].ifirst = &ivg_table[irq_pos];
+
+		for (irqn = 0; irqn < NR_PERI_INTS; irqn++) {
+			int iar_shift = (irqn & 7) * 4;
+			if (ivg ==
+			    (0xf &
+			     bfin_read32((unsigned long *)SIC_IAR0 +
+					 (irqn >> 3)) >> iar_shift)) {
+				ivg_table[irq_pos].irqno = IVG7 + irqn;
+				ivg_table[irq_pos].isrflag = 1 << irqn;
+				ivg7_13[ivg].istop++;
+				irq_pos++;
+			}
+		}
+	}
+}
+
+static void bf533_core_mask_irq(unsigned int irq)
+{
+	irq_flags &= ~(1 << irq);
+	if (!irqs_disabled())
+		local_irq_enable();

should that be local_irq_disable() ?

+}
+
+#ifdef CONFIG_IRQCHIP_DEMUX_GPIO
+static int gpio_enabled;
+static int gpio_edge_triggered;

General comment:  it's probably not in CodingStyle, but we seem to prefer
to see a blank line between a function's local data and its executable
statements (applies to many functions in this patch).

+static void bf533_gpio_mask_irq(unsigned int irq)
+{
+	int gpionr = irq - IRQ_PF0;
+	int mask = (1L << gpionr);
+	bfin_write_FIO_FLAG_C(mask);
+	__builtin_bfin_ssync();
+	bfin_write_FIO_MASKB_C(mask);
+	__builtin_bfin_ssync();
+}
+
+void do_irq(int vec, struct pt_regs *fp)
+{
+	if (vec == EVT_IVTMR_P) {
+		vec = IRQ_CORETMR;

drop the extra/unneeded braces.

+	} else {
+		struct ivgx *ivg = ivg7_13[vec - IVG7].ifirst;
+		struct ivgx *ivg_stop = ivg7_13[vec - IVG7].istop;
+		unsigned long sic_status;
+
+		__builtin_bfin_ssync();
+		sic_status = bfin_read_SIC_IMASK() & bfin_read_SIC_ISR();
+
+		for (;; ivg++) {
+			if (ivg >= ivg_stop) {
+				num_spurious++;
+				return;
+			} else if (sic_status & ivg->isrflag)
+				break;
+		}
+		vec = ivg->irqno;
+	}
+	asm_do_IRQ(vec, fp);
+}
+
diff -urN linux-2.6.18/arch/blackfin/mach-common/irqpanic.c linux-2.6.18.patch1/arch/blackfin/mach-common/irqpanic.c
--- linux-2.6.18/arch/blackfin/mach-common/irqpanic.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mach-common/irqpanic.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,193 @@
+
+/*
+ * irq_panic - calls panic with string setup
+ */
+asmlinkage void irq_panic(int reason, struct pt_regs *regs)
+{
...
+	if (die) {
+		printk("icache coherency error\n");

KERN_ALERT or KERN_EMERGENCY ?

+		for (j = 0; j <= i; j++) {
+			printk
+			    ("cache address   : %08x  cache value : %08x%08x\n",
+			     bad[j][0], bad[j][1], bad[j][2]);
+			printk
+			    ("physical address: %08x  SDRAM value : %08x%08x\n",
+			     bad[j][3], bad[j][4], bad[j][5]);
+		}
+		panic("icache coherency error");
+	} else {
+		printk("\n\nicache checked, and OK\n");
+	}
+#endif

Add KERN_ levels:

+	printk("\n\nException: IRQ 0x%x entered\n", reason);
+	printk(" code=[0x%08x],  ", (unsigned int)regs->seqstat);
+	printk(" stack frame=0x%04x,  ", (unsigned int)(unsigned long)regs);
+	printk(" bad PC=0x%04x\n", (unsigned int)regs->pc);
+	if (reason == 0x5) {
+		printk("\n----------- HARDWARE ERROR -----------\n\n");
+
+		/* There is only need to check for Hardware Errors, since other
+		 * EXCEPTIONS are handled in TRAPS.c (MH)
+		 */
+		switch (regs->seqstat & SEQSTAT_HWERRCAUSE) {
+		case (SEQSTAT_HWERRCAUSE_SYSTEM_MMR):	/* System MMR Error */
+			info.si_code = BUS_ADRALN;
+			sig = SIGBUS;
+			printk(HWC_x2);
+			break;
+		case (SEQSTAT_HWERRCAUSE_EXTERN_ADDR):	/* External Memory Addressing Error */
+			info.si_code = BUS_ADRERR;
+			sig = SIGBUS;
+			printk(KERN_EMERG HWC_x3);
+			break;
+		case (SEQSTAT_HWERRCAUSE_PERF_FLOW):	/* Performance Monitor Overflow */
+			printk(KERN_EMERG HWC_x12);
+			break;
+		case (SEQSTAT_HWERRCAUSE_RAISE_5):	/* RAISE 5 instruction */
+			printk(KERN_EMERG HWC_x18);
+			break;
+		default:	/* Reserved */
+			printk(KERN_EMERG HWC_default);
+			break;
+		}
+	}
+
+	regs->ipend = bfin_read_IPEND();
+	dump_bfin_regs(regs, (void *)regs->pc);
+	if (0 == (info.si_signo = sig) || 0 == user_mode(regs))	/* in kernelspace */
+		panic("Unhandled IRQ or exceptions!\n");
+	else {			/* in userspace */
+		info.si_errno = 0;
+		info.si_addr = (void *)regs->pc;
+		force_sig_info(sig, &info, current);
+	}
+}
+
diff -urN linux-2.6.18/arch/blackfin/mm/blackfin_sram.c linux-2.6.18.patch1/arch/blackfin/mm/blackfin_sram.c
--- linux-2.6.18/arch/blackfin/mm/blackfin_sram.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/mm/blackfin_sram.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,532 @@
+
+int sram_free(const void *addr)
+{
+	if (0) {
+	}

Drop those 2 lines.

+}
+
+int sram_free_with_lsl(const void *addr)
+{
+	struct sram_list_struct *lsl, **tmp;
+	struct mm_struct *mm = current->mm;
+
+	for (tmp = &mm->context.sram_list; *tmp; tmp = &(*tmp)->next)
+		if ((*tmp)->addr == addr)
+			goto found;
+	return -1;
+      found:

Outdent the label.

+	lsl = *tmp;
+	sram_free(addr);
+	*tmp = lsl->next;
+	kfree(lsl);
+
+	return 0;
+}
+
diff -urN linux-2.6.18/arch/blackfin/oprofile/common.c linux-2.6.18.patch1/arch/blackfin/oprofile/common.c
--- linux-2.6.18/arch/blackfin/oprofile/common.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/oprofile/common.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,170 @@
+
+static int op_bfin_create_files(struct super_block *sb, struct dentry *root)
+{
+	int i;
+
+	for (i = 0; i < model->num_counters; ++i) {
+		struct dentry *dir;
+		char buf[3];
+		printk("Oprofile: creating files... \n");

KERN_DEBUG ?

+		snprintf(buf, sizeof buf, "%d", i);
+		dir = oprofilefs_mkdir(sb, root, buf);
+
+		oprofilefs_create_ulong(sb, dir, "enabled", &ctr[i].enabled);
+		oprofilefs_create_ulong(sb, dir, "event", &ctr[i].event);
+		oprofilefs_create_ulong(sb, dir, "count", &ctr[i].count);
+		/*
+		 * We dont support per counter user/kernel selection, but
+		 * we leave the entries because userspace expects them
+		 */
+		oprofilefs_create_ulong(sb, dir, "kernel", &ctr[i].kernel);
+		oprofilefs_create_ulong(sb, dir, "user", &ctr[i].user);
+		oprofilefs_create_ulong(sb, dir, "unit_mask",
+					&ctr[i].unit_mask);
+	}
+
+	return 0;
+}
+int __init oprofile_arch_init(struct oprofile_operations *ops)
+{
+#ifdef CONFIG_HARDWARE_PM
+	unsigned int dspid;
+
+	init_MUTEX(&pfmon_sem);
+
+	dspid = bfin_read_DSPID();
+
+	printk("Oprofile got the cpu id is 0x%x. \n", dspid);

Drop "the" and "is" ?

+	switch (dspid) {
+	case BFIN_533_ID:
+		model = &op_model_bfin533;
+		model->num_counters = 2;
+		break;
+	case BFIN_537_ID:
+		model = &op_model_bfin533;
+		model->num_counters = 2;
+		break;
+	default:
+		return -ENODEV;
+	}
+
diff -urN linux-2.6.18/arch/blackfin/oprofile/op_model_bf533.c linux-2.6.18.patch1/arch/blackfin/oprofile/op_model_bf533.c
--- linux-2.6.18/arch/blackfin/oprofile/op_model_bf533.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/oprofile/op_model_bf533.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,168 @@
+
+#ifdef PM_DEBUG
+#define dbg(args...) printk(args)
+#else
+#define dbg(args...)
+#endif
+#define PM_ENABLE 0x01;

Drop the ";".

+#define PM_CTL1_ENABLE  0x18
+#define PM_CTL0_ENABLE  0xC000
+#define COUNT_EDGE_ONLY 0x3000000
+
+static int oprofile_running;
+
+unsigned curr_pfctl, curr_count[2];
+
+static int get_kernel(void)
+{
+	int ipend, is_kernel;
+
+	ipend = bfin_read_IPEND();
+
+	/* test bit 15 */
+	is_kernel = ((ipend & 0x8000) != 0);

Drop extra (outer) parens.

+	return is_kernel;
+}
+
diff -urN linux-2.6.18/arch/blackfin/oprofile/timer_int.c linux-2.6.18.patch1/arch/blackfin/oprofile/timer_int.c
--- linux-2.6.18/arch/blackfin/oprofile/timer_int.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18.patch1/arch/blackfin/oprofile/timer_int.c	2006-09-21 09:29:49.000000000 +0800
@@ -0,0 +1,79 @@
+static int sys_timer0_start(void)
+{
+	enable_sys_timer0();
+	int retval = request_irq(IVG11, sys_timer0_int_handler, 0,
+				 "sys_timer0", NULL);
+	if (retval)
+		return retval;
+	return 0;

Isn't that the same as just doing:
	return retval;
in all cases?

+}

###
