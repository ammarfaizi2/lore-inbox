Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263506AbRFANdV>; Fri, 1 Jun 2001 09:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263507AbRFANdL>; Fri, 1 Jun 2001 09:33:11 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:14599 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263506AbRFANc7>; Fri, 1 Jun 2001 09:32:59 -0400
From: Matt Chapman <matthewc@cse.unsw.edu.au>
To: Dag Brattli <dag@brattli.net>
Date: Fri, 1 Jun 2001 23:32:46 +1000
Cc: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.uit.no
Subject: [PATCH] for Linux IRDA initialisation bug 2.4.5
Message-ID: <20010601233245.A10478@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found that if you compile IRDA into the kernel, irda_proto_init
gets called twice - once at do_initcalls time, and once explicitly
in do_basic_setup - eventually resulting in a hang (as
register_netdevice_notifier gets called twice with the same struct,
and it's list becomes circular).

Here's a suggested patch.

Cheers,
Matt


diff -urN linux-2.4.5/init/main.c linux-2.4.5-irdafix/init/main.c
--- linux-2.4.5/init/main.c	Wed May 23 02:35:42 2001
+++ linux-2.4.5-irdafix/init/main.c	Fri Jun  1 23:03:00 2001
@@ -61,10 +61,6 @@
 #include <linux/isapnp.h>
 #endif
 
-#ifdef CONFIG_IRDA
-#include <net/irda/irda_device.h>
-#endif
-
 #ifdef CONFIG_X86_IO_APIC
 #include <asm/smp.h>
 #endif
@@ -698,10 +694,6 @@
 	start_context_thread();
 	do_initcalls();
 
-#ifdef CONFIG_IRDA
-	irda_proto_init();
-	irda_device_init(); /* Must be done after protocol initialization */
-#endif
 #ifdef CONFIG_PCMCIA
 	init_pcmcia_ds();		/* Do this last */
 #endif
diff -urN linux-2.4.5/net/irda/af_irda.c linux-2.4.5-irdafix/net/irda/af_irda.c
--- linux-2.4.5/net/irda/af_irda.c	Sun May 20 10:47:55 2001
+++ linux-2.4.5-irdafix/net/irda/af_irda.c	Fri Jun  1 23:04:25 2001
@@ -2411,9 +2411,7 @@
 	register_netdevice_notifier(&irda_dev_notifier);
 
 	irda_init();
-#ifdef MODULE
- 	irda_device_init();  /* Called by init/main.c when non-modular */
-#endif
+ 	irda_device_init();
 	return 0;
 }
 module_init(irda_proto_init);
