Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262786AbSJLC7n>; Fri, 11 Oct 2002 22:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262787AbSJLC7n>; Fri, 11 Oct 2002 22:59:43 -0400
Received: from franka.aracnet.com ([216.99.193.44]:24784 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262786AbSJLC7c>; Fri, 11 Oct 2002 22:59:32 -0400
Date: Fri, 11 Oct 2002 19:24:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Anton Blanchard <anton@samba.org>
cc: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
Message-ID: <1752854521.1034364285@[10.10.2.3]>
In-Reply-To: <20021012014332.GA7050@krispykreme>
References: <20021012014332.GA7050@krispykreme>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1752872036=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1752872036==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>> Are you going to have early console support (ie printk from before
>> what is now console_init) done before the freeze, or should I just 
>> submit our version?
> 
> On ppc64 Im currently setting a console up very early in arch init code
> and using the CONFIG_EARLY_PRINTK hook to disable it at console_init
> time. Works OK for me, do you guys need something on top of that?

Attatched is what I use when it all goes to hell in a handbasket. 

Works for me ... I'd love to see it more generally available, so
we didn't get bug reports saying "it says 'booting linux', then
nothing". I'm not desperately attatched to any one implementation,
as long as it works from really, really early on. The fact that
everyone and his dog (including me once, badly) has reimplemented 
this suggests it's very useful, and should go into mainline.

Patch by Bill Irwin and Keith Mannthey. Inlined so you can read it,
attached as well, cause my mail-reader on this PC seems to be eating 
things at the moment for some reason. This version supports standard
PC VGA consoles, and serial consoles (essential for remote work),
but should be easy to hook in other interfaces.

Probably needs some cleanup. If people would take a cleaned up version, 
I'll clean it up, or get someone to do it ;-)

M.

diff -urN linux-2.5.25/arch/i386/Config.help linux-2.5.25-early/arch/i386/Config.help
--- linux-2.5.25/arch/i386/Config.help	2002-07-05 16:42:04.000000000 -0700
+++ linux-2.5.25-early/arch/i386/Config.help	2002-07-16 13:11:21.000000000 -0700
@@ -941,6 +941,25 @@
   Say Y here if you want to reduce the chances of the tree compiling,
   and are prepared to dig into driver internals to fix compile errors.
 
+
+NO_CONFIG_EARLY_CONSOLE
+  If you are not doing early kernel devolopment NONE is what you want.
+  The other will add a early console for you (in i386)
+  This will allow you see printk output before console_init is called.
+  This is handy if you need to debug the kernel before this point.
+
+  VGA will give you a VGA console, your screen.
+
SERIAL will give you out put on your serial line.
+  Location of serial port
+  CONFIG_EARLY_CONSOLE_SERIAL_PORT
+   0x3F8 == COMM 1
+   0x3E8 == COMM 2
+
+CONFIG_EARLY_CONSOLE_SERIAL_BAUD
+  Set the the Baud of your serial console.
+
+
+
 Software Suspend
 CONFIG_SOFTWARE_SUSPEND
   Enable the possibilty of suspendig machine. It doesn't need APM.
diff -urN linux-2.5.25/arch/i386/config.in linux-2.5.25-early/arch/i386/config.in
--- linux-2.5.25/arch/i386/config.in	2002-07-25 10:23:53.000000000 -0700
+++ linux-2.5.25-early/arch/i386/config.in	2002-07-16 13:11:21.000000000 -0700
@@ -424,6 +424,16 @@
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
+
choice 'Early printk support'  \
+                "NONE               NO_CONFIG_EARLY_CONSOLE \
+                 VGA                CONFIG_EARLY_CONSOLE_VGA \
+                 Serial_PORT       CONFIG_EARLY_CONSOLE_SERIAL\
+                 Bochs_0xE9_hack    CONFIG_EARLY_CONSOLE_BOCHS_E9_HACK " NONE
+   if [ "$CONFIG_EARLY_CONSOLE_SERIAL" = "y" ]; then
+       hex "Location of serial port " CONFIG_EARLY_CONSOLE_SERIAL_PORT 0x3F8
+       int "Baud rate " CONFIG_EARLY_CONSOLE_SERIAL_BAUD  38400
+    fi
+
    fi
 fi
 
diff -urN linux-2.5.25/arch/i386/kernel/Makefile linux-2.5.25-early/arch/i386/kernel/Makefile
--- linux-2.5.25/arch/i386/kernel/Makefile	2002-07-05 16:42:14.000000000 -0700
+++ linux-2.5.25-early/arch/i386/kernel/Makefile	2002-07-16
13:11:21.000000000 -0700
@@ -11,7 +11,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
-		bootflag.o
+		bootflag.o early_consoles.o
 
 obj-y				+= cpu/
 obj-$(CONFIG_MCA)		+= mca.o
diff -urN linux-2.5.25/arch/i386/kernel/early_consoles.c linux-2.5.25-early/arch/i386/kernel/early_consoles.c
--- linux-2.5.25/arch/i386/kernel/early_consoles.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5.25-early/arch/i386/kernel/early_consoles.c	2002-07-16 13:19:34.000000000 -0700
@@ -0,0 +1,418 @@
+/*
+ * Early console drivers.
+ * (C) Nov 2001, William Irwin, IBM
+ *
+ * These are low-level pseudodrivers to enable
early console output
+ * to aid in debugging during early boot.
+ *
+ * They are crude, but hopefully effective. They rely on the fact
+ * that consoles are largely unused prior to the true console_init(),
+ * and that printk() uses the ->write callback and that callback
+ * only during its operation.
+ *
+ * Serial port routines are derived from Linux serial.c, and
+ * vga_putc() is derived from vsta, (C) Andrew Valencia.
+ */
+
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <linux/serial_reg.h>
+#include <asm/io.h>
+
+/*
+ * I/O ports are not linearly mapped on all architectures.
+ * On IA64 in particular, port I/O is just reading/writing from
+ * an uncached address, but ioremap there requires ia64_io_base
+ * to be initialized,
which does not happen until the middle of
+ * setup_arch(). So a port remapping macro is provided here.
+ *
+ * The IA64 case is not handled here, although the port remapping
+ * is demonstrated for the purposes of understanding its necessity.
+ * The IO_BASE is taken from Lion systems; in general, this varies.
+ * True handling for IA64 will be merged in given testing.
+ */
+
+#ifdef CONFIG_IA64
+
+#define IO_BASE   0xC0000FFFFC000000UL
+#define MK_PORT(port) ((char *)(IO_BASE|(((port)>>2)<<12)|((port) & 0xFFF)))
+
+#else
+
+/*
+ * This works for i386, but not everywhere.
+ * Other architectures with port I/O mapping needs will need to
+ * add to the preprocessor case analysis above.
+ */
+
+#define MK_PORT(port) (port)
+
+#endif
+
+#define
BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
+
+
+/*
+ * This serial output driver derived from the one appearing
+ * in serial.c
+ *
+ * It is a simple "bitbanging" style output routine, with
+ * initialization performed at every call.
+ */
+
+#ifdef CONFIG_EARLY_CONSOLE_SERIAL
+#define MAX_BAUD 115200
+#define BAUD_MSB (MAX_BAUD/CONFIG_EARLY_CONSOLE_SERIAL_BAUD)/0xFF
+#define BAUD_LSB (MAX_BAUD/CONFIG_EARLY_CONSOLE_SERIAL_BAUD)%0xFF
+
+
+static inline void wait_for_readiness(unsigned port)
+{
+	unsigned retries;
+	unsigned char status;
+
+	/*
+	 * Wait for transmitter holding and shift registers to empty,
+	 * which is required for output to succeed. If the retries are
+	 * exceeded, this deliberately fails to ensure termination.
+	 */
+	for(retries
= 0; retries < 65536; ++retries) {
+		status = inb(MK_PORT(port + 5));
+		if((status & BOTH_EMPTY) == BOTH_EMPTY)
+			break;
+	}
+}
+
+static int serial_init = 0; 
+
+static void init_serial_io_port(unsigned port)
+{
+	serial_init = 1;
+
+	wait_for_readiness(port);
+
+        /*
+         * Disable interrupts.
+         */
+        outb(0x0, MK_PORT(port + 1));
+
+        /*
+         * Set the baud rate divisor's LSB.
+         */
+        outb(BAUD_MSB, MK_PORT(port + 3));
+
+        /*
+         * Set the baud rate divisor's MSB.
+         */
+        outb(BAUD_LSB, MK_PORT(port));
+
+        /*
+         * Set no parity, 8 bits, 1 stop bit, and select
+         * interrupt enable register.
+         */
+        outb(0x3, MK_PORT(port + 3));
+}
+

+
+static void write_serial_io_port(unsigned port,
+					const char *s,
+					unsigned n)
+{
+	unsigned k;
+	
+	if (serial_init==0)
+	{
+		init_serial_io_port(port);
+	}
+
+	/*
+	 * Set data terminal ready and request to send.
+	 */
+
+	for(k = 0; k < n; ++k) {
+		wait_for_readiness(port);
+		outb(s[k], MK_PORT(port));
+		if(s[k] == '\n') {
+			wait_for_readiness(port);
+			outb('\r', MK_PORT(port));
+		}
+	}
+}
+
+
+
+/*
+ * On Intel-derived architectures it is customary for onboard serial
+ * ports to have I/O ports at these two port addresses.
+ */
+
+static void write_serial(struct console *c, const char *s, unsigned n)
+{
+	write_serial_io_port(CONFIG_EARLY_CONSOLE_SERIAL_PORT, s, n);
+}
+
+static struct console early_console_serial =
+{
+
	write: write_serial
+};
+#endif
+
+
+#ifdef CONFIG_EARLY_CONSOLE_VGA
+
+/*
+ * This should work for a variety of Intel-derived architectures,
+ * as it is customary for VGA memory to reside in this address range.
+ * vga_putc() is derived from vsta sources, (C) Andrew Valencia.
+ *
+ * Several forms of functionality are intentionally omitted in the
+ * interest of robustness, in particular, cursor movement and cursor
+ * position determination.
+ */
+
+#define VGA_MAXCOL 80
+#define VGA_MAXROW 25
+#define VGA_SCRNSZ (VGA_MAXCOL * VGA_MAXROW)
+#define VGA_REG_PORT 0x3D4
+#define VGA_VAL_PORT 0x3D5
+#define VGA_TEXT_BUFFER 0xB8000
+
+#define VGA_CHAR(_row_, _col_) vga_mem[(_row_)*VGA_MAXCOL + (_col_)].c
+
+struct vga_char_desc
+{
+	unsigned char c;
+
	unsigned char color;
+};
+
+static struct vga_char_desc * vga_mem = 
+	(struct vga_char_desc *)(VGA_TEXT_BUFFER + PAGE_OFFSET);
+
+/*
+ ** The screen position can actually be determined by port I/O,
+ ** but in the interest of robustness, these are always initialized
+ ** to the (0, 0) position. These position indices must always be
+ ** strictly less than the bounds VGA_MAXROW and VGA_MAXCOL.
+ **/
+static unsigned short row;
+static unsigned short col;
+	
+
+/*from martin bligh's early_printk */
+static inline void update_cursor(void)
+{
+        int pos = (col + VGA_MAXCOL*row) *2;
+   
+       	outb_p(14, VGA_REG_PORT);
+        outb_p(0xff & (pos >> 9), VGA_VAL_PORT);
+        outb_p(15, VGA_REG_PORT);
+        outb_p(0xff & (pos >> 1),
VGA_VAL_PORT);
+}
+
+
+void clear_vga_mem(void)
+{
+        int x, y;
+
+        for (x = 0; x < 80; x++) {
+                for (y = 0; y < 25; y++) {
+                        VGA_CHAR(y,x) = ' ';
+                }
+        }
+	row =0;
+	col =0;
+	update_cursor();
+}
+
+
+	
+
+/*
+ * The characters displayed at a screen position can be discerned by
+ * reading from the corresponding memory location. This can be used
+ * to simulate scrolling movement. Line blanking is simulated by
+ * overwriting the displayed characters with the space character.
+ *
+ * In the interest of robustness, cursor movement is also omitted.
+ */
+static inline void vga_scroll_up(void)
+{
+	unsigned k;
+
+	for(k = 0; k < (VGA_SCRNSZ - VGA_MAXCOL); ++k)
+		vga_mem[k].c =
vga_mem[k + VGA_MAXCOL].c;
+
+	for(k = VGA_SCRNSZ - VGA_MAXCOL; k < VGA_SCRNSZ; ++k)
+		vga_mem[k].c = ' ';
+}
+
+
+/*
+ * Line advancement must preserve the invariant that the row and
+ * column indices are in-bounds. The semantics of this mean that
+ * when line advancement "beyond" the last line results in scrolling.
+ */
+static inline void vga_line_advance(void)
+{
+	++row;
+
+	if(row >= VGA_MAXROW) {
+		row = VGA_MAXROW - 1;
+		vga_scroll_up();
+	}
+}
+
+
+/*
+ * Character advancement must once again preserve the in-bounds
+ * invariants, and in so doing line wrapping and advancement may occur.
+ */
+static inline void vga_char_advance(void)
+{
+	++col;
+
+	if(col >= VGA_MAXCOL) {
+		col = 0;
+		vga_line_advance();
+	}
+}
+
+
+/*
+ * Derived
from vsta sources (C) Andrew Valencia.
+ * Here the interpretation of several common special characters occurs,
+ * namely linefeeds, newlines, tabs, and backspaces. The position
+ * indices are updated using the vga_char_advance() and vga_line_advance()
+ * routines, and a vga_char_advance() is triggered on the printing of
+ * each ordinary character. The special characters have specialized
+ * position update semantics in order to be faithful to their customary
+ * cursor movement effects, although the cursor position is not updated.
+ */
+static void vga_putc(char c)
+{
+	unsigned k;
+	switch(c) {
+		case '\t':
+			for(k = 0; k < 8; ++k) {
+				VGA_CHAR(row, col) = ' ';
+				vga_char_advance();
+			}
+			break;
+
+		case '\r':
+			col = 0;
+
	break;
+
+		case '\n':
+			col = 0;
+			vga_line_advance();
+			break;
+
+		case '\b':
+			if(col > 0) {
+				--col;
+				VGA_CHAR(row, col) = ' ';
+			}
+			break;
+
+		default:
+			VGA_CHAR(row, col) = c;
+			vga_char_advance();
+			break;
+	}
+}
+
+
+/*
+ * write_vga(), given a NUL-terminated character array, writes
+ * characters to VGA space in bulk, and is the callback used for the
+ * driver structure.
+ */
+static void write_vga(struct console *c, const char *s, unsigned n)
+{
+	unsigned k;
+
+	for(k = 0; k < n; ++k)
+	{	
+		vga_putc(s[k]);
+		update_cursor();
+	}
+}
+
+static struct console early_console_vga =
+{
+	write: write_vga
+};
+
+#endif /*END CONFIG_EARLY_CONSOLE_VGA*/ 
+
+
+
+/*
+ * The bochs x86 simulator has an optional feature
for enabling
+ * debugging output through a normally unused ISA I/O port. The
+ * protocol for communicating with the simulated device is simply
+ * using port I/O writes to write a stream of characters to the
+ * device, and these are then relayed by the simulator to the
+ * controlling terminal of the simulator process.
+ */
+#ifdef CONFIG_EARLY_CONSOLE_BOCHS_E9_HACK
+static void write_bochs(struct console *c, const char *s, unsigned n)
+{
+	unsigned k;
+
+	for(k = 0; k < n; ++k)
+		outb(s[k], MK_PORT(0xE9));
+}
+
+static struct console early_console_bochs =
+{
+	write: write_bochs
+};
+#endif /* CONFIG_EARLY_CONSOLE_BOCHS_E9_HACK */
+
+
+/*
+ * In order to minimize the number of #ifdefs whch must
+ * appear in-line, this direct-mapped,
NULL-terminated table
+ * of console entries is used to provide a configuration-independent
+ * structure which may be traversed to discover all of the available
+ * early console devices for registration and unregistration.
+ *
+ * This is the ugliest part of the code, thanks to #ifdef
+ */
+static struct console * early_console_table[] =
+	{
+#ifdef CONFIG_EARLY_CONSOLE_SERIAL
+		&early_console_serial,
+#endif
+#ifdef CONFIG_EARLY_CONSOLE_VGA
+		&early_console_vga,
+#endif 
+#ifdef CONFIG_EARLY_CONSOLE_BOCHS_E9_HACK
+		&early_console_bochs,
+#endif
+		NULL
+	};
+
+
+/*
+ * The above implementations are quite far from complete console
+ * devices, but printk() only requires the ->write callback, so this is
+ * somewhat deceptive, but still cleaner
than editing printk.c itself.
+ */
+void add_early_consoles(void)
+{
+	
+	struct console **c = early_console_table;
+	while(*c)
+	{
+		register_early_console(*c++);
+		printk ("consoled added!\n\n");
+	}
+#ifdef CONFIG_EARLY_CONSOLE_VGA
+	clear_vga_mem();
+#endif 
+
+}
+
diff -urN linux-2.5.25/arch/i386/kernel/setup.c linux-2.5.25-early/arch/i386/kernel/setup.c
--- linux-2.5.25/arch/i386/kernel/setup.c	2002-07-05 16:42:23.000000000 -0700
+++ linux-2.5.25-early/arch/i386/kernel/setup.c	2002-07-16 13:11:21.000000000 -0700
@@ -598,7 +598,9 @@
 	int i;
 
 	early_cpu_init();
-
+	
+	add_early_consoles();
+	
 #ifdef CONFIG_VISWS
 	visws_get_board_type_and_rev();
 #endif
diff -urN linux-2.5.25/include/linux/console.h
linux-2.5.25-early/include/linux/console.h
--- linux-2.5.25/include/linux/console.h	2002-07-05 16:42:22.000000000 -0700
+++ linux-2.5.25-early/include/linux/console.h	2002-07-16 13:11:21.000000000 -0700
@@ -90,7 +90,7 @@
 #define CON_PRINTBUFFER	(1)
 #define CON_CONSDEV	(2) /* Last on the command line */
 #define CON_ENABLED	(4)
-
+#define EARLY_CONSOLE   (8) /* Early flag. Remove in con_init  */
 struct console
 {
 	char	name[8];
@@ -105,6 +105,7 @@
 	struct	 console *next;
 };
 
+
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
 extern struct console *console_drivers;
@@ -112,6 +113,9 @@
 extern void release_console_sem(void);
 extern void console_conditional_schedule(void);
 extern void
console_unblank(void);
+extern int clear_early_consoles(void);
+extern void register_early_console(struct console *);
+
 
 /* VESA Blanking Levels */
 #define VESA_NO_BLANKING        0
diff -urN linux-2.5.25/kernel/printk.c linux-2.5.25-early/kernel/printk.c
--- linux-2.5.25/kernel/printk.c	2002-07-05 16:42:23.000000000 -0700
+++ linux-2.5.25-early/kernel/printk.c	2002-07-16 13:11:21.000000000 -0700
@@ -579,6 +579,10 @@
 	int     i;
 	unsigned long flags;
 
+#ifndef  NO_CONFIG_EARLY_CONSOLE
+	clear_early_consoles();
+#endif
+
 	/*
 	 *	See if we want to use this console driver. If we
 	 *	didn't select a console we take the first one
@@ -676,6 +680,50 @@
 }
 EXPORT_SYMBOL(unregister_console);
 	
+/* This will clear any and all console_drivers that

+   use only in con_init to remove any consoles that setup_arch
+   may have added for early console support  
+ */
+int clear_early_consoles(void)
+{
+        struct console *a, *b;
+        int removed = 0;
+	
+	if(console_drivers)
+	{
+	acquire_console_sem();
+	
+	
+	for (a=console_drivers->next, b=console_drivers; a; b=a,a=b->next)
+	{
+		if (a->flags & EARLY_CONSOLE)
+                {
+		        b->next = a->next;        	
+		        removed++;
+		}
+	}
+
+	if (console_drivers->flags & EARLY_CONSOLE)
+	{
+		console_drivers=console_drivers->next;
+		removed++;
+	
+	}
+
+	if (console_drivers == NULL)
+		preferred_console = -1;
+
+	release_console_sem();
+	}
+	return removed;
+}
+
+void register_early_console(struct console *early_con)
+{
+
early_con->flags |= EARLY_CONSOLE;
+	register_console(early_con);
+}
+
 /**
  * tty_write_message - write a message to a certain tty, not just the console.
  *






--==========1752872036==========
Content-Type: application/octet-stream; name="early_console-2.5.25"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="early_console-2.5.25"; size=16019

ZGlmZiAtdXJOIGxpbnV4LTIuNS4yNS9hcmNoL2kzODYvQ29uZmlnLmhlbHAgbGludXgtMi41LjI1
LWVhcmx5L2FyY2gvaTM4Ni9Db25maWcuaGVscAotLS0gbGludXgtMi41LjI1L2FyY2gvaTM4Ni9D
b25maWcuaGVscAkyMDAyLTA3LTA1IDE2OjQyOjA0LjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgt
Mi41LjI1LWVhcmx5L2FyY2gvaTM4Ni9Db25maWcuaGVscAkyMDAyLTA3LTE2IDEzOjExOjIxLjAw
MDAwMDAwMCAtMDcwMApAQCAtOTQxLDYgKzk0MSwyNSBAQAogICBTYXkgWSBoZXJlIGlmIHlvdSB3
YW50IHRvIHJlZHVjZSB0aGUgY2hhbmNlcyBvZiB0aGUgdHJlZSBjb21waWxpbmcsCiAgIGFuZCBh
cmUgcHJlcGFyZWQgdG8gZGlnIGludG8gZHJpdmVyIGludGVybmFscyB0byBmaXggY29tcGlsZSBl
cnJvcnMuCiAKKworTk9fQ09ORklHX0VBUkxZX0NPTlNPTEUKKyAgSWYgeW91IGFyZSBub3QgZG9p
bmcgZWFybHkga2VybmVsIGRldm9sb3BtZW50IE5PTkUgaXMgd2hhdCB5b3Ugd2FudC4KKyAgVGhl
IG90aGVyIHdpbGwgYWRkIGEgZWFybHkgY29uc29sZSBmb3IgeW91IChpbiBpMzg2KQorICBUaGlz
IHdpbGwgYWxsb3cgeW91IHNlZSBwcmludGsgb3V0cHV0IGJlZm9yZSBjb25zb2xlX2luaXQgaXMg
Y2FsbGVkLgorICBUaGlzIGlzIGhhbmR5IGlmIHlvdSBuZWVkIHRvIGRlYnVnIHRoZSBrZXJuZWwg
YmVmb3JlIHRoaXMgcG9pbnQuCisKKyAgVkdBIHdpbGwgZ2l2ZSB5b3UgYSBWR0EgY29uc29sZSwg
eW91ciBzY3JlZW4uCisgIFNFUklBTCB3aWxsIGdpdmUgeW91IG91dCBwdXQgb24geW91ciBzZXJp
YWwgbGluZS4KKyAgTG9jYXRpb24gb2Ygc2VyaWFsIHBvcnQKKyAgQ09ORklHX0VBUkxZX0NPTlNP
TEVfU0VSSUFMX1BPUlQKKyAgIDB4M0Y4ID09IENPTU0gMQorICAgMHgzRTggPT0gQ09NTSAyCisK
K0NPTkZJR19FQVJMWV9DT05TT0xFX1NFUklBTF9CQVVECisgIFNldCB0aGUgdGhlIEJhdWQgb2Yg
eW91ciBzZXJpYWwgY29uc29sZS4KKworCisKIFNvZnR3YXJlIFN1c3BlbmQKIENPTkZJR19TT0ZU
V0FSRV9TVVNQRU5ECiAgIEVuYWJsZSB0aGUgcG9zc2liaWx0eSBvZiBzdXNwZW5kaWcgbWFjaGlu
ZS4gSXQgZG9lc24ndCBuZWVkIEFQTS4KZGlmZiAtdXJOIGxpbnV4LTIuNS4yNS9hcmNoL2kzODYv
Y29uZmlnLmluIGxpbnV4LTIuNS4yNS1lYXJseS9hcmNoL2kzODYvY29uZmlnLmluCi0tLSBsaW51
eC0yLjUuMjUvYXJjaC9pMzg2L2NvbmZpZy5pbgkyMDAyLTA3LTI1IDEwOjIzOjUzLjAwMDAwMDAw
MCAtMDcwMAorKysgbGludXgtMi41LjI1LWVhcmx5L2FyY2gvaTM4Ni9jb25maWcuaW4JMjAwMi0w
Ny0xNiAxMzoxMToyMS4wMDAwMDAwMDAgLTA3MDAKQEAgLTQyNCw2ICs0MjQsMTYgQEAKICAgIGJv
b2wgJyAgU3BpbmxvY2sgZGVidWdnaW5nJyBDT05GSUdfREVCVUdfU1BJTkxPQ0sKICAgIGlmIFsg
IiRDT05GSUdfSElHSE1FTSIgPSAieSIgXTsgdGhlbgogICAgICAgYm9vbCAnICBIaWdobWVtIGRl
YnVnZ2luZycgQ09ORklHX0RFQlVHX0hJR0hNRU0KKyAgIGNob2ljZSAnRWFybHkgcHJpbnRrIHN1
cHBvcnQnICBcCisgICAgICAgICAgICAgICAgIk5PTkUgICAgICAgICAgICAgICBOT19DT05GSUdf
RUFSTFlfQ09OU09MRSBcCisgICAgICAgICAgICAgICAgIFZHQSAgICAgICAgICAgICAgICBDT05G
SUdfRUFSTFlfQ09OU09MRV9WR0EgXAorICAgICAgICAgICAgICAgICBTZXJpYWxfUE9SVCAgICAg
ICBDT05GSUdfRUFSTFlfQ09OU09MRV9TRVJJQUxcCisgICAgICAgICAgICAgICAgIEJvY2hzXzB4
RTlfaGFjayAgICBDT05GSUdfRUFSTFlfQ09OU09MRV9CT0NIU19FOV9IQUNLICIgTk9ORQorICAg
aWYgWyAiJENPTkZJR19FQVJMWV9DT05TT0xFX1NFUklBTCIgPSAieSIgXTsgdGhlbgorICAgICAg
IGhleCAiTG9jYXRpb24gb2Ygc2VyaWFsIHBvcnQgIiBDT05GSUdfRUFSTFlfQ09OU09MRV9TRVJJ
QUxfUE9SVCAweDNGOAorICAgICAgIGludCAiQmF1ZCByYXRlICIgQ09ORklHX0VBUkxZX0NPTlNP
TEVfU0VSSUFMX0JBVUQgIDM4NDAwCisgICAgZmkKKwogICAgZmkKIGZpCiAKZGlmZiAtdXJOIGxp
bnV4LTIuNS4yNS9hcmNoL2kzODYva2VybmVsL01ha2VmaWxlIGxpbnV4LTIuNS4yNS1lYXJseS9h
cmNoL2kzODYva2VybmVsL01ha2VmaWxlCi0tLSBsaW51eC0yLjUuMjUvYXJjaC9pMzg2L2tlcm5l
bC9NYWtlZmlsZQkyMDAyLTA3LTA1IDE2OjQyOjE0LjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgt
Mi41LjI1LWVhcmx5L2FyY2gvaTM4Ni9rZXJuZWwvTWFrZWZpbGUJMjAwMi0wNy0xNiAxMzoxMToy
MS4wMDAwMDAwMDAgLTA3MDAKQEAgLTExLDcgKzExLDcgQEAKIG9iai15CTo9IHByb2Nlc3MubyBz
ZW1hcGhvcmUubyBzaWduYWwubyBlbnRyeS5vIHRyYXBzLm8gaXJxLm8gdm04Ni5vIFwKIAkJcHRy
YWNlLm8gaTgyNTkubyBpb3BvcnQubyBsZHQubyBzZXR1cC5vIHRpbWUubyBzeXNfaTM4Ni5vIFwK
IAkJcGNpLWRtYS5vIGkzODZfa3N5bXMubyBpMzg3Lm8gYmx1ZXNtb2tlLm8gZG1pX3NjYW4ubyBc
Ci0JCWJvb3RmbGFnLm8KKwkJYm9vdGZsYWcubyBlYXJseV9jb25zb2xlcy5vCiAKIG9iai15CQkJ
CSs9IGNwdS8KIG9iai0kKENPTkZJR19NQ0EpCQkrPSBtY2EubwpkaWZmIC11ck4gbGludXgtMi41
LjI1L2FyY2gvaTM4Ni9rZXJuZWwvZWFybHlfY29uc29sZXMuYyBsaW51eC0yLjUuMjUtZWFybHkv
YXJjaC9pMzg2L2tlcm5lbC9lYXJseV9jb25zb2xlcy5jCi0tLSBsaW51eC0yLjUuMjUvYXJjaC9p
Mzg2L2tlcm5lbC9lYXJseV9jb25zb2xlcy5jCTE5NjktMTItMzEgMTY6MDA6MDAuMDAwMDAwMDAw
IC0wODAwCisrKyBsaW51eC0yLjUuMjUtZWFybHkvYXJjaC9pMzg2L2tlcm5lbC9lYXJseV9jb25z
b2xlcy5jCTIwMDItMDctMTYgMTM6MTk6MzQuMDAwMDAwMDAwIC0wNzAwCkBAIC0wLDAgKzEsNDE4
IEBACisvKgorICogRWFybHkgY29uc29sZSBkcml2ZXJzLgorICogKEMpIE5vdiAyMDAxLCBXaWxs
aWFtIElyd2luLCBJQk0KKyAqCisgKiBUaGVzZSBhcmUgbG93LWxldmVsIHBzZXVkb2RyaXZlcnMg
dG8gZW5hYmxlIGVhcmx5IGNvbnNvbGUgb3V0cHV0CisgKiB0byBhaWQgaW4gZGVidWdnaW5nIGR1
cmluZyBlYXJseSBib290LgorICoKKyAqIFRoZXkgYXJlIGNydWRlLCBidXQgaG9wZWZ1bGx5IGVm
ZmVjdGl2ZS4gVGhleSByZWx5IG9uIHRoZSBmYWN0CisgKiB0aGF0IGNvbnNvbGVzIGFyZSBsYXJn
ZWx5IHVudXNlZCBwcmlvciB0byB0aGUgdHJ1ZSBjb25zb2xlX2luaXQoKSwKKyAqIGFuZCB0aGF0
IHByaW50aygpIHVzZXMgdGhlIC0+d3JpdGUgY2FsbGJhY2sgYW5kIHRoYXQgY2FsbGJhY2sKKyAq
IG9ubHkgZHVyaW5nIGl0cyBvcGVyYXRpb24uCisgKgorICogU2VyaWFsIHBvcnQgcm91dGluZXMg
YXJlIGRlcml2ZWQgZnJvbSBMaW51eCBzZXJpYWwuYywgYW5kCisgKiB2Z2FfcHV0YygpIGlzIGRl
cml2ZWQgZnJvbSB2c3RhLCAoQykgQW5kcmV3IFZhbGVuY2lhLgorICovCisKKyNpbmNsdWRlIDxs
aW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+CisjaW5jbHVkZSA8bGlu
dXgvc2VyaWFsX3JlZy5oPgorI2luY2x1ZGUgPGFzbS9pby5oPgorCisvKgorICogSS9PIHBvcnRz
IGFyZSBub3QgbGluZWFybHkgbWFwcGVkIG9uIGFsbCBhcmNoaXRlY3R1cmVzLgorICogT24gSUE2
NCBpbiBwYXJ0aWN1bGFyLCBwb3J0IEkvTyBpcyBqdXN0IHJlYWRpbmcvd3JpdGluZyBmcm9tCisg
KiBhbiB1bmNhY2hlZCBhZGRyZXNzLCBidXQgaW9yZW1hcCB0aGVyZSByZXF1aXJlcyBpYTY0X2lv
X2Jhc2UKKyAqIHRvIGJlIGluaXRpYWxpemVkLCB3aGljaCBkb2VzIG5vdCBoYXBwZW4gdW50aWwg
dGhlIG1pZGRsZSBvZgorICogc2V0dXBfYXJjaCgpLiBTbyBhIHBvcnQgcmVtYXBwaW5nIG1hY3Jv
IGlzIHByb3ZpZGVkIGhlcmUuCisgKgorICogVGhlIElBNjQgY2FzZSBpcyBub3QgaGFuZGxlZCBo
ZXJlLCBhbHRob3VnaCB0aGUgcG9ydCByZW1hcHBpbmcKKyAqIGlzIGRlbW9uc3RyYXRlZCBmb3Ig
dGhlIHB1cnBvc2VzIG9mIHVuZGVyc3RhbmRpbmcgaXRzIG5lY2Vzc2l0eS4KKyAqIFRoZSBJT19C
QVNFIGlzIHRha2VuIGZyb20gTGlvbiBzeXN0ZW1zOyBpbiBnZW5lcmFsLCB0aGlzIHZhcmllcy4K
KyAqIFRydWUgaGFuZGxpbmcgZm9yIElBNjQgd2lsbCBiZSBtZXJnZWQgaW4gZ2l2ZW4gdGVzdGlu
Zy4KKyAqLworCisjaWZkZWYgQ09ORklHX0lBNjQKKworI2RlZmluZSBJT19CQVNFICAgMHhDMDAw
MEZGRkZDMDAwMDAwVUwKKyNkZWZpbmUgTUtfUE9SVChwb3J0KSAoKGNoYXIgKikoSU9fQkFTRXwo
KChwb3J0KT4+Mik8PDEyKXwoKHBvcnQpICYgMHhGRkYpKSkKKworI2Vsc2UKKworLyoKKyAqIFRo
aXMgd29ya3MgZm9yIGkzODYsIGJ1dCBub3QgZXZlcnl3aGVyZS4KKyAqIE90aGVyIGFyY2hpdGVj
dHVyZXMgd2l0aCBwb3J0IEkvTyBtYXBwaW5nIG5lZWRzIHdpbGwgbmVlZCB0bworICogYWRkIHRv
IHRoZSBwcmVwcm9jZXNzb3IgY2FzZSBhbmFseXNpcyBhYm92ZS4KKyAqLworCisjZGVmaW5lIE1L
X1BPUlQocG9ydCkgKHBvcnQpCisKKyNlbmRpZgorCisjZGVmaW5lIEJPVEhfRU1QVFkgKFVBUlRf
TFNSX1RFTVQgfCBVQVJUX0xTUl9USFJFKQorCisKKy8qCisgKiBUaGlzIHNlcmlhbCBvdXRwdXQg
ZHJpdmVyIGRlcml2ZWQgZnJvbSB0aGUgb25lIGFwcGVhcmluZworICogaW4gc2VyaWFsLmMKKyAq
CisgKiBJdCBpcyBhIHNpbXBsZSAiYml0YmFuZ2luZyIgc3R5bGUgb3V0cHV0IHJvdXRpbmUsIHdp
dGgKKyAqIGluaXRpYWxpemF0aW9uIHBlcmZvcm1lZCBhdCBldmVyeSBjYWxsLgorICovCisKKyNp
ZmRlZiBDT05GSUdfRUFSTFlfQ09OU09MRV9TRVJJQUwKKyNkZWZpbmUgTUFYX0JBVUQgMTE1MjAw
CisjZGVmaW5lIEJBVURfTVNCIChNQVhfQkFVRC9DT05GSUdfRUFSTFlfQ09OU09MRV9TRVJJQUxf
QkFVRCkvMHhGRgorI2RlZmluZSBCQVVEX0xTQiAoTUFYX0JBVUQvQ09ORklHX0VBUkxZX0NPTlNP
TEVfU0VSSUFMX0JBVUQpJTB4RkYKKworCitzdGF0aWMgaW5saW5lIHZvaWQgd2FpdF9mb3JfcmVh
ZGluZXNzKHVuc2lnbmVkIHBvcnQpCit7CisJdW5zaWduZWQgcmV0cmllczsKKwl1bnNpZ25lZCBj
aGFyIHN0YXR1czsKKworCS8qCisJICogV2FpdCBmb3IgdHJhbnNtaXR0ZXIgaG9sZGluZyBhbmQg
c2hpZnQgcmVnaXN0ZXJzIHRvIGVtcHR5LAorCSAqIHdoaWNoIGlzIHJlcXVpcmVkIGZvciBvdXRw
dXQgdG8gc3VjY2VlZC4gSWYgdGhlIHJldHJpZXMgYXJlCisJICogZXhjZWVkZWQsIHRoaXMgZGVs
aWJlcmF0ZWx5IGZhaWxzIHRvIGVuc3VyZSB0ZXJtaW5hdGlvbi4KKwkgKi8KKwlmb3IocmV0cmll
cyA9IDA7IHJldHJpZXMgPCA2NTUzNjsgKytyZXRyaWVzKSB7CisJCXN0YXR1cyA9IGluYihNS19Q
T1JUKHBvcnQgKyA1KSk7CisJCWlmKChzdGF0dXMgJiBCT1RIX0VNUFRZKSA9PSBCT1RIX0VNUFRZ
KQorCQkJYnJlYWs7CisJfQorfQorCitzdGF0aWMgaW50IHNlcmlhbF9pbml0ID0gMDsgCisKK3N0
YXRpYyB2b2lkIGluaXRfc2VyaWFsX2lvX3BvcnQodW5zaWduZWQgcG9ydCkKK3sKKwlzZXJpYWxf
aW5pdCA9IDE7CisKKwl3YWl0X2Zvcl9yZWFkaW5lc3MocG9ydCk7CisKKyAgICAgICAgLyoKKyAg
ICAgICAgICogRGlzYWJsZSBpbnRlcnJ1cHRzLgorICAgICAgICAgKi8KKyAgICAgICAgb3V0Yigw
eDAsIE1LX1BPUlQocG9ydCArIDEpKTsKKworICAgICAgICAvKgorICAgICAgICAgKiBTZXQgdGhl
IGJhdWQgcmF0ZSBkaXZpc29yJ3MgTFNCLgorICAgICAgICAgKi8KKyAgICAgICAgb3V0YihCQVVE
X01TQiwgTUtfUE9SVChwb3J0ICsgMykpOworCisgICAgICAgIC8qCisgICAgICAgICAqIFNldCB0
aGUgYmF1ZCByYXRlIGRpdmlzb3IncyBNU0IuCisgICAgICAgICAqLworICAgICAgICBvdXRiKEJB
VURfTFNCLCBNS19QT1JUKHBvcnQpKTsKKworICAgICAgICAvKgorICAgICAgICAgKiBTZXQgbm8g
cGFyaXR5LCA4IGJpdHMsIDEgc3RvcCBiaXQsIGFuZCBzZWxlY3QKKyAgICAgICAgICogaW50ZXJy
dXB0IGVuYWJsZSByZWdpc3Rlci4KKyAgICAgICAgICovCisgICAgICAgIG91dGIoMHgzLCBNS19Q
T1JUKHBvcnQgKyAzKSk7Cit9CisKKworc3RhdGljIHZvaWQgd3JpdGVfc2VyaWFsX2lvX3BvcnQo
dW5zaWduZWQgcG9ydCwKKwkJCQkJY29uc3QgY2hhciAqcywKKwkJCQkJdW5zaWduZWQgbikKK3sK
Kwl1bnNpZ25lZCBrOworCQorCWlmIChzZXJpYWxfaW5pdD09MCkKKwl7CisJCWluaXRfc2VyaWFs
X2lvX3BvcnQocG9ydCk7CisJfQorCisJLyoKKwkgKiBTZXQgZGF0YSB0ZXJtaW5hbCByZWFkeSBh
bmQgcmVxdWVzdCB0byBzZW5kLgorCSAqLworCisJZm9yKGsgPSAwOyBrIDwgbjsgKytrKSB7CisJ
CXdhaXRfZm9yX3JlYWRpbmVzcyhwb3J0KTsKKwkJb3V0YihzW2tdLCBNS19QT1JUKHBvcnQpKTsK
KwkJaWYoc1trXSA9PSAnXG4nKSB7CisJCQl3YWl0X2Zvcl9yZWFkaW5lc3MocG9ydCk7CisJCQlv
dXRiKCdccicsIE1LX1BPUlQocG9ydCkpOworCQl9CisJfQorfQorCisKKworLyoKKyAqIE9uIElu
dGVsLWRlcml2ZWQgYXJjaGl0ZWN0dXJlcyBpdCBpcyBjdXN0b21hcnkgZm9yIG9uYm9hcmQgc2Vy
aWFsCisgKiBwb3J0cyB0byBoYXZlIEkvTyBwb3J0cyBhdCB0aGVzZSB0d28gcG9ydCBhZGRyZXNz
ZXMuCisgKi8KKworc3RhdGljIHZvaWQgd3JpdGVfc2VyaWFsKHN0cnVjdCBjb25zb2xlICpjLCBj
b25zdCBjaGFyICpzLCB1bnNpZ25lZCBuKQoreworCXdyaXRlX3NlcmlhbF9pb19wb3J0KENPTkZJ
R19FQVJMWV9DT05TT0xFX1NFUklBTF9QT1JULCBzLCBuKTsKK30KKworc3RhdGljIHN0cnVjdCBj
b25zb2xlIGVhcmx5X2NvbnNvbGVfc2VyaWFsID0KK3sKKwl3cml0ZTogd3JpdGVfc2VyaWFsCit9
OworI2VuZGlmCisKKworI2lmZGVmIENPTkZJR19FQVJMWV9DT05TT0xFX1ZHQQorCisvKgorICog
VGhpcyBzaG91bGQgd29yayBmb3IgYSB2YXJpZXR5IG9mIEludGVsLWRlcml2ZWQgYXJjaGl0ZWN0
dXJlcywKKyAqIGFzIGl0IGlzIGN1c3RvbWFyeSBmb3IgVkdBIG1lbW9yeSB0byByZXNpZGUgaW4g
dGhpcyBhZGRyZXNzIHJhbmdlLgorICogdmdhX3B1dGMoKSBpcyBkZXJpdmVkIGZyb20gdnN0YSBz
b3VyY2VzLCAoQykgQW5kcmV3IFZhbGVuY2lhLgorICoKKyAqIFNldmVyYWwgZm9ybXMgb2YgZnVu
Y3Rpb25hbGl0eSBhcmUgaW50ZW50aW9uYWxseSBvbWl0dGVkIGluIHRoZQorICogaW50ZXJlc3Qg
b2Ygcm9idXN0bmVzcywgaW4gcGFydGljdWxhciwgY3Vyc29yIG1vdmVtZW50IGFuZCBjdXJzb3IK
KyAqIHBvc2l0aW9uIGRldGVybWluYXRpb24uCisgKi8KKworI2RlZmluZSBWR0FfTUFYQ09MIDgw
CisjZGVmaW5lIFZHQV9NQVhST1cgMjUKKyNkZWZpbmUgVkdBX1NDUk5TWiAoVkdBX01BWENPTCAq
IFZHQV9NQVhST1cpCisjZGVmaW5lIFZHQV9SRUdfUE9SVCAweDNENAorI2RlZmluZSBWR0FfVkFM
X1BPUlQgMHgzRDUKKyNkZWZpbmUgVkdBX1RFWFRfQlVGRkVSIDB4QjgwMDAKKworI2RlZmluZSBW
R0FfQ0hBUihfcm93XywgX2NvbF8pIHZnYV9tZW1bKF9yb3dfKSpWR0FfTUFYQ09MICsgKF9jb2xf
KV0uYworCitzdHJ1Y3QgdmdhX2NoYXJfZGVzYworeworCXVuc2lnbmVkIGNoYXIgYzsKKwl1bnNp
Z25lZCBjaGFyIGNvbG9yOworfTsKKworc3RhdGljIHN0cnVjdCB2Z2FfY2hhcl9kZXNjICogdmdh
X21lbSA9IAorCShzdHJ1Y3QgdmdhX2NoYXJfZGVzYyAqKShWR0FfVEVYVF9CVUZGRVIgKyBQQUdF
X09GRlNFVCk7CisKKy8qCisgKiogVGhlIHNjcmVlbiBwb3NpdGlvbiBjYW4gYWN0dWFsbHkgYmUg
ZGV0ZXJtaW5lZCBieSBwb3J0IEkvTywKKyAqKiBidXQgaW4gdGhlIGludGVyZXN0IG9mIHJvYnVz
dG5lc3MsIHRoZXNlIGFyZSBhbHdheXMgaW5pdGlhbGl6ZWQKKyAqKiB0byB0aGUgKDAsIDApIHBv
c2l0aW9uLiBUaGVzZSBwb3NpdGlvbiBpbmRpY2VzIG11c3QgYWx3YXlzIGJlCisgKiogc3RyaWN0
bHkgbGVzcyB0aGFuIHRoZSBib3VuZHMgVkdBX01BWFJPVyBhbmQgVkdBX01BWENPTC4KKyAqKi8K
K3N0YXRpYyB1bnNpZ25lZCBzaG9ydCByb3c7CitzdGF0aWMgdW5zaWduZWQgc2hvcnQgY29sOwor
CQorCisvKmZyb20gbWFydGluIGJsaWdoJ3MgZWFybHlfcHJpbnRrICovCitzdGF0aWMgaW5saW5l
IHZvaWQgdXBkYXRlX2N1cnNvcih2b2lkKQoreworICAgICAgICBpbnQgcG9zID0gKGNvbCArIFZH
QV9NQVhDT0wqcm93KSAqMjsKKyAgIAorICAgICAgIAlvdXRiX3AoMTQsIFZHQV9SRUdfUE9SVCk7
CisgICAgICAgIG91dGJfcCgweGZmICYgKHBvcyA+PiA5KSwgVkdBX1ZBTF9QT1JUKTsKKyAgICAg
ICAgb3V0Yl9wKDE1LCBWR0FfUkVHX1BPUlQpOworICAgICAgICBvdXRiX3AoMHhmZiAmIChwb3Mg
Pj4gMSksIFZHQV9WQUxfUE9SVCk7Cit9CisKKwordm9pZCBjbGVhcl92Z2FfbWVtKHZvaWQpCit7
CisgICAgICAgIGludCB4LCB5OworCisgICAgICAgIGZvciAoeCA9IDA7IHggPCA4MDsgeCsrKSB7
CisgICAgICAgICAgICAgICAgZm9yICh5ID0gMDsgeSA8IDI1OyB5KyspIHsKKyAgICAgICAgICAg
ICAgICAgICAgICAgIFZHQV9DSEFSKHkseCkgPSAnICc7CisgICAgICAgICAgICAgICAgfQorICAg
ICAgICB9CisJcm93ID0wOworCWNvbCA9MDsKKwl1cGRhdGVfY3Vyc29yKCk7Cit9CisKKworCQor
CisvKgorICogVGhlIGNoYXJhY3RlcnMgZGlzcGxheWVkIGF0IGEgc2NyZWVuIHBvc2l0aW9uIGNh
biBiZSBkaXNjZXJuZWQgYnkKKyAqIHJlYWRpbmcgZnJvbSB0aGUgY29ycmVzcG9uZGluZyBtZW1v
cnkgbG9jYXRpb24uIFRoaXMgY2FuIGJlIHVzZWQKKyAqIHRvIHNpbXVsYXRlIHNjcm9sbGluZyBt
b3ZlbWVudC4gTGluZSBibGFua2luZyBpcyBzaW11bGF0ZWQgYnkKKyAqIG92ZXJ3cml0aW5nIHRo
ZSBkaXNwbGF5ZWQgY2hhcmFjdGVycyB3aXRoIHRoZSBzcGFjZSBjaGFyYWN0ZXIuCisgKgorICog
SW4gdGhlIGludGVyZXN0IG9mIHJvYnVzdG5lc3MsIGN1cnNvciBtb3ZlbWVudCBpcyBhbHNvIG9t
aXR0ZWQuCisgKi8KK3N0YXRpYyBpbmxpbmUgdm9pZCB2Z2Ffc2Nyb2xsX3VwKHZvaWQpCit7CisJ
dW5zaWduZWQgazsKKworCWZvcihrID0gMDsgayA8IChWR0FfU0NSTlNaIC0gVkdBX01BWENPTCk7
ICsraykKKwkJdmdhX21lbVtrXS5jID0gdmdhX21lbVtrICsgVkdBX01BWENPTF0uYzsKKworCWZv
cihrID0gVkdBX1NDUk5TWiAtIFZHQV9NQVhDT0w7IGsgPCBWR0FfU0NSTlNaOyArK2spCisJCXZn
YV9tZW1ba10uYyA9ICcgJzsKK30KKworCisvKgorICogTGluZSBhZHZhbmNlbWVudCBtdXN0IHBy
ZXNlcnZlIHRoZSBpbnZhcmlhbnQgdGhhdCB0aGUgcm93IGFuZAorICogY29sdW1uIGluZGljZXMg
YXJlIGluLWJvdW5kcy4gVGhlIHNlbWFudGljcyBvZiB0aGlzIG1lYW4gdGhhdAorICogd2hlbiBs
aW5lIGFkdmFuY2VtZW50ICJiZXlvbmQiIHRoZSBsYXN0IGxpbmUgcmVzdWx0cyBpbiBzY3JvbGxp
bmcuCisgKi8KK3N0YXRpYyBpbmxpbmUgdm9pZCB2Z2FfbGluZV9hZHZhbmNlKHZvaWQpCit7CisJ
Kytyb3c7CisKKwlpZihyb3cgPj0gVkdBX01BWFJPVykgeworCQlyb3cgPSBWR0FfTUFYUk9XIC0g
MTsKKwkJdmdhX3Njcm9sbF91cCgpOworCX0KK30KKworCisvKgorICogQ2hhcmFjdGVyIGFkdmFu
Y2VtZW50IG11c3Qgb25jZSBhZ2FpbiBwcmVzZXJ2ZSB0aGUgaW4tYm91bmRzCisgKiBpbnZhcmlh
bnRzLCBhbmQgaW4gc28gZG9pbmcgbGluZSB3cmFwcGluZyBhbmQgYWR2YW5jZW1lbnQgbWF5IG9j
Y3VyLgorICovCitzdGF0aWMgaW5saW5lIHZvaWQgdmdhX2NoYXJfYWR2YW5jZSh2b2lkKQorewor
CSsrY29sOworCisJaWYoY29sID49IFZHQV9NQVhDT0wpIHsKKwkJY29sID0gMDsKKwkJdmdhX2xp
bmVfYWR2YW5jZSgpOworCX0KK30KKworCisvKgorICogRGVyaXZlZCBmcm9tIHZzdGEgc291cmNl
cyAoQykgQW5kcmV3IFZhbGVuY2lhLgorICogSGVyZSB0aGUgaW50ZXJwcmV0YXRpb24gb2Ygc2V2
ZXJhbCBjb21tb24gc3BlY2lhbCBjaGFyYWN0ZXJzIG9jY3VycywKKyAqIG5hbWVseSBsaW5lZmVl
ZHMsIG5ld2xpbmVzLCB0YWJzLCBhbmQgYmFja3NwYWNlcy4gVGhlIHBvc2l0aW9uCisgKiBpbmRp
Y2VzIGFyZSB1cGRhdGVkIHVzaW5nIHRoZSB2Z2FfY2hhcl9hZHZhbmNlKCkgYW5kIHZnYV9saW5l
X2FkdmFuY2UoKQorICogcm91dGluZXMsIGFuZCBhIHZnYV9jaGFyX2FkdmFuY2UoKSBpcyB0cmln
Z2VyZWQgb24gdGhlIHByaW50aW5nIG9mCisgKiBlYWNoIG9yZGluYXJ5IGNoYXJhY3Rlci4gVGhl
IHNwZWNpYWwgY2hhcmFjdGVycyBoYXZlIHNwZWNpYWxpemVkCisgKiBwb3NpdGlvbiB1cGRhdGUg
c2VtYW50aWNzIGluIG9yZGVyIHRvIGJlIGZhaXRoZnVsIHRvIHRoZWlyIGN1c3RvbWFyeQorICog
Y3Vyc29yIG1vdmVtZW50IGVmZmVjdHMsIGFsdGhvdWdoIHRoZSBjdXJzb3IgcG9zaXRpb24gaXMg
bm90IHVwZGF0ZWQuCisgKi8KK3N0YXRpYyB2b2lkIHZnYV9wdXRjKGNoYXIgYykKK3sKKwl1bnNp
Z25lZCBrOworCXN3aXRjaChjKSB7CisJCWNhc2UgJ1x0JzoKKwkJCWZvcihrID0gMDsgayA8IDg7
ICsraykgeworCQkJCVZHQV9DSEFSKHJvdywgY29sKSA9ICcgJzsKKwkJCQl2Z2FfY2hhcl9hZHZh
bmNlKCk7CisJCQl9CisJCQlicmVhazsKKworCQljYXNlICdccic6CisJCQljb2wgPSAwOworCQkJ
YnJlYWs7CisKKwkJY2FzZSAnXG4nOgorCQkJY29sID0gMDsKKwkJCXZnYV9saW5lX2FkdmFuY2Uo
KTsKKwkJCWJyZWFrOworCisJCWNhc2UgJ1xiJzoKKwkJCWlmKGNvbCA+IDApIHsKKwkJCQktLWNv
bDsKKwkJCQlWR0FfQ0hBUihyb3csIGNvbCkgPSAnICc7CisJCQl9CisJCQlicmVhazsKKworCQlk
ZWZhdWx0OgorCQkJVkdBX0NIQVIocm93LCBjb2wpID0gYzsKKwkJCXZnYV9jaGFyX2FkdmFuY2Uo
KTsKKwkJCWJyZWFrOworCX0KK30KKworCisvKgorICogd3JpdGVfdmdhKCksIGdpdmVuIGEgTlVM
LXRlcm1pbmF0ZWQgY2hhcmFjdGVyIGFycmF5LCB3cml0ZXMKKyAqIGNoYXJhY3RlcnMgdG8gVkdB
IHNwYWNlIGluIGJ1bGssIGFuZCBpcyB0aGUgY2FsbGJhY2sgdXNlZCBmb3IgdGhlCisgKiBkcml2
ZXIgc3RydWN0dXJlLgorICovCitzdGF0aWMgdm9pZCB3cml0ZV92Z2Eoc3RydWN0IGNvbnNvbGUg
KmMsIGNvbnN0IGNoYXIgKnMsIHVuc2lnbmVkIG4pCit7CisJdW5zaWduZWQgazsKKworCWZvcihr
ID0gMDsgayA8IG47ICsraykKKwl7CQorCQl2Z2FfcHV0YyhzW2tdKTsKKwkJdXBkYXRlX2N1cnNv
cigpOworCX0KK30KKworc3RhdGljIHN0cnVjdCBjb25zb2xlIGVhcmx5X2NvbnNvbGVfdmdhID0K
K3sKKwl3cml0ZTogd3JpdGVfdmdhCit9OworCisjZW5kaWYgLypFTkQgQ09ORklHX0VBUkxZX0NP
TlNPTEVfVkdBKi8gCisKKworCisvKgorICogVGhlIGJvY2hzIHg4NiBzaW11bGF0b3IgaGFzIGFu
IG9wdGlvbmFsIGZlYXR1cmUgZm9yIGVuYWJsaW5nCisgKiBkZWJ1Z2dpbmcgb3V0cHV0IHRocm91
Z2ggYSBub3JtYWxseSB1bnVzZWQgSVNBIEkvTyBwb3J0LiBUaGUKKyAqIHByb3RvY29sIGZvciBj
b21tdW5pY2F0aW5nIHdpdGggdGhlIHNpbXVsYXRlZCBkZXZpY2UgaXMgc2ltcGx5CisgKiB1c2lu
ZyBwb3J0IEkvTyB3cml0ZXMgdG8gd3JpdGUgYSBzdHJlYW0gb2YgY2hhcmFjdGVycyB0byB0aGUK
KyAqIGRldmljZSwgYW5kIHRoZXNlIGFyZSB0aGVuIHJlbGF5ZWQgYnkgdGhlIHNpbXVsYXRvciB0
byB0aGUKKyAqIGNvbnRyb2xsaW5nIHRlcm1pbmFsIG9mIHRoZSBzaW11bGF0b3IgcHJvY2Vzcy4K
KyAqLworI2lmZGVmIENPTkZJR19FQVJMWV9DT05TT0xFX0JPQ0hTX0U5X0hBQ0sKK3N0YXRpYyB2
b2lkIHdyaXRlX2JvY2hzKHN0cnVjdCBjb25zb2xlICpjLCBjb25zdCBjaGFyICpzLCB1bnNpZ25l
ZCBuKQoreworCXVuc2lnbmVkIGs7CisKKwlmb3IoayA9IDA7IGsgPCBuOyArK2spCisJCW91dGIo
c1trXSwgTUtfUE9SVCgweEU5KSk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgY29uc29sZSBlYXJseV9j
b25zb2xlX2JvY2hzID0KK3sKKwl3cml0ZTogd3JpdGVfYm9jaHMKK307CisjZW5kaWYgLyogQ09O
RklHX0VBUkxZX0NPTlNPTEVfQk9DSFNfRTlfSEFDSyAqLworCisKKy8qCisgKiBJbiBvcmRlciB0
byBtaW5pbWl6ZSB0aGUgbnVtYmVyIG9mICNpZmRlZnMgd2hjaCBtdXN0CisgKiBhcHBlYXIgaW4t
bGluZSwgdGhpcyBkaXJlY3QtbWFwcGVkLCBOVUxMLXRlcm1pbmF0ZWQgdGFibGUKKyAqIG9mIGNv
bnNvbGUgZW50cmllcyBpcyB1c2VkIHRvIHByb3ZpZGUgYSBjb25maWd1cmF0aW9uLWluZGVwZW5k
ZW50CisgKiBzdHJ1Y3R1cmUgd2hpY2ggbWF5IGJlIHRyYXZlcnNlZCB0byBkaXNjb3ZlciBhbGwg
b2YgdGhlIGF2YWlsYWJsZQorICogZWFybHkgY29uc29sZSBkZXZpY2VzIGZvciByZWdpc3RyYXRp
b24gYW5kIHVucmVnaXN0cmF0aW9uLgorICoKKyAqIFRoaXMgaXMgdGhlIHVnbGllc3QgcGFydCBv
ZiB0aGUgY29kZSwgdGhhbmtzIHRvICNpZmRlZgorICovCitzdGF0aWMgc3RydWN0IGNvbnNvbGUg
KiBlYXJseV9jb25zb2xlX3RhYmxlW10gPQorCXsKKyNpZmRlZiBDT05GSUdfRUFSTFlfQ09OU09M
RV9TRVJJQUwKKwkJJmVhcmx5X2NvbnNvbGVfc2VyaWFsLAorI2VuZGlmCisjaWZkZWYgQ09ORklH
X0VBUkxZX0NPTlNPTEVfVkdBCisJCSZlYXJseV9jb25zb2xlX3ZnYSwKKyNlbmRpZiAKKyNpZmRl
ZiBDT05GSUdfRUFSTFlfQ09OU09MRV9CT0NIU19FOV9IQUNLCisJCSZlYXJseV9jb25zb2xlX2Jv
Y2hzLAorI2VuZGlmCisJCU5VTEwKKwl9OworCisKKy8qCisgKiBUaGUgYWJvdmUgaW1wbGVtZW50
YXRpb25zIGFyZSBxdWl0ZSBmYXIgZnJvbSBjb21wbGV0ZSBjb25zb2xlCisgKiBkZXZpY2VzLCBi
dXQgcHJpbnRrKCkgb25seSByZXF1aXJlcyB0aGUgLT53cml0ZSBjYWxsYmFjaywgc28gdGhpcyBp
cworICogc29tZXdoYXQgZGVjZXB0aXZlLCBidXQgc3RpbGwgY2xlYW5lciB0aGFuIGVkaXRpbmcg
cHJpbnRrLmMgaXRzZWxmLgorICovCit2b2lkIGFkZF9lYXJseV9jb25zb2xlcyh2b2lkKQorewor
CQorCXN0cnVjdCBjb25zb2xlICoqYyA9IGVhcmx5X2NvbnNvbGVfdGFibGU7CisJd2hpbGUoKmMp
CisJeworCQlyZWdpc3Rlcl9lYXJseV9jb25zb2xlKCpjKyspOworCQlwcmludGsgKCJjb25zb2xl
ZCBhZGRlZCFcblxuIik7CisJfQorI2lmZGVmIENPTkZJR19FQVJMWV9DT05TT0xFX1ZHQQorCWNs
ZWFyX3ZnYV9tZW0oKTsKKyNlbmRpZiAKKworfQorCmRpZmYgLXVyTiBsaW51eC0yLjUuMjUvYXJj
aC9pMzg2L2tlcm5lbC9zZXR1cC5jIGxpbnV4LTIuNS4yNS1lYXJseS9hcmNoL2kzODYva2VybmVs
L3NldHVwLmMKLS0tIGxpbnV4LTIuNS4yNS9hcmNoL2kzODYva2VybmVsL3NldHVwLmMJMjAwMi0w
Ny0wNSAxNjo0MjoyMy4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNS4yNS1lYXJseS9hcmNo
L2kzODYva2VybmVsL3NldHVwLmMJMjAwMi0wNy0xNiAxMzoxMToyMS4wMDAwMDAwMDAgLTA3MDAK
QEAgLTU5OCw3ICs1OTgsOSBAQAogCWludCBpOwogCiAJZWFybHlfY3B1X2luaXQoKTsKLQorCQor
CWFkZF9lYXJseV9jb25zb2xlcygpOworCQogI2lmZGVmIENPTkZJR19WSVNXUwogCXZpc3dzX2dl
dF9ib2FyZF90eXBlX2FuZF9yZXYoKTsKICNlbmRpZgpkaWZmIC11ck4gbGludXgtMi41LjI1L2lu
Y2x1ZGUvbGludXgvY29uc29sZS5oIGxpbnV4LTIuNS4yNS1lYXJseS9pbmNsdWRlL2xpbnV4L2Nv
bnNvbGUuaAotLS0gbGludXgtMi41LjI1L2luY2x1ZGUvbGludXgvY29uc29sZS5oCTIwMDItMDct
MDUgMTY6NDI6MjIuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjUuMjUtZWFybHkvaW5jbHVk
ZS9saW51eC9jb25zb2xlLmgJMjAwMi0wNy0xNiAxMzoxMToyMS4wMDAwMDAwMDAgLTA3MDAKQEAg
LTkwLDcgKzkwLDcgQEAKICNkZWZpbmUgQ09OX1BSSU5UQlVGRkVSCSgxKQogI2RlZmluZSBDT05f
Q09OU0RFVgkoMikgLyogTGFzdCBvbiB0aGUgY29tbWFuZCBsaW5lICovCiAjZGVmaW5lIENPTl9F
TkFCTEVECSg0KQotCisjZGVmaW5lIEVBUkxZX0NPTlNPTEUgICAoOCkgLyogRWFybHkgZmxhZy4g
UmVtb3ZlIGluIGNvbl9pbml0ICAqLwogc3RydWN0IGNvbnNvbGUKIHsKIAljaGFyCW5hbWVbOF07
CkBAIC0xMDUsNiArMTA1LDcgQEAKIAlzdHJ1Y3QJIGNvbnNvbGUgKm5leHQ7CiB9OwogCisKIGV4
dGVybiB2b2lkIHJlZ2lzdGVyX2NvbnNvbGUoc3RydWN0IGNvbnNvbGUgKik7CiBleHRlcm4gaW50
IHVucmVnaXN0ZXJfY29uc29sZShzdHJ1Y3QgY29uc29sZSAqKTsKIGV4dGVybiBzdHJ1Y3QgY29u
c29sZSAqY29uc29sZV9kcml2ZXJzOwpAQCAtMTEyLDYgKzExMyw5IEBACiBleHRlcm4gdm9pZCBy
ZWxlYXNlX2NvbnNvbGVfc2VtKHZvaWQpOwogZXh0ZXJuIHZvaWQgY29uc29sZV9jb25kaXRpb25h
bF9zY2hlZHVsZSh2b2lkKTsKIGV4dGVybiB2b2lkIGNvbnNvbGVfdW5ibGFuayh2b2lkKTsKK2V4
dGVybiBpbnQgY2xlYXJfZWFybHlfY29uc29sZXModm9pZCk7CitleHRlcm4gdm9pZCByZWdpc3Rl
cl9lYXJseV9jb25zb2xlKHN0cnVjdCBjb25zb2xlICopOworCiAKIC8qIFZFU0EgQmxhbmtpbmcg
TGV2ZWxzICovCiAjZGVmaW5lIFZFU0FfTk9fQkxBTktJTkcgICAgICAgIDAKZGlmZiAtdXJOIGxp
bnV4LTIuNS4yNS9rZXJuZWwvcHJpbnRrLmMgbGludXgtMi41LjI1LWVhcmx5L2tlcm5lbC9wcmlu
dGsuYwotLS0gbGludXgtMi41LjI1L2tlcm5lbC9wcmludGsuYwkyMDAyLTA3LTA1IDE2OjQyOjIz
LjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi41LjI1LWVhcmx5L2tlcm5lbC9wcmludGsuYwky
MDAyLTA3LTE2IDEzOjExOjIxLjAwMDAwMDAwMCAtMDcwMApAQCAtNTc5LDYgKzU3OSwxMCBAQAog
CWludCAgICAgaTsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCisjaWZuZGVmICBOT19DT05GSUdf
RUFSTFlfQ09OU09MRQorCWNsZWFyX2Vhcmx5X2NvbnNvbGVzKCk7CisjZW5kaWYKKwogCS8qCiAJ
ICoJU2VlIGlmIHdlIHdhbnQgdG8gdXNlIHRoaXMgY29uc29sZSBkcml2ZXIuIElmIHdlCiAJICoJ
ZGlkbid0IHNlbGVjdCBhIGNvbnNvbGUgd2UgdGFrZSB0aGUgZmlyc3Qgb25lCkBAIC02NzYsNiAr
NjgwLDUwIEBACiB9CiBFWFBPUlRfU1lNQk9MKHVucmVnaXN0ZXJfY29uc29sZSk7CiAJCisvKiBU
aGlzIHdpbGwgY2xlYXIgYW55IGFuZCBhbGwgY29uc29sZV9kcml2ZXJzIHRoYXQgCisgICB1c2Ug
b25seSBpbiBjb25faW5pdCB0byByZW1vdmUgYW55IGNvbnNvbGVzIHRoYXQgc2V0dXBfYXJjaAor
ICAgbWF5IGhhdmUgYWRkZWQgZm9yIGVhcmx5IGNvbnNvbGUgc3VwcG9ydCAgCisgKi8KK2ludCBj
bGVhcl9lYXJseV9jb25zb2xlcyh2b2lkKQoreworICAgICAgICBzdHJ1Y3QgY29uc29sZSAqYSwg
KmI7CisgICAgICAgIGludCByZW1vdmVkID0gMDsKKwkKKwlpZihjb25zb2xlX2RyaXZlcnMpCisJ
eworCWFjcXVpcmVfY29uc29sZV9zZW0oKTsKKwkKKwkKKwlmb3IgKGE9Y29uc29sZV9kcml2ZXJz
LT5uZXh0LCBiPWNvbnNvbGVfZHJpdmVyczsgYTsgYj1hLGE9Yi0+bmV4dCkKKwl7CisJCWlmIChh
LT5mbGFncyAmIEVBUkxZX0NPTlNPTEUpCisgICAgICAgICAgICAgICAgeworCQkgICAgICAgIGIt
Pm5leHQgPSBhLT5uZXh0OyAgICAgICAgCQorCQkgICAgICAgIHJlbW92ZWQrKzsKKwkJfQorCX0K
KworCWlmIChjb25zb2xlX2RyaXZlcnMtPmZsYWdzICYgRUFSTFlfQ09OU09MRSkKKwl7CisJCWNv
bnNvbGVfZHJpdmVycz1jb25zb2xlX2RyaXZlcnMtPm5leHQ7CisJCXJlbW92ZWQrKzsKKwkKKwl9
CisKKwlpZiAoY29uc29sZV9kcml2ZXJzID09IE5VTEwpCisJCXByZWZlcnJlZF9jb25zb2xlID0g
LTE7CisKKwlyZWxlYXNlX2NvbnNvbGVfc2VtKCk7CisJfQorCXJldHVybiByZW1vdmVkOworfQor
Cit2b2lkIHJlZ2lzdGVyX2Vhcmx5X2NvbnNvbGUoc3RydWN0IGNvbnNvbGUgKmVhcmx5X2NvbikK
K3sKKyAgICAgICAgZWFybHlfY29uLT5mbGFncyB8PSBFQVJMWV9DT05TT0xFOworCXJlZ2lzdGVy
X2NvbnNvbGUoZWFybHlfY29uKTsKK30KKwogLyoqCiAgKiB0dHlfd3JpdGVfbWVzc2FnZSAtIHdy
aXRlIGEgbWVzc2FnZSB0byBhIGNlcnRhaW4gdHR5LCBub3QganVzdCB0aGUgY29uc29sZS4KICAq
Cgo=

--==========1752872036==========--

