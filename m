Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291712AbSBHSle>; Fri, 8 Feb 2002 13:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291718AbSBHSlX>; Fri, 8 Feb 2002 13:41:23 -0500
Received: from f69.law11.hotmail.com ([64.4.17.69]:30995 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S291712AbSBHSkw>;
	Fri, 8 Feb 2002 13:40:52 -0500
X-Originating-IP: [156.153.254.10]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: tigran@veritas.com
Cc: linux-kernel@vger.kernel.org, balbir_soni@hotmail.com
Subject: Re: [patch] larger kernel stack (8k->16k) per task (fwd)
Date: Fri, 08 Feb 2002 10:40:45 -0800
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_3793_582a_6e6a"
Message-ID: <F69rw2fk1VK68maChsd0001c218@hotmail.com>
X-OriginalArrivalTime: 08 Feb 2002 18:40:46.0464 (UTC) FILETIME=[1F1B1800:01C1B0D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_3793_582a_6e6a
Content-Type: text/plain; format=flowed

Thanks, I managed to come up with a patch of my own.

The patch looks good, some comments

1. We do not really have to change the size of INIT_TASK
   since that is architecture independent code in sched.h
   PARISC is managing with init_task stack of 8K and
   other stacks of 16K.
2. I think you missed getuser.S in arch/i386/kernel/lib.
   All the __get_user_x should change to

3. I verified that the instance of GET_CURRENT in hw-irq.h
   is not being used by anybody and can safely be removed.

__get_user_1:
        movl %esp,%edx
        andl $~(THREAD_SIZE - 1),%edx
        cmpl addr_limit(%edx),%eax

I have a patch that lets the user select any stack size
from 8K to 64K, it can be configured. And yes, it works
on my system.

I do not have the /proc entry that u have though in
my patch.

Would you like to merge both the patches or would you
like me to do it and send out a new version.


The patch is attached along with this email. It
is againt 2.4.17

I believe that using 8K as stack size is correct.
My patch is to help people debug stack overflows
and if they wanted to experiment or port code from
other OS'es (where the code uses a stack > 8K - sizeof
(struct task_struct)) then they can use this patch.

Comments,
Balbir

>Hi Balbir,
>
>Here is my patch that does what you want but only on i386 architecture. I
>am forwarding it to you in case you are not subscribed to linux-kernel
>list.
>
>Regards
>Tigran
>
>---------- Forwarded message ----------
>Date: Fri, 8 Feb 2002 15:20:19 +0000 (GMT)
>From: Tigran Aivazian <tigran@veritas.com>
>To: linux-kernel@vger.kernel.org
>Cc: Hugh Dickins <hugh@veritas.com>
>Subject: [patch] larger kernel stack (8k->16k) per task
>
>Hi,
>
>In the light of some talks here about increasing kernel stack, here is my
>patch for i386 architecture that some may find useful. It also has a nice
>extra (/proc/stack) implemented by Hugh Dickins which helps to find major
>offenders.
>
>It is against 2.4.9 but should be easy to port in any direction. (One way
>the patch could be improved is by making the size CONFIG_ option instead
>of hardcoding). Oh btw, please don't tell me "but now you'd need _four_
>physically-contiguous pages to create a task instead of two!" because I
>know it (and think it's not too bad).
>
>Regards,
>Tigran
>
>diff -urN 249-vx/arch/i386/kernel/entry.S 
>249-vx-bigstack/arch/i386/kernel/entry.S
>--- 249-vx/arch/i386/kernel/entry.S	Tue Jun 12 19:47:28 2001
>+++ 249-vx-bigstack/arch/i386/kernel/entry.S	Sun Jan 13 00:14:30 2002
>@@ -130,7 +130,7 @@
>  .previous
>
>  #define GET_CURRENT(reg) \
>-	movl $-8192, reg; \
>+	movl $-16384, reg; \
>  	andl %esp, reg
>
>  ENTRY(lcall7)
>@@ -145,7 +145,7 @@
>  	movl %ecx,CS(%esp)	#
>  	movl %esp,%ebx
>  	pushl %ebx
>-	andl $-8192,%ebx	# GET_CURRENT
>+	andl $-16384,%ebx	# GET_CURRENT
>  	movl exec_domain(%ebx),%edx	# Get the execution domain
>  	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
>  	pushl $0x7
>@@ -166,7 +166,7 @@
>  	movl %ecx,CS(%esp)	#
>  	movl %esp,%ebx
>  	pushl %ebx
>-	andl $-8192,%ebx	# GET_CURRENT
>+	andl $-16384,%ebx	# GET_CURRENT
>  	movl exec_domain(%ebx),%edx	# Get the execution domain
>  	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
>  	pushl $0x27
>diff -urN 249-vx/arch/i386/kernel/head.S 
>249-vx-bigstack/arch/i386/kernel/head.S
>--- 249-vx/arch/i386/kernel/head.S	Wed Jun 20 19:00:53 2001
>+++ 249-vx-bigstack/arch/i386/kernel/head.S	Sun Jan 13 00:14:30 2002
>@@ -320,7 +320,7 @@
>  	ret
>
>  ENTRY(stack_start)
>-	.long SYMBOL_NAME(init_task_union)+8192
>+	.long SYMBOL_NAME(init_task_union)+16384
>  	.long __KERNEL_DS
>
>  /* This is the default interrupt "handler" :-) */
>diff -urN 249-vx/arch/i386/kernel/process.c 
>249-vx-bigstack/arch/i386/kernel/process.c
>--- 249-vx/arch/i386/kernel/process.c	Thu Jul 26 02:19:11 2001
>+++ 249-vx-bigstack/arch/i386/kernel/process.c	Sun Jan 13 00:14:30 2002
>@@ -757,12 +757,12 @@
>  		return 0;
>  	stack_page = (unsigned long)p;
>  	esp = p->thread.esp;
>-	if (!stack_page || esp < stack_page || esp > 8188+stack_page)
>+	if (!stack_page || esp < stack_page || esp > 16380+stack_page)
>  		return 0;
>  	/* include/asm-i386/system.h:switch_to() pushes ebp last. */
>  	ebp = *(unsigned long *) esp;
>  	do {
>-		if (ebp < stack_page || ebp > 8184+stack_page)
>+		if (ebp < stack_page || ebp > 16376+stack_page)
>  			return 0;
>  		eip = *(unsigned long *) (ebp+4);
>  		if (eip < first_sched || eip >= last_sched)
>diff -urN 249-vx/arch/i386/kernel/smpboot.c 
>249-vx-bigstack/arch/i386/kernel/smpboot.c
>--- 249-vx/arch/i386/kernel/smpboot.c	Tue Feb 13 22:13:43 2001
>+++ 249-vx-bigstack/arch/i386/kernel/smpboot.c	Sun Jan 13 00:14:30 2002
>@@ -577,7 +577,7 @@
>
>  	/* So we see what's up   */
>  	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
>-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
>+	stack_start.esp = (void *) idle->thread.esp;
>
>  	/*
>  	 * This grunge runs the startup process for
>diff -urN 249-vx/arch/i386/kernel/traps.c 
>249-vx-bigstack/arch/i386/kernel/traps.c
>--- 249-vx/arch/i386/kernel/traps.c	Sun Aug 12 19:13:59 2001
>+++ 249-vx-bigstack/arch/i386/kernel/traps.c	Sun Jan 13 00:14:30 2002
>@@ -160,7 +160,7 @@
>  	unsigned long esp = tsk->thread.esp;
>
>  	/* User space on another CPU? */
>-	if ((esp ^ (unsigned long)tsk) & (PAGE_MASK<<1))
>+	if ((esp ^ (unsigned long)tsk) & ~(THREAD_SIZE-1))
>  		return;
>  	show_trace((unsigned long *)esp);
>  }
>diff -urN 249-vx/arch/i386/lib/getuser.S 
>249-vx-bigstack/arch/i386/lib/getuser.S
>--- 249-vx/arch/i386/lib/getuser.S	Mon Jan 12 21:42:52 1998
>+++ 249-vx-bigstack/arch/i386/lib/getuser.S	Sun Jan 13 00:14:30 2002
>@@ -28,7 +28,7 @@
>  .globl __get_user_1
>  __get_user_1:
>  	movl %esp,%edx
>-	andl $0xffffe000,%edx
>+	andl $-16384,%edx
>  	cmpl addr_limit(%edx),%eax
>  	jae bad_get_user
>  1:	movzbl (%eax),%edx
>@@ -41,7 +41,7 @@
>  	addl $1,%eax
>  	movl %esp,%edx
>  	jc bad_get_user
>-	andl $0xffffe000,%edx
>+	andl $-16384,%edx
>  	cmpl addr_limit(%edx),%eax
>  	jae bad_get_user
>  2:	movzwl -1(%eax),%edx
>@@ -54,7 +54,7 @@
>  	addl $3,%eax
>  	movl %esp,%edx
>  	jc bad_get_user
>-	andl $0xffffe000,%edx
>+	andl $-16384,%edx
>  	cmpl addr_limit(%edx),%eax
>  	jae bad_get_user
>  3:	movl -3(%eax),%edx
>diff -urN 249-vx/arch/i386/vmlinux.lds 
>249-vx-bigstack/arch/i386/vmlinux.lds
>--- 249-vx/arch/i386/vmlinux.lds	Sat Jan 12 21:31:54 2002
>+++ 249-vx-bigstack/arch/i386/vmlinux.lds	Sun Jan 13 00:14:30 2002
>@@ -36,7 +36,7 @@
>
>    _edata = .;			/* End of data section */
>
>-  . = ALIGN(8192);		/* init_task */
>+  . = ALIGN(16384);		/* init_task */
>    .data.init_task : { *(.data.init_task) }
>
>    . = ALIGN(4096);		/* Init code and data */
>diff -urN 249-vx/include/asm-i386/current.h 
>249-vx-bigstack/include/asm-i386/current.h
>--- 249-vx/include/asm-i386/current.h	Sat Aug 15 00:35:22 1998
>+++ 249-vx-bigstack/include/asm-i386/current.h	Sun Jan 13 00:14:30 2002
>@@ -6,7 +6,7 @@
>  static inline struct task_struct * get_current(void)
>  {
>  	struct task_struct *current;
>-	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
>+	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~16383UL));
>  	return current;
>   }
>
>diff -urN 249-vx/include/asm-i386/hw_irq.h 
>249-vx-bigstack/include/asm-i386/hw_irq.h
>--- 249-vx/include/asm-i386/hw_irq.h	Wed Aug 15 22:21:11 2001
>+++ 249-vx-bigstack/include/asm-i386/hw_irq.h	Sun Jan 13 00:14:30 2002
>@@ -115,7 +115,7 @@
>
>  #define GET_CURRENT \
>  	"movl %esp, %ebx\n\t" \
>-	"andl $-8192, %ebx\n\t"
>+	"andl $-16384, %ebx\n\t"
>
>  /*
>   *	SMP has a few special interrupts for IPI messages
>diff -urN 249-vx/include/asm-i386/processor.h 
>249-vx-bigstack/include/asm-i386/processor.h
>--- 249-vx/include/asm-i386/processor.h	Wed Aug 15 22:21:11 2001
>+++ 249-vx-bigstack/include/asm-i386/processor.h	Sun Jan 13 00:14:30 2002
>@@ -445,13 +445,27 @@
>  }
>
>  unsigned long get_wchan(struct task_struct *p);
>-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned 
>long)(tsk)))[1019])
>-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned 
>long)(tsk)))[1022])
>
>-#define THREAD_SIZE (2*PAGE_SIZE)
>-#define alloc_task_struct() ((struct task_struct *) 
>__get_free_pages(GFP_KERNEL,1))
>-#define free_task_struct(p) free_pages((unsigned long) (p), 1)
>-#define get_task_struct(tsk)      atomic_inc(&virt_to_page(tsk)->count)
>+#define THREAD_ORDER	2
>+#define THREAD_SIZE	(PAGE_SIZE << THREAD_ORDER)
>+#define THREAD_LONGS	(THREAD_SIZE / sizeof(unsigned long))
>+
>+#define KSTK_EIP(tsk)	(((unsigned long *)(tsk))[THREAD_LONGS-5])
>+#define KSTK_ESP(tsk)	(((unsigned long *)(tsk))[THREAD_LONGS-2])
>+
>+#define alloc_task_struct()						\
>+    ({									\
>+	unsigned long tsk = __get_free_pages(GFP_KERNEL, THREAD_ORDER);	\
>+	if (tsk != 0) {							\
>+		/* Alt-SysRq-T show_task() show if stack went deep */	\
>+		memset((char*)tsk+sizeof(struct task_struct), 0,	\
>+			THREAD_SIZE-sizeof(struct task_struct));	\
>+	}								\
>+	(struct task_struct *) tsk;					\
>+    })
>+
>+#define free_task_struct(tsk) free_pages((unsigned long) (tsk), 
>THREAD_ORDER)
>+#define get_task_struct(tsk)  atomic_inc(&virt_to_page(tsk)->count)
>
>  #define init_task	(init_task_union.task)
>  #define init_stack	(init_task_union.stack)
>diff -urN 249-vx/include/linux/sched.h 
>249-vx-bigstack/include/linux/sched.h
>--- 249-vx/include/linux/sched.h	Sat Jan 12 23:53:58 2002
>+++ 249-vx-bigstack/include/linux/sched.h	Sun Jan 13 00:14:30 2002
>@@ -484,7 +484,7 @@
>
>
>  #ifndef INIT_TASK_SIZE
>-# define INIT_TASK_SIZE	2048*sizeof(long)
>+# define INIT_TASK_SIZE	4096*sizeof(long)
>  #endif
>
>  union task_union {
>diff -urN 249-vx/kernel/exit.c 249-vx-bigstack/kernel/exit.c
>--- 249-vx/kernel/exit.c	Sun Aug 12 18:52:29 2001
>+++ 249-vx-bigstack/kernel/exit.c	Sun Jan 13 00:14:30 2002
>@@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/completion.h>
>  #include <linux/tty.h>
>+#include <linux/proc_fs.h>
>  #ifdef CONFIG_BSD_PROCESS_ACCT
>  #include <linux/acct.h>
>  #endif
>@@ -24,6 +25,74 @@
>
>  int getrusage(struct task_struct *, int, struct rusage *);
>
>+#ifdef CONFIG_PROC_FS
>+static int max_stack_depth;
>+static pid_t max_stack_pid;
>+static struct task_struct *max_stack_task; /* kept for kdb */
>+static spinlock_t max_stack_lock = SPIN_LOCK_UNLOCKED;
>+static void check_stack_depth(struct task_struct *);
>+
>+static int stack_read_proc(char *page, char **start, off_t off,
>+				int count, int *eof, void *data)
>+{
>+	struct task_struct *p;
>+	int len;
>+
>+	read_lock(&tasklist_lock);
>+	for_each_task(p)
>+		check_stack_depth(p);
>+	read_unlock(&tasklist_lock);
>+
>+	spin_lock(&max_stack_lock);
>+	len = sprintf(page,
>+		"Deepest stack is 0x%04x (+ task 0x%04x = 0x%04x) for pid %d %.16s\n",
>+		max_stack_depth, sizeof(*p), sizeof(*p) + max_stack_depth,
>+		max_stack_pid, max_stack_task->comm);
>+	spin_unlock(&max_stack_lock);
>+
>+	*eof = (len <= off + count);
>+	*start = page + off;
>+	len -= off;
>+	if (len > count)
>+		len = count;
>+	if (len < 0)
>+		len = 0;
>+	return len;
>+}
>+
>+static void check_stack_depth(struct task_struct *p)
>+{
>+	int depth;
>+	struct task_struct *old_stack_task;
>+	unsigned long *sp = (unsigned long *)(p + 1);
>+
>+	while (!*sp)
>+		sp++;
>+	depth = (int)p + THREAD_SIZE - (int)sp;
>+	if (depth <= max_stack_depth)
>+		return;
>+
>+	old_stack_task = NULL;
>+	spin_lock(&max_stack_lock);
>+	if (depth > max_stack_depth) {
>+		old_stack_task = max_stack_task;
>+		max_stack_depth = depth;
>+		max_stack_pid = p->pid;
>+		max_stack_task = p;
>+		get_task_struct(p);
>+	}
>+	spin_unlock(&max_stack_lock);
>+
>+	if (old_stack_task)
>+		free_task_struct(old_stack_task);
>+	else
>+		create_proc_read_entry("stack",
>+			0444, NULL, stack_read_proc, NULL);
>+}
>+#else  /* ndef CONFIG_PROC_FS */
>+#define check_stack_depth(p)	do { } while (0)
>+#endif /* ndef CONFIG_PROC_FS */
>+
>  static void release_task(struct task_struct * p)
>  {
>  	if (p != current) {
>@@ -63,6 +132,7 @@
>  		current->counter += p->counter;
>  		if (current->counter >= MAX_COUNTER)
>  			current->counter = MAX_COUNTER;
>+		check_stack_depth(p);
>  		p->pid = 0;
>  		free_task_struct(p);
>  	} else {
>
>




_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

------=_NextPart_000_3793_582a_6e6a
Content-Type: application/octet-stream; name="big_stack_patch.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="big_stack_patch.diff"

ZGlmZiAtTmF1ciBsaW51eC9hcmNoL2kzODYvY29uZmlnLmluIGxpbnV4LW5l
dy9hcmNoL2kzODYvY29uZmlnLmluCi0tLSBsaW51eC9hcmNoL2kzODYvY29u
ZmlnLmluCUZyaSBEZWMgMjEgMTA6NDE6NTMgMjAwMQorKysgbGludXgtbmV3
L2FyY2gvaTM4Ni9jb25maWcuaW4JV2VkIEZlYiAgNiAxOToxNDoxMCAyMDAy
CkBAIC00MTMsNiArNDEzLDI2IEBACiAgICBib29sICcgIE1hZ2ljIFN5c1Jx
IGtleScgQ09ORklHX01BR0lDX1NZU1JRCiAgICBib29sICcgIFNwaW5sb2Nr
IGRlYnVnZ2luZycgQ09ORklHX0RFQlVHX1NQSU5MT0NLCiAgICBib29sICcg
IFZlcmJvc2UgQlVHKCkgcmVwb3J0aW5nIChhZGRzIDcwSyknIENPTkZJR19E
RUJVR19CVUdWRVJCT1NFCi1maQorICAgY2hvaWNlICdCaWdnZXIgU3RhY2sg
U2l6ZSBTdXBwb3J0JyBcCisJIm9mZiAgICBDT05GSUdfTk9CSUdTVEFDSyBc
CisJIDE2S0IgICBDT05GSUdfU1RBQ0tfU0laRV8xNktCIFwKKwkgMzJLQiAg
IENPTkZJR19TVEFDS19TSVpFXzMyS0IgXAorCSA2NEtCICAgQ09ORklHX1NU
QUNLX1NJWkVfNjRLQiIgb2ZmCiAKKyAgaWYgWyAiJENPTkZJR19OT0JJR1NU
QUNLIiA9ICJ5IiBdOyB0aGVuCisgICAgIGRlZmluZV9pbnQgQ09ORklHX1NU
QUNLX1NJWkVfU0hJRlQgMQorICBlbHNlCisgICAgaWYgWyAiJENPTkZJR19T
VEFDS19TSVpFXzE2S0IiID0gInkiIF07IHRoZW4KKyAgICAgICBkZWZpbmVf
aW50IENPTkZJR19TVEFDS19TSVpFX1NISUZUIDIKKyAgICBlbHNlCisgICAg
ICBpZiBbICIkQ09ORklHX1NUQUNLX1NJWkVfMzJLQiIgPSAieSIgXTsgdGhl
bgorICAgICAgICBkZWZpbmVfaW50IENPTkZJR19TVEFDS19TSVpFX1NISUZU
IDMKKyAgICAgIGVsc2UKKyAgICAgICAgaWYgWyAiJENPTkZJR19TVEFDS19T
SVpFXzY0S0IiID0gInkiIF07IHRoZW4KKyAgICAgICAgICBkZWZpbmVfaW50
IENPTkZJR19TVEFDS19TSVpFX1NISUYgNAorICAgICAgICBmaQorICAgICAg
ZmkKKyAgICBmaQorICBmaQorZmkKIGVuZG1lbnUKZGlmZiAtTmF1ciBsaW51
eC9hcmNoL2kzODYva2VybmVsL2VudHJ5LlMgbGludXgtbmV3L2FyY2gvaTM4
Ni9rZXJuZWwvZW50cnkuUwotLS0gbGludXgvYXJjaC9pMzg2L2tlcm5lbC9l
bnRyeS5TCUZyaSBOb3YgIDIgMTg6MTg6NDkgMjAwMQorKysgbGludXgtbmV3
L2FyY2gvaTM4Ni9rZXJuZWwvZW50cnkuUwlXZWQgRmViICA2IDE4OjUxOjU1
IDIwMDIKQEAgLTQ1LDYgKzQ1LDcgQEAKICNpbmNsdWRlIDxsaW51eC9saW5r
YWdlLmg+CiAjaW5jbHVkZSA8YXNtL3NlZ21lbnQuaD4KICNpbmNsdWRlIDxh
c20vc21wLmg+CisjaW5jbHVkZSA8YXNtL2N1cnJlbnQuaD4KIAogRUJYCQk9
IDB4MDAKIEVDWAkJPSAweDA0CkBAIC0xMjgsMTAgKzEyOSw2IEBACiAJLmxv
bmcgM2IsNmI7CVwKIC5wcmV2aW91cwogCi0jZGVmaW5lIEdFVF9DVVJSRU5U
KHJlZykgXAotCW1vdmwgJC04MTkyLCByZWc7IFwKLQlhbmRsICVlc3AsIHJl
ZwotCiBFTlRSWShsY2FsbDcpCiAJcHVzaGZsCQkJIyBXZSBnZXQgYSBkaWZm
ZXJlbnQgc3RhY2sgbGF5b3V0IHdpdGggY2FsbCBnYXRlcywKIAlwdXNobCAl
ZWF4CQkjIHdoaWNoIGhhcyB0byBiZSBjbGVhbmVkIHVwIGxhdGVyLi4KQEAg
LTE0NCw3ICsxNDEsNyBAQAogCW1vdmwgJWVjeCxDUyglZXNwKQkjCiAJbW92
bCAlZXNwLCVlYngKIAlwdXNobCAlZWJ4Ci0JYW5kbCAkLTgxOTIsJWVieAkj
IEdFVF9DVVJSRU5UCisJYW5kbCAkLVRIUkVBRF9TSVpFLCVlYngJIyBHRVRf
Q1VSUkVOVAogCW1vdmwgZXhlY19kb21haW4oJWVieCksJWVkeAkjIEdldCB0
aGUgZXhlY3V0aW9uIGRvbWFpbgogCW1vdmwgNCglZWR4KSwlZWR4CSMgR2V0
IHRoZSBsY2FsbDcgaGFuZGxlciBmb3IgdGhlIGRvbWFpbgogCXB1c2hsICQw
eDcKQEAgLTE2NSw3ICsxNjIsNyBAQAogCW1vdmwgJWVjeCxDUyglZXNwKQkj
CiAJbW92bCAlZXNwLCVlYngKIAlwdXNobCAlZWJ4Ci0JYW5kbCAkLTgxOTIs
JWVieAkjIEdFVF9DVVJSRU5UCisJYW5kbCAkLVRIUkVBRF9TSVpFLCVlYngJ
IyBHRVRfQ1VSUkVOVAogCW1vdmwgZXhlY19kb21haW4oJWVieCksJWVkeAkj
IEdldCB0aGUgZXhlY3V0aW9uIGRvbWFpbgogCW1vdmwgNCglZWR4KSwlZWR4
CSMgR2V0IHRoZSBsY2FsbDcgaGFuZGxlciBmb3IgdGhlIGRvbWFpbgogCXB1
c2hsICQweDI3CmRpZmYgLU5hdXIgbGludXgvYXJjaC9pMzg2L2tlcm5lbC9p
bml0X3Rhc2suYyBsaW51eC1uZXcvYXJjaC9pMzg2L2tlcm5lbC9pbml0X3Rh
c2suYwotLS0gbGludXgvYXJjaC9pMzg2L2tlcm5lbC9pbml0X3Rhc2suYwlN
b24gU2VwIDE3IDE2OjI5OjA5IDIwMDEKKysrIGxpbnV4LW5ldy9hcmNoL2kz
ODYva2VybmVsL2luaXRfdGFzay5jCVdlZCBGZWIgIDYgMTY6NDM6NTIgMjAw
MgpAQCAtMTQsNyArMTQsNyBAQAogLyoKICAqIEluaXRpYWwgdGFzayBzdHJ1
Y3R1cmUuCiAgKgotICogV2UgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCB0aGlz
IGlzIDgxOTItYnl0ZSBhbGlnbmVkIGR1ZSB0byB0aGUKKyAqIFdlIG5lZWQg
dG8gbWFrZSBzdXJlIHRoYXQgdGhpcyBpcyAxNjM4NC1ieXRlIGFsaWduZWQg
ZHVlIHRvIHRoZQogICogd2F5IHByb2Nlc3Mgc3RhY2tzIGFyZSBoYW5kbGVk
LiBUaGlzIGlzIGRvbmUgYnkgaGF2aW5nIGEgc3BlY2lhbAogICogImluaXRf
dGFzayIgbGlua2VyIG1hcCBlbnRyeS4uCiAgKi8KZGlmZiAtTmF1ciBsaW51
eC9hcmNoL2kzODYvbGliL2dldHVzZXIuUyBsaW51eC1uZXcvYXJjaC9pMzg2
L2xpYi9nZXR1c2VyLlMKLS0tIGxpbnV4L2FyY2gvaTM4Ni9saWIvZ2V0dXNl
ci5TCU1vbiBKYW4gMTIgMTQ6NDI6NTIgMTk5OAorKysgbGludXgtbmV3L2Fy
Y2gvaTM4Ni9saWIvZ2V0dXNlci5TCUZyaSBGZWIgIDggMTE6MjA6MjYgMjAw
MgpAQCAtMjEsNiArMjEsMTAgQEAKICAqIGFzIHRoZXkgZ2V0IGNhbGxlZCBm
cm9tIHdpdGhpbiBpbmxpbmUgYXNzZW1ibHkuCiAgKi8KIAorLyogRHVwbGlj
YXRlZCBmcm9tIGFzbS9wcm9jZXNzb3IuaCAqLworI2luY2x1ZGUgPGFzbS9j
dXJyZW50Lmg+CisjaW5jbHVkZSA8bGludXgvY29uZmlnLmg+CisKIGFkZHJf
bGltaXQgPSAxMgogCiAudGV4dApAQCAtMjgsNyArMzIsNyBAQAogLmdsb2Js
IF9fZ2V0X3VzZXJfMQogX19nZXRfdXNlcl8xOgogCW1vdmwgJWVzcCwlZWR4
Ci0JYW5kbCAkMHhmZmZmZTAwMCwlZWR4CisJYW5kbCAkfihUSFJFQURfU0la
RSAtIDEpLCVlZHgKIAljbXBsIGFkZHJfbGltaXQoJWVkeCksJWVheAogCWph
ZSBiYWRfZ2V0X3VzZXIKIDE6CW1vdnpibCAoJWVheCksJWVkeApAQCAtNDEs
NyArNDUsNyBAQAogCWFkZGwgJDEsJWVheAogCW1vdmwgJWVzcCwlZWR4CiAJ
amMgYmFkX2dldF91c2VyCi0JYW5kbCAkMHhmZmZmZTAwMCwlZWR4CisJYW5k
bCAkfihUSFJFQURfU0laRSAtIDEpLCVlZHgKIAljbXBsIGFkZHJfbGltaXQo
JWVkeCksJWVheAogCWphZSBiYWRfZ2V0X3VzZXIKIDI6CW1vdnp3bCAtMSgl
ZWF4KSwlZWR4CkBAIC01NCw3ICs1OCw3IEBACiAJYWRkbCAkMywlZWF4CiAJ
bW92bCAlZXNwLCVlZHgKIAlqYyBiYWRfZ2V0X3VzZXIKLQlhbmRsICQweGZm
ZmZlMDAwLCVlZHgKKwlhbmRsICR+KFRIUkVBRF9TSVpFIC0gMSksJWVkeAog
CWNtcGwgYWRkcl9saW1pdCglZWR4KSwlZWF4CiAJamFlIGJhZF9nZXRfdXNl
cgogMzoJbW92bCAtMyglZWF4KSwlZWR4CmRpZmYgLU5hdXIgbGludXgvaW5j
bHVkZS9hc20taTM4Ni9jdXJyZW50LmggbGludXgtbmV3L2luY2x1ZGUvYXNt
LWkzODYvY3VycmVudC5oCi0tLSBsaW51eC9pbmNsdWRlL2FzbS1pMzg2L2N1
cnJlbnQuaAlGcmkgQXVnIDE0IDE3OjM1OjIyIDE5OTgKKysrIGxpbnV4LW5l
dy9pbmNsdWRlL2FzbS1pMzg2L2N1cnJlbnQuaAlXZWQgRmViICA2IDIwOjA1
OjUzIDIwMDIKQEAgLTEsMTUgKzEsNDQgQEAKICNpZm5kZWYgX0kzODZfQ1VS
UkVOVF9ICiAjZGVmaW5lIF9JMzg2X0NVUlJFTlRfSAogCisjaW5jbHVkZSA8
YXNtL3BhZ2UuaD4KKworLyoKKyAqIENvbmZpZ3VyYWJsZSBwYWdlIHNpemVz
IG9uIGkzODYsIG1haW5seSBmb3IgZGVidWdnaW5nIHB1cnBvc2VzLgorICog
KGMpIEJhbGJpciBTaW5naAorICovIAorCisjaWZkZWYgX19BU1NFTUJMWV9f
CisKKyNkZWZpbmUgUEFHRV9TSVpFCTQwOTYJLyogYXMgY2Fubm90IGhhbmRs
ZSAxVUwgPDwgMTIgKi8KKyNkZWZpbmUgVEhSRUFEX1NJWkUgKCgxIDw8IENP
TkZJR19TVEFDS19TSVpFX1NISUZUKSAqIFBBR0VfU0laRSkKKworI2Vsc2UJ
LyogX19BU1NFTUJMWV9fICovCisKKyNkZWZpbmUgVEhSRUFEX1NJWkUgKCgx
IDw8IENPTkZJR19TVEFDS19TSVpFX1NISUZUKSAqIFBBR0VfU0laRSkKKyNk
ZWZpbmUgYWxsb2NfdGFza19zdHJ1Y3QoKSBcCisgICgoc3RydWN0IHRhc2tf
c3RydWN0ICopIF9fZ2V0X2ZyZWVfcGFnZXMoR0ZQX0tFUk5FTCxDT05GSUdf
U1RBQ0tfU0laRV9TSElGVCkpCisKKyNkZWZpbmUgZnJlZV90YXNrX3N0cnVj
dChwKSBcCisgIGZyZWVfcGFnZXMoKHVuc2lnbmVkIGxvbmcpIChwKSwgQ09O
RklHX1NUQUNLX1NJWkVfU0hJRlQpCisKIHN0cnVjdCB0YXNrX3N0cnVjdDsK
IAogc3RhdGljIGlubGluZSBzdHJ1Y3QgdGFza19zdHJ1Y3QgKiBnZXRfY3Vy
cmVudCh2b2lkKQogewogCXN0cnVjdCB0YXNrX3N0cnVjdCAqY3VycmVudDsK
LQlfX2FzbV9fKCJhbmRsICUlZXNwLCUwOyAiOiI9ciIgKGN1cnJlbnQpIDog
IjAiICh+ODE5MVVMKSk7CisJX19hc21fXygiYW5kbCAlJWVzcCwlMDsgIjoi
PXIiIChjdXJyZW50KSA6ICIwIiAofihUSFJFQURfU0laRSAtIDEpKSk7CiAJ
cmV0dXJuIGN1cnJlbnQ7Ci0gfQotIAorfQorCiAjZGVmaW5lIGN1cnJlbnQg
Z2V0X2N1cnJlbnQoKQogCisjZW5kaWYgLyogX19BU1NFTUJMWV9fICovCisK
KyNkZWZpbmUgR0VUX0NVUlJFTlQocmVnKSBcCisgICAgICAgIG1vdmwgJC1U
SFJFQURfU0laRSwgKHJlZyk7IFwKKyAgICAgICAgYW5kbCAlZXNwLCAocmVn
KQorCisKICNlbmRpZiAvKiAhKF9JMzg2X0NVUlJFTlRfSCkgKi8KKyNkZWZp
bmUgVEhSRUFEX1NJWkUgKCgxIDw8IENPTkZJR19TVEFDS19TSVpFX1NISUZU
KSAqIFBBR0VfU0laRSkKZGlmZiAtTmF1ciBsaW51eC9pbmNsdWRlL2FzbS1p
Mzg2L2h3X2lycS5oIGxpbnV4LW5ldy9pbmNsdWRlL2FzbS1pMzg2L2h3X2ly
cS5oCi0tLSBsaW51eC9pbmNsdWRlL2FzbS1pMzg2L2h3X2lycS5oCVRodSBO
b3YgMjIgMTI6NDY6MTggMjAwMQorKysgbGludXgtbmV3L2luY2x1ZGUvYXNt
LWkzODYvaHdfaXJxLmgJV2VkIEZlYiAgNiAyMDowNTo1NSAyMDAyCkBAIC0x
NSw2ICsxNSw3IEBACiAjaW5jbHVkZSA8bGludXgvY29uZmlnLmg+CiAjaW5j
bHVkZSA8YXNtL2F0b21pYy5oPgogI2luY2x1ZGUgPGFzbS9pcnEuaD4KKyNp
bmNsdWRlIDxhc20vY3VycmVudC5oPgogCiAvKgogICogSURUIHZlY3RvcnMg
dXNhYmxlIGZvciBleHRlcm5hbCBpbnRlcnJ1cHQgc291cmNlcyBzdGFydApA
QCAtMTEzLDEwICsxMTQsNiBAQAogI2RlZmluZSBJUlFfTkFNRTIobnIpIG5y
IyNfaW50ZXJydXB0KHZvaWQpCiAjZGVmaW5lIElSUV9OQU1FKG5yKSBJUlFf
TkFNRTIoSVJRIyNucikKIAotI2RlZmluZSBHRVRfQ1VSUkVOVCBcCi0JIm1v
dmwgJWVzcCwgJWVieFxuXHQiIFwKLQkiYW5kbCAkLTgxOTIsICVlYnhcblx0
IgotCiAvKgogICoJU01QIGhhcyBhIGZldyBzcGVjaWFsIGludGVycnVwdHMg
Zm9yIElQSSBtZXNzYWdlcwogICovCmRpZmYgLU5hdXIgbGludXgvaW5jbHVk
ZS9hc20taTM4Ni9wcm9jZXNzb3IuaCBsaW51eC1uZXcvaW5jbHVkZS9hc20t
aTM4Ni9wcm9jZXNzb3IuaAotLS0gbGludXgvaW5jbHVkZS9hc20taTM4Ni9w
cm9jZXNzb3IuaAlUaHUgTm92IDIyIDEyOjQ2OjE5IDIwMDEKKysrIGxpbnV4
LW5ldy9pbmNsdWRlL2FzbS1pMzg2L3Byb2Nlc3Nvci5oCVdlZCBGZWIgIDYg
MjA6MDU6NTUgMjAwMgpAQCAtMTQsNiArMTQsNyBAQAogI2luY2x1ZGUgPGFz
bS90eXBlcy5oPgogI2luY2x1ZGUgPGFzbS9zaWdjb250ZXh0Lmg+CiAjaW5j
bHVkZSA8YXNtL2NwdWZlYXR1cmUuaD4KKyNpbmNsdWRlIDxhc20vY3VycmVu
dC5oPgogI2luY2x1ZGUgPGxpbnV4L2NhY2hlLmg+CiAjaW5jbHVkZSA8bGlu
dXgvY29uZmlnLmg+CiAjaW5jbHVkZSA8bGludXgvdGhyZWFkcy5oPgpAQCAt
NDQ3LDkgKzQ0OCw2IEBACiAjZGVmaW5lIEtTVEtfRUlQKHRzaykJKCgodW5z
aWduZWQgbG9uZyAqKSg0MDk2Kyh1bnNpZ25lZCBsb25nKSh0c2spKSlbMTAx
OV0pCiAjZGVmaW5lIEtTVEtfRVNQKHRzaykJKCgodW5zaWduZWQgbG9uZyAq
KSg0MDk2Kyh1bnNpZ25lZCBsb25nKSh0c2spKSlbMTAyMl0pCiAKLSNkZWZp
bmUgVEhSRUFEX1NJWkUgKDIqUEFHRV9TSVpFKQotI2RlZmluZSBhbGxvY190
YXNrX3N0cnVjdCgpICgoc3RydWN0IHRhc2tfc3RydWN0ICopIF9fZ2V0X2Zy
ZWVfcGFnZXMoR0ZQX0tFUk5FTCwxKSkKLSNkZWZpbmUgZnJlZV90YXNrX3N0
cnVjdChwKSBmcmVlX3BhZ2VzKCh1bnNpZ25lZCBsb25nKSAocCksIDEpCiAj
ZGVmaW5lIGdldF90YXNrX3N0cnVjdCh0c2spICAgICAgYXRvbWljX2luYygm
dmlydF90b19wYWdlKHRzayktPmNvdW50KQogCiAjZGVmaW5lIGluaXRfdGFz
awkoaW5pdF90YXNrX3VuaW9uLnRhc2spCg==


------=_NextPart_000_3793_582a_6e6a--
