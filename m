Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266031AbUAUTYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 14:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUAUTYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 14:24:35 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:44216 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S266102AbUAUTWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:22:32 -0500
Date: Wed, 21 Jan 2004 12:22:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       George Anzinger <george@mvista.com>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040121192230.GW13454@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121192128.GV13454@stop.crashing.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 12:21:28PM -0700, Tom Rini wrote:
> On Wed, Jan 21, 2004 at 11:42:17AM -0700, Tom Rini wrote:
> > On Wed, Jan 21, 2004 at 10:23:12PM +0530, Amit S. Kale wrote:
> > 
> > > Hi,
> > > 
> > > Here it is: ppc kgdb from timesys kernel is available at
> > > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2
> > > 
> > > This is my attempt at extracting kgdb from TimeSys kernel. It works well in 
> > > TimeSys kernel, so blame me if above patch doesn't work.
> > 
> > Okay, here's my first patch against this.
> 
> And dependant upon this is a patch to fixup the rest of the common PPC
> code, as follows:

And on top of all of that is the following, which allows KGDB to work on
the Motorola LoPEC.

--- 1.48/arch/ppc/Kconfig	Wed Jan 21 10:13:13 2004
+++ edited/arch/ppc/Kconfig	Wed Jan 21 10:33:55 2004
@@ -583,11 +583,6 @@
 	depends on PPC_MULTIPLATFORM
 	default y
 
-config PPC_GEN550
-	bool
-	depends on SANDPOINT
-	default y
-
 config PPC_PMAC
 	bool
 	depends on PPC_MULTIPLATFORM
@@ -603,6 +598,11 @@
 	depends on PPC_PMAC || PPC_CHRP
 	default y
 
+config PPC_GEN550
+	bool
+	depends on SANDPOINT || MCPN765 || LOPEC
+	default y
+
 config FORCE
 	bool
 	depends on 6xx && (PCORE || POWERPMC250)
--- 1.20/arch/ppc/platforms/lopec_setup.c	Fri Sep 12 09:26:53 2003
+++ edited/arch/ppc/platforms/lopec_setup.c	Wed Jan 21 10:32:15 2004
@@ -32,6 +32,7 @@
 #include <asm/mpc10x.h>
 #include <asm/hw_irq.h>
 #include <asm/prep_nvram.h>
+#include <asm/kgdb.h>
 
 extern char saved_command_line[];
 extern void lopec_find_bridges(void);
@@ -261,44 +262,6 @@
 		: "=r" (batu), "=r" (batl));
 }
 
-#ifdef  CONFIG_SERIAL_TEXT_DEBUG
-#include <linux/serial.h>
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-
-static struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
-};
-
-volatile unsigned char *com_port;
-volatile unsigned char *com_port_lsr;
-
-static void
-serial_writechar(char c)
-{
-	while ((*com_port_lsr & UART_LSR_THRE) == 0)
-		;
-	*com_port = c;
-}
-
-void
-lopec_progress(char *s, unsigned short hex)
-{
-	volatile char c;
-
-	com_port = (volatile unsigned char *) rs_table[0].port;
-	com_port_lsr = com_port + UART_LSR;
-
-	while ((c = *s++) != 0)
-		serial_writechar(c);
-
-	/* Most messages don't have a newline in them */
-	serial_writechar('\n');
-	serial_writechar('\r');
-}
-#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
-
 TODC_ALLOC();
 
 static void __init
@@ -383,7 +346,10 @@
 	ppc_ide_md.default_io_base = lopec_ide_default_io_base;
 	ppc_ide_md.ide_init_hwif = lopec_ide_init_hwif_ports;
 #endif
+#ifdef CONFIG_KGDB
+	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
+#endif
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = lopec_progress;
+	ppc_md.progress = gen550_progress;
 #endif
 }

-- 
Tom Rini
http://gate.crashing.org/~trini/
