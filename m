Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUFNAhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUFNAhx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUFNAhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:37:52 -0400
Received: from holomorphy.com ([207.189.100.168]:29341 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261576AbUFNAhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:37:10 -0400
Date: Sun, 13 Jun 2004 17:37:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [4/12] unregister driver if probing fails in sb_card.c
Message-ID: <20040614003708.GS1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614003605.GR1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Unregister driver if probing fails in sound/oss/sb_card.c
This fixes Debian BTS #218845.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=218845

	From: Robin Gerard <robin.jag@free.fr>
	To: submit@bugs.debian.org
	Subject: no sound with kernel-image-2.6.0-test9-1-386
	Message-ID: <20031103004939.GA2071@mauritius>

I downlaoded the kernel-image-2.6.0-test9-1-386_2.6.0-test9-1_i386.deb
and I installed it successfully. Everything works fine, except the sound.
(I run also the kernel-image-2.4.20 and the sound is ok with this kernel)
My sound card is a sb.

First I launched modconf but no module was displayed.

I did: modprobe sb=20
and I got:

sb: Init: Done
sb: Init: Starting Probe...
kobject_register failed for OSS SndBlstr (-17)
Call Trace:
[<c0191cda>] kobject_register+0x3a/0x40
[<c01d9bcc>] bus_add_driver+0x30/0x64
[<c01d9e51>] driver_register+0x2d/0x34
[<c011a24a>] preempt_schedule+0x2a/0x48
[<c01b6f84>] pnp_register_driver+0x28/0x58
[<c01b6c5e>] pnp_register_card_driver+0x5e/0x98
[<c488f063>] sb_init+0x63/0xb5 [sb]
[<c0130bf4>] sys_init_module+0xe8/0x1f0
[<c010b577>] syscall_call+0x7/0xb


Index: linux-2.5/sound/oss/sb_card.c
===================================================================
--- linux-2.5.orig/sound/oss/sb_card.c	2004-06-13 11:57:56.000000000 -0700
+++ linux-2.5/sound/oss/sb_card.c	2004-06-13 12:08:55.000000000 -0700
@@ -309,7 +309,13 @@
 
 	/* If either PnP or Legacy registered a card then return
 	 * success */
-	return (pres > 0 || lres > 0) ? 0 : -ENODEV;
+	if (pres <= 0 && lres <= 0) {
+#ifdef CONFIG_PNP
+		pnp_unregister_card_driver(&sb_pnp_driver);
+#endif
+		return -ENODEV;
+	}
+	return 0;
 }
 
 static void __exit sb_exit(void)
