Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUJGSZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUJGSZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUJGSWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:22:52 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:59735 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267585AbUJGSTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:19:36 -0400
Subject: strange AMD x Intel Behaviour in 2.4.26
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 07 Oct 2004 15:15:36 -0300
Message-Id: <1097172936.3832.1.camel@lfs.barra.bali>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

  I wrote a syscall, similar to ptrace. Its purpose is to
count the number of user mode instructions and the number of
syscalls invoked by a program. The reason why I did not use ptrace,
is that I do not want the overhead of child -> kernel-> tracer on every
instruction, since I just want to count them.
  
  The code is producing correct results (same as ptrace, I mean)
but is RUNNING FASTER on a 500Mhz AMD K6-2 than on a 2.6Ghz HT
Pentium 4 !!!!  The monitored code runs faster on P4 if not being
monitored, as expected.

   Both machines are using a stock Slackware 10 distribution, but
the kernel modification. I append the patch AND the program using the
syscall to monitor its child.

   Any clues?

TIA
Fabiano


diff -ruN linux-2.4.26/Makefile linux-2.4.26-syscounter/Makefile
--- linux-2.4.26/Makefile 2004-04-14 10:05:41.000000000 -0300
+++ linux-2.4.26-syscounter/Makefile 2004-10-07 10:33:43.000000000 -0300
@@ -1,7 +1,7 @@
VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 26
-EXTRAVERSION =
+EXTRAVERSION =-syscounter

KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

diff -ruN linux-2.4.26/arch/i386/kernel/Makefile linux-2.4.26-
syscounter/arch/i386/kernel/Makefile
--- linux-2.4.26/arch/i386/kernel/Makefile 2003-11-28 16:26:19.000000000
-0200
+++ linux-2.4.26-syscounter/arch/i386/kernel/Makefile 2004-10-07
10:33:32.000000000 -0300
@@ -18,7 +18,7 @@

obj-y := process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
- pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o
+ pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o syscounter.o


ifdef CONFIG_PCI
diff -ruN linux-2.4.26/arch/i386/kernel/entry.S linux-2.4.26-
syscounter/arch/i386/kernel/entry.S
--- linux-2.4.26/arch/i386/kernel/entry.S 2003-06-13 11:51:29.000000000
-0300
+++ linux-2.4.26-syscounter/arch/i386/kernel/entry.S 2004-10-07
11:25:37.000000000 -0300
@@ -69,6 +69,9 @@
NT_MASK = 0x00004000
VM_MASK = 0x00020000

+PAGE_OFFSET = 0xC0000000
+PID_OFFSET = 0x7C          # pid offset into  task structure
+
/*
  * these are offsets into the task-struct.
  */
@@ -199,9 +202,20 @@
  * less clear than it otherwise should be.
  */

-ENTRY(system_call)
- pushl %eax # save orig_eax
+ENTRY(system_call) 
+     pushl %eax # save orig_eax
SAVE_ALL
+ cmp $-1, tracedpid # is someone being traced?
+ je original_syscall
+ GET_CURRENT(%ebx)
+ movl %ebx, taskstruct           # verifying pid
+ movl taskstruct, %ebx  
+ movl PID_OFFSET(%ebx), %ebx
+ cmp %ebx, tracedpid         # is this process being traced ?
+ jne original_syscall # if not, go on!         
+        addl    $1, syscalls # one more monitored syscall
+        adcl    $0, syscalls+4
+original_syscall:
GET_CURRENT(%ebx)
testb $0x02,tsk_ptrace(%ebx) # PT_TRACESYS
jne tracesys
@@ -325,6 +339,30 @@
jmp ret_from_exception

ENTRY(debug)
+ pushl %ebx                      
+        # the stack layout is now
+        #   eflags
+        #   cs    <-- 0x08 (%esp)
+        #   eip   <-- 0x04 (%esp)
+        #   ebx   <-- %esp      
+ GET_CURRENT(%ebx)
+ movl %ebx, taskstruct           
+ movl taskstruct, %ebx  
+ movl PID_OFFSET(%ebx), %ebx
+ cmp %ebx, tracedpid         # is this process being traced ?
+        jne original_debug 
+        movl 0x04(%esp), %ebx           # ebx = eip
+        cmp %ebx, PAGE_OFFSET           # was the trap generated in
userland ? (includes libc code)
+        jl count_user
+        popl %ebx
+        iret # not calling original if monitoring this process
+count_user:
+        addl    $1, userinstrexec
+        adcl    $0, userinstrexec+4
+        popl %ebx
+        iret
+original_debug:                    
+        popl %ebx
pushl $0
pushl $ SYMBOL_NAME(do_debug)
jmp error_code
@@ -663,6 +701,7 @@
.long SYMBOL_NAME(sys_ni_syscall) /* sys_epoll_wait */
  .long SYMBOL_NAME(sys_ni_syscall) /* sys_remap_file_pages */
  .long SYMBOL_NAME(sys_ni_syscall) /* sys_set_tid_address */
+ .long SYMBOL_NAME(sys_counter) /* 259 */

.rept NR_syscalls-(.-sys_call_table)/4
.long SYMBOL_NAME(sys_ni_syscall)
diff -ruN linux-2.4.26/arch/i386/kernel/syscounter.c linux-2.4.26-
syscounter/arch/i386/kernel/syscounter.c
--- linux-2.4.26/arch/i386/kernel/syscounter.c 1969-12-31
21:00:00.000000000 -0300
+++ linux-2.4.26-syscounter/arch/i386/kernel/syscounter.c 2004-10-07
11:34:30.000000000 -0300
@@ -0,0 +1,114 @@
+#include <linux/syscounter.h>
+
+volatile long long userinstrexec = 0;
+volatile long long syscalls = 0;
+struct task_struct *taskstruct = NULL;
+pid_t tracedpid = -1;
+
+
+static inline int get_stack_long(struct task_struct *task, int offset)
{
+
+         unsigned char *stack;
+
+         stack = (unsigned char *)task->thread.esp0;
+         stack += offset;
+         return (*((int *)stack));
+}
+
+static inline int put_stack_long(struct task_struct *task, int offset,
unsigned long data) {
+
+         unsigned char * stack;
+
+         stack = (unsigned char *) task->thread.esp0;
+         stack += offset;
+         *(unsigned long *) stack = data;
+         return 0;
+
+}
+
+/* syscall that will be used to count instructions */
+asmlinkage int sys_counter(int pid, int action, void* retval) {
+
+ struct task_struct *tsk = NULL; 
+ int ret;       
+
+ lock_kernel();
+        ret = 0;
+
+ if (action == GET_USER) {
+                if (retval ==  NULL) 
+ ret = INVALIDPOINTER; 
+                else {
+                if (copy_to_user(retval, (void *) &userinstrexec,
sizeof(long long)) != 0)
+                         ret = BADUSERLANDCOPY;
+                }
+ goto out;
+        }
+        else if (action == GET_SYSCALLS) {
+                if (retval ==  NULL) 
+ ret = INVALIDPOINTER;
+                else {
+    if (copy_to_user(retval, (void *) &syscalls, sizeof(long long)) !=
0)
+                        ret = BADUSERLANDCOPY;
+ } 
+ goto out;
+        }
+ else if (action == STOP) {
+ tracedpid = -1; 
+ goto out; 
+ }
+ else if (action == RESET) {
+ tracedpid = -1;
+ userinstrexec=0;
+                syscalls = 0;
+ goto out;
+ }
+ else if (action == START) {
+
+ if (tracedpid != -1) {
+ ret = TRACEINPROGRESS;
+ }
+ else {
+ long tmp;
+ 
+ read_lock(&tasklist_lock);
+ tsk = find_task_by_pid(pid);
+ read_unlock(&tasklist_lock);
+
+ if (tsk) {
+ 
+ get_task_struct(tsk);
+
+ tracedpid = pid; 
+ userinstrexec = 0;
+ syscalls = 0;
+ 
+ // ok, now we set up the trap bit in child's stack
+ tmp = get_stack_long(tsk, EFL_OFFSET) | TF_FLAG;
+ put_stack_long(tsk, EFL_OFFSET, tmp);
+
+ // and make it runnable
+ wake_up_process(tsk);
+ 
+ free_task_struct(tsk);
+ 
+ 
+ }
+ else { 
+ ret = NOSUCHPROCESS;
+ }
+
+ }
+ goto out;
+
+ }
+ else {
+ ret = UNKNOWNOPERATION;
+ goto out;
+ }
+
+out:
+ unlock_kernel();
+ return ret;
+}
+
diff -ruN linux-2.4.26/include/asm-i386/unistd.h linux-2.4.26-
syscounter/include/asm-i386/unistd.h
--- linux-2.4.26/include/asm-i386/unistd.h 2002-11-28 21:53:15.000000000
-0200
+++ linux-2.4.26-syscounter/include/asm-i386/unistd.h 2004-10-07
10:34:22.000000000 -0300
@@ -257,6 +257,7 @@
#define __NR_alloc_hugepages 250
#define __NR_free_hugepages 251
#define __NR_exit_group 252
+#define __NR_counter            259

/* user-visible error numbers are in the range -1 - -124: see <asm-
i386/errno.h> */

diff -ruN linux-2.4.26/include/linux/syscounter.h linux-2.4.26-
syscounter/include/linux/syscounter.h
--- linux-2.4.26/include/linux/syscounter.h 1969-12-31
21:00:00.000000000 -0300
+++ linux-2.4.26-syscounter/include/linux/syscounter.h 2004-10-07
11:32:15.000000000 -0300
@@ -0,0 +1,42 @@
+#ifndef __SYSCOUNTER_H
+#define __SYSCOUNTER_H
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <asm/uaccess.h>
+
+/* debug (trap) bit in eflags */
+#define TF_FLAG         0x00000100
+/* from ptrace.c */
+#define EFL 14
+#define EFL_OFFSET ((EFL-2)*4-sizeof(struct pt_regs)) 
+
+
+
+/* operations */
+#define START     0
+#define STOP       1
+#define GET_SYS     2
+#define GET_USER     3
+#define RESET     4
+#define GET_SYSCALLS     5
+
+
+/* error codes of new syscalls */
+//#define NOTRACEDPROCESS  -1
+#define NOSUCHPROCESS -2
+#define TRACEINPROGRESS  -3
+#define UNKNOWNOPERATION -4
+#define INVALIDACTION -5
+#define PROCESSTRACED -6 //process already traced
+#define PROCESSNOTTRACED -7
+#define INVALIDPOINTER   -8
+#define BADUSERLANDCOPY -9
+
+
+
+
+#endif




Now the tracer:

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/ptrace.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/sem.h>
#include <sys/wait.h>
#include <assert.h>
#include "counter.h" 


int main(int argc, char **argv){

long long c=0;
int retval;
struct sched_param sched_p;
int child;

       

child = fork();

if (child == 0) {


// setting realtime priority
sched_p.sched_priority = sched_get_priority_max(SCHED_FIFO);
retval = sched_setscheduler (0, SCHED_RR, &sched_p);
if (retval < 0){
printf ("Error setting realtime policy\n");
}

// so that we gain control back after execv()
ptrace(PTRACE_TRACEME,0,0,0);

execv(argv[1],&argv[1]);



}
else {

waitpid(child,&retval,0);

//ok, execve returned
                c = 0;

// start our count engine
counter(child,START,NULL);

// calls ptrace so that we are notified again when the child finishes
ptrace(PTRACE_CONT,child,0,0);
waitpid(child,&retval,0);

// ok, child finished. We stop the engine
                counter(0,STOP, NULL);

counter(0,GET_USER, (void *)&c);
                printf("\n[PARENT] User instructions = %llu\n",c);

counter(0,GET_SYSCALLS, (void *)&c);
                printf("\n[PARENT] Syscalls: %llu\n",c);

counter(0,RESET,NULL);



}


return 0;

}







