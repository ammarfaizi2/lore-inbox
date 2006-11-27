Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756548AbWK0EVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbWK0EVx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 23:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbWK0EVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 23:21:53 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:60092
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1756548AbWK0EVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 23:21:53 -0500
Date: Mon, 27 Nov 2006 04:21:14 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] paravirt reorder functions to avoid unspecified behaviour
Message-ID: <6388835f69fc4a69839a132636da7188@pinky>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paravirt: reorder functions to avoid unspecified behaviour

The paravirt ops introduce a 'weak' attribute onto memory_setup().
Code ordering leads to the following warnings on x86:

    arch/i386/kernel/setup.c:651: warning: weak declaration of
		`memory_setup' after first use results in unspecified behavior

Move memory_setup() to avoid this.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 8be04da..79df6e6 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -494,6 +494,12 @@ static void set_mca_bus(int x)
 static void set_mca_bus(int x) { }
 #endif
 
+/* Overridden in paravirt.c if CONFIG_PARAVIRT */
+char * __attribute__((weak)) memory_setup(void)
+{
+	return machine_specific_memory_setup();
+}
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -646,12 +652,6 @@ void __init setup_arch(char **cmdline_p)
 	tsc_init();
 }
 
-/* Overridden in paravirt.c if CONFIG_PARAVIRT */
-char * __attribute__((weak)) memory_setup(void)
-{
-	return machine_specific_memory_setup();
-}
-
 static __init int add_pcspkr(void)
 {
 	struct platform_device *pd;
