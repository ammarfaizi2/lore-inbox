Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVIADd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVIADd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 23:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbVIADd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 23:33:28 -0400
Received: from [210.76.114.20] ([210.76.114.20]:55216 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S965066AbVIADd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 23:33:27 -0400
Message-ID: <4316769C.5090303@ccoss.com.cn>
Date: Thu, 01 Sep 2005 11:33:48 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Question] [Patch] How get instruction pointer of user space ???
References: <20050831124318.98086.qmail@web15008.mail.cnb.yahoo.com>
In-Reply-To: <20050831124318.98086.qmail@web15008.mail.cnb.yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------080601030203060202060404"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080601030203060202060404
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

Hi:

Thanks to Yingchao Zhou and Gaurav Dhiman first, for your answers.

I get it now! but it look we must update knownledge about this.

I read copy_thread() in arch/i386/kernel/process.c, the code piece of
this function are:


/* childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long)
p->thread_info)) - 1;
** /*
* The below -8 is to reserve 8 bytes on top of the ring0 stack.
* This is necessary to guarantee that the entire "struct pt_regs"
* is accessable even if the CPU haven't stored the SS/ESP registers
* on the stack (interrupt gate does not save these registers
* when switching to the same priv ring).
* Therefore beware: accessing the xss/esp fields of the
* "struct pt_regs" is possible, but they may contain the
* completely wrong values.
*/
childregs = (struct pt_regs *) ((unsigned long) childregs - 8);
*childregs = *regs;
*/

Oh, clear all secrets on it now! that comment is very readable.

OK, see my code to do experiement in do_fork() :

/*
static void
my_check_regs_with_offset(struct pt_regs *orig_regs)
{
struct thread_info *thread_info;
struct pt_regs *pt_regs;
unsigned long *stack_bottom;

thread_info = current_thread_info();
pt_regs = (struct pt_regs*)((unsigned long)thread_info+THREAD_SIZE-8);
pt_regs--;
stack_bottom = 8+(unsigned long)(pt_regs+1),
printk("\tbottom=%p, pt_regs = %p eip=%p\n",
stack_bottom,
pt_regs,
pt_regs->eip);

}

static void
my_check_regs_without_offset(struct pt_regs *orig_regs)
{
struct thread_info *thread_info;
struct pt_regs *pt_regs;
unsigned long *stack_bottom;

thread_info = current_thread_info();
pt_regs = (struct pt_regs*)((unsigned long)thread_info+THREAD_SIZE);
pt_regs--;
stack_bottom = (unsigned long)(pt_regs+1),
printk("\tbottom=%p, pt_regs = %p eip=%p\n",
stack_bottom,
pt_regs,
pt_regs->eip);
}*/

in do_fork() function, I insert code:

/* if (current->tgid && (current->tgid % 10 == 0) && get_task_mm(current)) {
unsigned long stack_bottom;
struct thread_info *thread_info;
struct mm_struct *mm;

printk("withOUT offset: ");
my_check_regs_without_offset(regs);

printk("with offset: ");
my_check_regs_with_offset(regs);

printk("sizeof(struct pt_regs) = %d THREAD_SIZE=%x ",
sizeof(struct pt_regs),
THREAD_SIZE);
thread_info = current_thread_info();
printk("thread_info=%p\n", thread_info);

printk("In kernel words:");
printk(" KSTK_TOP(task)=%x\n", KSTK_TOP(current));
printk(" task_pt_regs(task)=%x\n", task_pt_regs(current));
printk(" KSTK_EIP(task)=%x\n", KSTK_EIP(current));

printk("In fact:\n");
stack_bottom = 8+(unsigned long)(regs+1);
printk(" bottom=%p, pt_regs=%p, eip=%p\n",stack_bottom,regs,regs->eip);
mm = get_task_mm(current);
printk(" code address range: [%x-%x]\n", mm->start_code, mm->end_code);
printk("\n");

}
*/
the printk() output:


*withOUT offset: bottom=dac16000, pt_regs = dac15fc4 eip=00000282
with offset: bottom=dac16000, pt_regs = dac15fbc eip=0012d402
sizeof(struct pt_regs) = 60 THREAD_SIZE=2000 thread_info=dac14000
In kernel words: KSTK_TOP(task)=deebb020
task_pt_regs(task)=dac15fc4
KSTK_EIP(task)=282
In fact:
bottom=dac16000, pt_regs=dac15fbc, eip=0012d402
code address range: [8047000-80d1b80]

withOUT offset: bottom=dac16000, pt_regs = dac15fc4 eip=00000282
with offset: bottom=dac16000, pt_regs = dac15fbc eip=00c1f402
sizeof(struct pt_regs) = 60 THREAD_SIZE=2000 thread_info=dac14000
In kernel words: KSTK_TOP(task)=deebb020
task_pt_regs(task)=dac15fc4
KSTK_EIP(task)=282
In fact:
bottom=dac16000, pt_regs=dac15fbc, eip=00c1f402
code address range: [8047000-80d1b80]

withOUT offset: bottom=dac16000, pt_regs = dac15fc4 eip=00000282
with offset: bottom=dac16000, pt_regs = dac15fbc eip=00c1f402
sizeof(struct pt_regs) = 60 THREAD_SIZE=2000 thread_info=dac14000
In kernel words: KSTK_TOP(task)=deebb020
task_pt_regs(task)=dac15fc4
KSTK_EIP(task)=282
In fact:
bottom=dac16000, pt_regs=dac15fbc, eip=00c1f402
code address range: [8047000-80d1b80]

* It's look there have one anonymous hero update copy_thread(), but
he/she forget to update
macro task_pt_regs(task). After browse LXR, I found 2.6.11 have not this
change yet.

the copy_thread() in 2.6.12.3 and 2.6.13 include this "dummy" offset, at
least.
the attachment is a patch for that.

Is right my words?

thanks again.

sailor












--------------080601030203060202060404
Content-Type: text/x-patch;
 name="2.6.13.dummy_offset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.13.dummy_offset.patch"

--- linux-2.6.13/include/asm-i386/processor.h.orig	2005-09-01 11:19:22.000000000 +0800
+++ linux-2.6.13/include/asm-i386/processor.h	2005-09-01 11:26:04.000000000 +0800
@@ -538,11 +538,13 @@
        unsigned long *__ptr = (unsigned long *)(info);                 \
        (unsigned long)(&__ptr[THREAD_SIZE_LONGS]);                     \
 })
-
+/*
+ * subtract 8 here, to skip dummy offset, see copy_thread() for detailed comment.
+ */
 #define task_pt_regs(task)                                             \
 ({                                                                     \
        struct pt_regs *__regs__;                                       \
-       __regs__ = (struct pt_regs *)KSTK_TOP((task)->thread_info);     \
+       __regs__ = (struct pt_regs *)(KSTK_TOP((task)->thread_info)-8); \
        __regs__ - 1;                                                   \
 })
 

--------------080601030203060202060404--
