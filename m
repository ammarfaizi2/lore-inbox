Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTEBNDG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 09:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTEBNDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 09:03:06 -0400
Received: from smtp.inet.fi ([192.89.123.192]:13485 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S262028AbTEBNDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 09:03:03 -0400
From: Kimmo Sundqvist <rabbit80@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: Badness in local_bh_enable at kernel/softirq.c:108
Date: Fri, 2 May 2003 16:15:02 +0300
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305021615.02690.rabbit80@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Next thing happens in every shutdown with 2.5.68-osdl2

*** From kern.log ***

May  2 05:24:13 : Badness in local_bh_enable at kernel/softirq.c:108
 : Call Trace:
 :  [local_bh_enable+53/108] local_bh_enable+0x35/0x6c
 :  [<f8d00d71>] ppp_async_push+0x18d/0x198 [ppp_async]
 :  [<f8d005bc>] ppp_asynctty_wakeup+0x28/0x4c [ppp_async]
 :  [pty_unthrottle+38/76] pty_unthrottle+0x26/0x4c
 :  [check_unthrottle+42/48] check_unthrottle+0x2a/0x30
 :  [reset_buffer_flags+134/140] reset_buffer_flags+0x86/0x8c
 :  [n_tty_flush_buffer+11/64] n_tty_flush_buffer+0xb/0x40
 :  [pty_flush_buffer+29/72] pty_flush_buffer+0x1d/0x48
 :  [do_tty_hangup+324/940] do_tty_hangup+0x144/0x3ac
 :  [tty_vhangup+10/16] tty_vhangup+0xa/0x10
 :  [pty_close+290/296] pty_close+0x122/0x128
 :  [release_dev+565/1612] release_dev+0x235/0x64c
 :  [release_pages+369/380] release_pages+0x171/0x17c
 :  [tty_release+74/140] tty_release+0x4a/0x8c
 :  [__fput+55/224] __fput+0x37/0xe0
 :  [fput+20/24] fput+0x14/0x18
 :  [filp_close+208/220] filp_close+0xd0/0xdc
 :  [put_files_struct+84/188] put_files_struct+0x54/0xbc
 :  [do_exit+512/1196] do_exit+0x200/0x4ac
 :  [sys_exit_group+0/20] sys_exit_group+0x0/0x14
 :  [sys_exit_group+14/20] sys_exit_group+0xe/0x14
May  2 05:24:13 :  [syscall_call+7/11] syscall_call+0x7/0xb

*** cat /proc/modules ***

soundcore 7232 0 - Live 0xf8d29000
ppp_async 9760 1 [unsafe], Live 0xf8d00000
ipv6 205604 5 - Live 0xf8d47000
microcode 5408 0 - Live 0xf8d07000
nls_iso8859_1 4096 1 - Live 0xf8c50000
nls_cp437 5760 1 - Live 0xf8c3c000
vfat 13216 1 - Live 0xf8c3f000
fat 40384 1 vfat, Live 0xf8c45000
msr 3200 0 - Live 0xf893e000
minix 28964 0 - Live 0xf896a000
via686a 16164 0 - Live 0xf895b000
i2c_sensor 2784 1 via686a, Live 0xf8940000
hfs 88672 0 - Live 0xf8974000
ppp_synctty 8032 0 - Live 0xf8931000
ppp_generic 27080 4 ppp_async,ppp_synctty, Live 0xf8953000
slhc 6112 1 ppp_generic, Live 0xf8934000
3c59x 31656 1 - Live 0xf894a000
i2c_core 18080 2 via686a,i2c_sensor, Live 0xf8938000

*** cat /proc/cpuinfo ***

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 932.044
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1830.91

Processor 1: everything else identical, except:
bogomips        : 1859.58

*** lspci ***

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0c.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / 
HPT370 (rev 03)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 03)

Pre-empt is enabled.

I access the Internet with:
PPPoE Version 3.3, Copyright (C) 2001 Roaring Penguin Software Inc.

(The machine has been found stable with 10 hours of prime-net (GIMPS) torture 
test, 2 instances since 2 CPUs.)

-Kimmo S.
