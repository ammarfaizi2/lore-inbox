Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSECAAf>; Thu, 2 May 2002 20:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSECAAe>; Thu, 2 May 2002 20:00:34 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:36302 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315479AbSEBX7s>; Thu, 2 May 2002 19:59:48 -0400
Date: Thu, 02 May 2002 17:58:01 -0700
From: Keith Mannthey <kmannth@us.ibm.com>
Reply-To: Keith Mannthey <kmannth@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Early printk/console for 2.5.12
Message-ID: <184120000.1020387481@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
  The following patch provides the ability to add early
consoles (to use with printk calls before console_init)
and then have them automatically removed right before
the real consoles are added.  This is useful if a kernel
doesn't boot past console init.

   Included in the patch are 3 drivers for i386. Primarily 
there is a VGA driver and a serial console driver that both 
work well with i386. This has been tested on a desktop
PC, an SMP machine, and a 16 processor NUMA-Q.

  An earlier variation was submitted by Bill Irwin in
November.  This is a cleaned up version a few more
features.

  I would like this to be added to the kernel to make
early debugging (before console_init) easier and a
provide a standard early console.

  Thanks for your time,
        Keith Mannthey

PS. The patch was generated against 2.5.11, but applies
cleanly against 2.5.12


diff -urN linux-2.5.11/arch/i386/Config.help linux-2.5.11.early/arch/i386/Config.help
--- linux-2.5.11/arch/i386/Config.help	Sun Apr 28 20:11:34 2002
+++ linux-2.5.11.early/arch/i386/Config.help	Tue Apr 30 13:41:41 2002
@@ -940,3 +940,23 @@
 CONFIG_DEBUG_OBSOLETE
   Say Y here if you want to reduce the chances of the tree compiling,
   and are prepared to dig into driver internals to fix compile errors.
+
+Early printk support
+NO_CONFIG_EARLY_CONSOLE
+  If you are not doing early kernel devolopment NONE is what you want.
+  The other will add a early console for you (in i386)
+  This will allow you see printk output before console_init is called.
+  This is handy if you need to debug the kernel before this point.
+ 
+ VGA will give you a VGA console, your screen.
+ SERIAL will give you out put on your serial line.
+
+Location of serial port
+CONFIG_EARLY_CONSOLE_SERIAL_PORT
+  0x3F8 == COMM 1
+  0x3E8 == COMM 2
+
+Baud rate
+CONFIG_EARLY_CONSOLE_SERIAL_BAUD
+  Set the the Baud of your serial console.
+
diff -urN linux-2.5.11/arch/i386/config.in linux-2.5.11.early/arch/i386/config.in
--- linux-2.5.11/arch/i386/config.in	Sun Apr 28 20:12:15 2002
+++ linux-2.5.11.early/arch/i386/config.in	Tue Apr 30 13:38:10 2002
@@ -408,6 +408,16 @@
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
+   choice 'Early printk support'  \
+               "NONE               NO_CONFIG_EARLY_CONSOLE \
+                VGA                CONFIG_EARLY_CONSOLE_VGA \
+                Serial_PORT       CONFIG_EARLY_CONSOLE_SERIAL\
+                Bochs_0xE9_hack    CONFIG_EARLY_CONSOLE_BOCHS_E9_HACK " NONE
+   if [ "$CONFIG_EARLY_CONSOLE_SERIAL" = "y" ]; then
+      hex "Location of serial port " CONFIG_EARLY_CONSOLE_SERIAL_PORT 0x3F8
+      int "Baud rate " CONFIG_EARLY_CONSOLE_SERIAL_BAUD  38400
+   fi
+
 fi
 
 endmenu
diff -urN linux-2.5.11/arch/i386/kernel/Makefile linux-2.5.11.early/arch/i386/kernel/Makefile
--- linux-2.5.11/arch/i386/kernel/Makefile	Sun Apr 28 20:11:44 2002
+++ linux-2.5.11.early/arch/i386/kernel/Makefile	Tue Apr 30 13:45:10 2002
@@ -19,7 +19,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
-		bootflag.o
+		bootflag.o early_consoles.o
 
 
 ifdef CONFIG_PCI
diff -urN linux-2.5.11/arch/i386/kernel/early_consoles.c linux-2.5.11.early/arch/i386/kernel/early_consoles.c
--- linux-2.5.11/arch/i386/kernel/early_consoles.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.11.early/arch/i386/kernel/early_consoles.c	Tue Apr 30 13:35:53 2002
@@ -0,0 +1,417 @@
+/*
+ * Early console drivers.
+ * (C) Nov 2001, William Irwin, IBM
+ *
+ * These are low-level pseudodrivers to enable early console output
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
+ * to be initialized, which does not happen until the middle of
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
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
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
+#define BAUD_MSB (CONFIG_EARLY_CONSOLE_SERIAL_BAUD/MAX_BAUD)/0xFF
+#define BAUD_LSB (CONFIG_EARLY_CONSOLE_SERIAL_BAUD/MAX_BAUD)%0xFF
+
+static inline __init void wait_for_readiness(unsigned port)
+{
+	unsigned retries;
+	unsigned char status;
+
+	/*
+	 * Wait for transmitter holding and shift registers to empty,
+	 * which is required for output to succeed. If the retries are
+	 * exceeded, this deliberately fails to ensure termination.
+	 */
+	for(retries = 0; retries < 65536; ++retries) {
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
+static void __init write_serial_io_port(unsigned port,
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
+static void __init write_serial(struct console *c, const char *s, unsigned n)
+{
+	write_serial_io_port(CONFIG_EARLY_CONSOLE_SERIAL_PORT, s, n);
+}
+
+static struct console __initdata early_console_serial =
+{
+	write: write_serial
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
+	unsigned char color;
+};
+
+static struct vga_char_desc * __initdata vga_mem = 
+	(struct vga_char_desc *)(VGA_TEXT_BUFFER + PAGE_OFFSET);
+
+/*
+ ** The screen position can actually be determined by port I/O,
+ ** but in the interest of robustness, these are always initialized
+ ** to the (0, 0) position. These position indices must always be
+ ** strictly less than the bounds VGA_MAXROW and VGA_MAXCOL.
+ **/
+static unsigned short __initdata row;
+static unsigned short __initdata col;
+	
+
+/*from martin bligh's early_printk */
+static inline void __init update_cursor(void)
+{
+        int pos = (col + VGA_MAXCOL*row) *2;
+   
+       	outb_p(14, VGA_REG_PORT);
+        outb_p(0xff & (pos >> 9), VGA_VAL_PORT);
+        outb_p(15, VGA_REG_PORT);
+        outb_p(0xff & (pos >> 1), VGA_VAL_PORT);
+}
+
+
+void __init clear_vga_mem(void)
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
+static inline void __init vga_scroll_up(void)
+{
+	unsigned k;
+
+	for(k = 0; k < (VGA_SCRNSZ - VGA_MAXCOL); ++k)
+		vga_mem[k].c = vga_mem[k + VGA_MAXCOL].c;
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
+static inline void __init vga_line_advance(void)
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
+static inline void __init vga_char_advance(void)
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
+ * Derived from vsta sources (C) Andrew Valencia.
+ * Here the interpretation of several common special characters occurs,
+ * namely linefeeds, newlines, tabs, and backspaces. The position
+ * indices are updated using the vga_char_advance() and vga_line_advance()
+ * routines, and a vga_char_advance() is triggered on the printing of
+ * each ordinary character. The special characters have specialized
+ * position update semantics in order to be faithful to their customary
+ * cursor movement effects, although the cursor position is not updated.
+ */
+static void __init vga_putc(char c)
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
+			break;
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
+static void __init write_vga(struct console *c, const char *s, unsigned n)
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
+static struct console __initdata early_console_vga =
+{
+	write: write_vga
+};
+
+#endif /*END CONFIG_EARLY_CONSOLE_VGA*/ 
+
+
+
+/*
+ * The bochs x86 simulator has an optional feature for enabling
+ * debugging output through a normally unused ISA I/O port. The
+ * protocol for communicating with the simulated device is simply
+ * using port I/O writes to write a stream of characters to the
+ * device, and these are then relayed by the simulator to the
+ * controlling terminal of the simulator process.
+ */
+#ifdef CONFIG_EARLY_CONSOLE_BOCHS_E9_HACK
+static void __init write_bochs(struct console *c, const char *s, unsigned n)
+{
+	unsigned k;
+
+	for(k = 0; k < n; ++k)
+		outb(s[k], MK_PORT(0xE9));
+}
+
+static struct console __initdata early_console_bochs =
+{
+	write: write_bochs
+};
+#endif /* CONFIG_EARLY_CONSOLE_BOCHS_E9_HACK */
+
+
+/*
+ * In order to minimize the number of #ifdefs whch must
+ * appear in-line, this direct-mapped, NULL-terminated table
+ * of console entries is used to provide a configuration-independent
+ * structure which may be traversed to discover all of the available
+ * early console devices for registration and unregistration.
+ *
+ * This is the ugliest part of the code, thanks to #ifdef
+ */
+static struct console * __initdata early_console_table[] =
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
+ * somewhat deceptive, but still cleaner than editing printk.c itself.
+ */
+void __init add_early_consoles(void)
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
diff -urN linux-2.5.11/arch/i386/kernel/setup.c linux-2.5.11.early/arch/i386/kernel/setup.c
--- linux-2.5.11/arch/i386/kernel/setup.c	Sun Apr 28 20:12:46 2002
+++ linux-2.5.11.early/arch/i386/kernel/setup.c	Tue Apr 30 13:35:53 2002
@@ -672,7 +672,9 @@
 	unsigned long bootmap_size, low_mem_size;
 	unsigned long start_pfn, max_low_pfn;
 	int i;
-
+	
+	add_early_consoles();
+	
 #ifdef CONFIG_VISWS
 	visws_get_board_type_and_rev();
 #endif
diff -urN linux-2.5.11/drivers/char/console.c linux-2.5.11.early/drivers/char/console.c
--- linux-2.5.11/drivers/char/console.c	Sun Apr 28 20:12:11 2002
+++ linux-2.5.11.early/drivers/char/console.c	Tue Apr 30 13:35:53 2002
@@ -2437,7 +2437,8 @@
 {
 	const char *display_desc = NULL;
 	unsigned int currcons = 0;
-
+	int removed =0;
+	
 	if (conswitchp)
 		display_desc = conswitchp->con_startup();
 	if (!display_desc) {
@@ -2513,10 +2514,14 @@
 		display_desc, video_num_columns, video_num_lines);
 	printable = 1;
 	printk("\n");
-
+	
+	/*clear any early consoles*/
+	removed = clear_early_consoles();
+	
 #ifdef CONFIG_VT_CONSOLE
 	register_console(&vt_console_driver);
 #endif
+	printk ("removed %d early consoles \n",removed);
 }
 
 #ifndef VT_SINGLE_DRIVER
diff -urN linux-2.5.11/include/linux/console.h linux-2.5.11.early/include/linux/console.h
--- linux-2.5.11/include/linux/console.h	Sun Apr 28 20:12:35 2002
+++ linux-2.5.11.early/include/linux/console.h	Tue Apr 30 13:54:23 2002
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
 extern void console_unblank(void);
+extern int clear_early_consoles(void);
+extern void register_early_console(struct console *);
+
 
 /* VESA Blanking Levels */
 #define VESA_NO_BLANKING        0
diff -urN linux-2.5.11/kernel/printk.c linux-2.5.11.early/kernel/printk.c
--- linux-2.5.11/kernel/printk.c	Sun Apr 28 20:12:49 2002
+++ linux-2.5.11.early/kernel/printk.c	Tue Apr 30 13:35:53 2002
@@ -669,6 +669,50 @@
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
+        early_con->flags |= EARLY_CONSOLE;
+	register_console(early_con);
+}
+
 /**
  * tty_write_message - write a message to a certain tty, not just the console.
  *

