Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262679AbTCJAPU>; Sun, 9 Mar 2003 19:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbTCJAPU>; Sun, 9 Mar 2003 19:15:20 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:2830 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S262679AbTCJAPS>; Sun, 9 Mar 2003 19:15:18 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200303100025.h2A0Pkp23345@sprite.physics.adelaide.edu.au>
Subject: Oops: kernel 2.4.20, ide-scsi, cdrecord 1.11a24
To: linux-kernel@vger.kernel.org
Date: Mon, 10 Mar 2003 10:55:46 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Please CC: followups to me direct since I don't always get to read the list
every day.

I have encountered an oops under 2.4.20 while burning CDs (the ksymoops
output is included later in this email).  The writer is an ATAPI device
currently connected as the master on the secondary IDE interface.  The
complete IDE setup in use is:
  Primary IDE (ide0), master = boot HDD
  Primary IDE (ide0), slave = second HDD
  Secondary IDE (ide1), master = CD writer
  Secondary IDE (ide1), slave = third HDD
  IDE from ESS1868 sound card (ide3), master = CD reader

Both CDs (the writer and the reader) are handled by ide-scsi.  Other stats
on the box:
  CPU: Pentium-MMX 233
  RAM: 96MB SDRAM
  Video card: Trio64V2 PCI
  Other cards: Tulip-based NIC, ieee1394 card, Ensoniq AudioPCI soundcard,
               ESS1868 soundcard (ISA), ALS007 soundcard (ISA)
  cdrecord version: 1.11a24

Up until a system upgrade on 29 November 2002 many CDs had been successfully
burnt using this setup under 2.2.19.  Since then some CDs have been burnt
successfully using cdrdao.

The CD data does NOT come from /dev/hdd (in all current tests, partitions on
/dev/hda were the source).

The kernel is compiled with ISAPnP in the kernel and IDE has PnP-IDE
enabled.  The target machine has been set as 586.

Following the oops, the caps-lock and scroll-lock keyboard LEDs blink at a
rate of 1Hz.  The num-lock LED remains off.  I don't know if this is
significant.

I have also tried 2.4.21pre3 and 2.4.18 and the opps occurs there as well.
The oops occurs after writing an apparently random number of bytes: it has
occurred after 25, 27, 57 and 580MB for instance.

Under 2.4.20 the oops usually occurs very soon after writing commences -
normally between 7MB and 30MB are written before disaster strikes.  2.4.18
seems less prone to the trouble - it tends to oops only after several
hundred MB have been written.

Other changes to the system which do NOT prevent the oops:
 * making the CDwriter the slave on its IDE channel, with the third HDD
   being the master
 * compiling the kernel WITHOUT IDE-PnP enabled
 * removing the ESS1868 from the system (both with and without IDE-PnP
   enabled)
 * have ide-scsi handle only the CD writer
 * removing/never loading USB and IEEE1394 driver modules
 * removing ESS1868 and ALS007 soundcards

The following is the output of ksymoops run on the 2.4.20 oops.

ksymoops 2.4.5 on i586 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000018
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<ccbc6805>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c9adbc40   ebx: c0310328   ecx: c9711f20   edx: c9711f20
esi: 00000000   edi: c0210328   ebp: 00000000   esp: c02cfe8c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02cf000)
Stack: c0310328 c0310328 c0310328 00000000 00000000 c0310328 c0310328 c9adbc40
       ccbc699f c0310328 00000000 00000000 c01ccc56 c0310328 c9711f20 00000000
       c9711f20 c03102e4 c0310328 00000282 00000000 c03102e4 c0310328 c01ccfb7
Call trace:    [<ccbc699f>] [<c01ccc56>] [<c01ccfb7>] [<c01cd281>] [<c01cd0e0>]
  [<c011c91c>] [<c01199c6>] [<c0119906>] [<c011971a>] [<c0109ced>] [<c0106e10>]
  [<c010be78>] [<c0106e10>] [<c0106e33>] [<c0106e97>] [<c0105000>] [<c0105027>]
Code: 8b 56 18 c7 44 24 18 00 00 00 00 89 70 04 8b 46 1c 8b 7e 0c


>>EIP; ccbc6805 <[ide-scsi]idescsi_issue_pc+19/198>   <=====

>>eax; c9adbc40 <_end+97c61bc/c86c57c>
>>ebx; c0310328 <ide_hwifs+3a8/21e8>
>>ecx; c9711f20 <_end+93fc49c/c86c57c>
>>edx; c9711f20 <_end+93fc49c/c86c57c>
>>edi; c0210328 <rtnetlink_event+0/3c>
>>esp; c02cfe8c <init_task_union+1e8c/2000>

Trace; ccbc699f <[ide-scsi]idescsi_do_request+1b/4c>
Trace; c01ccc56 <start_request+1ae/228>
Trace; c01ccfb7 <ide_do_request+28b/2d8>
Trace; c01cd281 <ide_timer_expiry+1a1/1b0>
Trace; c01cd0e0 <ide_timer_expiry+0/1b0>
Trace; c011c91c <timer_bh+274/390>
Trace; c01199c6 <bh_action+1a/48>
Trace; c0119906 <tasklet_hi_action+4a/70>
Trace; c011971a <do_softirq+5a/ac>
Trace; c0109ced <do_IRQ+a1/b4>
Trace; c0106e10 <default_idle+0/28>
Trace; c010be78 <call_do_IRQ+5/d>
Trace; c0106e10 <default_idle+0/28>
Trace; c0106e33 <default_idle+23/28>
Trace; c0106e97 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>

Code;  ccbc6805 <[ide-scsi]idescsi_issue_pc+19/198>
00000000 <_EIP>:
Code;  ccbc6805 <[ide-scsi]idescsi_issue_pc+19/198>   <=====
   0:   8b 56 18                  mov    0x18(%esi),%edx   <=====
Code;  ccbc6808 <[ide-scsi]idescsi_issue_pc+1c/198>
   3:   c7 44 24 18 00 00 00      movl   $0x0,0x18(%esp,1)
Code;  ccbc680f <[ide-scsi]idescsi_issue_pc+23/198>
   a:   00 
Code;  ccbc6810 <[ide-scsi]idescsi_issue_pc+24/198>
   b:   89 70 04                  mov    %esi,0x4(%eax)
Code;  ccbc6813 <[ide-scsi]idescsi_issue_pc+27/198>
   e:   8b 46 1c                  mov    0x1c(%esi),%eax
Code;  ccbc6816 <[ide-scsi]idescsi_issue_pc+2a/198>
  11:   8b 7e 0c                  mov    0xc(%esi),%edi

 <0>Kernel panic: Aiee, killing interrupt handler!


Excluding the value in ax, the oops is always the same.

All other functionality on the box is rock solid.  memtest86 reports no RAM
errors.

If more detail is needed I'm happy to provide it - just email me.

Best regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *
