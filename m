Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTJMPDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTJMPDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:03:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:48365 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261780AbTJMPCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:02:06 -0400
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: linux-kernel@vger.kernel.org
Date: Mon, 13 Oct 2003 17:01:57 +0200
MIME-Version: 1.0
Subject: oops in skb in 2.4.20/2.4.22-ac4/2.4.23pre1 but not 2.6.0-test1/test7
Message-ID: <3F8ADA85.8256.10ABE6B1@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

several times I got an OOPS in skb_drop_fraglist or alloc_skb. Here's 
a description of what has happened. Any help would be appreciated. 
Please CC me on all further mail traffic.

Contents:

1) one line summary
2) full description
3) keywords
4) /proc/version
5) OOPS-message (kernel 2.4.20, 2.4.22-ac4, 2.4.23pre1)
6) shell script
7) environment
7.1) ver_linux
7.2) cpuinfo
7.3) modules (kernel 2.4.20, 2.4.22-ac4, 2.4.23pre1)
7.4) ioports, iomem (kernel 2.4.20, 2.4.22-ac4, 2.4.23pre1)
7.5) PCI
7.6) scsi
7.7) other (ide, interrupts, Reiser FS, Samba)

###############################################################

1) one line summary:
When moving data (more than 4GB) from a Windows XP Client to a samba 
share or checking data stored on the samba share (Powerquest 
DriveImage images, 56 files, each ~700MB of size, checking with the 
Powerquest Image Explorer) the kernel panics with an OOPS. Linux has 
to be resetted hard.

The error is occuring on kernel
# 2.4.20 with samba 2.2.7a and 2.2.8a
# 2.4.22-ac4 with samba 2.2.8a (2.2.7a I didn't try any more)
# 2.4.23pre1 with samba 2.2.8a 

The error doesn't occur on kernel 2.6.0-test1 and test7 (the other 
2.6.0-versions I didn't try).

I compiled 2.4.22-ac4 only with PIIX and Promise 20269 ide support to 
prevent other ide driver to bother.

I run memtest for about 25 hours without any error.

###############################################################

2) full description:

I'm using Samba to distribute some shares to Windows clients. One of 
the shares is an Image-directory where I'm storing PQDI Images of 
Windows clients. One of the created images is about 40GB of size and 
is split up to 56 files each of same size. When verifying this image 
from a Win XP client, PQDI  stops with an error (error 1811, "Could 
not read from image file") and the Linux kernel panics. Verifying 
this image from DOS (with MS network client) is done without any 
error. Also verifying smaller images is done without any error. 
Verifying this Image via NFS is also done without an error. Another 
PQDI version (7.0) also reports an error and the Linux Kernel  
panics. Copying more than 4 GB to the samba share also lets the 
kernel panic with an OOPS. Copying data locally from the Linux 
console is done without an error.  

In the beginning I thought that the Promise controller is the source 
of problem, now I'm not sure. Maybe it's samba or the combination of 
samba and kernel version.

The share is lying in a directory on a Reiser filesystem: 

share Images 
ReiserFS 
LVM (on /dev/md0 only, 120GB) 
RAID1 /dev/md0 (120GB) 
/dev/hda1 + /dev/hde1 (one primary partition of 120GB on each drive)
/dev/hda + /dev/hde (each 120GB) IDE UDMA133-controller 

As IDE-controller I first used a Promise FastTrak TX2000 (which 
supports "hardware"-RAID). I tried the binary Promise-driver 
(1.03.0.1) and the source code-driver (1.02.0.25), both without 
success. All time the OOPS occurred. Then I replaced the controller 
and both Samsung SP1203N-hard drives (each  120GB) against a Promise 
UltraTrak 133 TX2 and two Maxtor drives (6Y120P0, each 120GB) and 
installed a Linux native software-RAID without any Promise-driver. 
But again the OOPS occurred. Of course I updated the Promise-firmware 
to the latest level.

To eliminate the RAID and LVM-drivers as the source of problem I 
installed just a Reiser FS on one 120GB-primary partition on one of 
both Maxtor disks (after removing the drive from the RAID). But 
again the Linux kernel panicked. Trying ext3 instead of reiserfs 
didn't help. As I do not have enough space on my scsi-disks I can't 
verify this big image from a scsi-disk.

Sometimes the Linux kernel panic occurs immediately some minutes 
after starting the verify, sometimes it happens after reading half of 
all image files. Samba doesn't report any error. I also tried a 
different PCI-slot for the Promise-adapter without any success.

###############################################################

3) keywords:
Suse Linux 8.20
kernel 2.4.20, 2.4.22-ac4, 2.4.23pre1, 2.6.0-test1, 2.6.0-test7, 
Promise Ultra 133 TX2, samba 2.2.7a, 2.28a

###############################################################

4) /proc/version:
Linux version 2.4.20-4GB (root@Pentium.suse.de) (gcc version 3.3 
20030226 (prerelease) (SuSE Linux)) #1 Wed Aug 6 18:26:21 UTC 2003

Linux version 2.4.22-ac4 (root@server01) (gcc version 2.95.3 20010315 
(SuSE)) #2 SMP Sat Oct 11 00:22:06 CEST 2003

Linux version 2.4.23pre1-usbtest (2.4.23pre1@USB-test.suse.de) (gcc 
version 3.2.2) #1 Wed Aug 27 19:43:12 UTC 2003

Linux version 2.6.0-test7 (root@server01) (gcc version 2.95.3 
20010315 (SuSE)) #1 Sat Oct 11 01:16:28 CEST 2003

###############################################################

5) OOPS-message:

kernel 2.4.20

EIP c022b217 refers to skb_drop_fraglist in vmlinux

Oops: 0000 2.4.20-4GB #1 Wed Aug 6 18:26:21 UTC 2003
CPU:    0
EIP:    0010:[<c022b217>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c428e6e0   ebx: 00200000   ecx: c428e6e0   edx: 00200000
esi: c940ee60   edi: c940eebc   ebp: 00000046   esp: cb4d9cb8
ds: 0018   es: 0018   ss: 0018
Process tail (pid: 1780, stackpage=cb4d9000)
Stack: c940ee60 c022b2ce c940ee60 c940ee60 c940ee60 c022b2eb c940ee60 
c2d09c00
       c022b43b c940ee60 fffffff9 c022f776 c940ee60 00000003 c0346f48 
c0122b1f
       c0346f48 00000006 0000000e d3dcdfa0 cb4d9d24 c010a34c c464421e 
d488f350
Call Trace:    [<c022b2ce>] [<c022b2eb>] [<c022b43b>] [<c022f776>] 
[<c0122b1f>]
  [<c010a34c>] [<c010c5f8>] [<c021b096>] [<c0215ac7>] [<c0216558>] 
[<c0216db8>]
  [<c01c19c5>] [<c01c34c0>] [<c01c48af>] [<c01c57e2>] [<c01c6443>] 
[<c01b7dbc>]
  [<c01b95be>] [<c0159c01>] [<c01b5737>] [<c01b9450>] [<c0144b08>] 
[<c0108c33>]
Code: 8b 1b 8b 42 70 48 74 0a ff 4a 70 0f 94 c0 84 c0 74 07 52 e8


>>EIP; c022b217 <skb_drop_fraglist+17/40>   <=====

>>eax; c428e6e0 <[ipv6]ip6_fl_gc_timer+ad980/c87300>
>>ecx; c428e6e0 <[ipv6]ip6_fl_gc_timer+ad980/c87300>

Trace; c022b2ce <skb_release_data+6e/80>
Trace; c022b2eb <kfree_skbmem+b/70>
Trace; c022b43b <__kfree_skb+eb/140>
Trace; c022f776 <net_tx_action+86/a0>
Trace; c0122b1f <do_softirq+5f/b0>
Trace; c010a34c <do_IRQ+9c/b0>
Trace; c010c5f8 <call_do_IRQ+5/d>
Trace; c021b096 <fbcon_cfb16_putcs+326/3e0>
Trace; c0215ac7 <fbcon_putcs_tl+57/130>
Trace; c0216558 <fbcon_redraw+1e8/340>
Trace; c0216db8 <fbcon_scroll+508/c60>
Trace; c01c19c5 <scrup+1e5/200>
Trace; c01c34c0 <lf+60/70>
Trace; c01c48af <do_con_trol+bf/cd0>
Trace; c01c57e2 <do_con_write+322/930>
Trace; c01c6443 <con_put_char+33/40>
Trace; c01b7dbc <opost+ac/190>
Trace; c01b95be <write_chan+16e/200>
Trace; c0159c01 <update_atime+51/60>
Trace; c01b5737 <tty_write+157/230>
Trace; c01b9450 <write_chan+0/200>
Trace; c0144b08 <sys_write+78/100>
Trace; c0108c33 <system_call+33/40>

Code;  c022b217 <skb_drop_fraglist+17/40>
00000000 <_EIP>:
Code;  c022b217 <skb_drop_fraglist+17/40>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c022b219 <skb_drop_fraglist+19/40>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c022b21c <skb_drop_fraglist+1c/40>
   5:   48                        dec    %eax
Code;  c022b21d <skb_drop_fraglist+1d/40>
   6:   74 0a                     je     12 <_EIP+0x12>
Code;  c022b21f <skb_drop_fraglist+1f/40>
   8:   ff 4a 70                  decl   0x70(%edx)
Code;  c022b222 <skb_drop_fraglist+22/40>
   b:   0f 94 c0                  sete   %al
Code;  c022b225 <skb_drop_fraglist+25/40>
   e:   84 c0                     test   %al,%al
Code;  c022b227 <skb_drop_fraglist+27/40>
  10:   74 07                     je     19 <_EIP+0x19>
Code;  c022b229 <skb_drop_fraglist+29/40>
  12:   52                        push   %edx
Code;  c022b22a <skb_drop_fraglist+2a/40>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

 <0>Kernel panic: Aiee, killing interrupt handler!

******************************************************

kernel 2.4.22-ac4

EIP c02518a3 refers to alloc_skb in vmlinux

Oops: 0000
CPU:    0
EIP:    0010:[<c02518a3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c525e660   ebx: 00200000   ecx: 00000000   edx: 00200000
esi: c5c97d40   edi: c5c97da0   ebp: c038ba24   esp: c034ff18
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c034f000)
Stack: c5c97d40 c025194b c5c97d40 c5c97d40 c5c97d40 c025196c c5c97d40 
c5c97d40
       c5c97d40 c0251ab4 c5c97d40 c57acd00 00000000 c0255103 c5c97d40 
c038b4c8
       00000001 fffffffd c03ac328 d3051000 c011e2cd c038b4c8 c03ac320 
c03729c0
Call Trace:    [<c025194b>] [<c025196c>] [<c0251ab4>] [<c0255103>] 
[<c011e2cd>]
  [<c010a32d>] [<c0106d70>] [<c0105000>] [<c010c7d8>] [<c0106d70>] 
[<c0105000>]
  [<c0106d9c>] [<c0106deb>] [<c0105049>]
Code: 8b 1b 8b 42 74 83 f8 01 74 0b f0 ff 4a 74 0f 94 c0 84 c0 74


>>EIP; c02518a3 <skb_drop_fraglist+17/3c>   <=====

>>eax; c525e660 <_end+4e6fe3c/14cc883c>
>>esi; c5c97d40 <_end+58a951c/14cc883c>
>>edi; c5c97da0 <_end+58a957c/14cc883c>
>>ebp; c038ba24 <softnet_data+24/3400>
>>esp; c034ff18 <init_task_union+1f18/2000>

Trace; c025194b <skb_release_data+5f/74>
Trace; c025196c <kfree_skbmem+c/68>
Trace; c0251ab4 <__kfree_skb+ec/f4>
Trace; c0255103 <net_tx_action+5f/11c>
Trace; c011e2cd <do_softirq+7d/dc>
Trace; c010a32d <do_IRQ+dd/ec>
Trace; c0106d70 <default_idle+0/34>
Trace; c0105000 <_stext+0/0>
Trace; c010c7d8 <call_do_IRQ+5/d>
Trace; c0106d70 <default_idle+0/34>
Trace; c0105000 <_stext+0/0>
Trace; c0106d9c <default_idle+2c/34>
Trace; c0106deb <cpu_idle+27/34>
Trace; c0105049 <rest_init+49/4c>

Code;  c02518a3 <skb_drop_fraglist+17/3c>
00000000 <_EIP>:
Code;  c02518a3 <skb_drop_fraglist+17/3c>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c02518a5 <skb_drop_fraglist+19/3c>
   2:   8b 42 74                  mov    0x74(%edx),%eax
Code;  c02518a8 <skb_drop_fraglist+1c/3c>
   5:   83 f8 01                  cmp    $0x1,%eax
Code;  c02518ab <skb_drop_fraglist+1f/3c>
   8:   74 0b                     je     15 <_EIP+0x15>
Code;  c02518ad <skb_drop_fraglist+21/3c>
   a:   f0 ff 4a 74               lock decl 0x74(%edx)
Code;  c02518b1 <skb_drop_fraglist+25/3c>
   e:   0f 94 c0                  sete   %al
Code;  c02518b4 <skb_drop_fraglist+28/3c>
  11:   84 c0                     test   %al,%al
Code;  c02518b6 <skb_drop_fraglist+2a/3c>
  13:   74 00                     je     15 <_EIP+0x15>

 <0>Kernel panic: Aiee, killing interrupt handler!

*****************************************************

kernel 2.4.23pre1

Oops: 0000
CPU:    0
EIP:    0010:[<c0219cd7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c40866a0   ebx: 00200000   ecx: c40866a0   edx: 00200000
esi: cec57360   edi: fffffff9   ebp: 00000046   esp: c0303f2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0303000)
Stack: cec57360 c0219d6e cec57360 cec57360 cec57360 c0219dab cec57360 
cec57360
       c0219efc cec57360 cf49cb20 c021e173 cec57360 00000003 c032c568 
c0120629
       c032c568 00000006 0000000e c0303f98 d3e02e40 c010a091 c0106f40 
c0302000
Call Trace:    [<c0219d6e>] [<c0219dab>] [<c0219efc>] [<c021e173>] 
[<c0120629>]
  [<c010a091>] [<c0106f40>] [<c010c4e8>] [<c0106f40>] [<c0106f64>] 
[<c0106fd2>]
  [<c0105000>]
Code: 8b 1b 8b 42 74 48 74 0a ff 4a 74 0f 94 c0 84 c0 74 07 52 e8


>>EIP; c0219cd7 <skb_drop_fraglist+17/40>   <=====

>>eax; c40866a0 <_end+3cf81fc/14e64bbc>
>>ecx; c40866a0 <_end+3cf81fc/14e64bbc>
>>esi; cec57360 <_end+e8c8ebc/14e64bbc>
>>esp; c0303f2c <init_task_union+1f2c/2000>

Trace; c0219d6e <skb_release_data+4e/80>
Trace; c0219dab <kfree_skbmem+b/70>
Trace; c0219efc <__kfree_skb+ec/150>
Trace; c021e173 <net_tx_action+33/a0>
Trace; c0120629 <do_softirq+99/a0>
Trace; c010a091 <do_IRQ+a1/b0>
Trace; c0106f40 <default_idle+0/30>
Trace; c010c4e8 <call_do_IRQ+5/d>
Trace; c0106f40 <default_idle+0/30>
Trace; c0106f64 <default_idle+24/30>
Trace; c0106fd2 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c0219cd7 <skb_drop_fraglist+17/40>
00000000 <_EIP>:
Code;  c0219cd7 <skb_drop_fraglist+17/40>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c0219cd9 <skb_drop_fraglist+19/40>
   2:   8b 42 74                  mov    0x74(%edx),%eax
Code;  c0219cdc <skb_drop_fraglist+1c/40>
   5:   48                        dec    %eax
Code;  c0219cdd <skb_drop_fraglist+1d/40>
   6:   74 0a                     je     12 <_EIP+0x12>
Code;  c0219cdf <skb_drop_fraglist+1f/40>
   8:   ff 4a 74                  decl   0x74(%edx)
Code;  c0219ce2 <skb_drop_fraglist+22/40>
   b:   0f 94 c0                  sete   %al
Code;  c0219ce5 <skb_drop_fraglist+25/40>
   e:   84 c0                     test   %al,%al
Code;  c0219ce7 <skb_drop_fraglist+27/40>
  10:   74 07                     je     19 <_EIP+0x19>
Code;  c0219ce9 <skb_drop_fraglist+29/40>
  12:   52                        push   %edx
Code;  c0219cea <skb_drop_fraglist+2a/40>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

 <0>Kernel panic: Aiee, killing interrupt handler!

############################################################### 

6) shell script: 
no way 

############################################################### 

7) environment:
Dell Optiplex GX1 400MTbr+, Intel II 400 MHz, 320 MB RAM
Adaptec AHA 2940UW as PCI-adapter with two hard drives (20GB and 4GB, 
/boot is on the first scsi-drive) and a Plextor CD-writer
onboard LAN (3com)
Promise Ultra133 TX2 as PCI-adapter with two Maxtor-drives (each 
120GB)
DVD-ROM at the onboard-IDE 

############################################################### 

7.1) ver_linux:

Linux server01 2.4.20-4GB #1 Wed Aug 6 18:26:21 UTC 2003 i686 unknown 
unknown GNU/Linux
 
Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.28
jfsutils               1.1.1
Linux C Library        x    1 root     root      1475331 Mar 27 21:39 
/lib/libc.so.6
Dynamic linker (ldd)   2.3.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.06
Sh-utils               4.5.8
Modules Loaded         isa-pnp usbserial parport_pc lp parport ipv6 
nfsd autofs st sr_mod sg mousedev joydev evdev input usb-uhci usbcore 
raw1394 ieee1394 3c59x ide-cd cdrom lvm-mod raid1 reiserfs aic7xxx

*******************************************************************

Linux server01 2.4.22-ac4 #2 SMP Sat Oct 11 00:22:06 CEST 2003 i686 
unknown unknown GNU/Linux
 
Gnu C                  2.95.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.28
jfsutils               1.1.1
Linux C Library        x    1 root     root      1475331 Mar 27  2003 
/lib/libc.so.6
Dynamic linker (ldd)   2.3.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.06
Sh-utils               4.5.8
Modules Loaded         st sr_mod sg parport_pc lp parport mousedev 
input 3c59x loop lvm-mod md

******************************************************************

Linux server01 2.4.23pre1-usbtest #1 Wed Aug 27 19:43:12 UTC 2003 
i686 unknown unknown GNU/Linux
 
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.28
jfsutils               1.1.1
Linux C Library        x    1 root     root      1475331 Mar 27 21:39 
/lib/libc.so.6
Dynamic linker (ldd)   2.3.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.06
Sh-utils               4.5.8
Modules Loaded         isa-pnp usbserial ipv6 nfsd autofs st sr_mod 
sg mousedev joydev evdev input usb-uhci usbcore raw1394 ieee1394 
3c59x ide-cd cdrom lvm-mod raid1 reiserfs aic7xxx

############################################################### 

7.2) cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 398.780
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips	: 796.26

############################################################### 

7.3) modules:

kernel 2.4.20

usbserial              18460   0 (autoclean) (unused)
parport_pc             25800   1 (autoclean)
lp                      6240   0 (autoclean)
parport                22440   1 (autoclean) [parport_pc lp]
ipv6                  134516  -1 (autoclean)
nfsd                   75536   4 (autoclean)
autofs                  9268   1 (autoclean)
st                     27956   0 (autoclean) (unused)
sr_mod                 12600   0 (autoclean)
sg                     25852   0 (autoclean)
mousedev                4148   0 (unused)
joydev                  5632   0 (unused)
evdev                   4032   0 (unused)
input                   3104   0 [mousedev joydev evdev]
usb-uhci               22096   0 (unused)
usbcore                57836   1 [usbserial usb-uhci]
raw1394                14516   0 (unused)
ieee1394               32880   0 [raw1394]
3c59x                  26064   1
ide-cd                 29404   0 (autoclean)
cdrom                  28192   0 (autoclean) [sr_mod ide-cd]
lvm-mod                65412  10 (autoclean)
raid1                  12944   1 (autoclean)
reiserfs              200532   4
aic7xxx               159940   6

*************************************************************

kernel 2.4.22-ac4

st                     27148   0 (autoclean) (unused)
sr_mod                 11664   0 (autoclean)
sg                     24956   0 (autoclean)
parport_pc             21160   1 (autoclean)
lp                      6048   0 (autoclean)
parport                25952   1 (autoclean) [parport_pc lp]
mousedev                3864   0 (unused)
input                   3456   0 [mousedev]
3c59x                  25776   1
loop                    8600   0 (autoclean)
lvm-mod                44864   1 (autoclean)
md                     42816   0 (autoclean)

************************************************************

kernel 2.4.23pre1

isa-pnp                30180   0 (unused)
usbserial              18332   0 (autoclean) (unused)
ipv6                  161172  -1 (autoclean)
nfsd                   65808   4 (autoclean)
autofs                 10100   1 (autoclean)
st                     27564   0 (autoclean) (unused)
sr_mod                 14680   0 (autoclean)
sg                     26540   0 (autoclean)
mousedev                4084   0 (unused)
joydev                  5728   0 (unused)
evdev                   4384   0 (unused)
input                   3328   0 [mousedev joydev evdev]
usb-uhci               21772   0 (unused)
usbcore                57664   1 [usbserial usb-uhci]
raw1394                17108   0 (unused)
ieee1394               42660   0 [raw1394]
3c59x                  26864   1
ide-cd                 30112   0 (autoclean)
cdrom                  26560   0 (autoclean) [sr_mod ide-cd]
lvm-mod                56192   6 (autoclean)
raid1                  12748   1 (autoclean)
reiserfs              182992   4
aic7xxx               139948   5

############################################################### 

7.4) ioports, iomem:

kernel 2.4.20

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f8-03ff : serial(auto)
0800-083f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0840-085f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0cf8-0cff : PCI conf1
cc00-cc7f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  cc00-cc7f : 00:11.0
cca0-ccaf : Promise Technology, Inc. 20269
  cca0-cca7 : ide0
  cca8-ccaf : ide2
ccb8-ccbb : Promise Technology, Inc. 20269
  ccba-ccba : ide2
ccc0-ccc7 : Promise Technology, Inc. 20269
  ccc0-ccc7 : ide2
ccd0-ccd3 : Promise Technology, Inc. 20269
  ccd2-ccd2 : ide0
ccd8-ccdf : Promise Technology, Inc. 20269
  ccd8-ccdf : ide0
cce0-ccff : Intel Corp. 82371AB/EB/MB PIIX4 USB
  cce0-ccff : usb-uhci
d000-dfff : PCI Bus #02
  d800-d8ff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
    d800-d8ff : aic7xxx
  dc00-dcff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
    dc00-dcff : aic7xxx
e000-efff : PCI Bus #01
  ec00-ecff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
ffa0-ffaf : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  ffa8-ffaf : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000d0000-000d7fff : Extension ROM
000d8000-000da7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-13ffffff : System RAM
  00100000-00288dd5 : Kernel code
  00288dd6-003189c3 : Kernel data
f0000000-f3ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge
f5000000-f5ffffff : PCI Bus #02
f6000000-f6ffffff : PCI Bus #01
fa000000-fbffffff : PCI Bus #02
  faffe000-faffefff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
    faffe000-faffefff : aic7xxx
  fafff000-faffffff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
    fafff000-faffffff : aic7xxx
fc000000-feffffff : PCI Bus #01
  fcfff000-fcffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
  fd000000-fdffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
    fd000000-fd3fffff : vesafb
ff000000-ff003fff : Promise Technology, Inc. 20269
ff004000-ff00407f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ffe00000-ffffffff : reserved

*******************************************************************

kernel 2.4.22-ac4

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f8-03ff : serial(auto)
0800-083f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
  0800-083f : PnPBIOS PNP0c01
0840-085f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
  0850-085f : PnPBIOS PNP0c01
0cf8-0cff : PCI conf1
cc00-cc7f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  cc00-cc7f : 00:11.0
cca0-ccaf : Promise Technology, Inc. 20269
  cca0-cca7 : ide2
  cca8-ccaf : ide3
ccb8-ccbb : Promise Technology, Inc. 20269
  ccba-ccba : ide3
ccc0-ccc7 : Promise Technology, Inc. 20269
  ccc0-ccc7 : ide3
ccd0-ccd3 : Promise Technology, Inc. 20269
  ccd2-ccd2 : ide2
ccd8-ccdf : Promise Technology, Inc. 20269
  ccd8-ccdf : ide2
cce0-ccff : Intel Corp. 82371AB/EB/MB PIIX4 USB
  cce0-ccff : usb-uhci
d000-dfff : PCI Bus #02
  d800-d8ff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
  dc00-dcff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
e000-efff : PCI Bus #01
  ec00-ecff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
ffa0-ffaf : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  ffa8-ffaf : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000d0000-000d7fff : Extension ROM
000d8000-000da7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-13ffffff : System RAM
  00100000-002a1705 : Kernel code
  002a1706-0034d71f : Kernel data
f0000000-f3ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge
f5000000-f5ffffff : PCI Bus #02
f6000000-f6ffffff : PCI Bus #01
fa000000-fbffffff : PCI Bus #02
  faffe000-faffefff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
    faffe000-faffefff : aic7xxx
  fafff000-faffffff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
    fafff000-faffffff : aic7xxx
fc000000-feffffff : PCI Bus #01
  fcfff000-fcffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
    fcfff000-fcffffff : atyfb
  fd000000-fdffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
    fd000000-fdffffff : atyfb
ff000000-ff003fff : Promise Technology, Inc. 20269
ff004000-ff00407f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ffe00000-ffffffff : reserved

**********************************************************************

kernel 2.4.23pre1

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vesafb
03f8-03ff : serial(auto)
0800-083f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0840-085f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0cf8-0cff : PCI conf1
cc00-cc7f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  cc00-cc7f : 00:11.0
cca0-ccaf : Promise Technology, Inc. 20269
  cca0-cca7 : ide0
  cca8-ccaf : ide2
ccb8-ccbb : Promise Technology, Inc. 20269
  ccba-ccba : ide2
ccc0-ccc7 : Promise Technology, Inc. 20269
  ccc0-ccc7 : ide2
ccd0-ccd3 : Promise Technology, Inc. 20269
  ccd2-ccd2 : ide0
ccd8-ccdf : Promise Technology, Inc. 20269
  ccd8-ccdf : ide0
cce0-ccff : Intel Corp. 82371AB/EB/MB PIIX4 USB
  cce0-ccff : usb-uhci
d000-dfff : PCI Bus #02
  d800-d8ff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
  dc00-dcff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
e000-efff : PCI Bus #01
  ec00-ecff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
ffa0-ffaf : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  ffa8-ffaf : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000d0000-000d7fff : Extension ROM
000d8000-000da7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-13ffffff : System RAM
  00100000-002700a5 : Kernel code
  002700a6-00301703 : Kernel data
f0000000-f3ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge
f5000000-f5ffffff : PCI Bus #02
f6000000-f6ffffff : PCI Bus #01
fa000000-fbffffff : PCI Bus #02
  faffe000-faffefff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
    faffe000-faffefff : aic7xxx
  fafff000-faffffff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
    fafff000-faffffff : aic7xxx
fc000000-feffffff : PCI Bus #01
  fcfff000-fcffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
    fcfff000-fcffffff : atyfb
  fd000000-fdffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
    fd000000-fdffffff : atyfb
ff000000-ff003fff : Promise Technology, Inc. 20269
ff004000-ff00407f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ffe00000-ffffffff : reserved

############################################################### 

7.5) PCI:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
 FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP 
bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fc000000-feffffff
	Prefetchable memory behind bridge: f6000000-f6ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 14
	Region 4: I/O ports at cce0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 
20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ccd8 [size=8]
	Region 1: I/O ports at ccd0 [size=4]
	Region 2: I/O ports at ccc0 [size=8]
	Region 3: I/O ports at ccb8 [size=4]
	Region 4: I/O ports at cca0 [size=16]
	Region 5: Memory at ff000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at f9000000 [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 
03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fa000000-fbffffff
	Prefetchable memory behind bridge: 00000000f5000000-00000000f5f00000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX 
[Cyclone] (rev 24)
	Subsystem: Dell Computer Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at cc00 [size=128]
	Region 1: Memory at ff004000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at f9000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 
AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation Optiplex GX1 Onboard Display 
Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at ec00 [size=256]
	Region 2: Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

02:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / 
AIC-7895 (rev 03)
	Subsystem: Adaptec AHA-2940U/2940UW Dual
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at dc00 [disabled] [size=256]
	Region 1: Memory at fafff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fb000000 [disabled] [size=64K]

02:0a.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / 
AIC-7895 (rev 03)
	Subsystem: Adaptec AHA-2940U/2940UW Dual
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at d800 [disabled] [size=256]
	Region 1: Memory at faffe000 (32-bit, non-prefetchable) [size=4K]

############################################################### 

7.6) scsi:
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DPSS-318350N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: VIKING II 4.5WLS Rev: 5520
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02

############################################################### 

7.7) other: 
/proc/ide:
ide-cdrom version 4.59-ac1
ide-disk version 1.18
ide-default version 0.9.newide

                                Ultra133 TX2 Chipset.

Controller: 0

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel ---
----------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- 
drive1 ------
DMA enabled:    no               no              yes               no 

UDMA enabled:   no               no              yes               no 

UDMA enabled:   X                X               2                 X
UDMA
DMA
PIO

/proc/interrupts:
           CPU0       
  0:      77091          XT-PIC  timer
  1:        599          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
 10:         14          XT-PIC  aic7xxx
 11:     429715          XT-PIC  ide0, ide2
 12:         32          XT-PIC  PS/2 Mouse
 14:       7926          XT-PIC  aic7xxx, eth0, usb-uhci
 15:         27          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          1
MIS:          0

Reiser FS:
reiserfsck 3.6.4 (2002 www.namesys.com)

Samba:
Version 2.2.8a-SuSE

###############################################################


Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

