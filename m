Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSFOIPN>; Sat, 15 Jun 2002 04:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSFOIPM>; Sat, 15 Jun 2002 04:15:12 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:21398 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315119AbSFOIPM>; Sat, 15 Jun 2002 04:15:12 -0400
Date: Sat, 15 Jun 2002 09:46:30 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <akpm@zip.com.au>
Subject: [PATCH][2.5] 2.5.21 deadlocks on UP (SMP kernel) w/ IOAPIC (take 2)
In-Reply-To: <Pine.LNX.4.44.0206141712590.30400-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0206150942490.30400-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of Andrew Morton we tracked down the original breakage to 
the irq_balance_t declaration which assumes there is a cpu#1

typedef struct {
        unsigned int cpu;
        unsigned long timestamp;
} ____cacheline_aligned irq_balance_t;

static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
                        = { [ 0 ... NR_IRQS-1 ] = { 1, 0 } };

against 2.5.21, test booted on UP(SMP) w/ IOAPIC and SMP

--- linux-2.5.19/arch/i386/kernel/io_apic.c.orig	Fri Jun 14 17:43:20 2002
+++ linux-2.5.19/arch/i386/kernel/io_apic.c	Sat Jun 15 10:07:11 2002
@@ -207,7 +207,7 @@
 } ____cacheline_aligned irq_balance_t;
 
 static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
-			= { [ 0 ... NR_IRQS-1 ] = { 1, 0 } };
+			= { [ 0 ... NR_IRQS-1 ] = { 0, 0 } };
 
 extern unsigned long irq_affinity [NR_IRQS];
 
Linus, i promise this is the last one ;)

Regards,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca


