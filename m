Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTFXWF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTFXWF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:05:27 -0400
Received: from pcp03710388pcs.westk01.tn.comcast.net ([68.34.200.110]:50818
	"EHLO ori.thedillows.org") by vger.kernel.org with ESMTP
	id S263365AbTFXWFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:05:02 -0400
Subject: 2.4.21: kernel BUG at ide-iops.c:1262!
From: David Dillow <dave@thedillows.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056493150.2840.17.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jun 2003 18:19:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found a completely repeatable BUG/panic in 2.4.21 (final). The
kernel BUGS and then panics in an interrupt while beginning to burn a
DVD+R. I get the following in the logs, then the BUG/panic decoded at
the end of this message:

scsi : aborting command due to timeout : pid 390, scsi0, channel 0, id
0, lun 0
Test Unit Ready 00 00 00 00 00
scsi : aborting command due to timeout : pid 390, scsi0, channel 0, id
0, lun 0
Test Unit Ready 00 00 00 00 00
SCSI host 0 abort (pid 390) timed out - resetting
SCSI bus is being reset for host 0 channel 0.

Hardware is a dual PIII, 512MB memory, VIA vt82c686b IDE controller,
Sony DRU-500A DVD+/-RW burner, and Maxwell 4x DVD+R media. I have not
been able to reproduce with any other media, and the firmware on the
500A is the latest.

I was able to reproduce this with 2.4.21-rc5-ac1, but have not had media
available to try other kernels. I do have a few left, so I can help test
theories and solutions.

I was using growifs from dvd+rw-tools versions 5.6.4.4.4 and 5.9.4.4.4.
It will happen under either version.

Dave




ksymoops 2.4.5 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map-2.4.21 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at ide-iops.c:1262!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c01b5551>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013082
eax: c01d8ee0   ebx: 00000000   ecx: 00000036   edx: 00000002
esi: c15d7c00   edi: c032c450   ebp: c032c254   esp: dfff5e84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=dfff5000)
Stack: 00000001 00003086 00003086 c15d7c00 c1597c60 00003086 00000000
c15d7c00 
       00000000 c15e64c0 c01b5767 c032c450 00000000 c01da110 c032c450
c01d427d 
       c15d7c00 00000002 00000000 c15d7c00 00003286 00000020 00000001
c01d3675 
Call Trace:    [<c01b5767>] [<c01da110>] [<c01d427d>] [<c01d3675>]
[<e0825fbc>]
  [<c01d35f0>] [<c0125c2e>] [<c0121b54>] [<c01219f7>] [<c01217b9>]
[<c0109399>]
  [<c01053e0>] [<c010bed8>] [<c01053e0>] [<c010540c>] [<c01054a2>]
[<c011c5a5>]
  [<c011c810>]
Code: 0f 0b ee 04 61 ef 25 c0 80 bf 09 01 00 00 20 74 0c 8b 74 24 


>>EIP; c01b5551 <do_reset1+31/230>   <=====

>>eax; c01d8ee0 <idescsi_pc_intr+0/360>
>>esi; c15d7c00 <_end+1298ac8/204cef28>
>>edi; c032c450 <ide_hwifs+670/2c88>
>>ebp; c032c254 <ide_hwifs+474/2c88>
>>esp; dfff5e84 <_end+1fcb6d4c/204cef28>

Trace; c01b5767 <ide_do_reset+17/20>
Trace; c01da110 <idescsi_reset+20/40>
Trace; c01d427d <scsi_reset+11d/370>
Trace; c01d3675 <scsi_old_times_out+85/160>
Trace; e0825fbc <[usb-uhci]rh_init_int_timer+5c/70>
Trace; c01d35f0 <scsi_old_times_out+0/160>
Trace; c0125c2e <run_timer_list+12e/1b7>
Trace; c0121b54 <bh_action+54/80>
Trace; c01219f7 <tasklet_hi_action+67/a0>
Trace; c01217b9 <do_softirq+d9/e0>
Trace; c0109399 <do_IRQ+e9/f0>
Trace; c01053e0 <default_idle+0/50>
Trace; c010bed8 <call_do_IRQ+5/d>
Trace; c01053e0 <default_idle+0/50>
Trace; c010540c <default_idle+2c/50>
Trace; c01054a2 <cpu_idle+52/70>
Trace; c011c5a5 <call_console_drivers+65/120>
Trace; c011c810 <printk+140/180>

Code;  c01b5551 <do_reset1+31/230>
00000000 <_EIP>:
Code;  c01b5551 <do_reset1+31/230>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01b5553 <do_reset1+33/230>
   2:   ee                        out    %al,(%dx)
Code;  c01b5554 <do_reset1+34/230>
   3:   04 61                     add    $0x61,%al
Code;  c01b5556 <do_reset1+36/230>
   5:   ef                        out    %eax,(%dx)
Code;  c01b5557 <do_reset1+37/230>
   6:   25 c0 80 bf 09            and    $0x9bf80c0,%eax
Code;  c01b555c <do_reset1+3c/230>
   b:   01 00                     add    %eax,(%eax)
Code;  c01b555e <do_reset1+3e/230>
   d:   00 20                     add    %ah,(%eax)
Code;  c01b5560 <do_reset1+40/230>
   f:   74 0c                     je     1d <_EIP+0x1d>
Code;  c01b5562 <do_reset1+42/230>
  11:   8b 74 24 00               mov    0x0(%esp,1),%esi

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


