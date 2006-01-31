Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWAaG0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWAaG0B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 01:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWAaG0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 01:26:01 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:44492 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932396AbWAaG0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 01:26:00 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: 2.6.14.6: CONFIG_BASE_SMALL=1 locks up with 32MB RAM
Date: Tue, 31 Jan 2006 08:25:23 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601310825.23509.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed 2.6.15.1 on a lowmem box.
I changed .config a bit compared to previous running kernel
(was at 2.6.12.3).

Box got unstable. After ~10 hours it locks up solid without
OOPS. No keyboard led toggling, no SysRq.

I went back to 2.6.14.6 but it didn't help. I changed .config
back to 2.6.12.3 one (a few settings at a time) and
narrowed it down to below diff.

I think it's CONFIG_BASE_SMALL. IOW: this one in menuconfig:

-> General setup 
-> Configure standard kernel features
-> Enable full-sized data structures for core

# diff -u config config_bad8
--- config      Mon Jan 30 15:56:00 2006
+++ config_bad8 Mon Jan 30 15:50:06 2006
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.14.6
-# Mon Jan 30 15:56:00 2006
+# Mon Jan 30 08:13:25 2006
 #
 CONFIG_X86=y
 CONFIG_SEMAPHORE_SLEEPERS=y
@@ -43,7 +43,7 @@
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
-CONFIG_BASE_FULL=y
+# CONFIG_BASE_FULL is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
@@ -53,7 +53,7 @@
 CONFIG_CC_ALIGN_LOOPS=1
 CONFIG_CC_ALIGN_JUMPS=1
 # CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
+CONFIG_BASE_SMALL=1

 #
 # Loadable module support
@@ -1279,7 +1279,7 @@
 CONFIG_FS_MBCACHE=y
 CONFIG_REISERFS_FS=y
 # CONFIG_REISERFS_CHECK is not set
-CONFIG_REISERFS_PROC_INFO=y
+# CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y


This box has 32MB of RAM:

Linux version 2.6.14.6 (root@firebird) (gcc version 3.4.1) #1 SMP Mon Jan 30 16:45:37 EET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
32MB LOWMEM available.
found SMP MP-table at 000f67a0
On node 0 totalpages: 8192
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 4096 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.0 present.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: RD440LX DP   APIC at: 0xFEE00000
Processor #0 6:3 APIC version 17
I/O APIC #1 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 10000000 (gap: 02000000:fcc00000)
Built 1 zonelists
Kernel command line: root=/dev/sdb1 devfs=nomount init=/init
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 256 (order: 8, 4096 bytes)
Detected 233.319 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x30
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 26520k/32768k available (3034k kernel code, 5820k reserved, 1311k data, 600k init, 0k highmem)

I will retest with 2.6.15.1 now.
--
vda
