Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbTF2DuN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 23:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbTF2DuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 23:50:13 -0400
Received: from hypatia.llnl.gov ([134.9.11.73]:38800 "EHLO hypatia.llnl.gov")
	by vger.kernel.org with ESMTP id S265546AbTF2Dt5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 23:49:57 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Dave Peterson <dsp@llnl.gov>
To: linux-kernel@vger.kernel.org
Subject: question regarding arch/i386/kernel/entry.S and stack/register usage
Date: Sat, 28 Jun 2003 21:04:06 -0700
User-Agent: KMail/1.4.1
Cc: dsp@llnl.gov
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306282104.06092.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experimenting with some code I wrote that checks for kernel
stack overflows and I have been observing some rather odd behavior.  I
am working with a 2.4.18 kernel and my code changes are as follows:

    1.  I added a field to the end of the task_struct
        as follows:

            #define STACK_RED_ZONE_SIZE 128

            struct task_struct {
                    ...
                    [ contents omitted for brevity ]
                    ...
                    uint32_t stack_red_zone[STACK_RED_ZONE_SIZE];
            }

    2.  I added the following function to kernel/sys.c:

            asmlinkage void check_stack_red_zone(void)
            {
                    int i;
                    uint32_t *red_zone;
                    char *stack;

                    red_zone = current->stack_red_zone;

                    for (i = 0; i < STACK_RED_ZONE_SIZE; i++) {
                            if (unlikely(red_zone[i] != STACK_RED_ZONE_VALUE))
                                    goto fail;
                    }

                    return;

            fail:
                    printk("kernel stack red zone corrupt\n");
                    printk("red zone contents:\n");

                    for (i = 0; i < STACK_RED_ZONE_SIZE; i++)
                            printk("0x%x ", red_zone[i]);

                    printk("\n");
                    stack = (char *) current;
                    stack += sizeof(struct task_struct);
                    SCAN_STACK((unsigned long *) stack); /* show stack trace */
                    panic("kernel stack overflow");
            }

    3.  I added some code that initializes the stack_red_zone field of the
        initial task at boot time.

    4.  I modified arch/i386/kernel/entry.S so that check_stack_red_zone()
        is called after each syscall or exception handler (but not interrupt
        handlers).  My code changes are shown by the diff appended to this
        message.  The only relevant changes are the ones that look like this:

            +#ifdef CONFIG_STACK_RED_ZONE
            +       call SYMBOL_NAME(check_stack_red_zone)
            +#endif

        All other code changes are unrelated.

With my code changes as described above, things work as expected most of the
time.  Occasionally when I boot my kernel, I observe the following:

    Real Time Clock Driver v1.10e
    block: 1024 slots per queue, batch=256
    Uniform Multi-Platform E-IDE driver Revision: 6.31
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    PIIX4: IDE controller on PCI bus 00 dev f9
    PCI: No IRQ known for interrupt pin A of device 00:1f.1. Probably buggy MP tab
    PIIX4: chipset revision 2
    PIIX4: not 100% native mode: will probe irqs later
    PIIX4: ATA-66/100 forced bit set (WARNING)!!
        ide0: BM-DMA at 0x3c40-0x3c47, BIOS settings: hda:DMA, hdb:pio
        ide1: BM-DMA at 0x3c48-0x3c4f, BIOS settings: hdc:pio, hdd:pio
    hda: C/H/S=0/0/0 from BIOS ignored
    hda: IC35L120AVVA07-0, ATA DISK drive
    Allocated IRQ 14 task f75de000
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    blk: queue c04777e4, I/O limit 4095Mb (mask 0xffffffff)
    blk: queue c04777e4, I/O limit 4095Mb (mask 0xffffffff)
    hda: lost interrupt
    hda: lost interrupt
    hda: lost interrupt
    hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(100
    hda: lost interrupt

    [ "lost interrupt" messages continue... ]

I find this surprising because AFAICS my changes to entry.S affect only
syscall and exception handlers, not interrupt handlers.  Is there anything that
looks clearly wrong with my code changes?  Do my changes to entry.S violate some
assumption I am unaware of regarding the layout of stuff on the kernel stack or
register contents?

-Dave Peterson
 dsp@llnl.gov



***** start of diff *********************************************************
--- entry.S.2_4_18      Sat Jun 28 19:55:26 2003
+++ entry.S.modified    Sat Jun 28 19:55:58 2003
@@ -63,7 +63,9 @@
 OLDSS          = 0x38

 CF_MASK                = 0x00000001
+TF_MASK                = 0x00000100
 IF_MASK                = 0x00000200
+DF_MASK                = 0x00000400
 NT_MASK                = 0x00004000
 VM_MASK                = 0x00020000

@@ -77,7 +79,7 @@
 exec_domain    = 16
 need_resched   = 20
 tsk_ptrace     = 24
-processor      = 52
+cpu            = 32

 ENOSYS = 38

@@ -140,6 +142,9 @@
        movl CS(%esp),%edx      # this is eip..
        movl EFLAGS(%esp),%ecx  # and this is cs..
        movl %eax,EFLAGS(%esp)  #
+       andl $~(NT_MASK|TF_MASK|DF_MASK), %eax
+       pushl %eax
+       popfl
        movl %edx,EIP(%esp)     # Now we move them to their "normal" places
        movl %ecx,CS(%esp)      #
        movl %esp,%ebx
@@ -149,6 +154,9 @@
        movl 4(%edx),%edx       # Get the lcall7 handler for the domain
        pushl $0x7
        call *%edx
+#ifdef CONFIG_STACK_RED_ZONE
+       call SYMBOL_NAME(check_stack_red_zone)
+#endif
        addl $4, %esp
        popl %eax
        jmp ret_from_sys_call
@@ -161,6 +169,9 @@
        movl CS(%esp),%edx      # this is eip..
        movl EFLAGS(%esp),%ecx  # and this is cs..
        movl %eax,EFLAGS(%esp)  #
+       andl $~(NT_MASK|TF_MASK|DF_MASK), %eax
+       pushl %eax
+       popfl
        movl %edx,EIP(%esp)     # Now we move them to their "normal" places
        movl %ecx,CS(%esp)      #
        movl %esp,%ebx
@@ -170,15 +181,19 @@
        movl 4(%edx),%edx       # Get the lcall7 handler for the domain
        pushl $0x27
        call *%edx
+#ifdef CONFIG_STACK_RED_ZONE
+       call SYMBOL_NAME(check_stack_red_zone)
+#endif
        addl $4, %esp
        popl %eax
        jmp ret_from_sys_call

-
 ENTRY(ret_from_fork)
+#if CONFIG_SMP
        pushl %ebx
        call SYMBOL_NAME(schedule_tail)
        addl $4, %esp
+#endif
        GET_CURRENT(%ebx)
        testb $0x02,tsk_ptrace(%ebx)    # PT_TRACESYS
        jne tracesys_exit
@@ -201,6 +216,9 @@
        jae badsys
        call *SYMBOL_NAME(sys_call_table)(,%eax,4)
        movl %eax,EAX(%esp)             # save the return value
+#ifdef CONFIG_STACK_RED_ZONE
+       call SYMBOL_NAME(check_stack_red_zone)
+#endif
 ENTRY(ret_from_sys_call)
        cli                             # need_resched and signals atomic test
        cmpl $0,need_resched(%ebx)
@@ -232,13 +250,22 @@
 tracesys:
        movl $-ENOSYS,EAX(%esp)
        call SYMBOL_NAME(syscall_trace)
+#ifdef CONFIG_STACK_RED_ZONE
+       call SYMBOL_NAME(check_stack_red_zone)
+#endif
        movl ORIG_EAX(%esp),%eax
        cmpl $(NR_syscalls),%eax
        jae tracesys_exit
        call *SYMBOL_NAME(sys_call_table)(,%eax,4)
        movl %eax,EAX(%esp)             # save the return value
+#ifdef CONFIG_STACK_RED_ZONE
+       call SYMBOL_NAME(check_stack_red_zone)
+#endif
 tracesys_exit:
        call SYMBOL_NAME(syscall_trace)
+#ifdef CONFIG_STACK_RED_ZONE
+       call SYMBOL_NAME(check_stack_red_zone)
+#endif
        jmp ret_from_sys_call
 badsys:
        movl $-ENOSYS,EAX(%esp)
@@ -288,6 +315,9 @@
        movl %edx,%es
        GET_CURRENT(%ebx)
        call *%edi
+#ifdef CONFIG_STACK_RED_ZONE
+       call SYMBOL_NAME(check_stack_red_zone)
+#endif
        addl $8,%esp
        jmp ret_from_exception

@@ -309,10 +339,16 @@
        testl $0x4,%eax                 # EM (math emulation bit)
        jne device_not_available_emulate
        call SYMBOL_NAME(math_state_restore)
+#ifdef CONFIG_STACK_RED_ZONE
+       call SYMBOL_NAME(check_stack_red_zone)
+#endif
        jmp ret_from_exception
 device_not_available_emulate:
        pushl $0                # temporary storage for ORIG_EIP
        call  SYMBOL_NAME(math_emulate)
+#ifdef CONFIG_STACK_RED_ZONE
+       call SYMBOL_NAME(check_stack_red_zone)
+#endif
        addl $4,%esp
        jmp ret_from_exception

@@ -584,8 +620,8 @@
        .long SYMBOL_NAME(sys_capset)           /* 185 */
        .long SYMBOL_NAME(sys_sigaltstack)
        .long SYMBOL_NAME(sys_sendfile)
-       .long SYMBOL_NAME(sys_ni_syscall)               /* streams1 */
-       .long SYMBOL_NAME(sys_ni_syscall)               /* streams2 */
+       .long SYMBOL_NAME(sys_getpmsg)          /* streams1 */
+       .long SYMBOL_NAME(sys_putpmsg)          /* streams2 */
        .long SYMBOL_NAME(sys_vfork)            /* 190 */
        .long SYMBOL_NAME(sys_getrlimit)
        .long SYMBOL_NAME(sys_mmap2)
@@ -618,7 +654,15 @@
        .long SYMBOL_NAME(sys_madvise)
        .long SYMBOL_NAME(sys_getdents64)       /* 220 */
        .long SYMBOL_NAME(sys_fcntl64)
-       .long SYMBOL_NAME(sys_ni_syscall)       /* reserved for TUX */
+#ifdef CONFIG_TUX
+       .long SYMBOL_NAME(__sys_tux)
+#else
+# ifdef CONFIG_TUX_MODULE
+       .long SYMBOL_NAME(sys_tux)
+# else
+       .long SYMBOL_NAME(sys_ni_syscall)
+# endif
+#endif
        .long SYMBOL_NAME(sys_ni_syscall)       /* Reserved for Security */
        .long SYMBOL_NAME(sys_gettid)
        .long SYMBOL_NAME(sys_readahead)        /* 225 */
@@ -634,6 +678,13 @@
        .long SYMBOL_NAME(sys_ni_syscall)       /* 235 reserved for removexattr */
        .long SYMBOL_NAME(sys_ni_syscall)       /* reserved for lremovexattr */
        .long SYMBOL_NAME(sys_ni_syscall)       /* reserved for fremovexattr */
+       .long SYMBOL_NAME(sys_tkill)
+       .long SYMBOL_NAME(sys_sendfile64)       /* reserved for sendfile64 */
+       .long SYMBOL_NAME(sys_ni_syscall)       /* 240 reserved for futex */
+       .long SYMBOL_NAME(sys_sched_setaffinity)
+       .long SYMBOL_NAME(sys_sched_getaffinity)
+       .long SYMBOL_NAME(sys_statfs64)
+       .long SYMBOL_NAME(sys_fstatfs64)

        .rept NR_syscalls-(.-sys_call_table)/4
                .long SYMBOL_NAME(sys_ni_syscall)

***** end of diff ***********************************************************
