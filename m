Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbSKNWpD>; Thu, 14 Nov 2002 17:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSKNWpD>; Thu, 14 Nov 2002 17:45:03 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:65003 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261612AbSKNWoz>;
	Thu, 14 Nov 2002 17:44:55 -0500
Message-ID: <3DD428C3.4030700@us.ibm.com>
Date: Thu, 14 Nov 2002 14:50:43 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] early printk for x86
References: <3DD3FCB3.40506@us.ibm.com> <3DD40719.5030108@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------030909000502030508090907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030909000502030508090907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> VGA and serial are certainly not hammer+ia32-specific.  Make the generic 
> parts generic...   the arch-specific components would need to change 
> early-foo base addresses perhaps, but otherwise, it's pretty generic.

Take 2.

- Move the x86_64 early_printk.c into kernel/
- move some of the basic defines into linux/early_printk.h and
   asm-{i386,x86_64}/early_printk.h
- run the setup in start_kernel() before setup_arch()

arch/i386/Kconfig                 |   20 +++
arch/x86_64/kernel/early_printk.c |  218 -----------------------------
arch/x86_64/kernel/head64.c       |    5
include/asm-i386/early_printk.h   |    8 +
include/asm-x86_64/early_printk.h |    8 +
include/linux/early_printk.h      |   47 ++++++++
init/main.c                       |    1
kernel/Makefile                   |    1
kernel/early_printk.c             |  209 +++++++++++++++++++++++++++++
  9 files changed, 295 insertions(+), 222 deletions(-)

-- 
Dave Hansen
haveblue@us.ibm.com

--------------030909000502030508090907
Content-Type: text/plain;
 name="early_printk-i386-2.5.47-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="early_printk-i386-2.5.47-2.patch"

diff -urN linux-2.5.47-clean/arch/i386/Kconfig linux-2.5.47/arch/i386/Kconfig
--- linux-2.5.47-clean/arch/i386/Kconfig	Sun Nov 10 19:28:05 2002
+++ linux-2.5.47/arch/i386/Kconfig	Thu Nov 14 14:17:45 2002
@@ -1588,6 +1588,26 @@
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
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
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
 	depends on DEBUG_KERNEL
diff -urN linux-2.5.47-clean/arch/x86_64/kernel/early_printk.c linux-2.5.47/arch/x86_64/kernel/early_printk.c
--- linux-2.5.47-clean/arch/x86_64/kernel/early_printk.c	Sun Nov 10 19:28:26 2002
+++ linux-2.5.47/arch/x86_64/kernel/early_printk.c	Wed Dec 31 16:00:00 1969
@@ -1,218 +0,0 @@
-#include <linux/console.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/string.h>
-#include <asm/io.h>
-
-/* Simple VGA output */
-
-#define VGABASE		0xffffffff800b8000UL
-
-#define MAX_YPOS	25
-#define MAX_XPOS	80
-
-static int current_ypos = 1, current_xpos = 0; 
-
-static void early_vga_write(struct console *con, const char *str, unsigned n)
-{
-	char c;
-	int  i, k, j;
-
-	while ((c = *str++) != '\0' && n-- > 0) {
-		if (current_ypos >= MAX_YPOS) {
-			/* scroll 1 line up */
-			for(k = 1, j = 0; k < MAX_YPOS; k++, j++) {
-				for(i = 0; i < MAX_XPOS; i++) {
-					writew(readw(VGABASE + 2*(MAX_XPOS*k + i)),
-					       VGABASE + 2*(MAX_XPOS*j + i));
-				}
-			}
-			for(i = 0; i < MAX_XPOS; i++) {
-				writew(0x720, VGABASE + 2*(MAX_XPOS*j + i));
-			}
-			current_ypos = MAX_YPOS-1;
-		}
-		if (c == '\n') {
-			current_xpos = 0;
-			current_ypos++;
-		} else if (c != '\r')  {
-			writew(((0x7 << 8) | (unsigned short) c),
-			       VGABASE + 2*(MAX_XPOS*current_ypos + current_xpos++));
-			if (current_xpos >= MAX_XPOS) {
-				current_xpos = 0;
-				current_ypos++;
-			}
-		}
-	}
-}
-
-static struct console early_vga_console = {
-	.name =		"earlyvga",
-	.write =	early_vga_write,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
-};
-
-/* Serial functions losely based on a similar package from Klaus P. Gerlicher */ 
-
-int early_serial_base = 0x3f8;  /* ttyS0 */ 
-
-#define XMTRDY          0x20
-
-#define DLAB		0x80
-
-#define TXR             0       /*  Transmit register (WRITE) */
-#define RXR             0       /*  Receive register  (READ)  */
-#define IER             1       /*  Interrupt Enable          */
-#define IIR             2       /*  Interrupt ID              */
-#define FCR             2       /*  FIFO control              */
-#define LCR             3       /*  Line control              */
-#define MCR             4       /*  Modem control             */
-#define LSR             5       /*  Line Status               */
-#define MSR             6       /*  Modem Status              */
-#define DLL             0       /*  Divisor Latch Low         */
-#define DLH             1       /*  Divisor latch High        */
-
-static int early_serial_putc(unsigned char ch) 
-{ 
-	unsigned timeout = 0xffff; 
-	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout) 
-		rep_nop(); 
-	outb(ch, early_serial_base + TXR);
-	return timeout ? 0 : -1;
-} 
-
-static void early_serial_write(struct console *con, const char *s, unsigned n)
-{
-	while (*s && n-- > 0) { 
-		early_serial_putc(*s); 
-		if (*s == '\n') 
-			early_serial_putc('\r'); 
-		s++; 
-	} 
-} 
-
-static __init void early_serial_init(char *opt)
-{
-	unsigned char c; 
-	unsigned divisor, baud = 38400;
-	char *s, *e;
-
-	if (*opt == ',') 
-		++opt;
-
-	s = strsep(&opt, ","); 
-	if (s != NULL) { 
-		unsigned port; 
-		if (!strncmp(s,"0x",2))
-			early_serial_base = simple_strtoul(s, &e, 16);
-		else {	
-			static int bases[] = { 0x3f8, 0x2f8 };
-		if (!strncmp(s,"ttyS",4)) 
-			s+=4; 
-		port = simple_strtoul(s, &e, 10); 
-		if (port > 1 || s == e) 
-			port = 0; 
-		early_serial_base = bases[port];
-	}
-	}
-
-	outb(0x3, early_serial_base + LCR); /* 8n1 */
-	outb(0, early_serial_base + IER); /* no interrupt */ 
-	outb(0, early_serial_base + FCR); /* no fifo */ 
-	outb(0x3, early_serial_base + MCR); /* DTR + RTS */ 
-
-	s = strsep(&opt, ","); 
-	if (s != NULL) { 
-		baud = simple_strtoul(s, &e, 0); 
-		if (baud == 0 || s == e) 
-			baud = 38400;
-	} 
-	
-	divisor = 115200 / baud; 
-	c = inb(early_serial_base + LCR); 
-	outb(c | DLAB, early_serial_base + LCR); 
-	outb(divisor & 0xff, early_serial_base + DLL); 
-	outb((divisor >> 8) & 0xff, early_serial_base + DLH); 
-	outb(c & ~DLAB, early_serial_base + LCR);
-}
-
-static struct console early_serial_console = {
-	.name =		"earlyser",
-	.write =	early_serial_write,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
-};
-
-/* Direct interface for emergencies */
-struct console *early_console = &early_vga_console;
-static int early_console_initialized = 0;
-
-void early_printk(const char *fmt, ...)
-{ 
-	char buf[512]; 
-	int n; 
-	va_list ap;
-	va_start(ap,fmt); 
-	n = vsnprintf(buf,512,fmt,ap);
-	early_console->write(early_console,buf,n);
-	va_end(ap); 
-} 
-
-static int keep_early; 
-
-int __init setup_early_printk(char *opt) 
-{  
-	char *space;
-	char buf[256]; 
-
-	if (early_console_initialized)
-		return -1;
-
-	strncpy(buf,opt,256); 
-	buf[255] = 0; 
-	space = strchr(buf, ' '); 
-	if (space)
-		*space = 0; 
-
-	if (strstr(buf,"keep"))
-		keep_early = 1; 
-
-	if (!strncmp(buf, "serial", 6)) { 
-		early_serial_init(buf + 6);
-		early_console = &early_serial_console;
-	} else if (!strncmp(buf, "ttyS", 4)) { 
-		early_serial_init(buf);
-		early_console = &early_serial_console;		
-	} else if (!strncmp(buf, "vga", 3)) {
-		early_console = &early_vga_console; 
-	} else {
-		early_console = NULL; 		
-		return -1; 
-	}
-	early_console_initialized = 1;
-	register_console(early_console);       
-	return 0;
-}
-
-void __init disable_early_printk(void)
-{ 
-	if (!early_console_initialized || !early_console)
-		return;
-	if (!keep_early) {
-		printk("disabling early console...\n"); 
-		unregister_console(early_console);
-		early_console_initialized = 0;
-	} else { 
-		printk("keeping early console.\n"); 
-	}
-} 
-
-/* syntax: earlyprintk=vga
-           earlyprintk=serial[,ttySn[,baudrate]] 
-   Append ,keep to not disable it when the real console takes over.
-   Only vga or serial at a time, not both.
-   Currently only ttyS0 and ttyS1 are supported. 
-   Interaction with the standard serial driver is not very good. 
-   The VGA output is eventually overwritten by the real console. */
-__setup("earlyprintk=", setup_early_printk);  
diff -urN linux-2.5.47-clean/arch/x86_64/kernel/head64.c linux-2.5.47/arch/x86_64/kernel/head64.c
--- linux-2.5.47-clean/arch/x86_64/kernel/head64.c	Sun Nov 10 19:28:10 2002
+++ linux-2.5.47/arch/x86_64/kernel/head64.c	Thu Nov 14 14:34:47 2002
@@ -70,7 +70,7 @@
 	boot_cpu_data.x86_mask = eax & 0xf;
 }
 
-extern void start_kernel(void), pda_init(int), setup_early_printk(char *); 
+extern void start_kernel(void), pda_init(int); 
 extern int disable_apic;
 
 void __init x86_64_start_kernel(char * real_mode_data)
@@ -80,9 +80,6 @@
 	clear_bss();
 	pda_init(0);
 	copy_bootdata(real_mode_data);
-	s = strstr(saved_command_line, "earlyprintk="); 
-	if (s != NULL)
-		setup_early_printk(s+12); 
 #ifdef CONFIG_X86_IO_APIC
 	if (strstr(saved_command_line, "disableapic"))
 		disable_apic = 1;
diff -urN linux-2.5.47-clean/include/asm-i386/early_printk.h linux-2.5.47/include/asm-i386/early_printk.h
--- linux-2.5.47-clean/include/asm-i386/early_printk.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.47/include/asm-i386/early_printk.h	Thu Nov 14 14:20:43 2002
@@ -0,0 +1,8 @@
+#ifndef __EARLY_PRINTK_H_I386_
+#define __EARLY_PRINTK_H_i386_
+
+#define VGABASE  0xB8000
+#define SERIAL_BASES { 0x3f8, 0x2f8 }
+#define SERIAL_BASES_LEN 2
+
+#endif
diff -urN linux-2.5.47-clean/include/asm-x86_64/early_printk.h linux-2.5.47/include/asm-x86_64/early_printk.h
--- linux-2.5.47-clean/include/asm-x86_64/early_printk.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.47/include/asm-x86_64/early_printk.h	Thu Nov 14 14:15:04 2002
@@ -0,0 +1,8 @@
+#ifdef __EARLY_PRINTK_H_X86_64_
+#define __EARLY_PRINTK_H_X86_64_
+
+#define VGABASE	0xffffffff800b8000UL
+#define SERIAL_BASES { 0x3f8, 0x2f8 }
+#define SERIAL_BASES_LEN 2
+
+#endif
Binary files linux-2.5.47-clean/include/linux/.early_printk.h.swp and linux-2.5.47/include/linux/.early_printk.h.swp differ
diff -urN linux-2.5.47-clean/include/linux/early_printk.h linux-2.5.47/include/linux/early_printk.h
--- linux-2.5.47-clean/include/linux/early_printk.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.47/include/linux/early_printk.h	Thu Nov 14 14:48:29 2002
@@ -0,0 +1,47 @@
+#ifndef __EARLY_PRINTK_H_
+#define __EARLY_PRINTK_H_
+
+#ifdef CONFIG_EARLY_PRINTK
+#include <linux/console.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <asm/io.h>
+#include <asm/early_printk.h>
+
+/* Simple VGA output */
+
+#define MAX_YPOS	25
+#define MAX_XPOS	80
+
+/* Simple serial port output */
+
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
+void early_printk(const char *fmt, ...);
+int __init setup_early_printk(char *opt); 
+
+#else
+
+#define early_printk(...) do {} while(0)
+#define setup_early_printk(X) do {} while(0)
+
+#endif
+
+#endif
diff -urN linux-2.5.47-clean/init/main.c linux-2.5.47/init/main.c
--- linux-2.5.47-clean/init/main.c	Sun Nov 10 19:28:05 2002
+++ linux-2.5.47/init/main.c	Thu Nov 14 14:47:14 2002
@@ -33,6 +33,7 @@
 #include <linux/workqueue.h>
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
+#include <linux/early_printk.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -387,6 +388,7 @@
  */
 	lock_kernel();
 	printk(linux_banner);
+	setup_early_printk(&command_line);
 	setup_arch(&command_line);
 	setup_per_cpu_areas();
 	build_all_zonelists();
diff -urN linux-2.5.47-clean/kernel/Makefile linux-2.5.47/kernel/Makefile
--- linux-2.5.47-clean/kernel/Makefile	Sun Nov 10 19:28:06 2002
+++ linux-2.5.47/kernel/Makefile	Thu Nov 14 14:16:00 2002
@@ -21,6 +21,7 @@
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urN linux-2.5.47-clean/kernel/early_printk.c linux-2.5.47/kernel/early_printk.c
--- linux-2.5.47-clean/kernel/early_printk.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.47/kernel/early_printk.c	Thu Nov 14 14:35:50 2002
@@ -0,0 +1,209 @@
+#include <linux/console.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/early_printk.h>
+#include <asm/io.h>
+
+/* Simple VGA output */
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
+int early_serial_base;  /* ttyS0 */ 
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
+	static int bases[] = SERIAL_BASES;
+	char *s, *e;
+
+	early_serial_base = bases[0];
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
+			if (!strncmp(s,"ttyS",4)) 
+				s+=4; 
+			port = simple_strtoul(s, &e, 10); 
+			if (port > (SERIAL_BASES_LEN-1) || s == e) 
+				port = 0; 
+			early_serial_base = bases[port];
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
+	char *space, *s;
+	char buf[256];
+
+	s = strstr(opt, "earlyprintk=");
+	if (s == NULL)
+		return -1;
+	opt = s+12;
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

--------------030909000502030508090907--

