Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268596AbUHTSF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268596AbUHTSF1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268553AbUHTSE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:04:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58273 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268541AbUHTSCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:02:19 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/14] kexec: apic-virtwire-on-shutdown.x86_64
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 12:01:05 -0600
Message-ID: <m1r7q1665a.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Likewise we need to place the local apic in virtual wire mode
on reboot for x86_64.

Eric

diff -uNr linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.i386/arch/x86_64/kernel/apic.c linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.x86_64/arch/x86_64/kernel/apic.c
--- linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.i386/arch/x86_64/kernel/apic.c	Fri Aug 20 09:56:29 2004
+++ linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.x86_64/arch/x86_64/kernel/apic.c	Fri Aug 20 10:12:49 2004
@@ -142,6 +142,36 @@
 		outb(0x70, 0x22);
 		outb(0x00, 0x23);
 	}
+	else {
+		/* Go back to Virtual Wire compatibility mode */
+		unsigned long value;
+
+		/* For the spurious interrupt use vector F, and enable it */
+		value = apic_read(APIC_SPIV);
+		value &= ~APIC_VECTOR_MASK;
+		value |= APIC_SPIV_APIC_ENABLED;
+		value |= 0xf;
+		apic_write_around(APIC_SPIV, value);
+
+		/* For LVT0 make it edge triggered, active high, external and enabled */
+		value = apic_read(APIC_LVT0);
+		value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
+			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
+			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
+		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXINT);
+		apic_write_around(APIC_LVT0, value);
+
+		/* For LVT1 make it edge triggered, active high, nmi and enabled */
+		value = apic_read(APIC_LVT1);
+		value &= ~(
+			APIC_MODE_MASK | APIC_SEND_PENDING |
+			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
+			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
+		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
+		apic_write_around(APIC_LVT1, value);
+	}
 }
 
 void disable_local_APIC(void)
diff -uNr linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.i386/include/asm-x86_64/apicdef.h linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.x86_64/include/asm-x86_64/apicdef.h
--- linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.i386/include/asm-x86_64/apicdef.h	Mon May 17 05:40:57 2004
+++ linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.x86_64/include/asm-x86_64/apicdef.h	Fri Aug 20 10:12:49 2004
@@ -32,6 +32,8 @@
 #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
 #define			APIC_ALL_CPUS		0xFF
 #define		APIC_DFR	0xE0
+#define			APIC_DFR_CLUSTER		0x0FFFFFFFul
+#define			APIC_DFR_FLAT			0xFFFFFFFFul
 #define		APIC_SPIV	0xF0
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
 #define			APIC_SPIV_APIC_ENABLED		(1<<8)
@@ -86,6 +88,7 @@
 #define			APIC_LVT_REMOTE_IRR		(1<<14)
 #define			APIC_INPUT_POLARITY		(1<<13)
 #define			APIC_SEND_PENDING		(1<<12)
+#define			APIC_MODE_MASK			0x700
 #define			GET_APIC_DELIVERY_MODE(x)	(((x)>>8)&0x7)
 #define			SET_APIC_DELIVERY_MODE(x,y)	(((x)&~0x700)|((y)<<8))
 #define				APIC_MODE_FIXED		0x0
