Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTDNSLX (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbTDNSLX (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:11:23 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:55529 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263612AbTDNRpl (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:41 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (13/16): s390/s390x unification - part 4.
Date: Mon, 14 Apr 2003 19:53:31 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141953.31560.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge s390x and s390 to one architecture.

diffstat:
 gdb-stub.c   |  581 ---------------------------------------------------
 head64.S     |  664 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 module.c     |   92 +++++---
 process.c    |   98 +++++++-
 ptrace.c     |  387 ++++++++++++++++++++++++++++------
 reipl64.S    |   96 ++++++++
 s390_ksyms.c |   25 ++
 setup.c      |   46 +++-
 signal.c     |   41 ++-
 smp.c        |   64 ++---
 sys_s390.c   |   98 +++++++-
 11 files changed, 1434 insertions(+), 758 deletions(-)

diff -urN linux-2.5.67/arch/s390/kernel/gdb-stub.c linux-2.5.67-s390/arch/s390/kernel/gdb-stub.c
--- linux-2.5.67/arch/s390/kernel/gdb-stub.c	Mon Apr  7 19:32:59 2003
+++ linux-2.5.67-s390/arch/s390/kernel/gdb-stub.c	Thu Jan  1 01:00:00 1970
@@ -1,581 +0,0 @@
-/*
- *  arch/s390/kernel/gdb-stub.c
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
- *
- *  Originally written by Glenn Engel, Lake Stevens Instrument Division
- *
- *  Contributed by HP Systems
- *
- *  Modified for SPARC by Stu Grossman, Cygnus Support.
- *
- *  Modified for Linux/MIPS (and MIPS in general) by Andreas Busse
- *  Send complaints, suggestions etc. to <andy@waldorf-gmbh.de>
- *
- *  Copyright (C) 1995 Andreas Busse
- */
-
-/*
- *  To enable debugger support, two things need to happen.  One, a
- *  call to set_debug_traps() is necessary in order to allow any breakpoints
- *  or error conditions to be properly intercepted and reported to gdb.
- *  Two, a breakpoint needs to be generated to begin communication.  This
- *  is most easily accomplished by a call to breakpoint().  Breakpoint()
- *  simulates a breakpoint by executing a BREAK instruction.
- *
- *
- *    The following gdb commands are supported:
- *
- * command          function                               Return value
- *
- *    g             return the value of the CPU registers  hex data or ENN
- *    G             set the value of the CPU registers     OK or ENN
- *
- *    mAA..AA,LLLL  Read LLLL bytes at address AA..AA      hex data or ENN
- *    MAA..AA,LLLL: Write LLLL bytes at address AA.AA      OK or ENN
- *
- *    c             Resume at current address              SNN   ( signal NN)
- *    cAA..AA       Continue at address AA..AA             SNN
- *
- *    s             Step one instruction                   SNN
- *    sAA..AA       Step one instruction from AA..AA       SNN
- *
- *    k             kill
- *
- *    ?             What was the last sigval ?             SNN   (signal NN)
- *
- *
- * All commands and responses are sent with a packet which includes a
- * checksum.  A packet consists of
- *
- * $<packet info>#<checksum>.
- *
- * where
- * <packet info> :: <characters representing the command or response>
- * <checksum>    :: < two hex digits computed as modulo 256 sum of <packetinfo>>
- *
- * When a packet is received, it is first acknowledged with either '+' or '-'.
- * '+' indicates a successful transfer.  '-' indicates a failed transfer.
- *
- * Example:
- *
- * Host:                  Reply:
- * $m0,10#2a               +$00010203040506070809101112131415#42
- *
- */
-#define TRUE 1
-#define FALSE 0
-#include <asm/gdb-stub.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/pgtable.h>
-#include <asm/system.h>
-#include <linux/stddef.h>
-
-#define S390_REGS_COMMON_SIZE offsetof(struct gdb_pt_regs,orig_gpr2)
-
-/*
- * external low-level support routines
- */
-
-
-extern void fltr_set_mem_err(void);
-extern void trap_low(void);
-
-/*
- * breakpoint and test functions
- */
-extern void breakpoint(void);
-extern void breakinst(void);
-
-/*
- * local prototypes
- */
-
-static void getpacket(char *buffer);
-static void putpacket(char *buffer);
-static int hex(unsigned char ch);
-static int hexToInt(char **ptr, int *intValue);
-static unsigned char *mem2hex(char *mem, char *buf, int count, int may_fault);
-
-
-/*
- * BUFMAX defines the maximum number of characters in inbound/outbound buffers
- * at least NUMREGBYTES*2 are needed for register packets
- */
-#define BUFMAX 2048
-
-static char input_buffer[BUFMAX];
-static char output_buffer[BUFMAX];
-int gdb_stub_initialised = FALSE;	
-static const char hexchars[]="0123456789abcdef";
-
-
-/*
- * Convert ch from a hex digit to an int
- */
-static int hex(unsigned char ch)
-{
-	if (ch >= 'a' && ch <= 'f')
-		return ch-'a'+10;
-	if (ch >= '0' && ch <= '9')
-		return ch-'0';
-	if (ch >= 'A' && ch <= 'F')
-		return ch-'A'+10;
-	return -1;
-}
-
-/*
- * scan for the sequence $<data>#<checksum>
- */
-static void getpacket(char *buffer)
-{
-	unsigned char checksum;
-	unsigned char xmitcsum;
-	int i;
-	int count;
-	unsigned char ch;
-
-	do {
-		/*
-		 * wait around for the start character,
-		 * ignore all other characters
-		 */
-		while ((ch = (getDebugChar() & 0x7f)) != '$') ;
-
-		checksum = 0;
-		xmitcsum = -1;
-		count = 0;
-	
-		/*
-		 * now, read until a # or end of buffer is found
-		 */
-		while (count < BUFMAX) {
-			ch = getDebugChar() & 0x7f;
-			if (ch == '#')
-				break;
-			checksum = checksum + ch;
-			buffer[count] = ch;
-			count = count + 1;
-		}
-
-		if (count >= BUFMAX)
-			continue;
-
-		buffer[count] = 0;
-
-		if (ch == '#') {
-			xmitcsum = hex(getDebugChar() & 0x7f) << 4;
-			xmitcsum |= hex(getDebugChar() & 0x7f);
-
-			if (checksum != xmitcsum)
-				putDebugChar('-');	/* failed checksum */
-			else {
-				putDebugChar('+'); /* successful transfer */
-
-				/*
-				 * if a sequence char is present,
-				 * reply the sequence ID
-				 */
-				if (buffer[2] == ':') {
-					putDebugChar(buffer[0]);
-					putDebugChar(buffer[1]);
-
-					/*
-					 * remove sequence chars from buffer
-					 */
-					count = strlen(buffer);
-					for (i=3; i <= count; i++)
-						buffer[i-3] = buffer[i];
-				}
-			}
-		}
-	}
-	while (checksum != xmitcsum);
-}
-
-/*
- * send the packet in buffer.
- */
-static void putpacket(char *buffer)
-{
-	unsigned char checksum;
-	int count;
-	unsigned char ch;
-
-	/*
-	 * $<packet info>#<checksum>.
-	 */
-
-	do {
-		putDebugChar('$');
-		checksum = 0;
-		count = 0;
-
-		while ((ch = buffer[count]) != 0) {
-			if (!(putDebugChar(ch)))
-				return;
-			checksum += ch;
-			count += 1;
-		}
-
-		putDebugChar('#');
-		putDebugChar(hexchars[checksum >> 4]);
-		putDebugChar(hexchars[checksum & 0xf]);
-
-	}
-	while ((getDebugChar() & 0x7f) != '+');
-}
-
-
-
-/*
- * Convert the memory pointed to by mem into hex, placing result in buf.
- * Return a pointer to the last char put in buf (null), in case of mem fault,
- * return 0.
- * If MAY_FAULT is non-zero, then we will handle memory faults by returning
- * a 0, else treat a fault like any other fault in the stub.
- */
-static unsigned char *mem2hex(char *mem, char *buf, int count, int may_fault)
-{
-	unsigned char ch;
-
-/*	set_mem_fault_trap(may_fault); */
-
-	while (count-- > 0) {
-		ch = *(mem++);
-#if 0
-		if (mem_err)
-			return 0;
-#endif
-		*buf++ = hexchars[ch >> 4];
-		*buf++ = hexchars[ch & 0xf];
-	}
-
-	*buf = 0;
-
-/*	set_mem_fault_trap(0); */
-
-	return buf;
-}
-
-/*
- * convert the hex array pointed to by buf into binary to be placed in mem
- * return a pointer to the character AFTER the last byte written
- */
-static char *hex2mem(char *buf, char *mem, int count, int may_fault)
-{
-	int i;
-	unsigned char ch;
-
-/*	set_mem_fault_trap(may_fault); */
-
-	for (i=0; i<count; i++)
-	{
-		ch = hex(*buf++) << 4;
-		ch |= hex(*buf++);
-		*(mem++) = ch;
-#if 0
-		if (mem_err)
-			return 0;
-#endif
-	}
-
-/*	set_mem_fault_trap(0); */
-
-	return mem;
-}
-
-
-
-/*
- * Set up exception handlers for tracing and breakpoints
- */
-void set_debug_traps(void)
-{
-//	unsigned long flags;
-	unsigned char c;
-
-//	save_and_cli(flags);
-	/*
-	 * In case GDB is started before us, ack any packets
-	 * (presumably "$?#xx") sitting there.
-	 */
-	while((c = getDebugChar()) != '$');
-	while((c = getDebugChar()) != '#');
-	c = getDebugChar(); /* eat first csum byte */
-	c = getDebugChar(); /* eat second csum byte */
-	putDebugChar('+'); /* ack it */
-
-	gdb_stub_initialised = TRUE;
-//	restore_flags(flags);
-}
-
-
-/*
- * Trap handler for memory errors.  This just sets mem_err to be non-zero.  It
- * assumes that %l1 is non-zero.  This should be safe, as it is doubtful that
- * 0 would ever contain code that could mem fault.  This routine will skip
- * past the faulting instruction after setting mem_err.
- */
-extern void fltr_set_mem_err(void)
-{
-  /* FIXME: Needs to be written... */
-}
-
-
-/*
- * While we find nice hex chars, build an int.
- * Return number of chars processed.
- */
-static int hexToInt(char **ptr, int *intValue)
-{
-	int numChars = 0;
-	int hexValue;
-
-	*intValue = 0;
-
-	while (**ptr)
-	{
-		hexValue = hex(**ptr);
-		if (hexValue < 0)
-			break;
-
-		*intValue = (*intValue << 4) | hexValue;
-		numChars ++;
-
-		(*ptr)++;
-	}
-
-	return (numChars);
-}
-
-void gdb_stub_get_non_pt_regs(struct gdb_pt_regs *regs)
-{
-	s390_fp_regs *fpregs=&regs->fp_regs;
-	int has_ieee=save_fp_regs1(fpregs);
-
-	if(!has_ieee)
-	{
-		fpregs->fpc=0;
-		fpregs->fprs[1].d=
-		fpregs->fprs[3].d=
-		fpregs->fprs[5].d=
-		fpregs->fprs[7].d=0;
-		memset(&fpregs->fprs[8].d,0,sizeof(freg_t)*8);
-	}
-}
-
-void gdb_stub_set_non_pt_regs(struct gdb_pt_regs *regs)
-{
-	restore_fp_regs1(&regs->fp_regs);
-}
-
-void gdb_stub_send_signal(int sigval)
-{
-	char *ptr;
-	ptr = output_buffer;
-
-	/*
-	 * Send trap type (converted to signal)
-	 */
-	*ptr++ = 'S';
-	*ptr++ = hexchars[sigval >> 4];
-	*ptr++ = hexchars[sigval & 0xf];
-	*ptr++ = 0;
-	putpacket(output_buffer);	/* send it off... */
-}
-
-/*
- * This function does all command processing for interfacing to gdb.  It
- * returns 1 if you should skip the instruction at the trap address, 0
- * otherwise.
- */
-void gdb_stub_handle_exception(struct gdb_pt_regs *regs,int sigval)
-{
-	int trap;			/* Trap type */
-	int addr;
-	int length;
-	char *ptr;
-	unsigned long *stack;
-
-	
-	/*
-	 * reply to host that an exception has occurred
-	 */
-#if 0
-	send_signal(sigval);
-#endif
-	/*
-	 * Wait for input from remote GDB
-	 */
-	while (1) 
-	{
-		output_buffer[0] = 0;
-		getpacket(input_buffer);
-
-		switch (input_buffer[0])
-		{
-		case '?':
-#if 0
-			send_signal(sigval);
-#endif
-			continue;
-
-		case 'd':
-			/* toggle debug flag */
-			break;
-
-		/*
-		 * Return the value of the CPU registers
-		 */
-		case 'g':
-			gdb_stub_get_non_pt_regs(regs);
-			ptr = output_buffer;
-			ptr=  mem2hex((char *)regs,ptr,S390_REGS_COMMON_SIZE,FALSE);
-			ptr=  mem2hex((char *)&regs->crs[0],ptr,NUM_CRS*CR_SIZE,FALSE);
-			ptr = mem2hex((char *)&regs->fp_regs, ptr,sizeof(s390_fp_regs),FALSE);
-			break;
-	  
-		/*
-		 * set the value of the CPU registers - return OK
-		 * FIXME: Needs to be written
-		 */
-		case 'G':
-			ptr=input_buffer;
-			hex2mem (ptr, (char *)regs,S390_REGS_COMMON_SIZE, FALSE);
-			ptr+=S390_REGS_COMMON_SIZE*2;
-			hex2mem (ptr, (char *)regs->crs[0],NUM_CRS*CR_SIZE, FALSE);
-			ptr+=NUM_CRS*CR_SIZE*2;
-			hex2mem (ptr, (char *)&regs->fp_regs,sizeof(s390_fp_regs), FALSE);
-			gdb_stub_set_non_pt_regs(regs);
-			strcpy(output_buffer,"OK");
-		break;
-
-		/*
-		 * mAA..AA,LLLL  Read LLLL bytes at address AA..AA
-		 */
-		case 'm':
-			ptr = &input_buffer[1];
-
-			if (hexToInt(&ptr, &addr)
-				&& *ptr++ == ','
-				&& hexToInt(&ptr, &length)) {
-				if (mem2hex((char *)addr, output_buffer, length, 1))
-					break;
-				strcpy (output_buffer, "E03");
-			} else
-				strcpy(output_buffer,"E01");
-			break;
-
-		/*
-		 * MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK
-		 */
-		case 'M': 
-			ptr = &input_buffer[1];
-
-			if (hexToInt(&ptr, &addr)
-				&& *ptr++ == ','
-				&& hexToInt(&ptr, &length)
-				&& *ptr++ == ':') 
-			{
-				if (hex2mem(ptr, (char *)addr, length, 1))
-					strcpy(output_buffer, "OK");
-				else
-					strcpy(output_buffer, "E03");
-			}
-			else
-				strcpy(output_buffer, "E02");
-			break;
-
-		/*
-		 * cAA..AA    Continue at address AA..AA(optional)
-		 */
-		case 'c':    
-			/* try to read optional parameter, pc unchanged if no parm */
-
-			ptr = &input_buffer[1];
-			if (hexToInt(&ptr, &addr))
-				regs->psw.addr = addr;
-			/*
-			 * Need to flush the instruction cache here, as we may
-			 * have deposited a breakpoint, and the icache probably
-			 * has no way of knowing that a data ref to some location
-			 * may have changed something that is in the instruction
-			 * cache.
-			 * NB: We flush both caches, just to be sure...
-			 */
-
-			flush_cache_all();
-			return;
-			/* NOTREACHED */
-			break;
-
-
-		/*
-		 * kill the program
-		 */
-		case 'k' :
-			break;		/* do nothing */
-
-
-		/*
-		 * Reset the whole machine (FIXME: system dependent)
-		 */
-		case 'r':
-			break;
-
-
-		/*
-		 * Step to next instruction
-		 */
-		case 's':
-			/*
-			 * There is no single step insn in the MIPS ISA, so we
-			 * use breakpoints and continue, instead.
-			 */
-#if 0
-			single_step(regs);
-#endif
-			flush_cache_all();
-			return;
-			/* NOTREACHED */
-			break;
-
-		}      /* switch */
-
-	/*
-	 * reply to the request
-	 */
-	
-		putpacket(output_buffer);
-	
-	} /* while */
-}
-
-/*
- * This function will generate a breakpoint exception.  It is used at the
- * beginning of a program to sync up with a debugger and can be used
- * otherwise as a quick means to stop program execution and "break" into
- * the debugger.
- */
-void breakpoint(void)
-{
-	if (!gdb_stub_initialised)
-		return;
-	asm volatile (".globl	breakinst\n"
-		"breakinst:\t.word   %0"
-		: : "i" (S390_BREAKPOINT_U16) );
-}
-
-
-
-
-
-
-
diff -urN linux-2.5.67/arch/s390/kernel/head64.S linux-2.5.67-s390/arch/s390/kernel/head64.S
--- linux-2.5.67/arch/s390/kernel/head64.S	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/kernel/head64.S	Mon Apr 14 19:11:56 2003
@@ -0,0 +1,664 @@
+/*
+ *  arch/s390/kernel/head.S
+ *
+ *  S390 version
+ *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Hartmut Penner (hp@de.ibm.com),
+ *               Martin Schwidefsky (schwidefsky@de.ibm.com),
+ *               Rob van der Heij (rvdhei@iae.nl)
+ *
+ * There are 5 different IPL methods
+ *  1) load the image directly into ram at address 0 and do an PSW restart
+ *  2) linload will load the image from address 0x10000 to memory 0x10000
+ *     and start the code thru LPSW 0x0008000080010000 (VM only, deprecated)
+ *  3) generate the tape ipl header, store the generated image on a tape
+ *     and ipl from it
+ *     In case of SL tape you need to IPL 5 times to get past VOL1 etc
+ *  4) generate the vm reader ipl header, move the generated image to the
+ *     VM reader (use option NOH!) and do a ipl from reader (VM only)
+ *  5) direct call of start by the SALIPL loader
+ *  We use the cpuid to distinguish between VM and native ipl
+ *  params for kernel are pushed to 0x10400 (see setup.h)
+
+    Changes: 
+    Okt 25 2000 <rvdheij@iae.nl>
+	added code to skip HDR and EOF to allow SL tape IPL (5 retries)
+	changed first CCW from rewind to backspace block
+
+ */
+
+#include <linux/config.h>
+#include <asm/setup.h>
+#include <asm/lowcore.h>
+
+#ifndef CONFIG_IPL
+        .org   0
+        .long  0x00080000,0x80000000+startup   # Just a restart PSW
+#else
+#ifdef CONFIG_IPL_TAPE
+#define IPL_BS 1024
+        .org   0
+        .long  0x00080000,0x80000000+iplstart  # The first 24 bytes are loaded
+        .long  0x27000000,0x60000001           # by ipl to addresses 0-23.
+        .long  0x02000000,0x20000000+IPL_BS    # (a PSW and two CCWs).
+        .long  0x00000000,0x00000000           # external old psw
+        .long  0x00000000,0x00000000           # svc old psw
+        .long  0x00000000,0x00000000           # program check old psw
+        .long  0x00000000,0x00000000           # machine check old psw
+        .long  0x00000000,0x00000000           # io old psw
+        .long  0x00000000,0x00000000
+        .long  0x00000000,0x00000000
+        .long  0x00000000,0x00000000
+        .long  0x000a0000,0x00000058           # external new psw
+        .long  0x000a0000,0x00000060           # svc new psw
+        .long  0x000a0000,0x00000068           # program check new psw
+        .long  0x000a0000,0x00000070           # machine check new psw
+        .long  0x00080000,0x80000000+.Lioint   # io new psw
+
+        .org   0x100
+#
+# subroutine for loading from tape
+# Paramters:	
+#  R1 = device number
+#  R2 = load address
+.Lloader:	
+        st    %r14,.Lldret
+        la    %r3,.Lorbread                    # r3 = address of orb 
+	la    %r5,.Lirb                        # r5 = address of irb
+        st    %r2,.Lccwread+4                  # initialize CCW data addresses
+        lctl  %c6,%c6,.Lcr6               
+        slr   %r2,%r2
+.Lldlp:
+        la    %r6,3                            # 3 retries
+.Lssch:
+        ssch  0(%r3)                           # load chunk of IPL_BS bytes
+        bnz   .Llderr
+.Lw4end:
+        bas   %r14,.Lwait4io
+        tm    8(%r5),0x82                      # do we have a problem ?
+        bnz   .Lrecov
+        slr   %r7,%r7
+        icm   %r7,3,10(%r5)                    # get residual count
+        lcr   %r7,%r7
+        la    %r7,IPL_BS(%r7)                  # IPL_BS-residual=#bytes read
+        ar    %r2,%r7                          # add to total size
+        tm    8(%r5),0x01                      # found a tape mark ?
+        bnz   .Ldone
+        l     %r0,.Lccwread+4                  # update CCW data addresses
+        ar    %r0,%r7
+        st    %r0,.Lccwread+4                
+        b     .Lldlp
+.Ldone:
+        l     %r14,.Lldret
+        br    %r14                             # r2 contains the total size
+.Lrecov:
+        bas   %r14,.Lsense                     # do the sensing
+        bct   %r6,.Lssch                       # dec. retry count & branch
+        b     .Llderr
+#
+# Sense subroutine
+#
+.Lsense:
+        st    %r14,.Lsnsret
+        la    %r7,.Lorbsense              
+        ssch  0(%r7)                           # start sense command
+        bnz   .Llderr
+        bas   %r14,.Lwait4io
+        l     %r14,.Lsnsret
+        tm    8(%r5),0x82                      # do we have a problem ?
+        bnz   .Llderr
+        br    %r14
+#
+# Wait for interrupt subroutine
+#
+.Lwait4io:
+        lpsw  .Lwaitpsw                 
+.Lioint:
+        c     %r1,0xb8                         # compare subchannel number
+        bne   .Lwait4io
+        tsch  0(%r5)
+        slr   %r0,%r0
+        tm    8(%r5),0x82                      # do we have a problem ?
+        bnz   .Lwtexit
+        tm    8(%r5),0x04                      # got device end ?
+        bz    .Lwait4io
+.Lwtexit:
+        br    %r14
+.Llderr:
+        lpsw  .Lcrash              
+
+        .align 8
+.Lorbread:
+	.long  0x00000000,0x0080ff00,.Lccwread
+        .align 8
+.Lorbsense:
+        .long  0x00000000,0x0080ff00,.Lccwsense
+        .align 8
+.Lccwread:
+        .long  0x02200000+IPL_BS,0x00000000
+.Lccwsense:
+        .long  0x04200001,0x00000000
+.Lwaitpsw:
+	.long  0x020a0000,0x80000000+.Lioint
+
+.Lirb:	.long  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
+.Lcr6:  .long  0xff000000
+        .align 8
+.Lcrash:.long  0x000a0000,0x00000000
+.Lldret:.long  0
+.Lsnsret: .long 0
+#endif  /* CONFIG_IPL_TAPE */
+
+#ifdef CONFIG_IPL_VM
+#define IPL_BS 0x730
+        .org   0
+        .long  0x00080000,0x80000000+iplstart  # The first 24 bytes are loaded
+        .long  0x02000018,0x60000050           # by ipl to addresses 0-23.
+        .long  0x02000068,0x60000050           # (a PSW and two CCWs).
+        .fill  80-24,1,0x40                    # bytes 24-79 are discarded !!
+        .long  0x020000f0,0x60000050           # The next 160 byte are loaded
+        .long  0x02000140,0x60000050           # to addresses 0x18-0xb7
+        .long  0x02000190,0x60000050           # They form the continuation
+        .long  0x020001e0,0x60000050           # of the CCW program started
+        .long  0x02000230,0x60000050           # by ipl and load the range
+        .long  0x02000280,0x60000050           # 0x0f0-0x730 from the image
+        .long  0x020002d0,0x60000050           # to the range 0x0f0-0x730
+        .long  0x02000320,0x60000050           # in memory. At the end of
+        .long  0x02000370,0x60000050           # the channel program the PSW
+        .long  0x020003c0,0x60000050           # at location 0 is loaded.
+        .long  0x02000410,0x60000050           # Initial processing starts
+        .long  0x02000460,0x60000050           # at 0xf0 = iplstart.
+        .long  0x020004b0,0x60000050
+        .long  0x02000500,0x60000050
+        .long  0x02000550,0x60000050
+        .long  0x020005a0,0x60000050
+        .long  0x020005f0,0x60000050
+        .long  0x02000640,0x60000050
+        .long  0x02000690,0x60000050
+        .long  0x020006e0,0x20000050
+
+        .org   0xf0
+#
+# subroutine for loading cards from the reader
+#
+.Lloader:	
+	la    %r3,.Lorb                        # r2 = address of orb into r2
+	la    %r5,.Lirb                        # r4 = address of irb
+        la    %r6,.Lccws              
+        la    %r7,20
+.Linit:
+        st    %r2,4(%r6)                       # initialize CCW data addresses
+        la    %r2,0x50(%r2)
+        la    %r6,8(%r6)
+        bct   7,.Linit
+
+        lctl  %c6,%c6,.Lcr6                    # set IO subclass mask
+	slr   %r2,%r2
+.Lldlp:
+        ssch  0(%r3)                           # load chunk of 1600 bytes
+        bnz   .Llderr
+.Lwait4irq:
+        mvc   0x78(8),.Lnewpsw                 # set up IO interrupt psw
+        lpsw  .Lwaitpsw              
+.Lioint:
+        c     %r1,0xb8                         # compare subchannel number
+	bne   .Lwait4irq
+	tsch  0(%r5)
+
+	slr   %r0,%r0
+	ic    %r0,8(%r5)                       # get device status
+	chi   %r0,8                            # channel end ?
+	be    .Lcont
+	chi   %r0,12                           # channel end + device end ?
+	be    .Lcont
+
+        l     %r0,4(%r5)
+        s     %r0,8(%r3)                       # r0/8 = number of ccws executed
+        mhi   %r0,10                           # *10 = number of bytes in ccws
+        lh    %r3,10(%r5)                      # get residual count
+        sr    %r0,%r3                          # #ccws*80-residual=#bytes read
+	ar    %r2,%r0
+	
+        br    %r14                             # r2 contains the total size
+
+.Lcont:
+	ahi   %r2,0x640                        # add 0x640 to total size
+        la    %r6,.Lccws             
+        la    %r7,20
+.Lincr:
+        l     %r0,4(%r6)                       # update CCW data addresses
+        ahi   %r0,0x640
+        st    %r0,4(%r6)
+        ahi   %r6,8
+        bct   7,.Lincr
+
+        b     .Lldlp
+.Llderr:
+        lpsw  .Lcrash              
+
+        .align 8
+.Lorb:	.long  0x00000000,0x0080ff00,.Lccws
+.Lirb:	.long  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
+.Lcr6:  .long  0xff000000
+.Lloadp:.long  0,0
+        .align 8
+.Lcrash:.long  0x000a0000,0x00000000
+.Lnewpsw:
+        .long  0x00080000,0x80000000+.Lioint
+.Lwaitpsw:
+        .long  0x020a0000,0x80000000+.Lioint
+
+        .align 8
+.Lccws: .rept  19
+        .long  0x02600050,0x00000000
+        .endr
+        .long  0x02200050,0x00000000
+#endif  /* CONFIG_IPL_VM */
+
+iplstart:
+        lh    %r1,0xb8                         # test if subchannel number
+        bct   %r1,.Lnoload                     #  is valid
+	l     %r1,0xb8                         # load ipl subchannel number
+        la    %r2,IPL_BS                       # load start address
+        bas   %r14,.Lloader                    # load rest of ipl image
+        larl  %r12,_pstart                     # pointer to parameter area
+        st    %r1,IPL_DEVICE+4-PARMAREA(%r12)  # store ipl device number
+
+#
+# load parameter file from ipl device
+#
+.Lagain1:
+ 	l     %r2,INITRD_START+4-PARMAREA(%r12)# use ramdisk location as temp
+        bas   %r14,.Lloader                    # load parameter file
+        ltr   %r2,%r2                          # got anything ?
+        bz    .Lnopf
+	chi   %r2,895
+	bnh   .Lnotrunc
+	la    %r2,895
+.Lnotrunc:
+	l     %r4,INITRD_START+4-PARMAREA(%r12)
+ 	clc   0(3,%r4),.L_hdr		       # if it is HDRx
+ 	bz    .Lagain1			       # skip dataset header
+ 	clc   0(3,%r4),.L_eof		       # if it is EOFx
+ 	bz    .Lagain1			       # skip dateset trailer
+        la    %r5,0(%r4,%r2)
+        lr    %r3,%r2
+.Lidebc:
+        tm    0(%r5),0x80                      # high order bit set ?
+        bo    .Ldocv                           #  yes -> convert from EBCDIC
+        ahi   %r5,-1
+        bct   %r3,.Lidebc
+        b     .Lnocv
+.Ldocv:
+        l     %r3,.Lcvtab
+        tr    0(256,%r4),0(%r3)                # convert parameters to ascii
+        tr    256(256,%r4),0(%r3)
+        tr    512(256,%r4),0(%r3)
+        tr    768(122,%r4),0(%r3)
+.Lnocv: la    %r3,COMMAND_LINE-PARMAREA(%r12)  # load adr. of command line
+	mvc   0(256,%r3),0(%r4)
+	mvc   256(256,%r3),256(%r4)
+	mvc   512(256,%r3),512(%r4)
+	mvc   768(122,%r3),768(%r4)
+        slr   %r0,%r0
+        b     .Lcntlp
+.Ldelspc:
+        ic    %r0,0(%r2,%r3)
+        chi   %r0,0x20                         # is it a space ?
+        be    .Lcntlp
+        ahi   %r2,1
+        b     .Leolp
+.Lcntlp:
+        brct  %r2,.Ldelspc
+.Leolp:
+        slr   %r0,%r0
+        stc   %r0,0(%r2,%r3)                   # terminate buffer
+.Lnopf:
+
+#
+# load ramdisk from ipl device
+#
+.Lagain2:
+ 	l     %r2,INITRD_START+4-PARMAREA(%r12)# load adr. of ramdisk
+        bas   %r14,.Lloader                    # load ramdisk
+ 	st    %r2,INITRD_SIZE+4-PARMAREA(%r12) # store size of ramdisk
+        ltr   %r2,%r2
+        bnz   .Lrdcont
+        st    %r2,INITRD_START+4-PARMAREA(%r12)# no ramdisk found, null it
+.Lrdcont:
+	l     %r2,INITRD_START+4-PARMAREA(%r12)
+	clc   0(3,%r2),.L_hdr		       # skip HDRx and EOFx 
+	bz    .Lagain2
+	clc   0(3,%r2),.L_eof
+	bz    .Lagain2
+
+#ifdef CONFIG_IPL_VM
+#
+# reset files in VM reader
+#
+        stidp __LC_CPUID                       # store cpuid
+	tm    __LC_CPUID,0xff                  # running VM ?
+	bno   .Lnoreset
+        la    %r2,.Lreset              
+        lhi   %r3,26
+        .long 0x83230008
+.Lnoreset:
+#endif
+	
+#
+# everything loaded, go for it
+#
+.Lnoload:
+        l     %r1,.Lstartup
+        br    %r1
+
+.Lstartup: .long startup
+.Lcvtab:.long  _ebcasc                         # ebcdic to ascii table
+.Lreset:.byte  0xc3,0xc8,0xc1,0xd5,0xc7,0xc5,0x40,0xd9,0xc4,0xd9,0x40
+        .byte  0xc1,0xd3,0xd3,0x40,0xd2,0xc5,0xc5,0xd7,0x40,0xd5,0xd6
+        .byte  0xc8,0xd6,0xd3,0xc4             # "change rdr all keep nohold"
+.L_eof: .long  0xc5d6c600       /* C'EOF' */
+.L_hdr: .long  0xc8c4d900       /* C'HDR' */
+#endif  /* CONFIG_IPL */
+
+#
+# SALIPL loader support. Based on a patch by Rob van der Heij.
+# This entry point is called directly from the SALIPL loader and
+# doesn't need a builtin ipl record.
+#
+        .org  0x800
+	.globl start
+start:
+	stm   %r0,%r15,0x07b0		# store registers
+	basr  %r12,%r0
+.base:
+	l     %r11,.parm
+	l     %r8,.cmd			# pointer to command buffer
+
+	ltr   %r9,%r9			# do we have SALIPL parameters?
+	bp    .sk8x8
+
+	mvc   0(64,%r8),0x00b0		# copy saved registers
+	xc    64(240-64,%r8),0(%r8)	# remainder of buffer
+	tr    0(64,%r8),.lowcase	
+	b     .gotr
+.sk8x8:
+	mvc   0(240,%r8),0(%r9)		# copy iplparms into buffer
+.gotr:
+	l     %r10,.tbl			# EBCDIC to ASCII table
+	tr    0(240,%r8),0(%r10)
+	stidp __LC_CPUID		# Are we running on VM maybe
+	cli   __LC_CPUID,0xff
+	bnz   .test
+	.long 0x83300060		# diag 3,0,x'0060' - storage size
+	b     .done
+.test:
+	mvc   0x68(8),.pgmnw		# set up pgm check handler
+	l     %r2,.fourmeg
+	lr    %r3,%r2
+	bctr  %r3,%r0			# 4M-1
+.loop:  iske  %r0,%r3
+	ar    %r3,%r2
+.pgmx:
+	sr    %r3,%r2
+	la    %r3,1(%r3)
+.done:
+	l     %r1,.memsize
+	st    %r3,4(%r1)
+	slr   %r0,%r0
+	st    %r0,INITRD_SIZE+4-PARMAREA(%r11)
+	st    %r0,INITRD_START+4-PARMAREA(%r11)
+	j     startup                   # continue with startup
+.tbl:	.long _ebcasc			# translate table
+.cmd:	.long COMMAND_LINE		# address of command line buffer
+.parm:	.long PARMAREA
+.fourmeg: .long 0x00400000      	# 4M
+.pgmnw:	.long 0x00080000,.pgmx
+.memsize: .long memory_size
+.lowcase:
+	.byte 0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07 
+	.byte 0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f
+	.byte 0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17 
+	.byte 0x18,0x19,0x1a,0x1b,0x1c,0x1d,0x1e,0x1f
+	.byte 0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27 
+	.byte 0x28,0x29,0x2a,0x2b,0x2c,0x2d,0x2e,0x2f
+	.byte 0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37 
+	.byte 0x38,0x39,0x3a,0x3b,0x3c,0x3d,0x3e,0x3f
+	.byte 0x40,0x41,0x42,0x43,0x44,0x45,0x46,0x47 
+	.byte 0x48,0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f
+	.byte 0x50,0x51,0x52,0x53,0x54,0x55,0x56,0x57 
+	.byte 0x58,0x59,0x5a,0x5b,0x5c,0x5d,0x5e,0x5f
+	.byte 0x60,0x61,0x62,0x63,0x64,0x65,0x66,0x67 
+	.byte 0x68,0x69,0x6a,0x6b,0x6c,0x6d,0x6e,0x6f
+	.byte 0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77 
+	.byte 0x78,0x79,0x7a,0x7b,0x7c,0x7d,0x7e,0x7f
+
+	.byte 0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87 
+	.byte 0x88,0x89,0x8a,0x8b,0x8c,0x8d,0x8e,0x8f
+	.byte 0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97 
+	.byte 0x98,0x99,0x9a,0x9b,0x9c,0x9d,0x9e,0x9f
+	.byte 0xa0,0xa1,0xa2,0xa3,0xa4,0xa5,0xa6,0xa7 
+	.byte 0xa8,0xa9,0xaa,0xab,0xac,0xad,0xae,0xaf
+	.byte 0xb0,0xb1,0xb2,0xb3,0xb4,0xb5,0xb6,0xb7 
+	.byte 0xb8,0xb9,0xba,0xbb,0xbc,0xbd,0xbe,0xbf
+	.byte 0xc0,0x81,0x82,0x83,0x84,0x85,0x86,0x87	# .abcdefg 
+	.byte 0x88,0x89,0xca,0xcb,0xcc,0xcd,0xce,0xcf	# hi
+	.byte 0xd0,0x91,0x92,0x93,0x94,0x95,0x96,0x97 	# .jklmnop
+	.byte 0x98,0x99,0xda,0xdb,0xdc,0xdd,0xde,0xdf	# qr
+	.byte 0xe0,0xe1,0xa2,0xa3,0xa4,0xa5,0xa6,0xa7	# ..stuvwx
+	.byte 0xa8,0xa9,0xea,0xeb,0xec,0xed,0xee,0xef	# yz
+	.byte 0xf0,0xf1,0xf2,0xf3,0xf4,0xf5,0xf6,0xf7 
+	.byte 0xf8,0xf9,0xfa,0xfb,0xfc,0xfd,0xfe,0xff
+
+#
+# startup-code at 0x10000, running in real mode
+# this is called either by the ipl loader or directly by PSW restart
+# or linload or SALIPL
+#
+        .org  0x10000
+startup:basr  %r13,0                     # get base
+.LPG1:  sll   %r13,1                     # remove high order bit
+        srl   %r13,1
+        lhi   %r1,1                      # mode 1 = esame
+        slr   %r0,%r0                    # set cpuid to zero
+        sigp  %r1,%r0,0x12               # switch to esame mode
+	sam64				 # switch to 64 bit mode
+	lctlg %c0,%c15,.Lctl-.LPG1(%r13) # load control registers
+	larl  %r12,_pstart               # pointer to parameter area
+					 # move IPL device to lowcore
+        mvc   __LC_IPLDEV(4),IPL_DEVICE+4-PARMAREA(%r12)
+
+#
+# clear bss memory
+#
+	larl  %r2,__bss_start           # start of bss segment
+        larl  %r3,_end                  # end of bss segment
+        sgr   %r3,%r2                   # length of bss
+        sgr   %r4,%r4                   #
+        sgr   %r5,%r5                   # set src,length and pad to zero
+        mvcle %r2,%r4,0                 # clear mem
+        jo    .-4                       # branch back, if not finish
+
+					 # set program check new psw mask
+	mvc   __LC_PGM_NEW_PSW(8),.Lpcmsk-.LPG1(%r13)
+
+#
+# find memory chunks.
+#
+	larl  %r1,.Lchkmem               # set program check address
+	stg   %r1,__LC_PGM_NEW_PSW+8
+	la    %r1,1                      # test in increments of 128KB
+	sllg  %r1,%r1,17
+	larl  %r3,memory_chunk
+	slgr  %r4,%r4                    # set start of chunk to zero
+	slgr  %r5,%r5                    # set end of chunk to zero
+	slr  %r6,%r6			 # set access code to zero
+.Lloop:
+	tprot 0(%r5),0			 # test protection of first byte
+	ipm   %r7
+	srl   %r7,28
+	clr   %r6,%r7			 # compare cc with last access code
+	je    .Lsame
+	clgr  %r4,%r5			 # chunk size > 0?
+	je    .Lsize0
+	stg   %r4,0(%r3)		 # store start address of chunk
+	lgr   %r0,%r5
+	slgr  %r0,%r4
+	stg   %r0,8(%r3)		 # store size of chunk
+	st    %r6,20(%r3)		 # store type of chunk
+	la    %r3,24(%r3)
+	lgr   %r4,%r5			 # set start to end
+	larl  %r8,memory_size
+	stg   %r5,0(%r8)                 # store memory size
+.Lsize0:
+	lr    %r6,%r7			 # set access code to last cc
+.Lsame:
+	algr  %r5,%r1			 # add 128KB to end of chunk
+	brc   12,.Lloop
+.Lchkmem:				 # > 16EB or tprot got a program check
+	clgr  %r4,%r5			 # chunk size > 0?
+	je    .Ldonemem
+	stg   %r4,0(%r3)		 # store start address of chunk
+	lgr   %r0,%r5
+	slgr  %r0,%r4
+	stg   %r0,8(%r3)		 # store size of chunk
+	st    %r6,20(%r3)		 # store type of chunk
+	la    %r3,24(%r3)
+	lgr   %r4,%r5
+	larl  %r8,memory_size
+	stg   %r5,0(%r8)                 # store memory size
+#
+# Running native the HSA is located at 2GB and we will get an
+# addressing exception trying to access it. We have to restart
+# the scan at 2GB to find out if the machine has more than 2GB.
+#
+	lghi  %r4,1
+	sllg  %r4,%r4,31
+	clgr  %r5,%r4
+	jhe   .Ldonemem
+	lgr   %r5,%r4
+	j     .Lloop
+.Ldonemem:		
+
+	larl  %r12,machine_flags
+#
+# find out if we are running under VM
+#
+        stidp  __LC_CPUID               # store cpuid
+	tm     __LC_CPUID,0xff          # running under VM ?
+	bno    0f-.LPG1(%r13)
+        oi     7(%r12),1                # set VM flag
+0:      lh     %r0,__LC_CPUID+4         # get cpu version
+        chi    %r0,0x7490               # running on a P/390 ?
+        bne    1f-.LPG1(%r13)
+        oi     7(%r12),4                # set P/390 flag
+1:
+
+#
+# find out if we have the MVPG instruction
+#
+	la     %r1,0f-.LPG1(%r13)       # set program check address
+	stg    %r1,__LC_PGM_NEW_PSW+8
+	sgr    %r0,%r0
+	lghi   %r1,0
+	lghi   %r2,0
+	mvpg   %r1,%r2                  # test MVPG instruction
+	oi     7(%r12),16               # set MVPG flag
+0:
+
+#
+# find out if the diag 0x44 works in 64 bit mode
+#
+	la     %r1,0f-.LPG1(%r13)	# set program check address
+	stg    %r1,__LC_PGM_NEW_PSW+8
+	mvc    __LC_DIAG44_OPCODE(8),.Lnop-.LPG1(%r13)
+	diag   0,0,0x44			# test diag 0x44
+	oi     7(%r12),32		# set diag44 flag
+	mvc    __LC_DIAG44_OPCODE(8),.Ldiag44-.LPG1(%r13)
+0:	
+
+        lpswe .Lentry-.LPG1(13)         # jump to _stext in primary-space,
+                                        # virtual and never return ...
+        .align 16
+.Lentry:.quad  0x0000000180000000,_stext
+.Lctl:  .quad  0x04b50002               # cr0: various things
+        .quad  0                        # cr1: primary space segment table
+        .quad  .Lduct                   # cr2: dispatchable unit control table
+        .quad  0                        # cr3: instruction authorization
+        .quad  0                        # cr4: instruction authorization
+        .quad  0                        # cr5:  various things
+        .quad  0                        # cr6:  I/O interrupts
+        .quad  0                        # cr7:  secondary space segment table
+        .quad  0                        # cr8:  access registers translation
+        .quad  0                        # cr9:  tracing off
+        .quad  0                        # cr10: tracing off
+        .quad  0                        # cr11: tracing off
+        .quad  0                        # cr12: tracing off
+        .quad  0                        # cr13: home space segment table
+        .quad  0xc0000000               # cr14: machine check handling off
+        .quad  0                        # cr15: linkage stack operations
+.Lpcmsk:.quad  0x0000000180000000
+.L4malign:.quad 0xffffffffffc00000
+.Lscan2g:.quad 0x80000000 + 0x20000 - 8 # 2GB + 128K - 8
+.Lnop:	.long  0x07000700
+.Ldiag44:.long 0x83000044
+
+	.org PARMAREA-64
+.Lduct:	.long 0,0,0,0,0,0,0,0
+	.long 0,0,0,0,0,0,0,0
+
+#
+# params at 10400 (setup.h)
+#
+	.org   PARMAREA
+	.global _pstart
+_pstart:
+	.quad  0                        # IPL_DEVICE
+        .quad  RAMDISK_ORIGIN           # INITRD_START
+        .quad  RAMDISK_SIZE             # INITRD_SIZE
+
+        .org   COMMAND_LINE
+    	.byte  "root=/dev/ram0 ro"
+        .byte  0
+	.org   0x11000
+	.global _pend
+_pend:	
+
+#ifdef CONFIG_SHARED_KERNEL
+	.org   0x100000
+#endif
+	
+#
+# startup-code, running in virtual mode
+#
+        .globl _stext
+_stext:	basr  %r13,0                    # get base
+.LPG2:
+#
+# Setup stack
+#
+	larl  %r15,init_thread_union
+        aghi  %r15,16384                # init_task_union + 16384
+        stg   %r15,__LC_KERNEL_STACK    # set end of kernel stack
+        aghi  %r15,-160
+        xc    0(8,%r15),0(%r15)         # set backchain to zero
+
+# check control registers
+        stctg  %c0,%c15,0(%r15)
+	oi     6(%r15),0x20             # enable sigp external interrupts
+	oi     4(%r15),0x10             # switch on low address proctection
+        lctlg  %c0,%c15,0(%r15)
+
+#
+        lam    0,15,.Laregs-.LPG2(%r13) # load access regs needed by uaccess
+        brasl  %r14,start_kernel        # go to C code
+#
+# We returned from start_kernel ?!? PANIK
+#
+        basr  %r13,0
+	lpswe .Ldw-.(%r13)           # load disabled wait psw
+#
+            .align 8
+.Ldw:       .quad  0x0002000180000000,0x0000000000000000
+.Laregs:    .long  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
+
diff -urN linux-2.5.67/arch/s390/kernel/module.c linux-2.5.67-s390/arch/s390/kernel/module.c
--- linux-2.5.67/arch/s390/kernel/module.c	Mon Apr  7 19:32:29 2003
+++ linux-2.5.67-s390/arch/s390/kernel/module.c	Mon Apr 14 19:11:56 2003
@@ -37,8 +37,11 @@
 #define DEBUGP(fmt , ...)
 #endif
 
-#define GOT_ENTRY_SIZE 4
+#ifndef CONFIG_ARCH_S390X
 #define PLT_ENTRY_SIZE 12
+#else /* CONFIG_ARCH_S390X */
+#define PLT_ENTRY_SIZE 20
+#endif /* CONFIG_ARCH_S390X */
 
 void *module_alloc(unsigned long size)
 {
@@ -56,30 +59,34 @@
 }
 
 static inline void
-check_rela(Elf32_Rela *rela, struct module *me)
+check_rela(Elf_Rela *rela, struct module *me)
 {
 	struct mod_arch_syminfo *info;
 
-	info = me->arch.syminfo + ELF32_R_SYM (rela->r_info);
-	switch (ELF32_R_TYPE (rela->r_info)) {
+	info = me->arch.syminfo + ELF_R_SYM (rela->r_info);
+	switch (ELF_R_TYPE (rela->r_info)) {
 	case R_390_GOT12:	/* 12 bit GOT offset.  */
 	case R_390_GOT16:	/* 16 bit GOT offset.  */
 	case R_390_GOT32:	/* 32 bit GOT offset.  */
+	case R_390_GOT64:	/* 64 bit GOT offset.  */
 	case R_390_GOTENT:	/* 32 bit PC rel. to GOT entry shifted by 1. */
 	case R_390_GOTPLT12:	/* 12 bit offset to jump slot.	*/
 	case R_390_GOTPLT16:	/* 16 bit offset to jump slot. */
 	case R_390_GOTPLT32:	/* 32 bit offset to jump slot. */
+	case R_390_GOTPLT64:	/* 64 bit offset to jump slot.	*/
 	case R_390_GOTPLTENT:	/* 32 bit rel. offset to jump slot >> 1. */
 		if (info->got_offset == -1UL) {
 			info->got_offset = me->arch.got_size;
-			me->arch.got_size += GOT_ENTRY_SIZE;
+			me->arch.got_size += sizeof(void*);
 		}
 		break;
 	case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
 	case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
 	case R_390_PLT32:	/* 32 bit PC relative PLT address.  */
+	case R_390_PLT64:	/* 64 bit PC relative PLT address.  */
 	case R_390_PLTOFF16:	/* 16 bit offset from GOT to PLT. */
 	case R_390_PLTOFF32:	/* 32 bit offset from GOT to PLT. */
+	case R_390_PLTOFF64:	/* 16 bit offset from GOT to PLT. */
 		if (info->plt_offset == -1UL) {
 			info->plt_offset = me->arch.plt_size;
 			me->arch.plt_size += PLT_ENTRY_SIZE;
@@ -100,12 +107,12 @@
  * got and plt but we can increase the core module size.
  */
 int
-module_frob_arch_sections(Elf32_Ehdr *hdr, Elf32_Shdr *sechdrs,
+module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			  char *secstrings, struct module *me)
 {
-	Elf32_Shdr *symtab;
-	Elf32_Sym *symbols;
-	Elf32_Rela *rela;
+	Elf_Shdr *symtab;
+	Elf_Sym *symbols;
+	Elf_Rela *rela;
 	char *strings;
 	int nrela, i, j;
 
@@ -123,7 +130,7 @@
 	}
 
 	/* Allocate one syminfo structure per symbol. */
-	me->arch.nsyms = symtab->sh_size / sizeof(Elf32_Sym);
+	me->arch.nsyms = symtab->sh_size / sizeof(Elf_Sym);
 	me->arch.syminfo = kmalloc(me->arch.nsyms *
 				   sizeof(struct mod_arch_syminfo),
 				   GFP_KERNEL);
@@ -148,7 +155,7 @@
 	for (i = 0; i < hdr->e_shnum; i++) {
 		if (sechdrs[i].sh_type != SHT_RELA)
 			continue;
-		nrela = sechdrs[i].sh_size / sizeof(Elf32_Rela);
+		nrela = sechdrs[i].sh_size / sizeof(Elf_Rela);
 		rela = (void *) hdr + sechdrs[i].sh_offset;
 		for (j = 0; j < nrela; j++)
 			check_rela(rela + j, me);
@@ -174,19 +181,19 @@
 }
 
 static inline int
-apply_rela(Elf32_Rela *rela, Elf32_Addr base, Elf32_Sym *symtab, 
+apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab, 
 	   struct module *me)
 {
 	struct mod_arch_syminfo *info;
-	Elf32_Addr loc, val;
+	Elf_Addr loc, val;
 	int r_type, r_sym;
 
 	/* This is where to make the change */
 	loc = base + rela->r_offset;
 	/* This is the symbol it is referring to.  Note that all
 	   undefined symbols have been resolved.  */
-	r_sym = ELF32_R_SYM(rela->r_info);
-	r_type = ELF32_R_TYPE(rela->r_info);
+	r_sym = ELF_R_SYM(rela->r_info);
+	r_type = ELF_R_TYPE(rela->r_info);
 	info = me->arch.syminfo + r_sym;
 	val = symtab[r_sym].st_value;
 
@@ -195,6 +202,7 @@
 	case R_390_12:		/* Direct 12 bit.  */
 	case R_390_16:		/* Direct 16 bit.  */
 	case R_390_32:		/* Direct 32 bit.  */
+	case R_390_64:		/* Direct 64 bit.  */
 		val += rela->r_addend;
 		if (r_type == R_390_8)
 			*(unsigned char *) loc = val;
@@ -205,11 +213,14 @@
 			*(unsigned short *) loc = val;
 		else if (r_type == R_390_32)
 			*(unsigned int *) loc = val;
+		else if (r_type == R_390_64)
+			*(unsigned long *) loc = val;
 		break;
 	case R_390_PC16:	/* PC relative 16 bit.  */
 	case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
 	case R_390_PC32DBL:	/* PC relative 32 bit shifted by 1.  */
 	case R_390_PC32:	/* PC relative 32 bit.  */
+	case R_390_PC64:	/* PC relative 64 bit.	*/
 		val += rela->r_addend - loc;
 		if (r_type == R_390_PC16)
 			*(unsigned short *) loc = val;
@@ -219,17 +230,22 @@
 			*(unsigned int *) loc = val >> 1;
 		else if (r_type == R_390_PC32)
 			*(unsigned int *) loc = val;
+		else if (r_type == R_390_PC64)
+			*(unsigned long *) loc = val;
 		break;
 	case R_390_GOT12:	/* 12 bit GOT offset.  */
 	case R_390_GOT16:	/* 16 bit GOT offset.  */
 	case R_390_GOT32:	/* 32 bit GOT offset.  */
+	case R_390_GOT64:	/* 64 bit GOT offset.  */
 	case R_390_GOTENT:	/* 32 bit PC rel. to GOT entry shifted by 1. */
 	case R_390_GOTPLT12:	/* 12 bit offset to jump slot.	*/
 	case R_390_GOTPLT16:	/* 16 bit offset to jump slot. */
 	case R_390_GOTPLT32:	/* 32 bit offset to jump slot. */
+	case R_390_GOTPLT64:	/* 64 bit offset to jump slot.	*/
 	case R_390_GOTPLTENT:	/* 32 bit rel. offset to jump slot >> 1. */
 		if (info->got_initialized == 0) {
-			Elf32_Addr *gotent;
+			Elf_Addr *gotent;
+
 			gotent = me->module_core + me->arch.got_offset +
 				info->got_offset;
 			*gotent = val;
@@ -249,27 +265,42 @@
 		else if (r_type == R_390_GOTENT ||
 			 r_type == R_390_GOTPLTENT)
 			*(unsigned int *) loc = val >> 1;
+		else if (r_type == R_390_GOT64 ||
+			 r_type == R_390_GOTPLT64)
+			*(unsigned long *) loc = val;
 		break;
 	case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
 	case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
 	case R_390_PLT32:	/* 32 bit PC relative PLT address.  */
+	case R_390_PLT64:	/* 64 bit PC relative PLT address.  */
 	case R_390_PLTOFF16:	/* 16 bit offset from GOT to PLT. */
 	case R_390_PLTOFF32:	/* 32 bit offset from GOT to PLT. */
+	case R_390_PLTOFF64:	/* 16 bit offset from GOT to PLT. */
 		if (info->plt_initialized == 0) {
 			unsigned int *ip;
 			ip = me->module_core + me->arch.plt_offset +
 				info->plt_offset;
+#ifndef CONFIG_ARCH_S390X
 			ip[0] = 0x0d105810; /* basr 1,0; l 1,6(1); br 1 */
 			ip[1] = 0x100607f1;
 			ip[2] = val;
+#else /* CONFIG_ARCH_S390X */
+			ip[0] = 0x0d10e310; /* basr 1,0; lg 1,10(1); br 1 */
+			ip[1] = 0x100a0004;
+			ip[2] = 0x07f10000;
+			ip[3] = (unsigned int) (val >> 32);
+			ip[4] = (unsigned int) val;
+#endif /* CONFIG_ARCH_S390X */
 			info->plt_initialized = 1;
 		}
 		if (r_type == R_390_PLTOFF16 ||
-		    r_type == R_390_PLTOFF32)
+		    r_type == R_390_PLTOFF32
+		    || r_type == R_390_PLTOFF64
+			)
 			val = me->arch.plt_offset - me->arch.got_offset +
 				info->plt_offset + rela->r_addend;
 		else
-			val =  (Elf32_Addr) me->module_core +
+			val =  (Elf_Addr) me->module_core +
 				me->arch.plt_offset + info->plt_offset + 
 				rela->r_addend - loc;
 		if (r_type == R_390_PLT16DBL)
@@ -281,19 +312,25 @@
 		else if (r_type == R_390_PLT32 ||
 			 r_type == R_390_PLTOFF32)
 			*(unsigned int *) loc = val;
+		else if (r_type == R_390_PLT64 ||
+			 r_type == R_390_PLTOFF64)
+			*(unsigned long *) loc = val;
 		break;
 	case R_390_GOTOFF16:	/* 16 bit offset to GOT.  */
 	case R_390_GOTOFF32:	/* 32 bit offset to GOT.  */
+	case R_390_GOTOFF64:	/* 64 bit offset to GOT. */
 		val = val + rela->r_addend -
-			((Elf32_Addr) me->module_core + me->arch.got_offset);
+			((Elf_Addr) me->module_core + me->arch.got_offset);
 		if (r_type == R_390_GOTOFF16)
 			*(unsigned short *) loc = val;
 		else if (r_type == R_390_GOTOFF32)
 			*(unsigned int *) loc = val;
+		else if (r_type == R_390_GOTOFF64)
+			*(unsigned long *) loc = val;
 		break;
 	case R_390_GOTPC:	/* 32 bit PC relative offset to GOT. */
 	case R_390_GOTPCDBL:	/* 32 bit PC rel. off. to GOT shifted by 1. */
-		val = (Elf32_Addr) me->module_core + me->arch.got_offset +
+		val = (Elf_Addr) me->module_core + me->arch.got_offset +
 			rela->r_addend - loc;
 		if (r_type == R_390_GOTPC)
 			*(unsigned int *) loc = val;
@@ -316,22 +353,23 @@
 }
 
 int
-apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
+apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		   unsigned int symindex, unsigned int relsec,
 		   struct module *me)
 {
-	Elf32_Addr base;
-	Elf32_Sym *symtab;
-	Elf32_Rela *rela;
+	Elf_Addr base;
+	Elf_Sym *symtab;
+	Elf_Rela *rela;
 	unsigned long i, n;
 	int rc;
 
 	DEBUGP("Applying relocate section %u to %u\n",
 	       relsec, sechdrs[relsec].sh_info);
 	base = sechdrs[sechdrs[relsec].sh_info].sh_addr;
-	symtab = (Elf32_Sym *) sechdrs[symindex].sh_addr;
-	rela = (Elf32_Rela *) sechdrs[relsec].sh_addr;
-	n = sechdrs[relsec].sh_size / sizeof(Elf32_Rela);
+	symtab = (Elf_Sym *) sechdrs[symindex].sh_addr;
+	rela = (Elf_Rela *) sechdrs[relsec].sh_addr;
+	n = sechdrs[relsec].sh_size / sizeof(Elf_Rela);
+
 	for (i = 0; i < n; i++, rela++) {
 		rc = apply_rela(rela, base, symtab, me);
 		if (rc)
diff -urN linux-2.5.67/arch/s390/kernel/process.c linux-2.5.67-s390/arch/s390/kernel/process.c
--- linux-2.5.67/arch/s390/kernel/process.c	Mon Apr  7 19:32:19 2003
+++ linux-2.5.67-s390/arch/s390/kernel/process.c	Mon Apr 14 19:11:56 2003
@@ -56,7 +56,11 @@
 	unsigned long bc;
 
 	bc = *((unsigned long *) tsk->thread.ksp);
+#ifndef CONFIG_ARCH_S390X
 	return *((unsigned long *) (bc+56));
+#else
+	return *((unsigned long *) (bc+112));
+#endif
 }
 
 /*
@@ -79,6 +83,7 @@
 	 */
 	wait_psw.mask = PSW_KERNEL_BITS | PSW_MASK_MCHECK | PSW_MASK_WAIT |
 		PSW_MASK_IO | PSW_MASK_EXT;
+#ifndef CONFIG_ARCH_S390X
 	asm volatile (
 		"    basr %0,0\n"
 		"0:  la   %0,1f-0b(%0)\n"
@@ -92,6 +97,18 @@
 		"    lpsw 0(%1)\n"
 		"2:"
 		: "=&a" (reg) : "a" (&wait_psw) : "memory", "cc" );
+#else /* CONFIG_ARCH_S390X */
+	asm volatile (
+		"    larl  %0,0f\n"
+		"    stg   %0,8(%1)\n"
+		"    lpswe 0(%1)\n"
+		"0:  larl  %0,1f\n"
+		"    stg   %0,8(%1)\n"
+		"    ni    1(%1),0xf9\n"
+		"    lpswe 0(%1)\n"
+		"1:"
+		: "=&a" (reg) : "a" (&wait_psw) : "memory", "cc" );
+#endif /* CONFIG_ARCH_S390X */
 }
 
 int cpu_idle(void)
@@ -109,9 +126,9 @@
 	struct task_struct *tsk = current;
 
         printk("CPU:    %d    %s\n", tsk->thread_info->cpu, print_tainted());
-        printk("Process %s (pid: %d, task: %08lx, ksp: %08x)\n",
-	       current->comm, current->pid, (unsigned long) tsk,
-	       tsk->thread.ksp);
+        printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
+	       current->comm, current->pid, (void *) tsk,
+	       (void *) tsk->thread.ksp);
 
 	show_registers(regs);
 	/* Show stack backtrace if pt_regs is from kernel mode */
@@ -120,6 +137,9 @@
 }
 
 extern void kernel_thread_starter(void);
+
+#ifndef CONFIG_ARCH_S390X
+
 __asm__(".align 4\n"
 	"kernel_thread_starter:\n"
 	"    l     15,0(8)\n"
@@ -130,6 +150,20 @@
 	"    sr    2,2\n"
 	"    br    11\n");
 
+#else /* CONFIG_ARCH_S390X */
+
+__asm__(".align 4\n"
+	"kernel_thread_starter:\n"
+	"    lg    15,0(8)\n"
+	"    sgr   15,7\n"
+	"    stosm 48(15),3\n"
+	"    lgr   2,10\n"
+	"    basr  14,9\n"
+	"    sgr   2,2\n"
+	"    br    11\n");
+
+#endif /* CONFIG_ARCH_S390X */
+
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
 	struct task_struct *p;
@@ -137,7 +171,7 @@
 
 	memset(&regs, 0, sizeof(regs));
 	regs.psw.mask = PSW_KERNEL_BITS;
-	regs.psw.addr = (__u32) kernel_thread_starter | PSW_ADDR_AMODE31;
+	regs.psw.addr = (unsigned long) kernel_thread_starter | PSW_ADDR_AMODE;
 	regs.gprs[7] = STACK_FRAME_OVERHEAD;
 	regs.gprs[8] = __LC_KERNEL_STACK;
 	regs.gprs[9] = (unsigned long) fn;
@@ -180,8 +214,8 @@
             unsigned long glue2;
             unsigned long scratch[2];
             unsigned long gprs[10];    /* gprs 6 -15                       */
-            unsigned long fprs[4];     /* fpr 4 and 6                      */
-            unsigned long empty[4];
+            unsigned int  fprs[4];     /* fpr 4 and 6                      */
+            unsigned int  empty[4];
             struct pt_regs childregs;
           } *frame;
 
@@ -198,7 +232,8 @@
         frame->gprs[8] = (unsigned long) ret_from_fork;
 
         /* fake return stack for resume(), don't go back to schedule */
-        frame->gprs[9]  = (unsigned long) frame;
+        frame->gprs[9] = (unsigned long) frame;
+#ifndef CONFIG_ARCH_S390X
         /*
 	 * save fprs to current->thread.fp_regs to merge them with
 	 * the emulated registers and then copy the result to the child.
@@ -207,14 +242,31 @@
 	memcpy(&p->thread.fp_regs, &current->thread.fp_regs,
 	       sizeof(s390_fp_regs));
         p->thread.user_seg = __pa((unsigned long) p->mm->pgd) | _SEGMENT_TABLE;
-	/* start process with ar4 pointing to the correct address space */
+	/* Set a new TLS ?  */
+	if (clone_flags & CLONE_SETTLS)
+		frame->childregs.acrs[0] = regs->gprs[6];
+#else /* CONFIG_ARCH_S390X */
+	/* Save the fpu registers to new thread structure. */
+	save_fp_regs(&p->thread.fp_regs);
+        p->thread.user_seg = __pa((unsigned long) p->mm->pgd) | _REGION_TABLE;
+	/* Set a new TLS ?  */
+	if (clone_flags & CLONE_SETTLS) {
+		if (test_thread_flag(TIF_31BIT)) {
+			frame->childregs.acrs[0] =
+				(unsigned int) regs->gprs[6];
+		} else {
+			frame->childregs.acrs[0] =
+				(unsigned int)(regs->gprs[6] >> 32);
+			frame->childregs.acrs[1] =
+				(unsigned int) regs->gprs[6];
+		}
+	}
+#endif /* CONFIG_ARCH_S390X */
+	/* start new process with ar4 pointing to the correct address space */
 	p->thread.ar4 = get_fs().ar4;
         /* Don't copy debug registers */
         memset(&p->thread.per_info,0,sizeof(p->thread.per_info));
 
-	/* Set a new TLS ?  */
-	if (clone_flags & CLONE_SETTLS)
-		frame->childregs.acrs[0] = regs->gprs[6];
         return 0;
 }
 
@@ -292,12 +344,16 @@
  */
 int dump_fpu (struct pt_regs * regs, s390_fp_regs *fpregs)
 {
+#ifndef CONFIG_ARCH_S390X
         /*
 	 * save fprs to current->thread.fp_regs to merge them with
 	 * the emulated registers and then copy the result to the dump.
 	 */
 	save_fp_regs(&current->thread.fp_regs);
 	memcpy(fpregs, &current->thread.fp_regs, sizeof(s390_fp_regs));
+#else /* CONFIG_ARCH_S390X */
+	save_fp_regs(fpregs);
+#endif /* CONFIG_ARCH_S390X */
 	return 1;
 }
 
@@ -339,16 +395,22 @@
 		return 0;
 	stack_page = (unsigned long) p->thread_info;
 	r15 = p->thread.ksp;
-        if (!stack_page || r15 < stack_page || r15 >= 8188+stack_page)
-                return 0;
-        bc = (*(unsigned long *) r15) & 0x7fffffff;
+	if (!stack_page || r15 < stack_page ||
+	    r15 >= THREAD_SIZE - sizeof(unsigned long) + stack_page)
+		return 0;
+	bc = (*(unsigned long *) r15) & PSW_ADDR_INSN;
 	do {
-                if (bc < stack_page || bc >= 8188+stack_page)
-                        return 0;
-		r14 = (*(unsigned long *) (bc+56)) & 0x7fffffff;
+		if (bc < stack_page ||
+		    bc >= THREAD_SIZE - sizeof(unsigned long) + stack_page)
+			return 0;
+#ifndef CONFIG_ARCH_S390X
+		r14 = (*(unsigned long *) (bc+56)) & PSW_ADDR_INSN;
+#else
+		r14 = *(unsigned long *) (bc+112);
+#endif
 		if (r14 < first_sched || r14 >= last_sched)
 			return r14;
-		bc = (*(unsigned long *) bc) & 0x7fffffff;
+		bc = (*(unsigned long *) bc) & PSW_ADDR_INSN;
 	} while (count++ < 16);
 	return 0;
 }
diff -urN linux-2.5.67/arch/s390/kernel/ptrace.c linux-2.5.67-s390/arch/s390/kernel/ptrace.c
--- linux-2.5.67/arch/s390/kernel/ptrace.c	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/arch/s390/kernel/ptrace.c	Mon Apr 14 19:11:56 2003
@@ -39,8 +39,12 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_S390_SUPPORT
+#include "compat_ptrace.h"
+#endif
 
-static void FixPerRegisters(struct task_struct *task)
+static void
+FixPerRegisters(struct task_struct *task)
 {
 	struct pt_regs *regs;
 	per_struct *per_info;
@@ -52,7 +56,12 @@
 	
 	if (per_info->single_step) {
 		per_info->control_regs.bits.starting_addr = 0;
-		per_info->control_regs.bits.ending_addr = 0x7fffffffUL;
+#ifdef CONFIG_S390_SUPPORT
+		if (test_thread_flag(TIF_31BIT))
+			per_info->control_regs.bits.ending_addr = 0x7fffffffUL;
+		else
+#endif
+			per_info->control_regs.bits.ending_addr = PSW_ADDR_INSN;
 	} else {
 		per_info->control_regs.bits.starting_addr =
 			per_info->starting_addr;
@@ -74,13 +83,15 @@
 		per_info->control_regs.bits.storage_alt_space_ctl = 0;
 }
 
-void set_single_step(struct task_struct *task)
+void
+set_single_step(struct task_struct *task)
 {
 	task->thread.per_info.single_step = 1;
 	FixPerRegisters(task);
 }
 
-void clear_single_step(struct task_struct *task)
+void
+clear_single_step(struct task_struct *task)
 {
 	task->thread.per_info.single_step = 0;
 	FixPerRegisters(task);
@@ -91,12 +102,19 @@
  *
  * Make sure single step bits etc are not set.
  */
-void ptrace_disable(struct task_struct *child)
+void
+ptrace_disable(struct task_struct *child)
 {
 	/* make sure the single step bit is not set. */
 	clear_single_step(child);
 }
 
+#ifndef CONFIG_ARCH_S390X
+# define __ADDR_MASK 3
+#else
+# define __ADDR_MASK 7
+#endif
+
 /*
  * Read the word at offset addr from the user area of a process. The
  * trouble here is that the information is littered over different
@@ -106,20 +124,20 @@
  * struct user contain pad bytes that should be read as zeroes.
  * Lovely...
  */
-static int peek_user(struct task_struct *child, addr_t addr, addr_t data)
+static int
+peek_user(struct task_struct *child, addr_t addr, addr_t data)
 {
 	struct user *dummy = NULL;
-	addr_t offset;
-	__u32 tmp;
+	addr_t offset, tmp;
 
-	if ((addr & 3) || addr > sizeof(struct user) - 3)
+	if ((addr & __ADDR_MASK) || addr > sizeof(struct user) - __ADDR_MASK)
 		return -EIO;
 
 	if (addr <= (addr_t) &dummy->regs.orig_gpr2) {
 		/*
 		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
 		 */
-		tmp = *(__u32 *)((addr_t) __KSTK_PTREGS(child) + addr);
+		tmp = *(addr_t *)((addr_t) __KSTK_PTREGS(child) + addr);
 
 	} else if (addr >= (addr_t) &dummy->regs.fp_regs &&
 		   addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
@@ -127,7 +145,7 @@
 		 * floating point regs. are stored in the thread structure
 		 */
 		offset = addr - (addr_t) &dummy->regs.fp_regs;
-		tmp = *(__u32 *)((addr_t) &child->thread.fp_regs + offset);
+		tmp = *(addr_t *)((addr_t) &child->thread.fp_regs + offset);
 
 	} else if (addr >= (addr_t) &dummy->regs.per_info &&
 		   addr < (addr_t) (&dummy->regs.per_info + 1)) {
@@ -135,12 +153,12 @@
 		 * per_info is found in the thread structure
 		 */
 		offset = addr - (addr_t) &dummy->regs.per_info;
-		tmp = *(__u32 *)((addr_t) &child->thread.per_info + offset);
+		tmp = *(addr_t *)((addr_t) &child->thread.per_info + offset);
 
 	} else
 		tmp = 0;
 
-	return put_user(tmp, (__u32 *) data);
+	return put_user(tmp, (addr_t *) data);
 }
 
 /*
@@ -149,12 +167,13 @@
  * Stores to the program status word and on the floating point
  * control register needs to get checked for validity.
  */
-static int poke_user(struct task_struct *child, addr_t addr, addr_t data)
+static int
+poke_user(struct task_struct *child, addr_t addr, addr_t data)
 {
 	struct user *dummy = NULL;
 	addr_t offset;
 
-	if ((addr & 3) || addr > sizeof(struct user) - 3)
+	if ((addr & __ADDR_MASK) || addr > sizeof(struct user) - __ADDR_MASK)
 		return -EIO;
 
 	if (addr <= (addr_t) &dummy->regs.orig_gpr2) {
@@ -162,14 +181,19 @@
 		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
 		 */
 		if (addr == (addr_t) &dummy->regs.psw.mask &&
+#ifdef CONFIG_S390_SUPPORT
+		    (data & ~PSW_MASK_CC) != PSW_USER32_BITS &&
+#endif
 		    (data & ~PSW_MASK_CC) != PSW_USER_BITS)
 			/* Invalid psw mask. */
 			return -EINVAL;
+#ifndef CONFIG_ARCH_S390X
 		if (addr == (addr_t) &dummy->regs.psw.addr)
 			/* I'd like to reject addresses without the
 			   high order bit but older gdb's rely on it */
-			data |= PSW_ADDR_AMODE31;
-		*(__u32 *)((addr_t) __KSTK_PTREGS(child) + addr) = data;
+			data |= PSW_ADDR_AMODE;
+#endif
+		*(addr_t *)((addr_t) __KSTK_PTREGS(child) + addr) = data;
 
 	} else if (addr >= (addr_t) &dummy->regs.fp_regs &&
 		   addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
@@ -180,7 +204,7 @@
 		    (data & ~FPC_VALID_MASK) != 0)
 			return -EINVAL;
 		offset = addr - (addr_t) &dummy->regs.fp_regs;
-		*(__u32 *)((addr_t) &child->thread.fp_regs + offset) = data;
+		*(addr_t *)((addr_t) &child->thread.fp_regs + offset) = data;
 
 	} else if (addr >= (addr_t) &dummy->regs.per_info &&
 		   addr < (addr_t) (&dummy->regs.per_info + 1)) {
@@ -188,7 +212,7 @@
 		 * per_info is found in the thread structure 
 		 */
 		offset = addr - (addr_t) &dummy->regs.per_info;
-		*(__u32 *)((addr_t) &child->thread.per_info + offset) = data;
+		*(addr_t *)((addr_t) &child->thread.per_info + offset) = data;
 
 	}
 
@@ -197,33 +221,16 @@
 }
 
 static int
-do_ptrace(struct task_struct *child, long request, long addr, long data)
+do_ptrace_normal(struct task_struct *child, long request, long addr, long data)
 {
 	unsigned long tmp;
 	ptrace_area parea; 
 	int copied, ret;
 
-	if (request == PTRACE_ATTACH)
-		return ptrace_attach(child);
-
-	/*
-	 * Special cases to get/store the ieee instructions pointer.
-	 */
-	if (child == current) {
-		if (request == PTRACE_PEEKUSR && addr == PT_IEEE_IP)
-			return peek_user(child, addr, data);
-		if (request == PTRACE_POKEUSR && addr == PT_IEEE_IP)
-			return poke_user(child, addr, data);
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		return ret;
-
 	switch (request) {
 	case PTRACE_PEEKTEXT:
 	case PTRACE_PEEKDATA:
-		/* Remove high order bit from address. */
+		/* Remove high order bit from address (only for 31 bit). */
 		addr &= PSW_ADDR_INSN;
 		/* read word at location addr. */
 		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
@@ -237,7 +244,7 @@
 
 	case PTRACE_POKETEXT:
 	case PTRACE_POKEDATA:
-		/* Remove high order bit from address. */
+		/* Remove high order bit from address (only for 31 bit). */
 		addr &= PSW_ADDR_INSN;
 		/* write the word at location addr. */
 		copied = access_process_vm(child, addr, &data, sizeof(data),1);
@@ -249,6 +256,272 @@
 		/* write the word at location addr in the USER area */
 		return poke_user(child, addr, data);
 
+	case PTRACE_PEEKUSR_AREA:
+	case PTRACE_POKEUSR_AREA:
+		if (!copy_from_user(&parea, (void *) addr, sizeof(parea)))
+			return -EFAULT;
+		addr = parea.kernel_addr;
+		data = parea.process_addr;
+		copied = 0;
+		while (copied < parea.len) {
+			if (request == PTRACE_PEEKUSR_AREA)
+				ret = peek_user(child, addr, data);
+			else
+				ret = poke_user(child, addr, data);
+			if (ret)
+				return ret;
+			addr += sizeof(unsigned long);
+			data += sizeof(unsigned long);
+			copied += sizeof(unsigned long);
+		}
+		return 0;
+	}
+	return ptrace_request(child, request, addr, data);
+}
+
+#ifdef CONFIG_S390_SUPPORT
+/*
+ * Now the fun part starts... a 31 bit program running in the
+ * 31 bit emulation tracing another program. PTRACE_PEEKTEXT,
+ * PTRACE_PEEKDATA, PTRACE_POKETEXT and PTRACE_POKEDATA are easy
+ * to handle, the difference to the 64 bit versions of the requests
+ * is that the access is done in multiples of 4 byte instead of
+ * 8 bytes (sizeof(unsigned long) on 31/64 bit).
+ * The ugly part are PTRACE_PEEKUSR, PTRACE_PEEKUSR_AREA,
+ * PTRACE_POKEUSR and PTRACE_POKEUSR_AREA. If the traced program
+ * is a 31 bit program too, the content of struct user can be
+ * emulated. A 31 bit program peeking into the struct user of
+ * a 64 bit program is a no-no.
+ */
+
+/*
+ * Same as peek_user but for a 31 bit program.
+ */
+static int
+peek_user_emu31(struct task_struct *child, addr_t addr, addr_t data)
+{
+	struct user32 *dummy32 = NULL;
+	per_struct32 *dummy_per32 = NULL;
+	addr_t offset;
+	__u32 tmp;
+
+	if (!test_thread_flag(TIF_31BIT) ||
+	    (addr & 3) || addr > sizeof(struct user) - 3)
+		return -EIO;
+
+	if (addr <= (addr_t) &dummy32->regs.orig_gpr2) {
+		/*
+		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 */
+		if (addr == (addr_t) &dummy32->regs.psw.mask) {
+			/* Fake a 31 bit psw mask. */
+			tmp = (__u32)(__KSTK_PTREGS(child)->psw.mask >> 32);
+			tmp = (tmp & PSW32_MASK_CC) | PSW32_USER_BITS;
+		} else if (addr == (addr_t) &dummy32->regs.psw.addr) {
+			/* Fake a 31 bit psw address. */
+			tmp = (__u32) __KSTK_PTREGS(child)->psw.addr |
+				PSW32_ADDR_AMODE31;
+		} else
+			tmp = *(__u32 *)((addr_t) __KSTK_PTREGS(child) + 
+					 addr*2 + 4);
+	} else if (addr >= (addr_t) &dummy32->regs.fp_regs &&
+		   addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
+		/*
+		 * floating point regs. are stored in the thread structure 
+		 */
+	        offset = addr - (addr_t) &dummy32->regs.fp_regs;
+		tmp = *(__u32 *)((addr_t) &child->thread.fp_regs + offset);
+
+	} else if (addr >= (addr_t) &dummy32->regs.per_info &&
+		   addr < (addr_t) (&dummy32->regs.per_info + 1)) {
+		/*
+		 * per_info is found in the thread structure
+		 */
+		offset = addr - (addr_t) &dummy32->regs.per_info;
+		/* This is magic. See per_struct and per_struct32. */
+		if ((offset >= (addr_t) &dummy_per32->control_regs &&
+		     offset < (addr_t) (&dummy_per32->control_regs + 1)) ||
+		    (offset >= (addr_t) &dummy_per32->starting_addr &&
+		     offset <= (addr_t) &dummy_per32->ending_addr) ||
+		    offset == (addr_t) &dummy_per32->lowcore.words.address)
+			offset = offset*2 + 4;
+		else
+			offset = offset*2;
+		tmp = *(__u32 *)((addr_t) &child->thread.per_info + offset);
+
+	} else
+		tmp = 0;
+
+	return put_user(tmp, (__u32 *) data);
+}
+
+/*
+ * Same as poke_user but for a 31 bit program.
+ */
+static int
+poke_user_emu31(struct task_struct *child, addr_t addr, addr_t data)
+{
+	struct user32 *dummy32 = NULL;
+	per_struct32 *dummy_per32 = NULL;
+	addr_t offset;
+	__u32 tmp;
+
+	if (!test_thread_flag(TIF_31BIT) ||
+	    (addr & 3) || addr > sizeof(struct user32) - 3)
+		return -EIO;
+
+	tmp = (__u32) data;
+
+	if (addr <= (addr_t) &dummy32->regs.orig_gpr2) {
+		/*
+		 * psw, gprs, acrs and orig_gpr2 are stored on the stack
+		 */
+		if (addr == (addr_t) &dummy32->regs.psw.mask) {
+			/* Build a 64 bit psw mask from 31 bit mask. */
+			if ((tmp & ~PSW32_MASK_CC) != PSW32_USER_BITS)
+				/* Invalid psw mask. */
+				return -EINVAL;
+			__KSTK_PTREGS(child)->psw.mask = PSW_USER_BITS |
+				((tmp & PSW32_MASK_CC) << 32);
+		} else if (addr == (addr_t) &dummy32->regs.psw.addr) {
+			/* Build a 64 bit psw address from 31 bit address. */
+			__KSTK_PTREGS(child)->psw.addr = 
+				(__u64) tmp & PSW32_ADDR_INSN;
+		} else
+			*(__u32*)((addr_t) __KSTK_PTREGS(child) + addr*2 + 4) =
+				tmp;
+	} else if (addr >= (addr_t) &dummy32->regs.fp_regs &&
+		   addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
+		/*
+		 * floating point regs. are stored in the thread structure 
+		 */
+		if (addr == (addr_t) &dummy32->regs.fp_regs.fpc &&
+		    (tmp & ~FPC_VALID_MASK) != 0)
+			/* Invalid floating point control. */
+			return -EINVAL;
+	        offset = addr - (addr_t) &dummy32->regs.fp_regs;
+		*(__u32 *)((addr_t) &child->thread.fp_regs + offset) = tmp;
+
+	} else if (addr >= (addr_t) &dummy32->regs.per_info &&
+		   addr < (addr_t) (&dummy32->regs.per_info + 1)) {
+		/*
+		 * per_info is found in the thread structure.
+		 */
+		offset = addr - (addr_t) &dummy32->regs.per_info;
+		/*
+		 * This is magic. See per_struct and per_struct32.
+		 * By incident the offsets in per_struct are exactly
+		 * twice the offsets in per_struct32 for all fields.
+		 * The 8 byte fields need special handling though,
+		 * because the second half (bytes 4-7) is needed and
+		 * not the first half.
+		 */
+		if ((offset >= (addr_t) &dummy_per32->control_regs &&
+		     offset < (addr_t) (&dummy_per32->control_regs + 1)) ||
+		    (offset >= (addr_t) &dummy_per32->starting_addr &&
+		     offset <= (addr_t) &dummy_per32->ending_addr) ||
+		    offset == (addr_t) &dummy_per32->lowcore.words.address)
+			offset = offset*2 + 4;
+		else
+			offset = offset*2;
+		*(__u32 *)((addr_t) &child->thread.per_info + offset) = tmp;
+
+	}
+
+	FixPerRegisters(child);
+	return 0;
+}
+
+static int
+do_ptrace_emu31(struct task_struct *child, long request, long addr, long data)
+{
+	unsigned int tmp;  /* 4 bytes !! */
+	ptrace_area_emu31 parea; 
+	int copied, ret;
+
+	switch (request) {
+	case PTRACE_PEEKTEXT:
+	case PTRACE_PEEKDATA:
+		/* read word at location addr. */
+		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
+		if (copied != sizeof(tmp))
+			return -EIO;
+		return put_user(tmp, (unsigned int *) data);
+
+	case PTRACE_PEEKUSR:
+		/* read the word at location addr in the USER area. */
+		return peek_user_emu31(child, addr, data);
+
+	case PTRACE_POKETEXT:
+	case PTRACE_POKEDATA:
+		/* write the word at location addr. */
+		tmp = data;
+		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 1);
+		if (copied != sizeof(tmp))
+			return -EIO;
+		return 0;
+
+	case PTRACE_POKEUSR:
+		/* write the word at location addr in the USER area */
+		return poke_user_emu31(child, addr, data);
+
+	case PTRACE_PEEKUSR_AREA:
+	case PTRACE_POKEUSR_AREA:
+		if (!copy_from_user(&parea, (void *) addr, sizeof(parea)))
+			return -EFAULT;
+		addr = parea.kernel_addr;
+		data = parea.process_addr;
+		copied = 0;
+		while (copied < parea.len) {
+			if (request == PTRACE_PEEKUSR_AREA)
+				ret = peek_user_emu31(child, addr, data);
+			else
+				ret = poke_user_emu31(child, addr, data);
+			if (ret)
+				return ret;
+			addr += sizeof(unsigned int);
+			data += sizeof(unsigned int);
+			copied += sizeof(unsigned int);
+		}
+		return 0;
+	}
+	return ptrace_request(child, request, addr, data);
+}
+#endif
+
+#define PT32_IEEE_IP 0x13c
+
+static int
+do_ptrace(struct task_struct *child, long request, long addr, long data)
+{
+	int ret;
+
+	if (request == PTRACE_ATTACH)
+		return ptrace_attach(child);
+
+	/*
+	 * Special cases to get/store the ieee instructions pointer.
+	 */
+	if (child == current) {
+		if (request == PTRACE_PEEKUSR && addr == PT_IEEE_IP)
+			return peek_user(child, addr, data);
+		if (request == PTRACE_POKEUSR && addr == PT_IEEE_IP)
+			return poke_user(child, addr, data);
+#ifdef CONFIG_S390_SUPPORT
+		if (request == PTRACE_PEEKUSR &&
+		    addr == PT32_IEEE_IP && test_thread_flag(TIF_31BIT))
+			return peek_user_emu31(child, addr, data);
+		if (request == PTRACE_POKEUSR &&
+		    addr == PT32_IEEE_IP && test_thread_flag(TIF_31BIT))
+			return poke_user_emu31(child, addr, data);
+#endif
+	}
+
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
+		return ret;
+
+	switch (request) {
 	case PTRACE_SYSCALL:
 		/* continue and stop at next (return from) syscall */
 	case PTRACE_CONT:
@@ -294,30 +567,21 @@
 		/* detach a process that was attached. */
 		return ptrace_detach(child, data);
 
-	case PTRACE_PEEKUSR_AREA:
-	case PTRACE_POKEUSR_AREA:
-		if (!copy_from_user(&parea, (void *) addr, sizeof(parea)))
-			return -EFAULT;
-		addr = parea.kernel_addr;
-		data = parea.process_addr;
-		copied = 0;
-		while (copied < parea.len) {
-			if (request == PTRACE_PEEKUSR_AREA)
-				ret = peek_user(child, addr, data);
-			else
-				ret = poke_user(child, addr, data);
-			if (ret)
-				return ret;
-			addr += sizeof(unsigned long);
-			data += sizeof(unsigned long);
-			copied += sizeof(unsigned long);
-		}
-		return 0;
+
+	/* Do requests that differ for 31/64 bit */
+	default:
+#ifdef CONFIG_S390_SUPPORT
+		if (test_thread_flag(TIF_31BIT))
+			return do_ptrace_emu31(child, request, addr, data);
+#endif
+		return do_ptrace_normal(child, request, addr, data);
 	}
-	return ptrace_request(child, request, addr, data);
+	/* Not reached.  */
+	return -EIO;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage int
+sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int ret;
@@ -358,7 +622,8 @@
 	return ret;
 }
 
-asmlinkage void syscall_trace(void)
+asmlinkage void
+syscall_trace(void)
 {
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
diff -urN linux-2.5.67/arch/s390/kernel/reipl64.S linux-2.5.67-s390/arch/s390/kernel/reipl64.S
--- linux-2.5.67/arch/s390/kernel/reipl64.S	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/kernel/reipl64.S	Mon Apr 14 19:11:56 2003
@@ -0,0 +1,96 @@
+/*
+ *  arch/s390/kernel/reipl.S
+ *
+ *  S390 version
+ *    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Holger Smolinski (Holger.Smolinski@de.ibm.com)
+	         Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
+ */
+
+#include <asm/lowcore.h>
+		.globl	do_reipl
+do_reipl:	basr	%r13,0
+.Lpg0:		lpswe   .Lnewpsw-.Lpg0(%r13)
+.Lpg1:		lctlg	%c6,%c6,.Lall-.Lpg0(%r13)
+                stctg   %c0,%c0,.Lctlsave-.Lpg0(%r13)
+                ni      .Lctlsave+4-.Lpg0(%r13),0xef
+                lctlg   %c0,%c0,.Lctlsave-.Lpg0(%r13)
+                lgr     %r1,%r2
+        	mvc     __LC_PGM_NEW_PSW(16),.Lpcnew-.Lpg0(%r13)
+                stsch   .Lschib-.Lpg0(%r13)                                    
+	        oi      .Lschib+5-.Lpg0(%r13),0x84 
+.Lecs:  	xi      .Lschib+27-.Lpg0(%r13),0x01 
+        	msch    .Lschib-.Lpg0(%r13) 
+	        lghi    %r0,5
+.Lssch:		ssch	.Liplorb-.Lpg0(%r13)           
+		jz	.L001
+		brct    %r0,.Lssch   
+		bas	%r14,.Ldisab-.Lpg0(%r13)
+.L001:		mvc	__LC_IO_NEW_PSW(16),.Lionew-.Lpg0(%r13)	
+.Ltpi:		lpswe	.Lwaitpsw-.Lpg0(%r13)          
+.Lcont:		c	%r1,__LC_SUBCHANNEL_ID
+		jnz	.Ltpi
+		clc	__LC_IO_INT_PARM(4),.Liplorb-.Lpg0(%r13)
+		jnz	.Ltpi
+		tsch	.Liplirb-.Lpg0(%r13)           
+		tm	.Liplirb+9-.Lpg0(%r13),0xbf
+                jz      .L002
+                bas     %r14,.Ldisab-.Lpg0(%r13)    
+.L002:		tm	.Liplirb+8-.Lpg0(%r13),0xf3    
+                jz      .L003
+                bas     %r14,.Ldisab-.Lpg0(%r13)	
+.L003:		spx	.Lnull-.Lpg0(%r13)
+		st 	%r1,__LC_SUBCHANNEL_ID
+                lhi     %r1,0            # mode 0 = esa
+                slr     %r0,%r0          # set cpuid to zero
+                sigp    %r1,%r0,0x12     # switch to esa mode
+                lpsw 	0
+.Ldisab:	sll    %r14,1
+		srl    %r14,1            # need to kill hi bit to avoid specification exceptions.
+		st     %r14,.Ldispsw+12-.Lpg0(%r13)
+		lpswe	.Ldispsw-.Lpg0(%r13)
+                .align 	8
+.Lall:		.quad	0x00000000ff000000
+.Lctlsave:      .quad   0x0000000000000000
+.Lnull:		.long   0x0000000000000000
+                .align 	16
+/*
+ * These addresses have to be 31 bit otherwise
+ * the sigp will throw a specifcation exception
+ * when switching to ESA mode as bit 31 be set
+ * in the ESA psw.
+ * Bit 31 of the addresses has to be 0 for the
+ * 31bit lpswe instruction a fact they appear to have
+ * ommited from the pop.
+ */
+.Lnewpsw:	.quad   0x0000000080000000
+		.quad   .Lpg1
+.Lpcnew:	.quad   0x0000000080000000
+	  	.quad   .Lecs
+.Lionew:	.quad   0x0000000080000000
+		.quad   .Lcont
+.Lwaitpsw:	.quad	0x0202000080000000
+		.quad   .Ltpi
+.Ldispsw:	.quad   0x0002000080000000
+		.quad   0x0000000000000000
+.Liplccws:	.long   0x02000000,0x60000018
+		.long   0x08000008,0x20000001
+.Liplorb:	.long	0x0049504c,0x0040ff80
+		.long	0x00000000+.Liplccws
+.Lschib:        .long   0x00000000,0x00000000
+		.long   0x00000000,0x00000000
+		.long   0x00000000,0x00000000
+		.long   0x00000000,0x00000000
+		.long   0x00000000,0x00000000
+		.long   0x00000000,0x00000000
+.Liplirb:	.long	0x00000000,0x00000000
+		.long	0x00000000,0x00000000
+		.long	0x00000000,0x00000000
+		.long	0x00000000,0x00000000
+		.long	0x00000000,0x00000000
+		.long	0x00000000,0x00000000
+		.long	0x00000000,0x00000000
+		.long	0x00000000,0x00000000
+	
+
+	
diff -urN linux-2.5.67/arch/s390/kernel/s390_ksyms.c linux-2.5.67-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.5.67/arch/s390/kernel/s390_ksyms.c	Mon Apr  7 19:31:51 2003
+++ linux-2.5.67-s390/arch/s390/kernel/s390_ksyms.c	Mon Apr 14 19:11:56 2003
@@ -4,11 +4,14 @@
  *  S390 version
  */
 #include <linux/config.h>
+#include <linux/highuid.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <asm/checksum.h>
 #include <asm/delay.h>
+#include <asm/pgalloc.h>
 #include <asm/setup.h>
 #if CONFIG_IP_MULTICAST
 #include <net/arp.h>
@@ -50,6 +53,28 @@
 EXPORT_SYMBOL_NOVERS(strpbrk);
 
 /*
+ * binfmt_elf loader 
+ */
+extern int dump_fpu (struct pt_regs * regs, s390_fp_regs *fpregs);
+EXPORT_SYMBOL(dump_fpu);
+EXPORT_SYMBOL(overflowuid);
+EXPORT_SYMBOL(overflowgid);
+
+#ifdef CONFIG_S390_SUPPORT
+/*
+ * Dynamically add/remove 31 bit ioctl conversion functions.
+ */
+extern int register_ioctl32_conversion(unsigned int cmd,
+				       int (*handler)(unsigned int, 
+						      unsigned int,
+						      unsigned long,
+						      struct file *));
+int unregister_ioctl32_conversion(unsigned int cmd);
+EXPORT_SYMBOL(register_ioctl32_conversion);
+EXPORT_SYMBOL(unregister_ioctl32_conversion);
+#endif
+
+/*
  * misc.
  */
 EXPORT_SYMBOL(machine_flags);
diff -urN linux-2.5.67/arch/s390/kernel/setup.c linux-2.5.67-s390/arch/s390/kernel/setup.c
--- linux-2.5.67/arch/s390/kernel/setup.c	Mon Apr 14 19:11:52 2003
+++ linux-2.5.67-s390/arch/s390/kernel/setup.c	Mon Apr 14 19:11:56 2003
@@ -324,15 +324,22 @@
         /*
          * print what head.S has found out about the machine 
          */
+#ifndef CONFIG_ARCH_S390X
 	printk((MACHINE_IS_VM) ?
 	       "We are running under VM (31 bit mode)\n" :
 	       "We are running native (31 bit mode)\n");
 	printk((MACHINE_HAS_IEEE) ?
 	       "This machine has an IEEE fpu\n" :
 	       "This machine has no IEEE fpu\n");
+#else /* CONFIG_ARCH_S390X */
+	printk((MACHINE_IS_VM) ?
+	       "We are running under VM (64 bit mode)\n" :
+	       "We are running native (64 bit mode)\n");
+#endif /* CONFIG_ARCH_S390X */
 
         ROOT_DEV = Root_RAM0;
         memory_start = (unsigned long) &_end;    /* fixit if use $CODELO etc*/
+#ifndef CONFIG_ARCH_S390X
 	memory_end = memory_size & ~0x400000UL;  /* align memory end to 4MB */
         /*
          * We need some free virtual space to be able to do vmalloc.
@@ -341,6 +348,9 @@
          */
         if (memory_end > 1920*1024*1024)
                 memory_end = 1920*1024*1024;
+#else /* CONFIG_ARCH_S390X */
+	memory_end = memory_size & ~0x200000UL;  /* detected in head.s */
+#endif /* CONFIG_ARCH_S390X */
         init_mm.start_code = PAGE_OFFSET;
         init_mm.end_code = (unsigned long) &_etext;
         init_mm.end_data = (unsigned long) &_edata;
@@ -461,26 +471,46 @@
         /*
          * Setup lowcore for boot cpu
          */
+#ifndef CONFIG_ARCH_S390X
 	lc = (struct _lowcore *) __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0);
 	memset(lc, 0, PAGE_SIZE);
+#else /* CONFIG_ARCH_S390X */
+	lc = (struct _lowcore *) __alloc_bootmem(2*PAGE_SIZE, 2*PAGE_SIZE, 0);
+	memset(lc, 0, 2*PAGE_SIZE);
+#endif /* CONFIG_ARCH_S390X */
 	lc->restart_psw.mask = PSW_BASE_BITS;
-	lc->restart_psw.addr = PSW_ADDR_AMODE31 + (__u32) restart_int_handler;
+	lc->restart_psw.addr =
+		PSW_ADDR_AMODE + (unsigned long) restart_int_handler;
 	lc->external_new_psw.mask = PSW_KERNEL_BITS;
-	lc->external_new_psw.addr = PSW_ADDR_AMODE31 + (__u32) ext_int_handler;
+	lc->external_new_psw.addr =
+		PSW_ADDR_AMODE + (unsigned long) ext_int_handler;
 	lc->svc_new_psw.mask = PSW_KERNEL_BITS;
-	lc->svc_new_psw.addr = PSW_ADDR_AMODE31 + (__u32) system_call;
+	lc->svc_new_psw.addr = PSW_ADDR_AMODE + (unsigned long) system_call;
 	lc->program_new_psw.mask = PSW_KERNEL_BITS;
-	lc->program_new_psw.addr = PSW_ADDR_AMODE31 + (__u32)pgm_check_handler;
-        lc->mcck_new_psw.mask = PSW_KERNEL_BITS;
-	lc->mcck_new_psw.addr = PSW_ADDR_AMODE31 + (__u32) mcck_int_handler;
+	lc->program_new_psw.addr =
+		PSW_ADDR_AMODE + (unsigned long)pgm_check_handler;
+	lc->mcck_new_psw.mask = PSW_KERNEL_BITS;
+	lc->mcck_new_psw.addr =
+		PSW_ADDR_AMODE + (unsigned long) mcck_int_handler;
 	lc->io_new_psw.mask = PSW_KERNEL_BITS;
-	lc->io_new_psw.addr = PSW_ADDR_AMODE31 + (__u32) io_int_handler;
+	lc->io_new_psw.addr = PSW_ADDR_AMODE + (unsigned long) io_int_handler;
 	lc->ipl_device = S390_lowcore.ipl_device;
+	lc->jiffy_timer = -1LL;
+#ifndef CONFIG_ARCH_S390X
 	lc->kernel_stack = ((__u32) &init_thread_union) + 8192;
 	lc->async_stack = (__u32)
 		__alloc_bootmem(2*PAGE_SIZE, 2*PAGE_SIZE, 0) + 8192;
-	lc->jiffy_timer = -1LL;
 	set_prefix((__u32) lc);
+#else /* CONFIG_ARCH_S390X */
+	lc->kernel_stack = ((__u64) &init_thread_union) + 16384;
+	lc->async_stack = (__u64)
+		__alloc_bootmem(4*PAGE_SIZE, 4*PAGE_SIZE, 0) + 16384;
+	if (MACHINE_HAS_DIAG44)
+		lc->diag44_opcode = 0x83000044;
+	else
+		lc->diag44_opcode = 0x07000700;
+	set_prefix((__u32)(__u64) lc);
+#endif /* CONFIG_ARCH_S390X */
         cpu_init();
         __cpu_logical_map[0] = S390_lowcore.cpu_data.cpu_addr;
 
diff -urN linux-2.5.67/arch/s390/kernel/signal.c linux-2.5.67-s390/arch/s390/kernel/signal.c
--- linux-2.5.67/arch/s390/kernel/signal.c	Mon Apr 14 19:11:52 2003
+++ linux-2.5.67-s390/arch/s390/kernel/signal.c	Mon Apr 14 19:11:56 2003
@@ -146,7 +146,7 @@
 
 
 /* Returns non-zero on fault. */
-static int save_sigregs(struct pt_regs *regs,_sigregs *sregs)
+static int save_sigregs(struct pt_regs *regs, _sigregs *sregs)
 {
 	int err;
   
@@ -158,18 +158,18 @@
 	 * to merge them with the emulated registers.
 	 */
 	save_fp_regs(&current->thread.fp_regs);
-	return __copy_to_user(&sregs->fpregs, &current->thread.fp_regs, 
+	return __copy_to_user(&sregs->fpregs, &current->thread.fp_regs,
 			      sizeof(s390_fp_regs));
 }
 
 /* Returns positive number on error */
-static int restore_sigregs(struct pt_regs *regs,_sigregs *sregs)
+static int restore_sigregs(struct pt_regs *regs, _sigregs *sregs)
 {
 	int err;
 
 	err = __copy_from_user(regs, &sregs->regs, sizeof(_s390_regs_common));
 	regs->psw.mask = PSW_USER_BITS | (regs->psw.mask & PSW_MASK_CC);
-	regs->psw.addr |= PSW_ADDR_AMODE31;
+	regs->psw.addr |= PSW_ADDR_AMODE;
 	if (err)
 		return err;
 
@@ -299,9 +299,11 @@
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER) {
-                regs->gprs[14] = (__u32) ka->sa.sa_restorer | PSW_ADDR_AMODE31;
+                regs->gprs[14] = (unsigned long)
+			ka->sa.sa_restorer | PSW_ADDR_AMODE;
 	} else {
-                regs->gprs[14] = (__u32) frame->retcode | PSW_ADDR_AMODE31;
+                regs->gprs[14] = (unsigned long)
+			frame->retcode | PSW_ADDR_AMODE;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn, 
 	                       (u16 *)(frame->retcode)))
 			goto give_sigsegv;
@@ -312,12 +314,12 @@
 		goto give_sigsegv;
 
 	/* Set up registers for signal handler */
-	regs->gprs[15] = (__u32) frame;
-	regs->psw.addr = (__u32) ka->sa.sa_handler | PSW_ADDR_AMODE31;
+	regs->gprs[15] = (unsigned long) frame;
+	regs->psw.addr = (unsigned long) ka->sa.sa_handler | PSW_ADDR_AMODE;
 	regs->psw.mask = PSW_USER_BITS;
 
 	regs->gprs[2] = map_signal(sig);
-	regs->gprs[3] = (__u32) &frame->sc;
+	regs->gprs[3] = (unsigned long) &frame->sc;
 
 	/* We forgot to include these in the sigcontext.
 	   To avoid breaking binary compatibility, they are passed as args. */
@@ -357,9 +359,11 @@
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	if (ka->sa.sa_flags & SA_RESTORER) {
-                regs->gprs[14] = (__u32) ka->sa.sa_restorer | PSW_ADDR_AMODE31;
+                regs->gprs[14] = (unsigned long)
+			ka->sa.sa_restorer | PSW_ADDR_AMODE;
 	} else {
-                regs->gprs[14] = (__u32) frame->retcode | PSW_ADDR_AMODE31;
+                regs->gprs[14] = (unsigned long)
+			frame->retcode | PSW_ADDR_AMODE;
 		err |= __put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn, 
 	                          (u16 *)(frame->retcode));
 	}
@@ -369,13 +373,13 @@
 		goto give_sigsegv;
 
 	/* Set up registers for signal handler */
-	regs->gprs[15] = (__u32) frame;
-	regs->psw.addr = (__u32) ka->sa.sa_handler | PSW_ADDR_AMODE31;
+	regs->gprs[15] = (unsigned long) frame;
+	regs->psw.addr = (unsigned long) ka->sa.sa_handler | PSW_ADDR_AMODE;
 	regs->psw.mask = PSW_USER_BITS;
 
 	regs->gprs[2] = map_signal(sig);
-	regs->gprs[3] = (__u32) &frame->info;
-	regs->gprs[4] = (__u32) &frame->uc;
+	regs->gprs[3] = (unsigned long) &frame->info;
+	regs->gprs[4] = (unsigned long) &frame->uc;
 	return;
 
 give_sigsegv:
@@ -461,6 +465,13 @@
 
 	if (!oldset)
 		oldset = &current->blocked;
+#ifdef CONFIG_S390_SUPPORT 
+	if (test_thread_flag(TIF_31BIT)) {
+		extern asmlinkage int do_signal32(struct pt_regs *regs,
+						  sigset_t *oldset); 
+		return do_signal32(regs, oldset);
+        }
+#endif 
 
 	signr = get_signal_to_deliver(&info, regs, NULL);
 	if (signr > 0) {
diff -urN linux-2.5.67/arch/s390/kernel/smp.c linux-2.5.67-s390/arch/s390/kernel/smp.c
--- linux-2.5.67/arch/s390/kernel/smp.c	Mon Apr  7 19:30:34 2003
+++ linux-2.5.67-s390/arch/s390/kernel/smp.c	Mon Apr 14 19:11:56 2003
@@ -171,7 +171,7 @@
 
         /* store status of all processors in their lowcores (real 0) */
         for (i =  0; i < NR_CPUS; i++) {
-                if (!cpu_online(i) || smp_processor_id() == i)
+                if (!cpu_online(i) || smp_processor_id() == i) 
 			continue;
 		low_core_addr = (unsigned long) lowcore_ptr[i];
 		do {
@@ -310,13 +310,11 @@
  */
 static void smp_ext_bitcall_others(ec_bit_sig sig)
 {
-        struct _lowcore *lowcore;
         int i;
 
         for (i = 0; i < NR_CPUS; i++) {
                 if (!cpu_online(i) || smp_processor_id() == i)
                         continue;
-                lowcore = lowcore_ptr[i];
                 /*
                  * Set signaling bit in lowcore of target cpu and kick it
                  */
@@ -326,6 +324,7 @@
         }
 }
 
+#ifndef CONFIG_ARCH_S390X
 /*
  * this function sends a 'purge tlb' signal to another CPU.
  */
@@ -338,6 +337,7 @@
 {
         on_each_cpu(smp_ptlb_callback, NULL, 0, 1);
 }
+#endif /* ! CONFIG_ARCH_S390X */
 
 /*
  * this function sends a 'reschedule' IPI to another CPU.
@@ -356,8 +356,8 @@
 {
 	__u16 start_ctl;
 	__u16 end_ctl;
-	__u32 orvals[16];
-	__u32 andvals[16];
+	unsigned long orvals[16];
+	unsigned long andvals[16];
 } ec_creg_mask_parms;
 
 /*
@@ -365,25 +365,14 @@
  */
 void smp_ctl_bit_callback(void *info) {
 	ec_creg_mask_parms *pp;
-	u32 cregs[16];
+	unsigned long cregs[16];
 	int i;
 	
 	pp = (ec_creg_mask_parms *) info;
-	asm volatile ("   bras  1,0f\n"
-		      "   stctl 0,0,0(%0)\n"
-		      "0: ex    %1,0(1)\n"
-		      : : "a" (cregs+pp->start_ctl),
-		          "a" ((pp->start_ctl<<4) + pp->end_ctl)
-		      : "memory", "1" );
+	__ctl_store(cregs[pp->start_ctl], pp->start_ctl, pp->end_ctl);
 	for (i = pp->start_ctl; i <= pp->end_ctl; i++)
 		cregs[i] = (cregs[i] & pp->andvals[i]) | pp->orvals[i];
-	asm volatile ("   bras  1,0f\n"
-		      "   lctl 0,0,0(%0)\n"
-		      "0: ex    %1,0(1)\n"
-		      : : "a" (cregs+pp->start_ctl),
-		          "a" ((pp->start_ctl<<4) + pp->end_ctl)
-		      : "memory", "1" );
-	return;
+	__ctl_load(cregs[pp->start_ctl], pp->start_ctl, pp->end_ctl);
 }
 
 /*
@@ -395,7 +384,7 @@
 	parms.start_ctl = cr;
 	parms.end_ctl = cr;
 	parms.orvals[cr] = 1 << bit;
-	parms.andvals[cr] = 0xFFFFFFFF;
+	parms.andvals[cr] = -1L;
 	preempt_disable();
 	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
         __ctl_set_bit(cr, bit);
@@ -410,8 +399,8 @@
 
 	parms.start_ctl = cr;
 	parms.end_ctl = cr;
-	parms.orvals[cr] = 0x00000000;
-	parms.andvals[cr] = ~(1 << bit);
+	parms.orvals[cr] = 0;
+	parms.andvals[cr] = ~(1L << bit);
 	preempt_disable();
 	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
         __ctl_clear_bit(cr, bit);
@@ -493,7 +482,7 @@
 	 *  Set prefix page for new cpu
 	 */
 
-	ccode = signal_processor_p((u32)(lowcore_ptr[cpu]),
+	ccode = signal_processor_p((unsigned long)(lowcore_ptr[cpu]),
 				   cpu, sigp_set_prefix);
 	if (ccode){
 		printk("sigp_set_prefix failed for cpu %d "
@@ -502,7 +491,6 @@
 		return -EIO;
 	}
 
-
         /* We can't use kernel_thread since we must _avoid_ to reschedule
            the child. */
         idle = fork_by_hand();
@@ -521,15 +509,13 @@
 
         cpu_lowcore = lowcore_ptr[cpu];
 	cpu_lowcore->save_area[15] = idle->thread.ksp;
-	cpu_lowcore->kernel_stack = (__u32) idle->thread_info + (2*PAGE_SIZE);
-        __asm__ __volatile__("la    1,%0\n\t"
-			     "stctl 0,15,0(1)\n\t"
-			     "la    1,%1\n\t"
-                             "stam  0,15,0(1)"
-                             : "=m" (cpu_lowcore->cregs_save_area[0]),
-                               "=m" (cpu_lowcore->access_regs_save_area[0])
-                             : : "1", "memory");
-
+	cpu_lowcore->kernel_stack = (unsigned long)
+		idle->thread_info + (THREAD_SIZE);
+	__ctl_store(cpu_lowcore->cregs_save_area[0], 0, 15);
+	__asm__ __volatile__("la    1,%0\n\t"
+			     "stam  0,15,0(1)"
+			     : "=m" (cpu_lowcore->access_regs_save_area[0])
+			     : : "1", "memory");
         eieio();
         signal_processor(cpu,sigp_restart);
 
@@ -551,7 +537,6 @@
                 panic("Couldn't request external interrupt 0x1202");
         smp_check_cpus(max_cpus);
         memset(lowcore_ptr,0,sizeof(lowcore_ptr));  
-
         /*
          *  Initialize prefix pages and stacks for all possible cpus
          */
@@ -561,15 +546,16 @@
 		if (!cpu_possible(i))
 			continue;
 		lowcore_ptr[i] = (struct _lowcore *)
-			__get_free_page(GFP_KERNEL|GFP_DMA);
-		async_stack = __get_free_pages(GFP_KERNEL,1);
-		if (lowcore_ptr[i] == NULL || async_stack == 0UL)
+			__get_free_pages(GFP_KERNEL|GFP_DMA, 
+					sizeof(void*) == 8 ? 1 : 0);
+		async_stack = __get_free_pages(GFP_KERNEL,ASYNC_ORDER);
+		if (lowcore_ptr[i] == NULL || async_stack == 0ULL)
 			panic("smp_boot_cpus failed to allocate memory\n");
 
                 memcpy(lowcore_ptr[i], &S390_lowcore, sizeof(struct _lowcore));
-		lowcore_ptr[i]->async_stack = async_stack + (2 * PAGE_SIZE);
+		lowcore_ptr[i]->async_stack = async_stack + (ASYNC_SIZE);
 	}
-	set_prefix((u32) lowcore_ptr[smp_processor_id()]);
+	set_prefix((u32)(unsigned long) lowcore_ptr[smp_processor_id()]);
 }
 
 void __devinit smp_prepare_boot_cpu(void)
diff -urN linux-2.5.67/arch/s390/kernel/sys_s390.c linux-2.5.67-s390/arch/s390/kernel/sys_s390.c
--- linux-2.5.67/arch/s390/kernel/sys_s390.c	Mon Apr  7 19:31:05 2003
+++ linux-2.5.67-s390/arch/s390/kernel/sys_s390.c	Mon Apr 14 19:11:56 2003
@@ -24,15 +24,24 @@
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
+#ifdef CONFIG_ARCH_S390X
+#include <linux/personality.h>
+#endif /* CONFIG_ARCH_S390X */
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
 
+#ifndef CONFIG_ARCH_S390X
+#define __SYS_RETTYPE int
+#else
+#define __SYS_RETTYPE long
+#endif /* CONFIG_ARCH_S390X */
+
 /*
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way Unix traditionally does this, though.
  */
-asmlinkage int sys_pipe(unsigned long * fildes)
+asmlinkage __SYS_RETTYPE sys_pipe(unsigned long * fildes)
 {
 	int fd[2];
 	int error;
@@ -51,7 +60,7 @@
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	int error = -EBADF;
+	__SYS_RETTYPE error = -EBADF;
 	struct file * file = NULL;
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
@@ -99,10 +108,10 @@
 	return error;
 }
 
-asmlinkage int old_mmap(struct mmap_arg_struct *arg)
+asmlinkage __SYS_RETTYPE old_mmap(struct mmap_arg_struct *arg)
 {
 	struct mmap_arg_struct a;
-	int error = -EFAULT;
+	__SYS_RETTYPE error = -EFAULT;
 
 	if (copy_from_user(&a, arg, sizeof(a)))
 		goto out;
@@ -118,6 +127,7 @@
 
 extern asmlinkage int sys_select(int, fd_set *, fd_set *, fd_set *, struct timeval *);
 
+#ifndef CONFIG_ARCH_S390X
 struct sel_arg_struct {
 	unsigned long n;
 	fd_set *inp, *outp, *exp;
@@ -132,22 +142,61 @@
 		return -EFAULT;
 	/* sys_select() does the appropriate kernel locking */
 	return sys_select(a.n, a.inp, a.outp, a.exp, a.tvp);
+
 }
+#else /* CONFIG_ARCH_S390X */
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		       unsigned long len, unsigned long pgoff,
+		       unsigned long flags)
+{
+	struct vm_area_struct *vma;
+	unsigned long end;
+
+	if (test_thread_flag(TIF_31BIT)) { 
+		if (!addr) 
+			addr = 0x40000000; 
+		end = 0x80000000;		
+	} else { 
+		if (!addr) 
+			addr = TASK_SIZE / 2;
+		end = TASK_SIZE; 
+	}
+
+	if (len > end)
+		return -ENOMEM;
+	addr = PAGE_ALIGN(addr);
+
+	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
+		/* At this point:  (!vma || addr < vma->vm_end). */
+		if (end - len < addr)
+			return -ENOMEM;
+		if (!vma || addr + len <= vma->vm_start)
+			return addr;
+		addr = vma->vm_end;
+	}
+}
+#endif /* CONFIG_ARCH_S390X */
 
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls..
  *
  * This is really horribly ugly.
  */
-asmlinkage int sys_ipc (uint call, int first, int second, 
-                        int third, void *ptr)
+asmlinkage __SYS_RETTYPE sys_ipc (uint call, int first, int second, 
+				  unsigned long third, void *ptr,
+				  unsigned long fifth)
 {
         struct ipc_kludge tmp;
 	int ret;
 
         switch (call) {
         case SEMOP:
-                return sys_semop (first, (struct sembuf *)ptr, second);
+		return sys_semtimedop (first, (struct sembuf *) ptr, second,
+				       NULL);
+	case SEMTIMEDOP:
+		return sys_semtimedop(first, (struct sembuf *) ptr, second,
+				      (const struct timespec *) fifth);
         case SEMGET:
                 return sys_semget (first, second, third);
         case SEMCTL: {
@@ -191,7 +240,7 @@
 		return sys_shmctl (first, second,
                                    (struct shmid_ds *) ptr);
 	default:
-		return -EINVAL;
+		return -ENOSYS;
 
 	}
         
@@ -212,6 +261,7 @@
 	return err?-EFAULT:0;
 }
 
+#ifndef CONFIG_ARCH_S390X
 asmlinkage int sys_olduname(struct oldold_utsname * name)
 {
 	int error;
@@ -243,6 +293,36 @@
 
 asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on)
 {
-  return -ENOSYS;
+	return -ENOSYS;
+}
+
+#else /* CONFIG_ARCH_S390X */
+
+extern asmlinkage int sys_newuname(struct new_utsname * name);
+
+asmlinkage int s390x_newuname(struct new_utsname * name)
+{
+	int ret = sys_newuname(name);
+
+	if (current->personality == PER_LINUX32 && !ret) {
+		ret = copy_to_user(name->machine, "s390\0\0\0\0", 8);
+		if (ret) ret = -EFAULT;
+	}
+	return ret;
 }
 
+extern asmlinkage long sys_personality(unsigned long);
+
+asmlinkage int s390x_personality(unsigned long personality)
+{
+	int ret;
+
+	if (current->personality == PER_LINUX32 && personality == PER_LINUX)
+		personality = PER_LINUX32;
+	ret = sys_personality(personality);
+	if (ret == PER_LINUX32)
+		ret = PER_LINUX;
+
+	return ret;
+}
+#endif /* CONFIG_ARCH_S390X */

