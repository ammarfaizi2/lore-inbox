Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUIVVGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUIVVGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 17:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267823AbUIVVGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 17:06:24 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:64652 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267806AbUIVVGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 17:06:09 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm2
Date: Wed, 22 Sep 2004 17:05:55 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040922131210.6c08b94c.akpm@osdl.org> <200409221648.30234.jbarnes@engr.sgi.com> <20040922135456.3af5d203.akpm@osdl.org>
In-Reply-To: <20040922135456.3af5d203.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zkeUBZQYxbpCkUr"
Message-Id: <200409221705.55716.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_zkeUBZQYxbpCkUr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday, September 22, 2004 4:54 pm, Andrew Morton wrote:
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > On Wednesday, September 22, 2004 4:12 pm, Andrew Morton wrote:
> > > - This kernel doesn't work on ia64 (instant reboot).  But neither does
> > >   2.6.9-rc2, nor current Linus -bk.  Is it just me?
> >
> > I certainly hope so.  Current bk works on my 2p Altix, and iirc 2.6.9-rc2
> > worked as well.  I'm trying 2.6.9-rc2-mm2 right now.  I haven't tried
> > generic_defconfig yet either, maybe that's it?
>
> My config may have wandered from defconfig a bit, but it should be fairly
> generic.  There's a copy at
> http://www.zip.com.au/~akpm/linux/patches/stuff/config-ia64

Assuming you have a real McKinley machine, I don't see anything suspicious.  
You could try wedging this into your tree, enabling early printk for vga and 
see what you come up with.

Jesse

--Boundary-00=_zkeUBZQYxbpCkUr
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="early-printk-ia64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="early-printk-ia64.patch"

Index: linux/arch/ia64/Kconfig
===================================================================
--- linux.orig/arch/ia64/Kconfig	Mon Jul 12 11:12:01 2004
+++ linux/arch/ia64/Kconfig	Mon Jul 12 11:13:15 2004
@@ -431,6 +431,33 @@ config MAGIC_SYSRQ
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
+config IA64_EARLY_PRINTK
+	bool "Early printk support"
+	depends on DEBUG_KERNEL && !IA64_GENERIC
+	help
+	  Selecting this option uses the VGA screen or serial console for
+	  printk() output before the consoles are initialised.  It is useful
+	  for debugging problems early in the boot process, but only if you
+	  have a suitable VGA/serial console attached.  If you're unsure,
+	  select N.
+
+config IA64_EARLY_PRINTK_UART
+	bool "Early printk on MMIO serial port"
+	depends on IA64_EARLY_PRINTK
+
+config IA64_EARLY_PRINTK_UART_BASE
+	hex "UART MMIO base address"
+	depends on IA64_EARLY_PRINTK_UART
+	default "ff5e0000"
+
+config IA64_EARLY_PRINTK_VGA
+	bool "Early printk on VGA"
+	depends on IA64_EARLY_PRINTK
+
+config IA64_EARLY_PRINTK_SGI_SN
+	bool "Early printk on SGI SN serial console"
+	depends on IA64_EARLY_PRINTK && (IA64_GENERIC || IA64_SGI_SN2)
+
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 	depends on DEBUG_KERNEL
Index: linux/kernel/printk.c
===================================================================
--- linux.orig/kernel/printk.c	Mon Jul 12 11:12:14 2004
+++ linux/kernel/printk.c	Mon Jul 12 11:13:15 2004
@@ -406,6 +406,12 @@ static void _call_console_drivers(unsign
 			__call_console_drivers(start, end);
 		}
 	}
+#ifdef CONFIG_IA64_EARLY_PRINTK
+	if (!console_drivers) {
+		void early_printk (const char *str, size_t len);
+		early_printk(&LOG_BUF(start), end - start);
+	}
+#endif
 }
 
 /*
@@ -793,7 +799,11 @@ void register_console(struct console * c
 		 * for us.
 		 */
 		spin_lock_irqsave(&logbuf_lock, flags);
+#ifdef CONFIG_IA64_EARLY_PRINTK
+		con_start = log_end;
+#else
 		con_start = log_start;
+#endif
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
 	release_console_sem();
@@ -895,3 +905,117 @@ int printk_ratelimit(void)
 				printk_ratelimit_burst);
 }
 EXPORT_SYMBOL(printk_ratelimit);
+
+#ifdef CONFIG_IA64_EARLY_PRINTK
+
+#include <asm/io.h>
+
+# ifdef CONFIG_IA64_EARLY_PRINTK_VGA
+
+
+#define VGABASE		((char *)0xc0000000000b8000)
+#define VGALINES	24
+#define VGACOLS		80
+
+static int current_ypos = VGALINES, current_xpos = 0;
+
+static void
+early_printk_vga (const char *str, size_t len)
+{
+	char c;
+	int  i, k, j;
+
+	while (len-- > 0) {
+		c = *str++;
+		if (current_ypos >= VGALINES) {
+			/* scroll 1 line up */
+			for (k = 1, j = 0; k < VGALINES; k++, j++) {
+				for (i = 0; i < VGACOLS; i++) {
+					writew(readw(VGABASE + 2*(VGACOLS*k + i)),
+					       VGABASE + 2*(VGACOLS*j + i));
+				}
+			}
+			for (i = 0; i < VGACOLS; i++) {
+				writew(0x720, VGABASE + 2*(VGACOLS*j + i));
+			}
+			current_ypos = VGALINES-1;
+		}
+		if (c == '\n') {
+			current_xpos = 0;
+			current_ypos++;
+		} else if (c != '\r')  {
+			writew(((0x7 << 8) | (unsigned short) c),
+			       VGABASE + 2*(VGACOLS*current_ypos + current_xpos++));
+			if (current_xpos >= VGACOLS) {
+				current_xpos = 0;
+				current_ypos++;
+			}
+		}
+	}
+}
+
+# endif /* CONFIG_IA64_EARLY_PRINTK_VGA */
+
+# ifdef CONFIG_IA64_EARLY_PRINTK_UART
+
+#include <linux/serial_reg.h>
+#include <asm/system.h>
+
+static void early_printk_uart(const char *str, size_t len)
+{
+	static char *uart = NULL;
+	unsigned long uart_base;
+	char c;
+
+	if (!uart) {
+		uart_base = 0;
+#  ifdef CONFIG_SERIAL_8250_HCDP
+		{
+			extern unsigned long hcdp_early_uart(void);
+			uart_base = hcdp_early_uart();
+		}
+#  endif
+#  if CONFIG_IA64_EARLY_PRINTK_UART_BASE
+		if (!uart_base)
+			uart_base = CONFIG_IA64_EARLY_PRINTK_UART_BASE;
+#  endif
+		if (!uart_base)
+			return;
+
+		uart = ioremap(uart_base, 64);
+		if (!uart)
+			return;
+	}
+
+	while (len-- > 0) {
+		c = *str++;
+		while ((readb(uart + UART_LSR) & UART_LSR_TEMT) == 0)
+			cpu_relax(); /* spin */
+
+		writeb(c, uart + UART_TX);
+
+		if (c == '\n')
+			writeb('\r', uart + UART_TX);
+	}
+}
+
+# endif /* CONFIG_IA64_EARLY_PRINTK_UART */
+
+#ifdef CONFIG_IA64_EARLY_PRINTK_SGI_SN
+extern int early_printk_sn_sal(const char *str, int len);
+#endif
+
+void early_printk(const char *str, size_t len)
+{
+#ifdef CONFIG_IA64_EARLY_PRINTK_UART
+	early_printk_uart(str, len);
+#endif
+#ifdef CONFIG_IA64_EARLY_PRINTK_VGA
+	early_printk_vga(str, len);
+#endif
+#ifdef CONFIG_IA64_EARLY_PRINTK_SGI_SN
+ 	early_printk_sn_sal(str, len);
+#endif
+}
+
+#endif /* CONFIG_IA64_EARLY_PRINTK */

--Boundary-00=_zkeUBZQYxbpCkUr--
