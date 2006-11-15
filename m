Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbWKOPAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWKOPAI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWKOPAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:00:07 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:20888
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030513AbWKOPAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:00:06 -0500
Message-Id: <455B39CF.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 15 Nov 2006 15:01:19 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] use CON_BOOT in early printk code
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Making the code simpler and closing the time window between disabling
the early console and getting the real one ready.

Once all architectures using CONFIG_EARLY_PRINTK have done so, the
dummy disable_early_printk() could then also be removed.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc5/arch/x86_64/kernel/early_printk.c	2006-11-08 09:21:47.000000000 +0100
+++ 2.6.19-rc5-x86-early-printk/arch/x86_64/kernel/early_printk.c	2006-11-06 09:10:16.000000000 +0100
@@ -56,7 +56,7 @@ static void early_vga_write(struct conso
 static struct console early_vga_console = {
 	.name =		"earlyvga",
 	.write =	early_vga_write,
-	.flags =	CON_PRINTBUFFER,
+	.flags =	CON_PRINTBUFFER | CON_BOOT,
 	.index =	-1,
 };
 
@@ -152,7 +152,7 @@ static __init void early_serial_init(cha
 static struct console early_serial_console = {
 	.name =		"earlyser",
 	.write =	early_serial_write,
-	.flags =	CON_PRINTBUFFER,
+	.flags =	CON_PRINTBUFFER | CON_BOOT,
 	.index =	-1,
 };
 
@@ -213,8 +213,6 @@ void early_printk(const char *fmt, ...)
 	va_end(ap);
 }
 
-static int __initdata keep_early;
-
 static int __init setup_early_printk(char *buf)
 {
 	if (!buf)
@@ -224,9 +222,6 @@ static int __init setup_early_printk(cha
 		return 0;
 	early_console_initialized = 1;
 
-	if (!strcmp(buf,"keep"))
-		keep_early = 1;
-
 	if (!strncmp(buf, "serial", 6)) {
 		early_serial_init(buf + 6);
 		early_console = &early_serial_console;
@@ -242,9 +237,14 @@ static int __init setup_early_printk(cha
  	} else if (!strncmp(buf, "simnow", 6)) {
  		simnow_init(buf + 6);
  		early_console = &simnow_console;
- 		keep_early = 1;
 	}
+	if (strstr(buf,"keep"))
+		early_console->flags &= ~CON_BOOT;
+
 	register_console(early_console);
+	if (!(early_console->flags & CON_BOOT))
+		printk("Will keep early console.\n");
+
 	return 0;
 }
 
@@ -252,14 +252,5 @@ early_param("earlyprintk", setup_early_p
 
 void __init disable_early_printk(void)
 {
-	if (!early_console_initialized || !early_console)
-		return;
-	if (!keep_early) {
-		printk("disabling early console\n");
-		unregister_console(early_console);
-		early_console_initialized = 0;
-	} else {
-		printk("keeping early console\n");
-	}
 }
 


