Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268534AbTCAIte>; Sat, 1 Mar 2003 03:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268536AbTCAIte>; Sat, 1 Mar 2003 03:49:34 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:20741 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S268534AbTCAItb>;
	Sat, 1 Mar 2003 03:49:31 -0500
Date: Sat, 1 Mar 2003 09:42:04 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       macro@ds2.pg.gda.pl, marcelo@conectiva.com.br
Subject: [PATCH][2.4] APIC irq balance
Message-ID: <20030301084204.GF5411@alpha.home.local>
References: <Pine.LNX.4.50.0303010109360.1132-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303010109360.1132-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 01:25:50AM -0500, Zwane Mwaikambo wrote:
> This patch fixes what seems to have been a longstanding bug. Ever since we 
> moved cpu bringup later into the boot process, we end up programming the 
> ioapics before we have any of our possible cpus in the cpu_online_map. 
> Therefore leading to the following current situation;

Hi Zwane !

I've had the same problem on 2.4 since 2.4.21-pre1, but I couldn't find the
culprit. I've ported your patch to 2.4.21-pre5 and guess what ? it works, as
shown below. I'd like Maciej to review it quickly (if he has time), so that
Marcelo could include it in 2.4.21. Patch at the end.

Oh, I forgot to say : it's on an Asus A7M266-D, dual XP1800.

Anyway, congratulations for this finding !

Cheers,
Willy

----- dmesg:

 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  1    1    0   1   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  1    1    0   1   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1

----- proc/interrupts :

           CPU0       CPU1       
  0:       5001       4156    IO-APIC-edge  timer
  1:        188        125    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
 10:        222        210   IO-APIC-level  usb-ohci, eth0
 11:          0          0   IO-APIC-level  usb-ohci
 12:       9099       8796   IO-APIC-level  aic7xxx
 15:          2          4    IO-APIC-edge  ide1
NMI:          0          0 
LOC:       9085       9084 
ERR:          0
MIS:          0

----- patch


diff -urN linux-2.4.21-pre5/arch/i386/kernel/io_apic.c linux-2.4.21-pre5-apic/arch/i386/kernel/io_apic.c
--- linux-2.4.21-pre5/arch/i386/kernel/io_apic.c	Sat Feb  1 19:42:12 2003
+++ linux-2.4.21-pre5-apic/arch/i386/kernel/io_apic.c	Sat Mar  1 09:38:18 2003
@@ -1313,6 +1313,34 @@
 
 static void mask_and_ack_level_ioapic_irq (unsigned int irq) { /* nothing */ }
 
+/*
+ * This function currently is only a helper for the i386 smp boot process where 
+ * we need to reprogram the ioredtbls to cater for the cpus which have come online
+ * so mask in all cases should simply be TARGET_CPUS
+ */
+void __devinit set_ioapic_logical_dest (unsigned long mask)
+{
+	struct IO_APIC_route_entry entry;
+	unsigned long flags;
+	int apic, pin;
+
+	if (skip_ioapic_setup == 1)
+		return;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	for (apic = 0; apic < nr_ioapics; apic++) {
+		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
+			*(((int *)&entry)+0) = io_apic_read(apic, 0x10+pin*2);
+			*(((int *)&entry)+1) = io_apic_read(apic, 0x11+pin*2);
+			entry.dest.logical.logical_dest = mask;
+			io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry) + 0));
+			io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry) + 1));
+		}
+
+	}
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
 static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
 {
 	unsigned long flags;
diff -urN linux-2.4.21-pre5/arch/i386/kernel/smpboot.c linux-2.4.21-pre5-apic/arch/i386/kernel/smpboot.c
--- linux-2.4.21-pre5/arch/i386/kernel/smpboot.c	Sat Feb  1 19:42:12 2003
+++ linux-2.4.21-pre5-apic/arch/i386/kernel/smpboot.c	Sat Mar  1 09:41:38 2003
@@ -971,6 +971,8 @@
 extern int prof_old_multiplier[NR_CPUS];
 extern int prof_counter[NR_CPUS];
 
+extern void set_ioapic_logical_dest(unsigned long mask);
+
 static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
@@ -1223,5 +1225,6 @@
 		synchronize_tsc_bp();
 
 smp_done:
+	set_ioapic_logical_dest(cpu_online_map);
 	zap_low_mappings();
 }


