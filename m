Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVDJRYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVDJRYC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVDJRYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:24:02 -0400
Received: from mail.homelink.ru ([81.9.33.123]:8140 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S261525AbVDJRXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:23:45 -0400
Date: Sun, 10 Apr 2005 21:23:32 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11 x86_64 NUMA slightly broken
Message-Id: <20050410212332.440fbf34.zap@homelink.ru>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've upgraded the kernel from 2.6.10 to 2.6.11 (both from Fedora Core 3
RPMs) on one of my servers, based on a Tyan S2882 board with two Opteron
248's and two 1Gb modules inserted into the slots next to *second* CPU
(they just happened to be there). And the kernel didn't booted. I've
also tried to compile the kernel myself -- with same result.

I'll skip the whole detective story and will describe just the net
result. It looks like the bug is somewhere in the NUMA handling code,
because:

a) The kernel boots fine with numa=off

b) The kernel started working even without numa=off after I've moved the
DRAM from the slots bound to CPU#2 to the slots bound to CPU#1.

c) The output with kernel 2.6.10 (which worked fine even with DRAM in
slots #2) was as follows:

Bootdata ok (command line is ro root=/dev/hda1 selinux=0)
Linux version 2.6.10-1.741_FC3smp (bhcompile@crowe.devel.redhat.com)
(gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 SMP
Thu Jan 13 16:58:29 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Skipping disabled node 0
Node 1 MemBase 0000000000000000 Limit 000000007fff0000
Using node hash shift of 24
Bootmem setup node 1 0000000000000000-000000007fff0000
No mptable found.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
...

---------------------------------------------------
Kernel 2.6.11 with numa=off:

Linux version 2.6.11-1.7_FC3smp (bhcompile@crowe.devel.redhat.com)
(gcc version 3.4.3 20050227 (Red Hat 3.4.3-22)) #1 SMP
Sat Mar 19 20:16:43 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
NUMA turned off
Faking a node at 0000000000000000-000000007fff0000
Bootmem setup node 0 0000000000000000-000000007fff0000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
...

---------------------------------------------------
Kernel 2.6.11 with enabled numa, crashing (transcribed off the
screen with the earlyprintk=vga option):

Linux version 2.6.11-1.7_FC3smp (bhcompile@crowe.devel.redhat.com)
(gcc version 3.4.3 20050227 (Red Hat 3.4.3-22)) #1 SMP
Sat Mar 19 20:16:43 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
kernel direct mapping tables upto ffff810100000000 @ 8000-d000
Scanning NUMA topology in Northbridge 24
Number of nodes 2
Skipping disabled node 0
Node 1 MemBase 0000000000000000-000000007fff0000
Using node hash shift of 24
Bootmem setup node 1 0000000000000000-000000007fff0000
PANIC: early exception rip ffffffff8020427b error 0 cr2 0
...

The address ffffffff8020427b is:

ffffffff80204210 T find_next_zero_bit
ffffffff802042a0 T find_next_bit

Is this information enough for catching the bug? I'll do my best to
gather more info although it's a production server.

-- 
Greetings,
   Andrew

P.S. Please Cc: to me.
