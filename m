Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbRHBHCZ>; Thu, 2 Aug 2001 03:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268834AbRHBHCK>; Thu, 2 Aug 2001 03:02:10 -0400
Received: from 63-216-69-197.sdsl.cais.net ([63.216.69.197]:43526 "EHLO
	vyger.freesoft.org") by vger.kernel.org with ESMTP
	id <S268832AbRHBHBs>; Thu, 2 Aug 2001 03:01:48 -0400
Message-ID: <3B68FADE.DBABBE85@freesoft.org>
Date: Thu, 02 Aug 2001 03:01:50 -0400
From: Brent Baccala <baccala@freesoft.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel gdb for intel
Content-Type: multipart/mixed;
 boundary="------------FD874D4518F698B1F5858707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FD874D4518F698B1F5858707
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi -

I've been trying to track down a problem I've had with a USB CD-Burner
locking up.  In the course of my investigations I ported the i386 remote
gdb stuff to the Linux kernel, because I'm used to using gdb on the
kernel (it works on SPARC and PPC) instead of trying to read oopses.

For those not familiar with the remote debug feature, you use two
computers, connected together with a null modem serial line.  One
computer has a complete Linux kernel tree on it, compiled with debugging
information (-g); the other computer is the one running the kernel under
test.  You can breakpoint and halt the kernel, which puts it in a tight
little loop reading packets (gdb, not IP) from the serial port and
responding to the debugger.  You get almost all the features you're used
to with gdb - stack backtraces, single stepping, source-based variable
names, intelligent structure decodes, etc.

Anyway, I'm attaching the patch (against 2.4.6).  After installing, a
menu option appears under "Kernel hacking" for remote debugging. 
Recompile the whole kernel (make clean) so that it compiles with
debugging info.  Then supply the "kgdb" switch to the kernel command
line, make sure the debugging computer is attached on COM1 (or whatever
you want to call it), and run "target remote /dev/whatever" on the
debugging computer.  See arch/i386/kernel/stub-i386.c for more info.

Known problems:

- only runs on COM1.  Shouldn't be hard to fix this

- doesn't switch stacks, so you can't use gdb's "call" feature, which
scribbles on the stack.  Other than that, no problem.

- doesn't support SMP, since I don't have an Intel SMP box.  I'd guess
what you'd want it to do is an smp_call_function that would halt all the
processors and put them into some tight little loop while gdb fiddles
things.  ideas?

- doesn't support any concept of multiple tasks/threads, though GDB can
do this with it's remote protocol, and I've discovered that it'd be
really nice to switch to another task within the kernel.  Lacking this,
you have to do stack backtraces by hand for other tasks.

- we have to compile Linux with -O2 to get inline functions, and this
can confuse GDB sometimes.  When in doubt, study the assembly.

And it still sometimes does some strange things, so might need some
tweaks here and there, but works 95% of the time.  Please try it out and
let me know what you think.


-- 
                                        -bwb

                                        Brent Baccala
                                        baccala@freesoft.org

==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:
   
mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================
--------------FD874D4518F698B1F5858707
Content-Type: text/plain; charset=us-ascii;
 name="linux-kgdb-diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-kgdb-diff"

diff -Nru linux-2.4.6-dist/Makefile linux-2.4.6-kgdb/Makefile
--- linux-2.4.6-dist/Makefile	Wed Jul 25 13:53:08 2001
+++ linux-2.4.6-kgdb/Makefile	Wed Jul 25 15:14:17 2001
@@ -87,8 +87,13 @@
 
 CPPFLAGS := -D__KERNEL__ -I$(HPATH)
 
+ifdef CONFIG_REMOTE_DEBUG
+CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -g
+else
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
           -fomit-frame-pointer -fno-strict-aliasing
+endif
+
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
 #
diff -Nru linux-2.4.6-dist/arch/i386/config.in linux-2.4.6-kgdb/arch/i386/config.in
--- linux-2.4.6-dist/arch/i386/config.in	Wed Jul 25 13:53:08 2001
+++ linux-2.4.6-kgdb/arch/i386/config.in	Wed Jul 25 14:00:34 2001
@@ -388,4 +388,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Remote kernel debugger (gdb)' CONFIG_REMOTE_DEBUG
 endmenu
diff -Nru linux-2.4.6-dist/arch/i386/kernel/Makefile linux-2.4.6-kgdb/arch/i386/kernel/Makefile
--- linux-2.4.6-dist/arch/i386/kernel/Makefile	Fri Dec 29 17:35:47 2000
+++ linux-2.4.6-kgdb/arch/i386/kernel/Makefile	Wed Jul 25 14:00:34 2001
@@ -40,5 +40,6 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
+obj-$(CONFIG_REMOTE_DEBUG)	+= i386-stub.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux-2.4.6-dist/arch/i386/kernel/entry.S linux-2.4.6-kgdb/arch/i386/kernel/entry.S
--- linux-2.4.6-dist/arch/i386/kernel/entry.S	Wed Jul 25 13:53:08 2001
+++ linux-2.4.6-kgdb/arch/i386/kernel/entry.S	Wed Aug  1 18:43:36 2001
@@ -64,6 +64,7 @@
 OLDSS		= 0x38
 
 CF_MASK		= 0x00000001
+TF_MASK		= 0x00000100
 IF_MASK		= 0x00000200
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
@@ -317,25 +318,128 @@
 	addl $4,%esp
 	jmp ret_from_exception
 
+ENTRY(nmi)
+	pushl %eax
+	SAVE_ALL
+	movl %esp,%edx
+	pushl $0
+	pushl %edx
+	call SYMBOL_NAME(do_nmi)
+	addl $8,%esp
+	RESTORE_ALL
+
+#ifdef CONFIG_REMOTE_DEBUG
+
+#define DEBUGGER_SAVE_REGISTERS				\
+	movl %eax, SYMBOL_NAME(kgdb_registers)		\
+	movl %ecx, SYMBOL_NAME(kgdb_registers)+4	\
+	movl %edx, SYMBOL_NAME(kgdb_registers)+8	\
+	movl %ebx, SYMBOL_NAME(kgdb_registers)+12	\
+	movl %ebp, SYMBOL_NAME(kgdb_registers)+20	\
+	movl %esi, SYMBOL_NAME(kgdb_registers)+24	\
+	movl %edi, SYMBOL_NAME(kgdb_registers)+28	\
+	movw $0, %ax					\
+	movw %ds, SYMBOL_NAME(kgdb_registers)+48	\
+	movw %ax, SYMBOL_NAME(kgdb_registers)+50	\
+	movw %es, SYMBOL_NAME(kgdb_registers)+52	\
+	movw %ax, SYMBOL_NAME(kgdb_registers)+54	\
+	movw %fs, SYMBOL_NAME(kgdb_registers)+56	\
+	movw %ax, SYMBOL_NAME(kgdb_registers)+58	\
+	movw %gs, SYMBOL_NAME(kgdb_registers)+60	\
+	movw %ax, SYMBOL_NAME(kgdb_registers)+62
+
+
+
+/* If we get an breakpoint interrupt in kernel space, we want to be as
+ * lean as possible.  On the other hand, a breakpoint in user space
+ * requires error_code and all its friends, since we might have to
+ * stop the process, signal the debugger, and reschedule.  So we check
+ * the low 2 bits of the saved CS register here to figure out if we're
+ * in kernel space.  If they're zero, call the kernel debugger;
+ * otherwise do a normal int 3.
+ */
+
+ENTRY(int3)
+	pushl $0
+	pushl %eax
+	movl 12(%esp),%eax
+	andl $3,%eax
+	popl %eax
+	jnz user_int3
+	cmpl $0, kgdb_initialized
+	jz user_int3
+	SAVE_ALL
+	movl %esp,%edx
+	pushl %edx
+	pushl $5				/* 5 = SIGTRAP */
+	call SYMBOL_NAME(handle_exception)
+	addl $8,%esp
+	RESTORE_ALL
+	
+user_int3:
+	pushl $ SYMBOL_NAME(do_int3)
+	jmp error_code
+
+/* Same rational for interrupt 1; the debug (single step) fault.
+ * If kgdb_stepping isn't set, then it's a spurious trap, so
+ * ignore it, i.e, if we single stepped through a save_flags(),
+ * then we'll get a trap later on after restore_flags()
+ */
+
+
 ENTRY(debug)
+	pushl %eax
+	movl 8(%esp),%eax
+	andl $3,%eax
+	popl %eax
+	jnz user_debug
+	cmpl $0, kgdb_stepping
+	jz spurious_debug
+	pushl $0
+	SAVE_ALL
+	movl %esp,%edx
+	pushl %edx
+	pushl $5				/* 5 = SIGTRAP */
+	call SYMBOL_NAME(handle_exception)
+	addl $8,%esp
+	RESTORE_ALL
+
+spurious_debug:
+	andl $~TF_MASK, 8(%esp)			/* Clear trace flag */
+	iret
+	
+user_debug:
 	pushl $0
 	pushl $ SYMBOL_NAME(do_debug)
 	jmp error_code
 
-ENTRY(nmi)
-	pushl %eax
+/* When the kernel debugger is active, it installs this routine as the
+ * page fault handler, to trap illegal memory accesses.  Since it's
+ * never used except while the kernel is halted and the debugger is
+ * active, it's very simple - just hand off to the C routine.
+ */
+
+ENTRY(debugger_fault)
 	SAVE_ALL
 	movl %esp,%edx
 	pushl $0
 	pushl %edx
-	call SYMBOL_NAME(do_nmi)
+	call SYMBOL_NAME(do_debugger_fault)
 	addl $8,%esp
 	RESTORE_ALL
+#else
 
 ENTRY(int3)
 	pushl $0
 	pushl $ SYMBOL_NAME(do_int3)
 	jmp error_code
+
+ENTRY(debug)
+	pushl $0
+	pushl $ SYMBOL_NAME(do_debug)
+	jmp error_code
+
+#endif
 
 ENTRY(overflow)
 	pushl $0
diff -Nru linux-2.4.6-dist/arch/i386/kernel/i386-stub.c linux-2.4.6-kgdb/arch/i386/kernel/i386-stub.c
--- linux-2.4.6-dist/arch/i386/kernel/i386-stub.c	Wed Dec 31 19:00:00 1969
+++ linux-2.4.6-kgdb/arch/i386/kernel/i386-stub.c	Wed Aug  1 20:30:12 2001
@@ -0,0 +1,622 @@
+/****************************************************************************
+
+		THIS SOFTWARE IS NOT COPYRIGHTED
+
+   HP offers the following for use in the public domain.  HP makes no
+   warranty with regard to the software or it's performance and the
+   user accepts the software "AS IS" with all faults.
+
+   HP DISCLAIMS ANY WARRANTIES, EXPRESS OR IMPLIED, WITH REGARD
+   TO THIS SOFTWARE INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+
+****************************************************************************/
+
+/****************************************************************************
+ *  Header: remcom.c,v 1.34 91/03/09 12:29:49 glenne Exp $
+ *
+ *  Module name: remcom.c $
+ *  Revision: 1.34 $
+ *  Date: 91/03/09 12:29:49 $
+ *  Contributor:     Lake Stevens Instrument Division$
+ *
+ *  Description:     low level support for gdb debugger. $
+ *
+ *  Considerations:  only works on target hardware $
+ *
+ *  Written by:      Glenn Engel $
+ *  ModuleState:     Experimental $
+ *
+ *  NOTES:           See Below $
+ *
+ *  Modified for 386 by Jim Kingdon, Cygnus Support.
+ *
+ *  Modified for Linux i386 kernel by Brent Baccala <baccala@freesoft.org>
+ *
+ *  The basic idea is to attach two machines together via a null modem
+ *  cable between their serial ports.  The debugging machine should have
+ *  the linux kernel source tree and vmlinux object file.  The machine
+ *  under test should boot the same version of the kernel (possibily
+ *  by copying bzImage to it from the debugging machine).  The debugging
+ *  machine runs gdb (unmodified) on the linux kernel and controls the
+ *  machine under test via the serial connection, the gdb remote protocol,
+ *  and this code (in the kernel of the machine under test).
+ *
+ *  To enable debugger support, two things need to happen.  One, any
+ *  breakpoints or error conditions need to be properly intercepted
+ *  and reported to gdb via handle_exception(), which is called from
+ *  int1/int3 handlers (in entry.S), do_page_fault (in fault.c), and
+ *  do_trap() (in traps.c) on any kernel fault if remote debugging has
+ *  been enabled.  Two, a breakpoint needs to be generated to begin
+ *  communication.  This is most easily accomplished by a call to
+ *  breakpoint().  Breakpoint() simulates a breakpoint by executing an
+ *  INT3.
+ *
+ *  The INT 3 (breakpoint) and INT 1 (debug) handlers should install
+ *  as interrupt gates so that interrupts are masked while the handler
+ *  runs.
+ *
+ *  Because gdb will sometimes write to the stack area to execute function
+ *  calls, this program cannot rely on using the supervisor stack.
+ *
+ *  CAVEAT:  This is currently broken; we use the supervisor stack,
+ *  so the gdb "call" command will trash the kernel.  Don't use it.
+ *
+ *  CAVEAT:  No smp support at this time
+ *
+ *  CAVEAT:  Hardware watchpoints could be done, but presently aren't
+ *  supported by either this code or the gdb i386 remote backend.
+ *
+ *************
+ *  TEST PROCEDURE FOR THIS CODE
+ *
+ *  1.  boot kernel, specifying "kgdb" as a kernel argument
+ *  2.  kernel should halt almost immediately after loading, and send
+ *      an "$S05#84" out the serial port at 9600N8.  Should be visible
+ *      with a standard serial program.  Tests kernel INT3 handler.
+ *  3.  run "gdb vmlinux" on remote machine from the linux source dir
+ *  4.  "target remote /dev/cua0" (or whatever the serial device is)
+ *  5.  debugger should show a breakpoint in function breakpoint()
+ *      Tests basic debugger/kernel serial interface
+ *  6.  "info reg" - tests debuggers ability to read processor registers
+ *  7.  "where" - shows stack trace and tests memory fault handler
+ *      (the "Cannot access memory" message is normal)
+ *  8.  "break blk_get_queue"
+ *  9.  "cont" - tests debugger's ability to set a breakpoint, restart
+ *      kernel, and get control back a few seconds later
+ *  10. "next" - tests kernel single step trap, and single steps past a
+ *      save_flags() in blk_get_queue, thus pushing the flags register
+ *      with the TF bit set
+ *  11. "dis 1" - disable the breakpoint
+ *  12. "cont" - tests spurious single step trap handling, since the
+ *      saved flags registers will generate a spurious trap when it
+ *      is popped and restored.  Kernel should _not_ halt; there should
+ *      be no visible indication of the spurious trap
+ *  13. wait for kernel to finish booting
+ *  14. hit CNTL-C on debugger
+ *  15. kernel should halt and give control to debugger.  Tests ability
+ *      to grab control via a serial interrupt.  "continue"
+ *  16. on the machine under test, run ordinary gdb on some ordinary program
+ *  17. "break main" and "run" (ordinary gdb)
+ *  18. should breakpoint normally, without a breakpoint on the kernel
+ *      debugger.  Tests user space INT 3 handling
+ *  19. "next" (ordinary gdb)
+ *  20. should step normally, without affecting the kernel debugger.
+ *      Tests user space single step trap handling
+ *
+ *************
+ *
+ *    The following gdb commands are supported:
+ *
+ * command          function                               Return value
+ *
+ *    g             return the value of the CPU registers  hex data or ENN
+ *    G             set the value of the CPU registers     OK or ENN
+ *
+ *    mAA..AA,LLLL  Read LLLL bytes at address AA..AA      hex data or ENN
+ *    MAA..AA,LLLL: Write LLLL bytes at address AA.AA      OK or ENN
+ *
+ *    c             Resume at current address              SNN   ( signal NN)
+ *    cAA..AA       Continue at address AA..AA             SNN
+ *
+ *    s             Step one instruction                   SNN
+ *    sAA..AA       Step one instruction from AA..AA       SNN
+ *
+ *    k             kill
+ *
+ *    ?             What was the last sigval ?             SNN   (signal NN)
+ *
+ * All commands and responses are sent with a packet which includes a
+ * checksum.  A packet consists of
+ *
+ * $<packet info>#<checksum>.
+ *
+ * where
+ * <packet info> :: <characters representing the command or response>
+ * <checksum>    :: < two hex digits computed as modulo 256 sum of <packetinfo>>
+ *
+ * When a packet is received, it is first acknowledged with either '+' or '-'.
+ * '+' indicates a successful transfer.  '-' indicates a failed transfer.
+ *
+ * Example:
+ *
+ * Host:                  Reply:
+ * $m0,10#2a               +$00010203040506070809101112131415#42
+ *
+ ****************************************************************************/
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+
+#include <asm/ptrace.h>
+#include <asm/desc.h>
+
+/************************************************************************
+ *
+ * external low-level support routines
+ */
+
+extern void putDebugChar(char);	/* write a single character      */
+extern char getDebugChar(void);	/* read and return a single char */
+extern void kgdb_interruptible(int); /* true if recv data triggers breakpt */
+
+/************************************************************************/
+/* BUFMAX defines the maximum number of characters in inbound/outbound buffers*/
+/* at least NUMREGBYTES*2 are needed for register packets */
+#define BUFMAX 400
+
+char kgdb_initialized = 0;	/* TRUE = we've been initialized */
+int kgdb_active = 0;		/* TRUE = we're in the exception handler */
+int kgdb_stepping = 0;		/* TRUE = we're single-stepping the kernel*/
+
+static const char hexchars[]="0123456789abcdef";
+
+/* Number of registers.  */
+#define NUMREGS	16
+
+/* Number of bytes of registers.  */
+#define NUMREGBYTES (NUMREGS * 4)
+
+/* This is the register order that GDB uses - it is _not_ the order
+ * that Linux uses (struct pt_regs), so we need to be careful
+ */
+
+enum regnames {GDB_EAX, GDB_ECX, GDB_EDX, GDB_EBX,
+	       GDB_ESP, GDB_EBP, GDB_ESI, GDB_EDI,
+	       GDB_PC /* also known as eip */,
+	       GDB_PS /* also known as eflags */,
+	       GDB_CS, GDB_SS, GDB_DS, GDB_ES, GDB_FS, GDB_GS};
+
+static int registers[NUMREGS];
+
+int hex(char ch)
+{
+  if ((ch >= 'a') && (ch <= 'f')) return (ch-'a'+10);
+  if ((ch >= '0') && (ch <= '9')) return (ch-'0');
+  if ((ch >= 'A') && (ch <= 'F')) return (ch-'A'+10);
+  return (-1);
+}
+
+static char remcomInBuffer[BUFMAX];
+static char remcomOutBuffer[BUFMAX];
+
+/* scan for the sequence $<data>#<checksum>     */
+
+unsigned char *
+getpacket (void)
+{
+  unsigned char *buffer = &remcomInBuffer[0];
+  unsigned char checksum;
+  unsigned char xmitcsum;
+  int count;
+  char ch;
+
+  while (1)
+    {
+      /* wait around for the start character, ignore all other characters */
+      while ((ch = getDebugChar ()) != '$')
+	;
+
+retry:
+      checksum = 0;
+      xmitcsum = -1;
+      count = 0;
+
+      /* now, read until a # or end of buffer is found */
+      while (count < BUFMAX)
+	{
+	  ch = getDebugChar ();
+          if (ch == '$')
+	    goto retry;
+	  if (ch == '#')
+	    break;
+	  checksum = checksum + ch;
+	  buffer[count] = ch;
+	  count = count + 1;
+	}
+      buffer[count] = 0;
+
+      if (ch == '#')
+	{
+	  ch = getDebugChar ();
+	  xmitcsum = hex (ch) << 4;
+	  ch = getDebugChar ();
+	  xmitcsum += hex (ch);
+
+	  if (checksum != xmitcsum)
+	    {
+	      putDebugChar ('-');	/* failed checksum */
+	    }
+	  else
+	    {
+	      putDebugChar ('+');	/* successful transfer */
+
+	      /* if a sequence char is present, reply the sequence ID */
+	      if (buffer[2] == ':')
+		{
+		  putDebugChar (buffer[0]);
+		  putDebugChar (buffer[1]);
+
+		  return &buffer[3];
+		}
+
+	      return &buffer[0];
+	    }
+	}
+    }
+}
+
+/* send the packet in buffer.  */
+
+void putpacket(char *buffer)
+{
+  unsigned char checksum;
+  int  count;
+  char ch;
+
+  /*  $<packet info>#<checksum>. */
+  do {
+  putDebugChar('$');
+  checksum = 0;
+  count    = 0;
+
+  while ((ch=buffer[count])) {
+    putDebugChar(ch);
+    checksum += ch;
+    count += 1;
+  }
+
+  putDebugChar('#');
+  putDebugChar(hexchars[checksum >> 4]);
+  putDebugChar(hexchars[checksum % 16]);
+
+  } while (getDebugChar() != '+');
+
+}
+
+/* Get/set a byte in memory, with error indication on page faults
+ *
+ * I originally tried using the exception table mechanism for this
+ * code, but the standard page fault handler is too heavy weight - it
+ * grabs semaphores, spinlocks, and such.  Since the kernel is halted
+ * when this code runs, the only page faults we should get are our
+ * own, so I just install my own custom page fault handler, and
+ * restore the system handler when the kernel restarts.  The assembler
+ * statements are hard coded so I know exactly what the critical
+ * instructions are.  Each is a two-byte move that I just step past in
+ * the fault handler.
+ *
+ * debugger_fault and page_fault are defined in arch/i386/kernel/entry.S
+ * They are the fault handlers registered in the processor's IDT.  They
+ * save the registers onto the stack and set up a C call frame before
+ * calling do_page_fault (the normal fault routine) or do_debugger_fault.
+ */
+
+static volatile int mem_err = 0;
+
+unsigned char get_char (unsigned char *addr)
+{
+	int val = 0;
+
+	__asm__("movb (%1), %%al"
+                : "=a" (val) : "r" (addr));
+
+	return val;
+}
+
+void set_char (unsigned char *addr, unsigned char val)
+{
+	__asm__("movb %%al, (%1)"
+                : : "a" (val), "r" (addr));
+}
+
+asmlinkage void debugger_fault(void);
+asmlinkage void page_fault(void);
+
+asmlinkage void do_debugger_fault(struct pt_regs *regs, long error_code)
+{
+	mem_err = 1;
+	regs->eip += 2;
+}
+
+/* convert the memory pointed to by mem into hex, placing result in buf */
+/* return a pointer to the last char put in buf (null) */
+/* If MAY_FAULT is non-zero, then we should set mem_err in response to
+   a fault; if zero treat a fault like any other fault in the stub.  */
+char* mem2hex(char *mem, char *buf, int count, int may_fault)
+{
+      int i;
+      unsigned char ch;
+
+      for (i=0;i<count;i++) {
+          ch = get_char (mem++);
+	  if (may_fault && mem_err)
+	    return (buf);
+          *buf++ = hexchars[ch >> 4];
+          *buf++ = hexchars[ch % 16];
+      }
+      *buf = 0;
+      return(buf);
+}
+
+/* convert the hex array pointed to by buf into binary to be placed in mem */
+/* return a pointer to the character AFTER the last byte written */
+char* hex2mem(char *buf, char *mem, int count, int may_fault)
+{
+      int i;
+      unsigned char ch;
+
+      for (i=0;i<count;i++) {
+          ch = hex(*buf++) << 4;
+          ch = ch + hex(*buf++);
+          set_char (mem++, ch);
+	  if (may_fault && mem_err)
+	    return (mem);
+      }
+      return(mem);
+}
+
+/**********************************************/
+/* WHILE WE FIND NICE HEX CHARS, BUILD AN INT */
+/* RETURN NUMBER OF CHARS PROCESSED           */
+/**********************************************/
+int hexToInt(char **ptr, int *intValue)
+{
+    int numChars = 0;
+    int hexValue;
+
+    *intValue = 0;
+
+    while (**ptr)
+    {
+        hexValue = hex(**ptr);
+        if (hexValue >=0)
+        {
+            *intValue = (*intValue <<4) | hexValue;
+            numChars ++;
+        }
+        else
+            break;
+
+        (*ptr)++;
+    }
+
+    return (numChars);
+}
+
+/*
+ * This function does all command procesing for interfacing to gdb.
+ */
+
+void handle_exception(int sigval, struct pt_regs *regs)
+{
+  int    addr, length;
+  char * ptr;
+  int    newPC;
+
+  if (kgdb_active) {
+	  printk("interrupt while in kgdb, returning\n");
+	  return;
+  }
+  kgdb_active = 1;
+
+  kgdb_interruptible(0);
+  set_intr_gate(14,&debugger_fault);
+  /* lock_kernel(); */
+
+  registers[GDB_EAX] = regs->eax;
+  registers[GDB_EBX] = regs->ebx;
+  registers[GDB_ECX] = regs->ecx;
+  registers[GDB_EDX] = regs->edx;
+  registers[GDB_EBP] = regs->ebp;
+  registers[GDB_ESI] = regs->esi;
+  registers[GDB_EDI] = regs->edi;
+  registers[GDB_PC]  = regs->eip;
+  registers[GDB_PS]  = regs->eflags;
+  registers[GDB_CS]  = regs->xcs;
+  registers[GDB_DS]  = regs->xds;
+  registers[GDB_ES]  = regs->xes;
+
+  /* Kernel doesn't use FS or GS */
+  registers[GDB_FS]  = 0;
+  registers[GDB_GS]  = 0;
+
+  /* We came in through a trap gate from the same privilege level, so
+   * the CPU didn't change stacks and push ESP/SP like it would have
+   * for a trap from user space (different privilege level), so
+   * regs->esp and regs->xss are invalid.  We figure out ESP based
+   * the address of the register frame (go past the register frame,
+   * then backup 8 bytes to account for ESP/SS that didn't get pushded),
+   * and SS we ignore because GDB doesn't use it.
+   */
+
+  registers[GDB_ESP] = (int)regs + sizeof(struct pt_regs) - 8;
+  registers[GDB_SS]  = 0;
+
+  /* reply to host that an exception has occurred */
+  remcomOutBuffer[0] = 'S';
+  remcomOutBuffer[1] =  hexchars[sigval >> 4];
+  remcomOutBuffer[2] =  hexchars[sigval % 16];
+  remcomOutBuffer[3] = 0;
+
+  putpacket(remcomOutBuffer);
+
+  kgdb_stepping = 0;
+
+  while (1==1) {
+    remcomOutBuffer[0] = 0;
+    ptr = getpacket();
+
+    switch (*ptr++) {
+      case '?' :   remcomOutBuffer[0] = 'S';
+                   remcomOutBuffer[1] =  hexchars[sigval >> 4];
+                   remcomOutBuffer[2] =  hexchars[sigval % 16];
+                   remcomOutBuffer[3] = 0;
+                 break;
+      case 'd' : /* toggle debug flag */
+                 break;
+      case 'g' : /* return the value of the CPU registers */
+	      mem2hex((char*) registers, remcomOutBuffer, NUMREGBYTES, 0);
+	      break;
+      case 'G' : /* set the value of the CPU registers - return OK */
+                hex2mem(ptr, (char*) registers, NUMREGBYTES, 0);
+                strcpy(remcomOutBuffer,"OK");
+                break;
+      case 'P' : /* set the value of a single CPU register - return OK */
+                {
+                  int regno;
+
+                  if (hexToInt (&ptr, &regno) && *ptr++ == '=') 
+                  if (regno >= 0 && regno < NUMREGS)
+                    {
+                      hex2mem (ptr, (char *)&registers[regno], 4, 0);
+                      strcpy(remcomOutBuffer,"OK");
+                      break;
+                    }
+
+                  strcpy (remcomOutBuffer, "E01");
+                  break;
+                }
+
+      /* mAA..AA,LLLL  Read LLLL bytes at address AA..AA */
+      case 'm' :
+		    /* TRY TO READ %x,%x.  IF SUCCEED, SET PTR = 0 */
+                    if (hexToInt(&ptr,&addr))
+                        if (*(ptr++) == ',')
+                            if (hexToInt(&ptr,&length))
+                            {
+                                ptr = 0;
+				mem_err = 0;
+                                mem2hex((char*) addr, remcomOutBuffer, length, 1);
+				if (mem_err) {
+				    strcpy (remcomOutBuffer, "E03");
+				}
+                            }
+
+                    if (ptr)
+                    {
+		      strcpy(remcomOutBuffer,"E01");
+		    }
+	          break;
+
+      /* MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK */
+      case 'M' :
+		    /* TRY TO READ '%x,%x:'.  IF SUCCEED, SET PTR = 0 */
+                    if (hexToInt(&ptr,&addr))
+                        if (*(ptr++) == ',')
+                            if (hexToInt(&ptr,&length))
+                                if (*(ptr++) == ':')
+                                {
+				    mem_err = 0;
+                                    hex2mem(ptr, (char*) addr, length, 1);
+
+				    if (mem_err) {
+					strcpy (remcomOutBuffer, "E03");
+				    } else {
+				        strcpy(remcomOutBuffer,"OK");
+				    }
+
+                                    ptr = 0;
+                                }
+                    if (ptr)
+                    {
+		      strcpy(remcomOutBuffer,"E02");
+		    }
+                break;
+
+     /* cAA..AA    Continue at address AA..AA(optional) */
+     /* sAA..AA   Step one instruction from AA..AA(optional) */
+     case 's' :
+	 kgdb_stepping = 1;
+     case 'c' :
+          /* try to read optional parameter, pc unchanged if no parm */
+         if (hexToInt(&ptr,&addr))
+             registers[ GDB_PC ] = addr;
+
+          newPC = registers[ GDB_PC];
+
+          /* clear the trace bit */
+          registers[ GDB_PS ] &= 0xfffffeff;
+
+          /* set the trace bit if we're stepping */
+          if (kgdb_stepping) registers[ GDB_PS ] |= 0x100;
+
+	  regs->eax = registers[GDB_EAX];
+	  regs->ebx = registers[GDB_EBX];
+	  regs->ecx = registers[GDB_ECX];
+	  regs->edx = registers[GDB_EDX];
+	  regs->ebp = registers[GDB_EBP];
+	  regs->esi = registers[GDB_ESI];
+	  regs->edi = registers[GDB_EDI];
+	  regs->eip = registers[GDB_PC];
+	  regs->eflags = registers[GDB_PS];
+	  regs->xcs = registers[GDB_CS];
+	  regs->xds = registers[GDB_DS];
+	  regs->xes = registers[GDB_ES];
+
+	  /* We didn't restore FS, GS, or SS because we never saved them,
+	   * nor did we restore ESP because we're using the same stack
+	   * ourselves!
+	   */
+
+	  set_intr_gate(14,&page_fault);
+	  kgdb_interruptible(1);
+	  /* unlock_kernel(); */
+	  kgdb_active = 0;
+
+	  return;
+
+      /* kill the program */
+      case 'k' :
+	      strcpy(remcomOutBuffer, "OK");
+	      putpacket(remcomOutBuffer);
+	      machine_restart(NULL);
+	      break;
+
+      } /* switch */
+
+    /* reply to the request */
+    putpacket(remcomOutBuffer);
+    }
+}
+
+/* this function is used to set up exception handlers for tracing and
+   breakpoints */
+void set_debug_traps(void)
+{
+  kgdb_initialized = 1;
+}
+
+/* This function will generate a breakpoint exception.  It is used at the
+   beginning of a program to sync up with a debugger and can be used
+   otherwise as a quick means to stop program execution and "break" into
+   the debugger. */
+
+void breakpoint(void)
+{
+	if (kgdb_initialized) {
+		asm("   int $3");
+	}
+}
diff -Nru linux-2.4.6-dist/arch/i386/kernel/setup.c linux-2.4.6-kgdb/arch/i386/kernel/setup.c
--- linux-2.4.6-dist/arch/i386/kernel/setup.c	Fri May 25 20:07:09 2001
+++ linux-2.4.6-kgdb/arch/i386/kernel/setup.c	Wed Jul 25 14:00:34 2001
@@ -104,6 +104,12 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+
+#ifdef CONFIG_REMOTE_DEBUG
+extern int serial_kgdb_hook(int);
+extern void set_debug_traps(void);
+#endif
+
 /*
  * Machine setup..
  */
@@ -1016,6 +1022,19 @@
 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
 	if (low_mem_size > pci_mem_start)
 		pci_mem_start = low_mem_size;
+
+#ifdef CONFIG_REMOTE_DEBUG
+	if (strstr(*cmdline_p, "kgdb") && (serial_kgdb_hook(0) == 0)) {
+
+	     /* We can't breakpoint yet because traps haven't been set up,
+	      * but we'll just grab the UART (serial_kgdb_hook did that)
+	      * and initialize.  We'll breakpoint in traps.c as soon
+	      * as it's ready.
+	      */
+
+	     set_debug_traps();
+        }
+#endif
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
diff -Nru linux-2.4.6-dist/arch/i386/kernel/traps.c linux-2.4.6-kgdb/arch/i386/kernel/traps.c
--- linux-2.4.6-dist/arch/i386/kernel/traps.c	Wed Jul 25 13:53:09 2001
+++ linux-2.4.6-kgdb/arch/i386/kernel/traps.c	Tue Jul 31 00:48:24 2001
@@ -86,6 +86,17 @@
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
+#ifdef CONFIG_REMOTE_DEBUG
+
+extern char kgdb_initialized;
+extern int kgdb_active;
+extern int kgdb_stepping;
+
+extern void handle_exception(int sigval, struct pt_regs *regs);
+extern void breakpoint(void);
+
+#endif
+
 int kstack_depth_to_print = 24;
 
 /*
@@ -263,6 +274,16 @@
 		unsigned long fixup = search_exception_table(regs->eip);
 		if (fixup)
 			regs->eip = fixup;
+#ifdef CONFIG_REMOTE_DEBUG
+
+		/* This is not the main entry point for the remote debugger.
+		 * That's in entry.S's int3 (breakpoint) handler.  This code
+		 * just drops us into the debugger on the odd kernel fault.
+		 */
+
+		else if (kgdb_initialized)
+			handle_exception(signr, regs);
+#endif
 		else	
 			die(str, regs, error_code);
 		return;
@@ -432,6 +453,16 @@
 	 */
 	int sum, cpu = smp_processor_id();
 
+#ifdef CONFIG_REMOTE_DEBUG
+
+	/* If GDB is active, then we're sitting in a loop waiting for the
+	 * remote debugger, so the CPU may appear hung.  Skip the checks.
+	 */
+
+	if (kgdb_active) return;
+
+#endif
+
 	sum = apic_timer_irqs[cpu];
 
 	if (last_irq_sums[cpu] == sum) {
@@ -527,6 +558,25 @@
 
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
+#ifdef CONFIG_REMOTE_DEBUG
+
+	/* If we running GDB on the kernel, then check for a single
+	 * step trap in kernel space and hand it off to the debugger.
+	 * If kgdb_stepping isn't set, then it's a spurious trap, so
+	 * ignore it, i.e, if we single stepped through a save_flags(),
+	 * then we'll get a trap later on after restore_flags()
+	 */
+
+	if ((condition & DR_STEP) && !(regs->xcs & 3)) {
+		if (kgdb_stepping) {
+			handle_exception(5, regs);	/* 5 is SIGTRAP */
+			return;
+		} else {
+			goto clear_TF;
+		}
+	}
+#endif
+
 	/* Mask out spurious debug traps due to lazy DR7 setting */
 	if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)) {
 		if (!tsk->thread.debugreg[7])
@@ -817,21 +867,42 @@
  * Pentium F0 0F bugfix can have resulted in the mapped
  * IDT being write-protected.
  */
+
+/* Interrupt gate - masks off interrupts and can't be called from user space,
+ * only by a hardware interrupt, processor fault, or "INT n" instruction
+ * in kernel space (but that never happens)
+ */
+
 void set_intr_gate(unsigned int n, void *addr)
 {
 	_set_gate(idt_table+n,14,0,addr);
 }
 
+/* Trap gate - doesn't mask interrupts and can't be called from user space */
+
 static void __init set_trap_gate(unsigned int n, void *addr)
 {
 	_set_gate(idt_table+n,15,0,addr);
 }
 
+/* System gate - doesn't mask interrupts and can be called from user space,
+ * via an "INT n" instruction
+ */
+
 static void __init set_system_gate(unsigned int n, void *addr)
 {
 	_set_gate(idt_table+n,15,3,addr);
 }
 
+/* System interrupt gate - masks ints and can be called from user space */
+
+static void __init set_system_intr_gate(unsigned int n, void *addr)
+{
+	_set_gate(idt_table+n,14,3,addr);
+}
+
+/* Call gate - accessed via a far CALL rather than an exception or INT n */
+
 static void __init set_call_gate(void *a, void *addr)
 {
 	_set_gate(a,12,3,addr);
@@ -965,10 +1036,18 @@
 		EISA_bus = 1;
 #endif
 
+	/* Interrupts 1 and 3 are interrupt gates in case they were
+	 * generated within the kernel, in which case we want
+	 * interrupts masked off while the kernel debugger runs.
+	 * Additionally, interrupt 3 could be called from user space
+	 * by an "INT 3" inserted by a user space debugger, so it gets
+	 * a system interrupt gate.
+	 */
+
 	set_trap_gate(0,&divide_error);
-	set_trap_gate(1,&debug);
+	set_intr_gate(1,&debug);
 	set_intr_gate(2,&nmi);
-	set_system_gate(3,&int3);	/* int3-5 can be called from all */
+	set_system_intr_gate(3,&int3);	/* int3-5 can be called from all */
 	set_system_gate(4,&overflow);
 	set_system_gate(5,&bounds);
 	set_trap_gate(6,&invalid_op);
@@ -1004,5 +1083,12 @@
 	superio_init();
 	lithium_init();
 	cobalt_init();
+#endif
+
+#ifdef CONFIG_REMOTE_DEBUG
+	/* Traps are now setup - OK to fire off an initial breakpoint,
+	 * which should halt the kernel and hand control to the debugger.
+	 */
+	if (kgdb_initialized) breakpoint();
 #endif
 }
diff -Nru linux-2.4.6-dist/arch/i386/mm/fault.c linux-2.4.6-kgdb/arch/i386/mm/fault.c
--- linux-2.4.6-dist/arch/i386/mm/fault.c	Tue May 15 03:16:51 2001
+++ linux-2.4.6-kgdb/arch/i386/mm/fault.c	Wed Aug  1 12:39:33 2001
@@ -25,6 +25,10 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
+#ifdef CONFIG_REMOTE_DEBUG
+extern char kgdb_initialized;
+#endif
+
 /*
  * Ugly, ugly, but the goto's result in better assembly..
  */
@@ -270,6 +274,13 @@
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
  */
+
+#ifdef CONFIG_REMOTE_DEBUG
+	if (kgdb_initialized) {
+		handle_exception(11, regs);	/* 11 - SIGSEGV */
+		return;
+	}
+#endif
 
 	bust_spinlocks();
 
diff -Nru linux-2.4.6-dist/drivers/char/serial.c linux-2.4.6-kgdb/drivers/char/serial.c
--- linux-2.4.6-dist/drivers/char/serial.c	Sun May 20 15:11:38 2001
+++ linux-2.4.6-kgdb/drivers/char/serial.c	Wed Jul 25 14:00:34 2001
@@ -264,6 +264,8 @@
 static int IRQ_timeout[NR_IRQS];
 #ifdef CONFIG_SERIAL_CONSOLE
 static struct console sercons;
+#endif
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_REMOTE_DEBUG)
 static int lsr_break_flag;
 #endif
 #if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
@@ -360,6 +362,17 @@
 #define DBG_CNT(s)
 #endif
 
+/* If kgdb is active is one of the serial ports, kgdb_index holds
+ * the port's offset in rs_table[].  No normal operations are permitted
+ * on a port running kgdb.
+ */
+
+static int kgdb_index = -1;
+
+#ifdef CONFIG_REMOTE_DEBUG
+void enable_kgdb_interrupts(void);
+#endif
+
 /*
  * tmp_buf is used as a temporary buffer by serial_write.  We need to
  * lock it in case the copy_from_user blocks while swapping in a page,
@@ -3133,7 +3146,7 @@
 
 	MOD_INC_USE_COUNT;
 	line = MINOR(tty->device) - tty->driver.minor_start;
-	if ((line < 0) || (line >= NR_PORTS)) {
+	if ((line < 0) || (line >= NR_PORTS) || (line == kgdb_index)) {
 		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
@@ -5285,6 +5298,12 @@
 		panic("Couldn't register callout driver\n");
 	
 	for (i = 0, state = rs_table; i < NR_PORTS; i++,state++) {
+#ifdef CONFIG_REMOTE_DEBUG
+		if (i == kgdb_index) {
+			enable_kgdb_interrupts();
+			continue;
+		}
+#endif
 		state->magic = SSTATE_MAGIC;
 		state->line = i;
 		state->type = PORT_UNKNOWN;
@@ -5307,7 +5326,7 @@
 			autoconfig(state);
 	}
 	for (i = 0, state = rs_table; i < NR_PORTS; i++,state++) {
-		if (state->type == PORT_UNKNOWN)
+		if ((state->type == PORT_UNKNOWN) || (i == kgdb_index))
 			continue;
 		if (   (state->flags & ASYNC_BOOT_AUTOCONF)
 		    && (state->flags & ASYNC_AUTO_IRQ)
@@ -5564,12 +5583,10 @@
  * Serial console driver
  * ------------------------------------------------------------
  */
-#ifdef CONFIG_SERIAL_CONSOLE
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_REMOTE_DEBUG)
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
-static struct async_struct async_sercons;
-
 /*
  *	Wait for transmitter & holding register to empty
  */
@@ -5595,6 +5612,12 @@
 	}	
 }
 
+#endif
+
+
+#ifdef CONFIG_SERIAL_CONSOLE
+
+static struct async_struct async_sercons;
 
 /*
  *	Print a string to the serial port trying not to disturb
@@ -5821,6 +5844,215 @@
 void __init serial_console_init(void)
 {
 	register_console(&sercons);
+}
+#endif
+
+/*
+ *   Hooks for remote GDB driver
+ *
+ * GDB has a mode ("target remote") which allows it to debug a program
+ * via a simple serial protocol, documented in GDB's "remote.c" file.
+ * In our case, the "program" is the Linux kernel itself, and the
+ * protocol runs over a standard serial port.  Standard configuration
+ * is to run a null modem cable between two machines, then GDB can be
+ * run on one and be used to breakpoint, single step, and do all that
+ * neat source debugger stuff to the kernel on the other machine.
+ *
+ * If the "kgdb" option is given to the kernel, serial_kgdb_hook(index) is
+ * called which sets up for remote GDB on the "index"th serial line.
+ * The index is squirreled away in kgdb_index, to make sure the normal
+ * serial code doesn't try to init the UART or open the device.
+ * A special interrupt handler is installed, and the putDebugChar() and
+ * getDebugChar() functions are exported, along with kgdb_interruptible(),
+ * which tells the system's state:
+ *
+ *    kgdb_interruptible(1) - system running,
+ *                            CNTL-C from the remote triggers a breakpoint
+ *    kgdb_interruptible(0) - system halted,
+ *                            characters from the remote go to getDebugChar()
+ */
+
+#ifdef CONFIG_REMOTE_DEBUG
+
+void breakpoint(void);
+
+static struct async_struct async_kgdb;
+static int kgdb_interrupts_active = 0;
+
+static void rs_interrupt_kgdb(int irq, void *dev_id, struct pt_regs *regs)
+{
+	while (serial_in(&async_kgdb, UART_LSR) & UART_LSR_DR) {
+		if (serial_in(&async_kgdb, UART_RX) == '\003') {
+			breakpoint();
+			return;
+		}
+	}
+}
+
+int serial_kgdb_hook(int index)
+{
+	struct async_struct *info;
+        struct serial_state *state;
+        unsigned cval;
+        int     baud = 9600;
+        int     bits = 8;
+        int     parity = 'n';
+        int     cflag = CREAD | HUPCL | CLOCAL;
+        int     quot = 0;
+
+        kgdb_index = index;
+
+        /*
+         *      Now construct a cflag setting.
+         */
+        switch(baud) {
+	case 1200:
+		cflag |= B1200;
+		break;
+	case 2400:
+		cflag |= B2400;
+		break;
+	case 4800:
+		cflag |= B4800;
+		break;
+	case 19200:
+		cflag |= B19200;
+		break;
+	case 38400:
+		cflag |= B38400;
+		break;
+	case 57600:
+		cflag |= B57600;
+		break;
+	case 115200:
+		cflag |= B115200;
+		break;
+	case 9600:
+	default:
+		cflag |= B9600;
+		break;
+        }
+        switch(bits) {
+	case 7:
+		cflag |= CS7;
+		break;
+	default:
+	case 8:
+		cflag |= CS8;
+		break;
+        }
+        switch(parity) {
+	case 'o': case 'O':
+		cflag |= PARODD;
+		break;
+	case 'e': case 'E':
+		cflag |= PARENB;
+		break;
+        }
+
+        /*
+         *      Divisor, bytesize and parity
+         */
+        state = rs_table + index;
+	info = &async_kgdb;
+	info->magic = SERIAL_MAGIC;
+	info->state = state;
+	info->port = state->port;
+	info->flags = state->flags;
+#ifdef CONFIG_HUB6
+	info->hub6 = state->hub6;
+#endif
+	info->io_type = state->io_type;
+	info->iomem_base = state->iomem_base;
+	info->iomem_reg_shift = state->iomem_reg_shift;
+        quot = state->baud_base / baud;
+        cval = cflag & (CSIZE | CSTOPB);
+#if defined(__powerpc__) || defined(__alpha__)
+        cval >>= 8;
+#else /* !__powerpc__ && !__alpha__ */
+        cval >>= 4;
+#endif /* !__powerpc__ && !__alpha__ */
+        if (cflag & PARENB)
+                cval |= UART_LCR_PARITY;
+        if (!(cflag & PARODD))
+                cval |= UART_LCR_EPAR;
+
+
+        /*
+         *      Set DTR and RTS high along with OUT1 and OUT2 (to
+         *      enable interrupts) and set speed.
+	 */
+	serial_out(info, UART_LCR, cval | UART_LCR_DLAB);	/* set DLAB */
+	serial_out(info, UART_DLL, quot & 0xff);	/* LS of divisor */
+	serial_out(info, UART_DLM, quot >> 8);		/* MS of divisor */
+	serial_out(info, UART_LCR, cval);		/* reset DLAB */
+	serial_out(info, UART_IER, 0);			/* int off for now */
+	/* serial_out(info, UART_MCR, UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT1 | UART_MCR_OUT2); */
+	serial_out(info, UART_MCR, UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2);
+
+        /*
+         *      If we read 0xff from the LSR, there is no UART here.
+         */
+	if (serial_in(info, UART_LSR) == 0xff) {
+                return -1;
+        }
+        return 0;
+}
+
+static void enable_kgdb_interrupts(void)
+{
+        /* This routine gets called from rs_init(), and sets up the
+	 * IRQ handler and I/O block for the KGDB debugger.  We don't
+	 * need this to make KGDB work - we only need it to debug
+	 * asynchronously (hit CTRL-C on the debugger and break into
+	 * the kernel).  We didn't do this in serial_kgdb_hook() since
+	 * IRQs hadn't been initialized yet!
+	 */
+
+        /* Allocate the IRQ (we don't share it) and IO ports */
+
+        if (request_irq(async_kgdb.state->irq, rs_interrupt_kgdb, 0,
+                        "serial(kgdb)", NULL)) {
+                printk("Can't get KGDB IRQ - no asynchronous debugging\n");
+        }
+
+	/* enable UART recv data interrupt */
+	serial_out(&async_kgdb, UART_IER, UART_IER_RDI);
+
+	rs_interrupt_kgdb(async_kgdb.state->irq, NULL, NULL);
+
+	kgdb_interrupts_active = 1;
+
+        request_region(async_kgdb.port, 8, "serial(kgdb)");
+}
+
+void putDebugChar(char kgdb_char)
+{
+        wait_for_xmitr(&async_kgdb);
+	serial_out(&async_kgdb, UART_TX, kgdb_char);
+        wait_for_xmitr(&async_kgdb);
+}
+
+char getDebugChar(void)
+{
+        int lsr;
+
+        do {
+                lsr = serial_in(&async_kgdb, UART_LSR);
+        } while (!(lsr & UART_LSR_DR));
+
+        return serial_in(&async_kgdb, UART_RX);
+}
+
+void kgdb_interruptible(int i)
+{
+        if (i && kgdb_interrupts_active) {
+                /* KGDB interruptible - enable UART recv data interrupt */
+                serial_out(&async_kgdb, UART_IER, UART_IER_RDI);
+        } else {
+                /* KGDB not interruptible - disable UART interrupts */
+                serial_out(&async_kgdb, UART_IER, 0);
+        }
 }
 #endif
 


--------------FD874D4518F698B1F5858707--

