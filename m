Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUCBWDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbUCBWDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:03:19 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:54176 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S261962AbUCBWCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:02:35 -0500
Date: Tue, 2 Mar 2004 15:02:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net, amit@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
Subject: [KGDB][RFC] Send a fuller T packet
Message-ID: <20040302220233.GG20227@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  Since a 'T' packet is allowed to send back information on an
arbitrary number of registers, and on PPC32 we've always been including
information on the stack pointer and program counter, I was wondering
what people thought of the following patch:

diff -u linux-2.6.3/include/asm-x86_64/kgdb.h linux-2.6.3/include/asm-x86_64/kgdb.h
--- linux-2.6.3/include/asm-x86_64/kgdb.h	2004-02-27 11:30:37.445782703 -0700
+++ linux-2.6.3/include/asm-x86_64/kgdb.h	2004-03-02 14:42:47.854532793 -0700
@@ -48,6 +48,10 @@
 /* Number of bytes of registers.  */
 #define NUMREGBYTES (_LASTREG*8)
 
+#define PC_REGNUM	_PC	/* Program Counter */
+#define SP_REGNUM	_RSP	/* Stack Pointer */
+#define PTRACE_PC	rip	/* Program Counter, in ptrace regs. */
+
 #define BREAKPOINT() asm("   int $3");
 #define BREAK_INSTR_SIZE       1
 
diff -u linux-2.6.3/include/asm-i386/kgdb.h linux-2.6.3/include/asm-i386/kgdb.h
--- linux-2.6.3/include/asm-i386/kgdb.h	2004-02-26 13:14:41.769186750 -0700
+++ linux-2.6.3/include/asm-i386/kgdb.h	2004-03-02 14:42:03.232624041 -0700
@@ -43,6 +43,10 @@
 	_GS			/* 15 */
 };
 
+#define PC_REGNUM	_PC	/* Program Counter */
+#define SP_REGNUM	_ESP	/* Stack Pointer */
+#define PTRACE_PC	eip	/* Program Counter, in ptrace regs. */
+
 #define BREAKPOINT() asm("   int $3");
 #define BREAK_INSTR_SIZE       1
 
diff -u linux-2.6.3/kernel/kgdb.c linux-2.6.3/kernel/kgdb.c
--- linux-2.6.3/kernel/kgdb.c	2004-03-02 14:25:42.590401068 -0700
+++ linux-2.6.3/kernel/kgdb.c	2004-03-02 14:51:51.535627684 -0700
@@ -695,12 +695,24 @@
 	/* Master processor is completely in the debugger */
 	kgdb_post_master_code(linux_regs, exVector, err_code);
 
+	/* If kgdb is connected, then an exception has occured, and
+	 * we need to pass something back to GDB. */
 	if (kgdb_connected) {
-		/* reply to host that an exception has occurred */
 		ptr = remcom_out_buffer;
 		*ptr++ = 'T';
 		*ptr++ = hexchars[(signo >> 4) % 16];
 		*ptr++ = hexchars[signo % 16];
+		*ptr++ = hexchars[(PC_REGNUM >> 4) % 16];
+		*ptr++ = hexchars[PC_REGNUM % 16];
+		*ptr++ = ':';
+		ptr = kgdb_mem2hex((char *)&linux_regs->PTRACE_PC, ptr, 4);
+		*ptr++ = ';';
+		*ptr++ = hexchars[SP_REGNUM >> 4];
+		*ptr++ = hexchars[SP_REGNUM & 0xf];
+		*ptr++ = ':';
+		ptr = kgdb_mem2hex(((char *)linux_regs) + SP_REGNUM * 4, ptr,
+				4);
+		*ptr++ = ';';
 		ptr += strlen(strcpy(ptr, "thread:"));
 		int_to_threadref(&thref, shadow_pid(current->pid));
 		ptr = pack_threadid(ptr, &thref);
@@ -728,11 +740,28 @@
 			 * we clear out our breakpoints now incase
 			 * GDB is reconnecting. */
 			remove_all_break();
-			remcom_out_buffer[0] = 'S';
-			remcom_out_buffer[1] = hexchars[signo >> 4];
-			remcom_out_buffer[2] = hexchars[signo % 16];
+			/* reply to host that an exception has occurred */
+			ptr = remcom_out_buffer;
+			*ptr++ = 'T';
+			*ptr++ = hexchars[(signo >> 4) % 16];
+			*ptr++ = hexchars[signo % 16];
+			*ptr++ = hexchars[(PC_REGNUM >> 4) % 16];
+			*ptr++ = hexchars[PC_REGNUM % 16];
+			*ptr++ = ':';
+			ptr = kgdb_mem2hex((char *)&linux_regs->PTRACE_PC, ptr,
+					4);
+			*ptr++ = ';';
+			*ptr++ = hexchars[SP_REGNUM >> 4];
+			*ptr++ = hexchars[SP_REGNUM & 0xf];
+			*ptr++ = ':';
+			ptr = kgdb_mem2hex(((char *)linux_regs) + SP_REGNUM * 4,
+					ptr, 4);
+			*ptr++ = ';';
+			ptr += strlen(strcpy(ptr, "thread:"));
+			int_to_threadref(&thref, shadow_pid(current->pid));
+			ptr = pack_threadid(ptr, &thref);
+			*ptr++ = ';';
 			break;
-
 		case 'g':	/* return the value of the CPU registers */
 			thread = kgdb_usethread;
 

Is this too much extra stuff to bother with, since that information can
be gotten elsewhere?

-- 
Tom Rini
http://gate.crashing.org/~trini/
