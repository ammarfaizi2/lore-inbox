Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSKNTgt>; Thu, 14 Nov 2002 14:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSKNTgt>; Thu, 14 Nov 2002 14:36:49 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55544 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263362AbSKNTgo>;
	Thu, 14 Nov 2002 14:36:44 -0500
Message-ID: <3DD3FCB3.40506@us.ibm.com>
Date: Thu, 14 Nov 2002 11:42:43 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@suse.de>
Subject: [PATCH] early printk for x86
Content-Type: multipart/mixed;
 boundary="------------090302000909010909060003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090302000909010909060003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I copied the x86_64 early printk support for plain x86.  Is anyone 
opposed to me sending this on to Linus?

-- 
Dave Hansen
haveblue@us.ibm.com

--------------090302000909010909060003
Content-Type: text/plain;
 name="early_printk-i386-2.5.47.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="early_printk-i386-2.5.47.patch"

diff -urN linux-2.5.47-clean/arch/i386/Kconfig linux-2.5.47/arch/i386/Kconfig
--- linux-2.5.47-clean/arch/i386/Kconfig	Sun Nov 10 19:28:05 2002
+++ linux-2.5.47/arch/i386/Kconfig	Tue Nov 12 15:19:24 2002
@@ -1574,6 +1574,26 @@
 	  that can still be used by old drivers that are being ported from
 	  2.0/2.2.
 
+config EARLY_PRINTK
+	bool "Early console support"
+	default n
+	depends on DEBUG_KERNEL
+	help
+	  Write kernel log output directly into the VGA buffer or serial port. 
+	  This is useful for kernel debugging when your machine crashes very 
+	  early before the console code is initialized. For normal operation 
+	  it is not recommended because it looks ugly and doesn't cooperate 
+	  with klogd/syslogd or the X server.You should normally N here, 
+	  unless you want to debug such a crash.
+
+	  Syntax: earlyprintk=vga
+		  earlyprintk=serial[,ttySn[,baudrate]] 
+	  Append ,keep to not disable it when the real console takes over.
+	  Only vga or serial at a time, not both.
+	  Currently only ttyS0 and ttyS1 are supported. 
+	  Interaction with the standard serial driver is not very good. 
+	  The VGA output is eventually overwritten by the real console.
+
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on DEBUG_KERNEL
diff -urN linux-2.5.47-clean/arch/i386/kernel/Makefile linux-2.5.47/arch/i386/kernel/Makefile
--- linux-2.5.47-clean/arch/i386/kernel/Makefile	Sun Nov 10 19:28:05 2002
+++ linux-2.5.47/arch/i386/kernel/Makefile	Tue Nov 12 14:57:05 2002
@@ -28,6 +28,7 @@
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_EDD)             	+= edd.o
+obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -urN linux-2.5.47-clean/arch/i386/kernel/early_printk.c linux-2.5.47/arch/i386/kernel/early_printk.c
--- linux-2.5.47-clean/arch/i386/kernel/early_printk.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.47/arch/i386/kernel/early_printk.c	Thu Nov 14 11:29:26 2002
@@ -0,0 +1,220 @@
+#include <linux/console.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <asm/io.h>
+
+/* Simple VGA output */
+
+#define VGABASE	 0xB8000
+
+#define MAX_YPOS	25
+#define MAX_XPOS	80
+
+static int current_ypos = 1, current_xpos = 0; 
+
+static void early_vga_write(struct console *con, const char *str, unsigned n)
+{
+	char c;
+	int  i, k, j;
+
+	while ((c = *str++) != '\0' && n-- > 0) {
+		if (current_ypos >= MAX_YPOS) {
+			/* scroll 1 line up */
+			for(k = 1, j = 0; k < MAX_YPOS; k++, j++) {
+				for(i = 0; i < MAX_XPOS; i++) {
+					writew(readw(VGABASE + 2*(MAX_XPOS*k + i)),
+					       VGABASE + 2*(MAX_XPOS*j + i));
+				}
+			}
+			for(i = 0; i < MAX_XPOS; i++) {
+				writew(0x720, VGABASE + 2*(MAX_XPOS*j + i));
+			}
+			current_ypos = MAX_YPOS-1;
+		}
+		if (c == '\n') {
+			current_xpos = 0;
+			current_ypos++;
+		} else if (c != '\r')  {
+			writew(((0x7 << 8) | (unsigned short) c),
+			       VGABASE + 2*(MAX_XPOS*current_ypos + current_xpos++));
+			if (current_xpos >= MAX_XPOS) {
+				current_xpos = 0;
+				current_ypos++;
+			}
+		}
+	}
+}
+
+static struct console early_vga_console = {
+	.name =		"earlyvga",
+	.write =	early_vga_write,
+	.flags =	CON_PRINTBUFFER,
+	.index =	-1,
+};
+
+/* Serial functions losely based on a similar package from Klaus P. Gerlicher */ 
+
+int early_serial_base = 0x3f8;  /* ttyS0 */ 
+#define DEFAULT_BAUD	57600
+#define XMTRDY		0x20
+
+#define DLAB		0x80
+
+#define TXR		0	/*  Transmit register (WRITE) */
+#define RXR		0	/*  Receive register  (READ)  */
+#define IER		1	/*  Interrupt Enable	  	*/
+#define IIR		2	/*  Interrupt ID		*/
+#define FCR		2	/*  FIFO control		*/
+#define LCR		3	/*  Line control		*/
+#define MCR		4	/*  Modem control		*/
+#define LSR		5	/*  Line Status			*/
+#define MSR		6	/*  Modem Status		*/
+#define DLL		0	/*  Divisor Latch Low	 	*/
+#define DLH		1	/*  Divisor latch High		*/
+
+
+static int early_serial_putc(unsigned char ch) 
+{ 
+	unsigned timeout = 0xffff; 
+	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout) 
+		rep_nop(); 
+	outb(ch, early_serial_base + TXR);
+	return timeout ? 0 : -1;
+} 
+
+static void early_serial_write(struct console *con, const char *s, unsigned n)
+{
+	while (*s && n-- > 0) { 
+		early_serial_putc(*s); 
+		if (*s == '\n') 
+			early_serial_putc('\r'); 
+		s++; 
+	} 
+} 
+
+static __init void early_serial_init(char *opt)
+{
+	unsigned char c; 
+	unsigned divisor, baud = DEFAULT_BAUD;
+	char *s, *e;
+
+	if (*opt == ',') 
+		++opt;
+
+	s = strsep(&opt, ","); 
+	if (s != NULL) { 
+		unsigned port; 
+		if (!strncmp(s,"0x",2))
+			early_serial_base = simple_strtoul(s, &e, 16);
+		else {	
+			static int bases[] = { 0x3f8, 0x2f8 };
+		if (!strncmp(s,"ttyS",4)) 
+			s+=4; 
+		port = simple_strtoul(s, &e, 10); 
+		if (port > 1 || s == e) 
+			port = 0; 
+		early_serial_base = bases[port];
+		}
+	}
+
+	outb(0x3, early_serial_base + LCR); /* 8n1 */
+	outb(0, early_serial_base + IER); /* no interrupt */ 
+	outb(0, early_serial_base + FCR); /* no fifo */ 
+	outb(0x3, early_serial_base + MCR); /* DTR + RTS */ 
+
+	s = strsep(&opt, ","); 
+	if (s != NULL) { 
+		baud = simple_strtoul(s, &e, 0); 
+		if (baud == 0 || s == e) 
+			baud = DEFAULT_BAUD;
+	} 
+	
+	divisor = 115200 / baud; 
+	c = inb(early_serial_base + LCR); 
+	outb(c | DLAB, early_serial_base + LCR); 
+	outb(divisor & 0xff, early_serial_base + DLL); 
+	outb((divisor >> 8) & 0xff, early_serial_base +	DLH);
+	outb(c & ~DLAB, early_serial_base + LCR);
+}
+
+static struct console early_serial_console = {
+	.name =		"earlyser",
+	.write =	early_serial_write,
+	.flags =	CON_PRINTBUFFER,
+	.index =	-1,
+};
+
+/* Direct interface for emergencies */
+struct console *early_console = &early_vga_console;
+static int early_console_initialized = 0;
+
+void early_printk(const char *fmt, ...)
+{ 
+	char buf[512]; 
+	int n; 
+	va_list ap;
+	va_start(ap,fmt); 
+	n = vsnprintf(buf,512,fmt,ap);
+	early_console->write(early_console,buf,n);
+	va_end(ap); 
+} 
+
+static int keep_early; 
+
+int __init setup_early_printk(char *opt) 
+{  
+	char *space;
+	char buf[256]; 
+
+	if (early_console_initialized)
+		return -1;
+
+	strncpy(buf,opt,256); 
+	buf[255] = 0; 
+	space = strchr(buf, ' '); 
+	if (space)
+		*space = 0; 
+
+	if (strstr(buf,"keep"))
+		keep_early = 1; 
+
+	if (!strncmp(buf, "serial", 6)) { 
+		early_serial_init(buf + 6);
+		early_console = &early_serial_console;
+	} else if (!strncmp(buf, "ttyS", 4)) { 
+		early_serial_init(buf);
+		early_console = &early_serial_console;		
+	} else if (!strncmp(buf, "vga", 3)) {
+		early_console = &early_vga_console; 
+	} else {
+		early_console = NULL; 		
+		return -1; 
+	}
+	early_console_initialized = 1;
+	register_console(early_console);
+	early_printk( "early printk console registered\n" );
+	return 0;
+}
+
+void __init disable_early_printk(void)
+{ 
+	if (!early_console_initialized || !early_console)
+		return;
+	if (!keep_early) {
+		printk("disabling early console...\n"); 
+		unregister_console(early_console);
+		early_console_initialized = 0;
+	} else { 
+		printk("keeping early console.\n"); 
+	}
+} 
+
+/* syntax: earlyprintk=vga
+           earlyprintk=serial[,ttySn[,baudrate]] 
+   Append ,keep to not disable it when the real console takes over.
+   Only vga or serial at a time, not both.
+   Currently only ttyS0 and ttyS1 are supported. 
+   Interaction with the standard serial driver is not very good. 
+   The VGA output is eventually overwritten by the real console. */
+__setup("earlyprintk=", setup_early_printk);  
diff -urN linux-2.5.47-clean/arch/i386/kernel/setup.c linux-2.5.47/arch/i386/kernel/setup.c
--- linux-2.5.47-clean/arch/i386/kernel/setup.c	Sun Nov 10 19:28:13 2002
+++ linux-2.5.47/arch/i386/kernel/setup.c	Thu Nov 14 11:15:22 2002
@@ -84,6 +84,7 @@
 
 extern void early_cpu_init(void);
 extern void dmi_scan_machine(void);
+extern void setup_early_printk(char *);
 extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
 extern int blk_nohighio;
@@ -836,7 +837,12 @@
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long max_low_pfn;
+	char* s;
 
+	s = strstr(saved_command_line, "earlyprintk=");
+	if (s != NULL)
+		setup_early_printk(s+12);
+	
 	pre_setup_arch_hook();
 	early_cpu_init();
 

--------------090302000909010909060003--

