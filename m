Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317905AbSFNK0I>; Fri, 14 Jun 2002 06:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317906AbSFNK0H>; Fri, 14 Jun 2002 06:26:07 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:26576 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317905AbSFNK0H>; Fri, 14 Jun 2002 06:26:07 -0400
Date: Fri, 14 Jun 2002 11:40:04 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] 2.5.21 deadlocks on UP (SMP kernel) w/ IOAPIC
Message-ID: <Pine.LNX.4.44.0206141106330.30400-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
	The balance_irq/move code in 2.5.21 currently deadlocks on my UP 
box due to the following;

balance_irq() {
entry = irq_balance + irq;
	[...]
	rdtscl(random_number);
	random_number &= 1;
	[...]
	entry->cpu = move(entry->cpu, allowed_mask, now, random_number);
}

move() {
	do {
		[...]
		cpu=0x0 curr_cpu=0x1 smp_num_cpus=0x1 allowed_mask=0x1 direction=0x0
		[...]
	} while (!IRQ_ALLOWED(cpu,allowed_mask) ||
		(search_idle && !IDLE_ENOUGH(cpu,now)));


}

Please apply

Regards,
	Zwane Mwaikambo

Diffed against 2.5.21
--- linux-2.5.19/arch/i386/kernel/io_apic.c.orig	Fri Jun 14 11:53:15 2002
+++ linux-2.5.19/arch/i386/kernel/io_apic.c	Fri Jun 14 11:55:01 2002
@@ -248,13 +248,14 @@
 static inline void balance_irq(int irq)
 {
 #if CONFIG_SMP
-	irq_balance_t *entry = irq_balance + irq;
+	irq_balance_t *entry;
 	unsigned long now = jiffies;
 
-	if (unlikely(entry->timestamp != now)) {
+	if ((entry->timestamp != now) && (smp_num_cpus > 1)) {
 		unsigned long allowed_mask;
 		int random_number;
 
+		entry = irq_balance + irq;
 		rdtscl(random_number);
 		random_number &= 1;
 

-- 
http://function.linuxpower.ca
		




