Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTJCBR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 21:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTJCBR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 21:17:28 -0400
Received: from mailhub2.midco.net ([24.220.0.34]:58041 "EHLO
	mailhub2.midco.net") by vger.kernel.org with ESMTP id S263572AbTJCBRT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 21:17:19 -0400
Message-ID: <3F7CCEB8.8040803@spe.midco.net>
Date: Thu, 02 Oct 2003 19:19:52 -0600
From: AG <agroz@spe.midco.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5 & test6 cd burning/scheduler/ide-scsi.c bug
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

 This is my first bug submission, so please have patience with my noobness :)

Here goes:

 Kernel test5 and test6 appear to have a bug which prevents at least 
some systems from burning CDs correctly. It manifests itself in kernel 
lockups (requiring a hard reset) in test6 and burner application lockups 
in test5 on x86 hardware.

 Hardware in both instances is different; burners were tested in 
Windows, BeOS and in kernels 2.4.20 and 2.4.22 and everything was found 
to work correctly, so it's not likely to be a hardware bug.  One system 
is using ext3 and a 24x burner (the      system), the other system is 
using reiserfs and a 4x HP CD-Writer+ 8200a (the Duron system).

  The 24x system under test5 showed k3b, Gtoaster and cdrecord all 
locking up at random points during the burn and the system required a 
reboot for the drive to work again;; under test6 the system locked up 
entirely requiring a hard reset.

  The system with the 4x burner was upgraded from test3 and hardlocks 
every time during the burn. The cdwriter appeared to be alive, showing a 
red light when the eject button was pushed, indicating that the tray was 
locked as it should be.

  Neither system under test6 would respond to any commands and required 
hard resets.

  Under kernels 2.4.20, 2.4.22 and 2.6.0-test3 the same installations 
will burn cds with no difficulties.

  The 24x system using k3b showed a wildly varying buffer value during 
the burn, which is unusual.

 A search of the lkml archives revealed nothing relevant to our 
knowledge.  After some discussion and testing we were able to obtain a 
log showing the crash, which is below.

  -------
 Crash log which shows the ide-scsi.c BUG at line 493;

/crash log from machine with 24x burner

Sep 30 22:09:53 sdchomelinux kernel: hdd: irq timeout: status=0xd0 { Busy }
Sep 30 22:09:53 sdchomelinux kernel: hdd: DMA disabled
Sep 30 22:09:53 sdchomelinux kernel: ide-scsi: abort called for 5687
Sep 30 22:09:53 sdchomelinux kernel: Debug: sleeping function called 
from invalid context at include/asm/semaphore.h:119
Sep 30 22:09:53 sdchomelinux kernel: in_atomic():1, irqs_disabled():1
Sep 30 22:09:53 sdchomelinux kernel: Call Trace:
Sep 30 22:09:53 sdchomelinux kernel:  [<c0117a9a>] __might_sleep+0x9c/0xb6
Sep 30 22:09:53 sdchomelinux kernel:  [<c0274d5d>] scsi_sleep+0x6c/0x89
Sep 30 22:09:53 sdchomelinux kernel:  [<c0274cdd>] scsi_sleep_done+0x0/0x14
Sep 30 22:09:53 sdchomelinux kernel:  [<d886c859>] 
idescsi_abort+0xee/0xf7 [ide_scsi]
Sep 30 22:09:53 sdchomelinux kernel:  [<c027460c>] 
scsi_try_to_abort_cmd+0x65/0x80
Sep 30 22:09:53 sdchomelinux kernel:  [<c0274732>] 
scsi_eh_abort_cmds+0x40/0x74
Sep 30 22:09:53 sdchomelinux kernel:  [<c0275159>] scsi_unjam_host+0xa5/0xcb
Sep 30 22:09:53 sdchomelinux kernel:  [<c027525f>] 
scsi_error_handler+0xe0/0x11c
Sep 30 22:09:53 sdchomelinux kernel:  [<c027517f>] 
scsi_error_handler+0x0/0x11c
Sep 30 22:09:53 sdchomelinux kernel:  [<c0107345>] 
kernel_thread_helper+0x5/0xb
Sep 30 22:09:53 sdchomelinux kernel:
Sep 30 22:09:53 sdchomelinux kernel: bad: scheduling while atomic!
Sep 30 22:09:53 sdchomelinux kernel: Call Trace:
Sep 30 22:09:53 sdchomelinux kernel:  [<c0116661>] schedule+0x58c/0x591
Sep 30 22:09:53 sdchomelinux kernel:  [<c011a5a0>] printk+0x11d/0x17b
Sep 30 22:09:53 sdchomelinux kernel:  [<c01081c2>] __down+0x91/0x107
Sep 30 22:09:53 sdchomelinux kernel:  [<c01166b6>] 
default_wake_function+0x0/0x2e
Sep 30 22:09:53 sdchomelinux kernel:  [<c01098b9>] dump_stack+0x1e/0x22
Sep 30 22:09:53 sdchomelinux kernel:  [<c01083eb>] __down_failed+0xb/0x14
Sep 30 22:09:53 sdchomelinux kernel:  [<c02754bf>] 
.text.lock.scsi_error+0x37/0x48
Sep 30 22:09:53 sdchomelinux kernel:  [<c0274cdd>] scsi_sleep_done+0x0/0x14
Sep 30 22:09:53 sdchomelinux kernel:  [<d886c859>] 
idescsi_abort+0xee/0xf7 [ide_scsi]
Sep 30 22:09:53 sdchomelinux kernel:  [<c027460c>] 
scsi_try_to_abort_cmd+0x65/0x80
Sep 30 22:09:53 sdchomelinux kernel:  [<c0274732>] 
scsi_eh_abort_cmds+0x40/0x74
Sep 30 22:09:53 sdchomelinux kernel:  [<c0275159>] scsi_unjam_host+0xa5/0xcb
Sep 30 22:09:53 sdchomelinux kernel:  [<c027525f>] 
scsi_error_handler+0xe0/0x11c
Sep 30 22:09:53 sdchomelinux kernel:  [<c027517f>] 
scsi_error_handler+0x0/0x11c
Sep 30 22:09:53 sdchomelinux kernel:  [<c0107345>] 
kernel_thread_helper+0x5/0xb
Sep 30 22:09:53 sdchomelinux kernel:
Sep 30 22:09:53 sdchomelinux kernel: hdd: ATAPI reset complete
Sep 30 22:09:53 sdchomelinux kernel: hdd: irq timeout: status=0xc0 { Busy }
Sep 30 22:09:53 sdchomelinux kernel: hdd: ATAPI reset complete
Sep 30 22:09:53 sdchomelinux kernel: hdd: irq timeout: status=0xc0 { Busy }
Sep 30 22:09:55 sdchomelinux kernel: ide-scsi: reset called for 5687

Sep 30 22:09:55 sdchomelinux kernel: ------------[ cut here ]------------
Sep 30 22:09:55 sdchomelinux kernel: kernel BUG at 
drivers/scsi/ide-scsi.c:493!
Sep 30 22:09:55 sdchomelinux kernel: invalid operand: 0000 [#1]
Sep 30 22:09:55 sdchomelinux kernel: CPU:    0
Sep 30 22:09:55 sdchomelinux kernel: EIP:    0060:[<d886ba9c>]    Not 
tainted
Sep 30 22:09:55 sdchomelinux kernel: EFLAGS: 00010286
Sep 30 22:09:55 sdchomelinux kernel: EIP is at 
idescsi_transfer_pc+0x9c/0x120 [ide_scsi]
Sep 30 22:09:55 sdchomelinux kernel: eax: c025fc53   ebx: c047eafc   
ecx: 72c79a8e   edx: 00000172
Sep 30 22:09:55 sdchomelinux kernel: esi: cfa1fb80   edi: d7687ba4   
ebp: d789fdf4   esp: d789fdd0
Sep 30 22:09:55 sdchomelinux kernel: ds: 007b   es: 007b   ss: 0068

Sep 30 22:09:55 sdchomelinux kernel: Process scsi_eh_1 (pid: 2369, 
threadinfo=d789e000 task=d78a1900)
Sep 30 22:09:55 sdchomelinux kernel: Stack: 00000172 c047eafc 00000008 
00000080 0000001e d7687ba4 c047eafc d6f9b580
Sep 30 22:09:55 sdchomelinux kernel:        00000000 d789fe20 c025c38b 
c047eafc cfa1fb80 00000000 00000000 0000001e
Sep 30 22:09:55 sdchomelinux kernel:        0000000f d6f9b580 c047eafc 
c047e8bc d789fe50 c025c685 c047eafc d6f9b580
Sep 30 22:09:55 sdchomelinux kernel: Call Trace:
Sep 30 22:09:55 sdchomelinux kernel:  [<c025c38b>] start_request+0x179/0x27b
Sep 30 22:09:55 sdchomelinux kernel:  [<c025c685>] 
ide_do_request+0x1d5/0x34e
Sep 30 22:09:55 sdchomelinux kernel:  [<c0248a7e>] 
__elv_add_request+0x27/0x38
Sep 30 22:09:55 sdchomelinux kernel:  [<c025ce66>] 
ide_do_drive_cmd+0xd0/0x132
Sep 30 22:09:55 sdchomelinux kernel:  [<c01166e0>] 
default_wake_function+0x2a/0x2e
Sep 30 22:09:55 sdchomelinux kernel:  [<d886c31c>] 
idescsi_queue+0x1e1/0x630 [ide_scsi]
Sep 30 22:09:55 sdchomelinux kernel:  [<c02742c2>] 
scsi_send_eh_cmnd+0xa7/0x189
Sep 30 22:09:55 sdchomelinux kernel:  [<c02741d1>] scsi_eh_done+0x0/0x4a
Sep 30 22:09:55 sdchomelinux kernel:  [<c02741b0>] 
scsi_eh_times_out+0x0/0x21
Sep 30 22:09:55 sdchomelinux kernel:  [<c02746bb>] scsi_eh_tur+0x94/0xcb
Sep 30 22:09:55 sdchomelinux kernel:  [<c027493e>] 
scsi_eh_bus_device_reset+0x145/0x177
Sep 30 22:09:55 sdchomelinux kernel:  [<c02746c5>] scsi_eh_tur+0x9e/0xcb
Sep 30 22:09:55 sdchomelinux kernel:  [<c0274ff8>] 
scsi_eh_ready_devs+0x28/0x74
Sep 30 22:09:55 sdchomelinux kernel:  [<c0275176>] scsi_unjam_host+0xc2/0xcb
Sep 30 22:09:55 sdchomelinux kernel:  [<c027525f>] 
scsi_error_handler+0xe0/0x11c
Sep 30 22:09:55 sdchomelinux kernel:  [<c027517f>] 
scsi_error_handler+0x0/0x11c
Sep 30 22:09:55 sdchomelinux kernel:  [<c0107345>] 
kernel_thread_helper+0x5/0xb
Sep 30 22:09:55 sdchomelinux kernel:
Sep 30 22:09:55 sdchomelinux kernel: Code: 0f 0b ed 01 69 cf 86 d8 8b 56 
38 a1 00 9d 3c c0 89 d1 29 c1
Sep 30 22:09:55 sdchomelinux kernel:  hdd: ATAPI reset complete

/end log

------

An IRC log of our conversation in which we discovered this is available.

 No workarounds as of yet or other info.
 
DarkHills and Cyber Daemon of #cola on infrared.oftc.net

contact email:  agroz@spe.midco.net 

Info section:

Kernel versions: 2.6.0-test5 and 2.6.0-test6
Processors: Duron 1200 and P4 1.5GHz
Modules loaded: Duron system:
                      system:
/proc/ioports:
        Duron

bash-2.05b# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0330-0331 : MPU401 UART
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-40ff : 0000:00:07.4
5000-500f : 0000:00:07.4
6000-607f : 0000:00:07.4
d000-d00f : 0000:00:07.1
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : 0000:00:07.2
  d400-d41f : uhci-hcd
d800-d81f : 0000:00:07.3
  d800-d81f : uhci-hcd
dc00-dcff : 0000:00:0f.0
  dc00-dcff : 8139too
e000-e0ff : 0000:00:11.0
  e000-e0ff : CMI8738


            P4:
stephen@sdchomelinux stephen $ cat /proc/ioports 
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0500-050f : 0000:00:1f.3
0cf8-0cff : PCI conf1
c000-c01f : 0000:02:03.0
  c000-c01f : ne2k-pci
c400-c4ff : 0000:02:04.0
  c400-c4ff : 8139too
d000-d01f : 0000:00:1f.2
  d000-d01f : uhci-hcd
d800-d81f : 0000:00:1f.4
  d800-d81f : uhci-hcd
f000-f00f : 0000:00:1f.1
  f000-f007 : ide0
  f008-f00f : ide1




/proc/iomem:

        Duron

bash-2.05b# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0037e9b2 : Kernel code
  0037e9b3-004590ff : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
    d0000000-d1ffffff : rivafb
d8000000-dbffffff : 0000:00:00.0
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : 0000:01:00.0
    dc000000-dcffffff : rivafb
df000000-df0000ff : 0000:00:0f.0
  df000000-df0000ff : 8139too
df001000-df001fff : 0000:00:10.0
df002000-df002fff : 0000:00:10.1
ffff0000-ffffffff : reserved


            P4:
stephen@sdchomelinux stephen $ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-003693dc : Kernel code
  003693dd-0044857f : Kernel data
17ff0000-17ff2fff : ACPI Non-volatile Storage
17ff3000-17ffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-ebffffff : PCI Bus #01
  e4000000-e7ffffff : 0000:01:00.0
  e8000000-e807ffff : 0000:01:00.0
ec000000-edffffff : PCI Bus #01
  ec000000-ecffffff : 0000:01:00.0
ef000000-ef0fffff : 0000:02:01.0
ef100000-ef1000ff : 0000:02:04.0
  ef100000-ef1000ff : 8139too
ef101000-ef101fff : 0000:02:01.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb00000-ffffffff : reserved




PCI info:        Duron

lspci not installed

            P4:
lspci not installed




/proc/scsi/scsi    Duron

bash-2.05b# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: CD-Writer+ 8200a Rev: 1.0f
  Type:   CD-ROM                           ANSI SCSI revision: 02


            P4:
sdchomelinux root # cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model: DVD-ROM          Rev: 2.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: TDK      Model: CDRW241040B      Rev: 57S4
  Type:   CD-ROM                           ANSI SCSI revision: 02


ver_linux script results:

    Duron

Linux AMDbox 2.6.0-test6 #2 Sun Sep 28 15:31:35 MDT 2003 i686 AMD 
Athlon(tm) Processor AuthenticAMD GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.33
reiserfsprogs          3.6.8
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         se401 videodev ide_scsi nvidia 8139too mii crc32 
sg sr_mod sd_mod scsi_mod


    P4:
Linux sdchomelinux 2.6.0-test6 #2 Tue Sep 30 21:44:42 CDT 2003 i686 Intel(R) Pentium(R) 4 CPU 1.50GHz GenuineIntel GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.33
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         ipt_TOS ipt_MASQUERADE ipt_REJECT ipt_LOG ipt_state ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp ipt_multiport ipt_conntrack iptable_filter iptable_mangle iptable_nat ip_conntrack ip_tables rtc joydev 8139too mii ne2k_pci 8390 crc32 ide_scsi sr_mod




Duron environment is KDE 3.1.2
P4 environment is Fluxbox 0.1.14
-----------------------------------------
*end cut and paste section*


