Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTEaPcD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTEaPcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:32:03 -0400
Received: from ns.suse.de ([213.95.15.193]:22289 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264373AbTEaPcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:32:00 -0400
Date: Sat, 31 May 2003 17:45:21 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@digeo.com
Subject: Re: [PATCH] Eat keys on panic
Message-ID: <20030531154521.GA8602@wotan.suse.de>
References: <20030531115653.GA11119@wotan.suse.de> <1054390488.27311.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054390488.27311.5.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 03:14:51PM +0100, Alan Cox wrote:
> On Sad, 2003-05-31 at 12:56, Andi Kleen wrote:
> 
> > +void eat_key(void)
> > +{
> > +        if (inb(0x60) & 1) 
> > +                inb(0x64);
> >  }
> 
> This will crash at least one of my machines. The keyboard controller
> has mandatory access delays of up to 1mS. Respect them or some stuff
> dies horribly.

1ms? Is it clocked in Khz or something? 

Here is a new version that is hopefully Alan's-broken-chipset proof.
I also added the request comment.

-Andi

P.S.: This is different from the panic blink code. The two can easily
coexist though.


Index: linux/arch/i386/kernel/ioport.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/ioport.c,v
retrieving revision 1.17
diff -u -u -r1.17 ioport.c
--- linux/arch/i386/kernel/ioport.c	30 May 2003 20:12:29 -0000	1.17
+++ linux/arch/i386/kernel/ioport.c	31 May 2003 14:24:16 -0000
@@ -15,6 +15,8 @@
 #include <linux/stddef.h>
 #include <linux/slab.h>
 #include <linux/thread_info.h>
+#include <asm/io.h>
+#include <linux/delay.h>
 
 /* Set EXTENT bits starting at BASE in BITMAP to value TURN_ON. */
 static void set_bitmap(unsigned long *bitmap, short base, short extent, int new_value)
@@ -128,4 +130,14 @@
 	/* Make sure we return the long way (not sysenter) */
 	set_thread_flag(TIF_IRET);
 	return 0;
+}
+
+/* Some KVMs don't switch consoles unless the keyboard is served. */
+void eat_key(void)
+{
+	if (inb(0x60) & 1) {
+		mdelay(1);
+		inb(0x64);
+	}
+	mdelay(1);
 }
Index: linux/include/asm-i386/system.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/system.h,v
retrieving revision 1.37
diff -u -u -r1.37 system.h
--- linux/include/asm-i386/system.h	30 May 2003 20:10:39 -0000	1.37
+++ linux/include/asm-i386/system.h	31 May 2003 14:24:22 -0000
@@ -476,4 +476,7 @@
 #define BROKEN_PNP_BIOS		0x0004
 #define BROKEN_CPUFREQ		0x0008
 
+#define HAVE_EAT_KEY
+void eat_key(void);
+
 #endif
Index: linux/kernel/panic.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/panic.c,v
retrieving revision 1.20
diff -u -u -r1.20 panic.c
--- linux/kernel/panic.c	30 May 2003 20:14:20 -0000	1.20
+++ linux/kernel/panic.c	31 May 2003 14:24:24 -0000
@@ -96,8 +96,11 @@
         disabled_wait(caller);
 #endif
 	local_irq_enable();
-	for (;;)
-		;
+	for (;;) { 
+#ifdef HAVE_EAT_KEY
+		eat_key();
+#endif
+	} 
 }
 
 /**

> 
> 
