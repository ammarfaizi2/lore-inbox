Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUBJTaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUBJT35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:29:57 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:64749 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S266142AbUBJT0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:26:52 -0500
Date: Tue, 10 Feb 2004 12:26:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@suse.cz>,
       akpm@osdl.org, george@mvista.com, Andi Kleen <ak@suse.de>,
       jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040210192649.GM5219@smtp.west.cox.net>
References: <20040127184029.GI32525@stop.crashing.org> <20040209173828.GG2315@waste.org> <200402101327.40378.amitkale@emsyssoft.com> <200402101357.39236.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402101357.39236.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 01:57:39PM +0530, Amit S. Kale wrote:

> Tom,
> Can you please post diffs wrt. 2.6.x kernels for the bitkeeper challanged
> (me :)?

I appologize for not getting to this sooner, but I've been doing a lot
of cleanups and such to the code (and not being as well versed in the
gdb protocol as I'd have like to been, spending some time looking into
user-error type bugs).  But I'm now at the point where I'm much happier
with how KGDB works wrt breaking in, resuming sessions, etc, so I'm
going to start double checking kgdboe again and hopefully checkin, and
then break out for Andrew all of the stuff I've got.  The following is
a patch against what I've pushed last (debug bits and all):
 arch/i386/kernel/irq.c     |    3 
 arch/ppc/kernel/irq.c      |    5 
 arch/x86_64/kernel/irq.c   |    2 
 drivers/net/kgdb_eth.c     |   10 -
 drivers/serial/kgdb_8250.c |   35 +-----
 include/linux/kgdb.h       |   24 +++-
 init/main.c                |    2 
 kernel/Kconfig.kgdb        |    2 
 kernel/kgdbstub.c          |  231 ++++++++++++++++++++-------------------------
 9 files changed, 143 insertions(+), 171 deletions(-)
--- 1.49/arch/i386/kernel/irq.c	Wed Jan 21 10:13:13 2004
+++ edited/arch/i386/kernel/irq.c	Tue Feb 10 11:03:49 2004
@@ -34,6 +34,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/kgdb.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -507,6 +508,8 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+
+	kgdb_process_breakpoint();
 
 	return 1;
 }
--- 1.37/arch/ppc/kernel/irq.c	Fri Jan 23 14:10:18 2004
+++ edited/arch/ppc/kernel/irq.c	Tue Feb 10 11:03:49 2004
@@ -46,6 +46,7 @@
 #include <linux/random.h>
 #include <linux/seq_file.h>
 #include <linux/cpumask.h>
+#include <linux/kgdb.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -538,7 +539,9 @@
 	if (irq != -2 && first)
 		/* That's not SMP safe ... but who cares ? */
 		ppc_spurious_interrupts++;
-        irq_exit();
+	irq_exit();
+
+	kgdb_process_breakpoint();
 }
 
 unsigned long probe_irq_on (void)
--- 1.21/arch/x86_64/kernel/irq.c	Wed Dec 31 22:27:45 2003
+++ edited/arch/x86_64/kernel/irq.c	Tue Feb 10 11:03:49 2004
@@ -405,6 +405,8 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+
+	kgdb_process_breakpoint();
 	return 1;
 }
 
--- 1.3/drivers/net/kgdb_eth.c	Thu Feb  5 16:05:24 2004
+++ edited/drivers/net/kgdb_eth.c	Tue Feb 10 11:03:49 2004
@@ -60,8 +60,6 @@
 static atomic_t in_count;
 int kgdboe = 0; /* Default to tty mode */
 
-extern void set_debug_traps(void);
-extern void breakpoint(void);
 static void rx_hook(struct netpoll *np, int port, char *msg, int len);
 
 static struct netpoll np = {
@@ -91,6 +89,7 @@
 	if(out_count && np.dev) {
 		netpoll_send_udp(&np, out_buf, out_count);
 		out_count = 0;
+		memset(out_buf, 0, sizeof(out_buf));
 	}
 }
 
@@ -108,13 +107,10 @@
 	np->remote_port = port;
 
 	/* Is this gdb trying to attach? */
-	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
-		breakpoint();
+	if (!kgdb_connected && !netpoll_trap())
+		kgdb_schedule_breakpoint();
 
 	for (i = 0; i < len; i++) {
-		if (msg[i] == 3)
-			breakpoint();
-
 		if (atomic_read(&in_count) >= IN_BUF_SIZE) {
 			/* buffer overflow, clear it */
 			in_head = in_tail = 0;
--- 1.3/drivers/serial/kgdb_8250.c	Thu Feb  5 16:05:24 2004
+++ edited/drivers/serial/kgdb_8250.c	Tue Feb 10 11:23:45 2004
@@ -65,9 +65,6 @@
 static atomic_t kgdb8250_buf_in_cnt;
 static int kgdb8250_buf_out_inx;
 
-static int kgdb8250_got_dollar = -3, kgdb8250_got_H = -3,
-    kgdb8250_interrupt_iteration = 0;
-
 /* Determine serial information. */
 static struct serial_state state = {
 	.magic = SSTATE_MAGIC,
@@ -98,7 +95,6 @@
 static void (*serial_outb) (unsigned char val, unsigned long addr);
 static unsigned long (*serial_inb) (unsigned long addr);
 
-extern void set_debug_traps(void);	/* GDB routine */
 int serial8250_release_irq(int irq);
 
 static int kgdb8250_init(void);
@@ -250,6 +246,12 @@
 	if (irq != gdb_async_info.line)
 		return IRQ_NONE;
 
+	/* If we get an interrupt, then KGDB is trying to connect. */
+	if (!kgdb_connected) {
+		kgdb_schedule_breakpoint();
+		return IRQ_HANDLED;
+	}
+
 	local_irq_save(flags);
 	spin_lock(&uart_interrupt_lock);
 
@@ -265,28 +267,6 @@
 			continue;
 		}
 
-		if (atomic_read(&kgdb_killed_or_detached)) {
-			if (chr == '$')
-				kgdb8250_got_dollar =
-				    kgdb8250_interrupt_iteration;
-			if (kgdb8250_interrupt_iteration ==
-			    kgdb8250_got_dollar + 1 && chr == 'H')
-				kgdb8250_got_H = kgdb8250_interrupt_iteration;
-			else if (kgdb8250_interrupt_iteration ==
-				 kgdb8250_got_H + 1 && chr == 'c') {
-				kgdb8250_buf[kgdb8250_buf_in_inx++] = chr;
-				atomic_inc(&kgdb8250_buf_in_cnt);
-				atomic_set(&kgdb_might_be_resumed, 1);
-				wmb();
-				breakpoint();
-				atomic_set(&kgdb_might_be_resumed, 0);
-				kgdb8250_interrupt_iteration = 0;
-				kgdb8250_got_dollar = -3;
-				kgdb8250_got_H = -3;
-				continue;
-			}
-		}
-
 		if (atomic_read(&kgdb8250_buf_in_cnt) >= GDB_BUF_SIZE) {
 			/* buffer overflow, clear it */
 			kgdb8250_buf_in_inx = 0;
@@ -299,9 +279,6 @@
 		kgdb8250_buf_in_inx &= (GDB_BUF_SIZE - 1);
 		atomic_inc(&kgdb8250_buf_in_cnt);
 	} while (iir & UART_IIR_RDI);
-
-	if (atomic_read(&kgdb_killed_or_detached))
-		kgdb8250_interrupt_iteration++;
 
 	spin_unlock(&uart_interrupt_lock);
 	local_irq_restore(flags);
--- 1.4/include/linux/kgdb.h	Thu Feb  5 16:05:24 2004
+++ edited/include/linux/kgdb.h	Tue Feb 10 11:25:25 2004
@@ -11,8 +11,21 @@
 #include <asm/atomic.h>
 #include <linux/debugger.h>
 
+/*
+ * This file should not include ANY others.  This makes it usable
+ * most anywhere without the fear of include order or inclusion.
+ * TODO: Make it so!
+ *
+ * This file may be included all the time.  It is only active if
+ * CONFIG_KGDB is defined, otherwise it stubs out all the macros
+ * and entry points.
+ */
+
+#if defined(CONFIG_KGDB) && !defined(__ASSEMBLY__)
 /* To enter the debugger explicitly. */
-void breakpoint(void);
+extern void breakpoint(void);
+extern void kgdb_process_breakpoint(void);
+extern volatile int kgdb_connected;
 
 #ifndef KGDB_MAX_NO_CPUS
 #if CONFIG_NR_CPUS > 8
@@ -21,10 +34,8 @@
 #define KGDB_MAX_NO_CPUS 8
 #endif
 
-extern atomic_t kgdb_setting_breakpoint;
-extern atomic_t kgdb_killed_or_detached;
-extern atomic_t kgdb_might_be_resumed;
-	
+extern volatile int kgdb_connected;
+
 extern struct task_struct *kgdb_usethread, *kgdb_contthread;
 
 enum gdb_bptype
@@ -110,4 +121,7 @@
 int kgdb_hexToLong(char **ptr, long *longValue);
 char *kgdb_mem2hex(char *mem, char *buf, int count, int can_fault);
 
+#else
+#define kgdb_process_breakpoint()	do {} while(0)
+#endif /* KGDB && !__ASSEMBLY__ */
 #endif /* _KGDB_H_ */
--- 1.118/init/main.c	Tue Jan 27 11:41:03 2004
+++ edited/init/main.c	Tue Feb 10 11:03:49 2004
@@ -581,8 +581,8 @@
 	do_pre_smp_initcalls();
 
 	smp_init();
-	debugger_entry();
 	do_basic_setup();
+	debugger_entry();
 
 	prepare_namespace();
 
--- 1.1/kernel/Kconfig.kgdb	Thu Jan 29 14:30:40 2004
+++ edited/kernel/Kconfig.kgdb	Tue Feb 10 11:03:49 2004
@@ -101,7 +101,7 @@
 
 config KGDB_CONSOLE
 	bool "KGDB: Console messages through gdb"
-	depends on KGDB
+	depends on KGDB && !KGDB_ETH
 	help
 	  If you say Y here, console messages will appear through gdb.
 	  Other consoles such as tty or ttyS will continue to work as usual.
--- 1.6/kernel/kgdbstub.c	Thu Feb  5 16:05:24 2004
+++ edited/kernel/kgdbstub.c	Tue Feb 10 12:11:55 2004
@@ -117,7 +117,7 @@
 kgdb_arch_handle_exception(int vector, int signo, int err_code, char *InBuffer,
 		char *outBuffer, struct pt_regs *regs)
 {
-	return 0;
+	return -1;	/* Do not exit from the handler. */
 }
 
 int __attribute__ ((weak))
@@ -164,14 +164,12 @@
 int kgdb_enter = 0;
 static const char hexchars[] = "0123456789abcdef";
 
-int get_char(char *addr, unsigned char *data, int can_fault);
-int set_char(char *addr, int data, int can_fault);
+static int get_char(char *addr, unsigned char *data, int can_fault);
+static int set_char(char *addr, int data, int can_fault);
 
 spinlock_t slavecpulocks[KGDB_MAX_NO_CPUS];
-volatile int procindebug[KGDB_MAX_NO_CPUS];
-atomic_t kgdb_setting_breakpoint;
-atomic_t kgdb_killed_or_detached;
-atomic_t kgdb_might_be_resumed;
+static volatile int procindebug[KGDB_MAX_NO_CPUS];
+static atomic_t kgdb_setting_breakpoint;
 volatile int kgdb_connected;
 struct task_struct *kgdb_usethread, *kgdb_contthread;
 
@@ -221,13 +219,14 @@
 {
 	unsigned char checksum;
 	unsigned char xmitcsum;
-	int i;
 	int count;
 	char ch;
 
 	do {
 	/* wait around for the start character, ignore all other characters */
-		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$');
+		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$')
+			;	/* Spin */
+		kgdb_connected = 1;
 		checksum = 0;
 		xmitcsum = -1;
 
@@ -249,24 +248,17 @@
 			xmitcsum += hex(kgdb_serial->read_char() & 0x7f);
 
 			if (checksum != xmitcsum)
-				kgdb_serial->write_char('-');	/* failed checksum */
-			else {
-				kgdb_serial->write_char('+');	/* successful transfer */
-				/* if a sequence char is present, reply the sequence ID */
-				if (buffer[2] == ':') {
-					kgdb_serial->write_char(buffer[0]);
-					kgdb_serial->write_char(buffer[1]);
-					/* remove sequence chars from buffer */
-					count = strlen(buffer);
-					for (i = 3; i <= count; i++)
-						buffer[i - 3] = buffer[i];
-				}
-			}
+				/* Retransmit. */
+				kgdb_serial->write_char('-');
+			else
+				/* ACK. */
+				kgdb_serial->write_char('+');
+
 			if (kgdb_serial->flush)
 				kgdb_serial->flush();
 		}
 	} while (checksum != xmitcsum);
-
+	printk("%s : %s\n", __func__, buffer);
 }
 
 
@@ -275,27 +267,25 @@
  * Check for gdb connection if asked for.
  */
 static void
-putpacket(char *buffer, int checkconnect)
+putpacket(char *buffer)
 {
 	unsigned char checksum;
 	int count;
 	char ch;
-	static char gdbseq[] = "$Hc-1#09";
-	int i;
-	int send_count;
+
+	printk("%s : %s\n", __func__, buffer);
 
 	/*  $<packet info>#<checksum>. */
 	do {
-		kgdb_serial->write_char('$');
 		checksum = 0;
 		count = 0;
-		send_count = 0;
 
+		/* Write out the packet. */
+		kgdb_serial->write_char('$');
 		while ((ch = buffer[count])) {
 			kgdb_serial->write_char(ch);
 			checksum += ch;
-			count ++;
-			send_count ++;
+			count++;
 		}
 
 		kgdb_serial->write_char('#');
@@ -303,31 +293,7 @@
 		kgdb_serial->write_char(hexchars[checksum % 16]);
 		if (kgdb_serial->flush)
 			kgdb_serial->flush();
-
-		i = 0;
-		while ((ch = kgdb_serial->read_char()) == gdbseq[i++] &&
-		       checkconnect) {
-			if (!gdbseq[i]) {
-				kgdb_serial->write_char('+');
-				if (kgdb_serial->flush)
-					kgdb_serial->flush();
-				breakpoint();
-
-				/*
-				 * GDB is available now.
-				 * Retransmit this packet.
-				 */
-				break;
-			}
-		}
-		if (checkconnect && ch == 3) {
-			kgdb_serial->write_char('+');
-			if (kgdb_serial->flush)
-				kgdb_serial->flush();
-			breakpoint();
-		}
-	} while (( ch & 0x7f) != '+');
-
+	} while ((kgdb_serial->read_char() & 0x7f) != '+');
 }
 
 /*
@@ -568,7 +534,10 @@
 				return -1;
 			kgdb_break[i].state = bp_disabled;
 			return 0;
-		}
+		} else
+			printk("Breakpoint %d is state %d and addr %08lx\n",
+					i, kgdb_break[i].state,
+					kgdb_break[i].bpt_addr);
 	}
 	return -1;
 }
@@ -576,6 +545,9 @@
 int remove_all_break(void)
 {
 	int i;
+
+	printk("%s\n", __func__);
+
 	for (i=0; i < MAX_BREAKPOINTS; i++) {
 		if(kgdb_break[i].state == bp_enabled) {
 			unsigned long addr = kgdb_break[i].bpt_addr;
@@ -708,20 +680,9 @@
 	/* Master processor is completely in the debugger */
 	kgdb_post_master_code(linux_regs, exVector, err_code);
 
-	if (atomic_read(&kgdb_killed_or_detached) &&
-	    atomic_read(&kgdb_might_be_resumed)) {
-		getpacket(remcomInBuffer);
-		if(remcomInBuffer[0] == 'H' && remcomInBuffer[1] =='c') {
-			remove_all_break();
-			atomic_set(&kgdb_killed_or_detached, 0);
-			strcpy(remcomOutBuffer, "OK");
-		}
-		else
-			return 1;
-	}
-	else {
-
-		/* reply to host that an exception has occurred */
+	/* If kgdb is connected, then an exception has occured, and
+	 * we need to pass something back to GDB. */
+	if (kgdb_connected) {
 		ptr = remcomOutBuffer;
 		*ptr++ = 'T';
 		*ptr++ = hexchars[(signo >> 4) % 16];
@@ -741,10 +702,10 @@
 		int_to_threadref(&thref, shadow_pid(current->pid));
 		ptr = pack_threadid(ptr, &thref);
 		*ptr++ = ';';
-	}		
-	putpacket(remcomOutBuffer, 0);
-	kgdb_connected = 1;
-	
+
+		putpacket(remcomOutBuffer);
+	}
+
 	kgdb_usethread = current;
 	kgdb_usethreadid = shadow_pid(current->pid);
 
@@ -765,11 +726,28 @@
 #endif
 		switch (remcomInBuffer[0]) {
 		case '?':
-			remcomOutBuffer[0] = 'S';
-			remcomOutBuffer[1] = hexchars[signo >> 4];
-			remcomOutBuffer[2] = hexchars[signo % 16];
+			/* reply to host that an exception has occurred */
+			ptr = remcomOutBuffer;
+			*ptr++ = 'T';
+			*ptr++ = hexchars[(signo >> 4) % 16];
+			*ptr++ = hexchars[signo % 16];
+			*ptr++ = hexchars[(PC_REGNUM >> 4) % 16];
+			*ptr++ = hexchars[PC_REGNUM % 16];
+			*ptr++ = ':';
+			ptr = kgdb_mem2hex((char *)&linux_regs->PTRACE_PC, ptr,
+					4, 0);
+			*ptr++ = ';';
+			*ptr++ = hexchars[SP_REGNUM >> 4];
+			*ptr++ = hexchars[SP_REGNUM & 0xf];
+			*ptr++ = ':';
+			ptr = kgdb_mem2hex(((char *)linux_regs) + SP_REGNUM * 4,
+					ptr, 4, 0);
+			*ptr++ = ';';
+			ptr += strlen(strcpy(ptr, "thread:"));
+			int_to_threadref(&thref, shadow_pid(current->pid));
+			ptr = pack_threadid(ptr, &thref);
+			*ptr++ = ';';
 			break;
-
 		case 'g':	/* return the value of the CPU registers */
 			thread = kgdb_usethread;
 				
@@ -854,29 +832,19 @@
 				strcpy(remcomOutBuffer, "E02");
 			}
 			break;
-
-			
-			/* Continue and Single Step are Architecture specific
-			 * and will not be handled by the generic code.
-			 */
-
-
-			/* kill the program. KGDB should treat this like a 
-			 * continue.
-			 */
+		/* GDB has told us it is detaching.  So we'll remove all of
+		 * our breakpoints and get back to 'normal'. */
 		case 'D':
 			strcpy(remcomOutBuffer, "OK");
-			remove_all_break();
-			putpacket(remcomOutBuffer, 0);
-			kgdb_connected = 0;
-			goto default_handle;
-
+			putpacket(remcomOutBuffer);
+			/* fall through. */
+		/* GDB is telling us to 'kill' the running process.  We'll
+		 * just stop debugging. */
 		case 'k':
 			remove_all_break();
 			kgdb_connected = 0;
-			goto default_handle;
-
-			/* query */
+			goto kgdb_exit;
+		/* query */
 		case 'q':
 			switch (remcomInBuffer[1]) {
 			case 's':
@@ -973,7 +941,6 @@
 				break;
 
 			case 'c':
-				atomic_set(&kgdb_killed_or_detached, 0);
 				ptr = &remcomInBuffer[2];
 				kgdb_hexToLong(&ptr, &threadid);
 				if (!threadid) {
@@ -1031,11 +998,16 @@
 							bpt_type);
 			}
 			else {
-				if (bpt_type == bp_breakpoint)
+				if (bpt_type == bp_breakpoint) {
+					printk("bpt_type == bp_breakpoint");
 					ret = remove_break(addr);
-				else
+					printk(": %d\n", ret);
+				} else {
+					printk("bpt_type != bp_breakpoint");
 					ret = kgdb_arch_remove_break(addr,
 							bpt_type);
+					printk(": %d\n", ret);
+				}
 			}
 			
 			if (ret == 0)
@@ -1046,16 +1018,12 @@
 			break;
 
 		default:
-		default_handle:
-			ret = kgdb_arch_handle_exception(exVector, signo,
-					err_code, remcomInBuffer,
-					remcomOutBuffer, linux_regs);
-
-			if(ret >= 0 || remcomInBuffer[0] == 'D' ||
-			    remcomInBuffer[0] == 'k')
+			if (kgdb_arch_handle_exception(exVector, signo,
+						err_code, remcomInBuffer,
+						remcomOutBuffer,
+						linux_regs) >= 0)
+				/* An error occured. */
 				goto kgdb_exit;
-
-
 		}		/* switch */
 #if KGDB_DEBUG
 		bust_spinlocks(1);
@@ -1064,7 +1032,7 @@
 #endif
 
 		/* reply to the request */
-		putpacket(remcomOutBuffer, 0);
+		putpacket(remcomOutBuffer);
 	}
 
 kgdb_exit:
@@ -1088,7 +1056,6 @@
 	}
 
 	/* Free debugger_active */
-	atomic_set(&kgdb_killed_or_detached, 1);
 	atomic_set(&debugger_active, 0);
 	local_irq_restore(flags);
 
@@ -1118,21 +1085,9 @@
 	/* Free debugger_active */
 	atomic_set(&debugger_active, 0);
 
-	/* This flag is used, if gdb has detached and wants to start
-	 * another session
-	 */
-	atomic_set(&kgdb_killed_or_detached, 1);
-	atomic_set(&kgdb_might_be_resumed, 0);
-
 	for (i = 0; i < MAX_BREAKPOINTS; i++) 
 		kgdb_break[i].state = bp_disabled;
 
-	
-	/*
-	 * In case GDB is started before us, ack any packets (presumably
-	 * "$?#xx") sitting there.  */
-	kgdb_serial->write_char('+');
-
 	linux_debug_hook = kgdb_handle_exception;
 
 	/* We can't do much if this fails */
@@ -1150,10 +1105,8 @@
 
 void breakpoint(void)
 {
-	if (!kgdb_initialized) {
-		printk("calling set_debug_traps\n");
+	if (!kgdb_initialized)
 		set_debug_traps();
-	}
 
 	atomic_set(&kgdb_setting_breakpoint, 1);
 	wmb();
@@ -1209,6 +1162,30 @@
 	printk("Connected.\n");
 }
 
+/*
+ * Sometimes we need to schedule a breakpoint because we can't break
+ * right where we are.
+ */
+static int kgdb_need_breakpoint[NR_CPUS];
+
+void kgdb_schedule_breakpoint(void)
+{
+	kgdb_need_breakpoint[smp_processor_id()] = 1;
+}
+
+void kgdb_process_breakpoint(void)
+{
+	/*
+	 * Handle a breakpoint queued from inside network driver code
+         * to avoid reentrancy issues
+	 */
+	if (kgdb_need_breakpoint[smp_processor_id()]) {
+		printk("Making a break\n");
+		kgdb_need_breakpoint[smp_processor_id()] = 0;
+		breakpoint();
+	}
+}
+
 #ifdef CONFIG_KGDB_CONSOLE
 char kgdbconbuf[BUFMAX];
 
@@ -1239,7 +1216,7 @@
 		*bufptr = '\0';
 		s += wcount;
 
-		putpacket(kgdbconbuf, 1);
+		putpacket(kgdbconbuf);
 
 	}
 	local_irq_restore(flags);

I'll check it in incrementally when I'm done, so it's easier to see
what's what in bkweb.

-- 
Tom Rini
http://gate.crashing.org/~trini/
