Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268578AbUHTSBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268578AbUHTSBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268568AbUHTSBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:01:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56225 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268476AbUHTSAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:00:50 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/14] kexec: apic-virtwire-on-shutdown.i386.patch
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 11:59:36 -0600
Message-ID: <m1vffd667r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Restore the local apic to virtual wire mode on reboot.

diff -uNr linux-2.6.8.1-mm2-i8259-sysfs.x86_64/arch/i386/kernel/apic.c linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.i386/arch/i386/kernel/apic.c
--- linux-2.6.8.1-mm2-i8259-sysfs.x86_64/arch/i386/kernel/apic.c	Fri Aug 20 09:56:25 2004
+++ linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.i386/arch/i386/kernel/apic.c	Fri Aug 20 10:26:22 2004
@@ -202,6 +202,36 @@
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
diff -uNr linux-2.6.8.1-mm2-i8259-sysfs.x86_64/include/asm-i386/apicdef.h linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.i386/include/asm-i386/apicdef.h
--- linux-2.6.8.1-mm2-i8259-sysfs.x86_64/include/asm-i386/apicdef.h	Wed Mar 10 19:55:28 2004
+++ linux-2.6.8.1-mm2-apic-virtwire-on-shutdown.i386/include/asm-i386/apicdef.h	Fri Aug 20 10:26:22 2004
@@ -86,6 +86,7 @@
 #define			APIC_LVT_REMOTE_IRR		(1<<14)
 #define			APIC_INPUT_POLARITY		(1<<13)
 #define			APIC_SEND_PENDING		(1<<12)
+#define			APIC_MODE_MASK			0x700
 #define			GET_APIC_DELIVERY_MODE(x)	(((x)>>8)&0x7)
 #define			SET_APIC_DELIVERY_MODE(x,y)	(((x)&~0x700)|((y)<<8))
 #define				APIC_MODE_FIXED		0x0
