Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWGNTTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWGNTTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161284AbWGNTTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:19:00 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:29749 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1161058AbWGNTTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:19:00 -0400
Date: Fri, 14 Jul 2006 15:18:58 -0400
From: Michael Lindner <mikell@optonline.net>
Subject: PROBLEM: epoll_wait() returns wrong events for EOF with EPOLLOUT
To: linux-kernel@vger.kernel.org
Message-id: <200607141518.58635.mikell@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
	epoll_wait() returns wrong events for EOF with EPOLLOUT

[2.] Full description of the problem/report:
	If a program is waiting in epoll_wait() for EPOLLOUT event on a
	socket and the socket is closed, epoll_wait() returns EPOLLHUP|EPOLLERR,
	but *not* EPOLLOUT.

	This differs from the expected behavior in several ways:

	1. epoll_wait is not returning the events it was told to wait for.
	    Why not return EPOLLOUT? select() returns an FD as writable on EOF.
 	2. epoll_wait() is returning events it was not told to wait for.
 	3. EPOLLHUP is not returned if EPOLLIN was requested, why
	   do so on EPOLLOUT?
	4. There has been no error on the FD, so why return EPOLLERR?

	Also a minor issue - epoll_ctl doesn't check if the fd in events.data.fd
	is the same as the fd that's been passed in as argument 3. If they differ
	(due to programmer error), epoll_wait will return an event with the
	incorrect events.data.fd specified to epoll_ctl().

[3.] kernel

[4.] Kernel version (from /proc/version): Linux version 2.6.17.4 (root@self) 
(gcc version 3.3.4 (Mandrakelinux 10.1 3.3.4-2mdk)) #1 Fri Jul 14 13:55:58 
EDT 2006

[5.] Output of Oops.. message (if applicable)

[6.] A small shell script or example program which triggers the
     problem (if possible)
	C program attached.
	When run it listens on a specified port. Connect to the port
	with telnet, then quit out of telnet.

[7.] Environment 

[7.1.] Software (add the output of the ver_linux script here)

Linux self 2.6.17.4 #1 Fri Jul 14 13:55:58 EDT 2006 i686 Unknown CPU Typ 
unknown GNU/Linux
 
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.17
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   030
Modules Loaded         sr_mod binfmt_misc eeprom w83l785ts asb100 hwmon_vid 
i2c_nforce2 i2c_core ipv6 snd_pcm_oss snd_mixer_oss snd_cs46xx gameport 
snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd 
soundcore snd_page_alloc ppp_async ppp_generic slhc crc_ccitt af_packet 
floppy forcedeth ide_cd cdrom loop nvidia_agp agpgart usblp usb_storage 
scsi_mod ehci_hcd ohci_hcd usbcore reiserfs raid1


[7.2.] Processor information (from /proc/cpuinfo): 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : Unknown CPU Typ
stepping        : 0
cpu MHz         : 2305.465
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow up ts fid vid
bogomips        : 4615.59

[7.3.] Module information (from /proc/modules):
sr_mod 15076 0 - Live 0xf8c5b000
binfmt_misc 8840 1 - Live 0xf8d3e000
eeprom 5520 0 - Live 0xf8d3b000
w83l785ts 5648 0 - Live 0xf8cb6000
asb100 21652 0 - Live 0xf8d2e000
hwmon_vid 2624 1 asb100, Live 0xf8848000
i2c_nforce2 5824 0 - Live 0xf8b4c000
i2c_core 17104 4 eeprom,w83l785ts,asb100,i2c_nforce2, Live 0xf8d35000
ipv6 233376 31 - Live 0xf8d72000
snd_pcm_oss 39520 0 - Live 0xf8d0d000
snd_mixer_oss 16576 1 snd_pcm_oss, Live 0xf8d07000
snd_cs46xx 81352 0 - Live 0xf8d19000
gameport 11208 1 snd_cs46xx, Live 0xf8cb2000
snd_rawmidi 19616 1 snd_cs46xx, Live 0xf8cfb000
snd_seq_device 6604 1 snd_rawmidi, Live 0xf8b41000
snd_ac97_codec 92640 1 snd_cs46xx, Live 0xf8cce000
snd_ac97_bus 1920 1 snd_ac97_codec, Live 0xf887e000
snd_pcm 78088 3 snd_pcm_oss,snd_cs46xx,snd_ac97_codec, Live 0xf8ce6000
snd_timer 20228 1 snd_pcm, Live 0xf8cba000
snd 45412 8 
snd_pcm_oss,snd_mixer_oss,snd_cs46xx,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer, 
Live 0xf8cc1000
soundcore 7328 1 snd, Live 0xf8b3b000
snd_page_alloc 8200 2 snd_cs46xx,snd_pcm, Live 0xf8ca6000
ppp_async 8768 0 - Live 0xf8ca2000
ppp_generic 23636 1 ppp_async, Live 0xf8cab000
slhc 6208 1 ppp_generic, Live 0xf8b3e000
crc_ccitt 1792 1 ppp_async, Live 0xf884c000
af_packet 16328 2 - Live 0xf8b2d000
floppy 56196 0 - Live 0xf8c71000
forcedeth 25676 0 - Live 0xf8b44000
ide_cd 37124 0 - Live 0xf8c50000
cdrom 38304 2 sr_mod,ide_cd, Live 0xf8c45000
loop 13448 0 - Live 0xf8b28000
nvidia_agp 6172 1 - Live 0xf883c000
agpgart 29040 1 nvidia_agp, Live 0xf8b32000
usblp 11456 0 - Live 0xf8856000
usb_storage 65280 0 - Live 0xf8b6e000
scsi_mod 122504 2 sr_mod,usb_storage, Live 0xf8b4f000
ehci_hcd 27720 0 - Live 0xf884e000
ohci_hcd 18820 0 - Live 0xf883f000
usbcore 116672 5 usblp,usb_storage,ehci_hcd,ohci_hcd, Live 0xf885b000
reiserfs 258548 1 - Live 0xf8a56000
raid1 19264 1 - Live 0xf8814000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
5000-5007 : nForce2_smbus
5500-5507 : nForce2_smbus
9000-afff : PCI Bus #01
  9000-9007 : 0000:01:0a.0
    9000-9007 : ide2
  9400-9403 : 0000:01:0a.0
    9402-9402 : ide2
  9800-9807 : 0000:01:0a.0
    9800-9807 : ide3
  9c00-9c03 : 0000:01:0a.0
    9c02-9c02 : ide3
  a000-a00f : 0000:01:0a.0
    a000-a007 : ide2
    a008-a00f : ide3
b000-b007 : 0000:00:04.0
  b000-b007 : forcedeth
b400-b4ff : 0000:00:06.0
b800-b87f : 0000:00:06.0
c400-c41f : 0000:00:01.1
f000-f00f : 0000:00:09.0
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000d0000-000d17ff : Adapter ROM
000d2000-000d47ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-002ff480 : Kernel code
  002ff481-003a1c0f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
50000000-500fffff : PCI Bus #01
  50000000-50003fff : 0000:01:0a.0
d0000000-d7ffffff : PCI Bus #02
  d0000000-d7ffffff : 0000:02:00.0
    d0000000-d7ffffff : vesafb
d8000000-dbffffff : 0000:00:00.0
dc000000-ddffffff : PCI Bus #02
  dc000000-dcffffff : 0000:02:00.0
  dd000000-dd01ffff : 0000:02:00.0
de000000-dfffffff : PCI Bus #01
  df000000-df003fff : 0000:01:0a.0
e0000000-e0000fff : 0000:00:04.0
  e0000000-e0000fff : forcedeth
e0001000-e0001fff : 0000:00:06.0
e0003000-e0003fff : 0000:00:02.0
  e0003000-e0003fff : ohci_hcd
e0004000-e0004fff : 0000:00:02.1
  e0004000-e0004fff : ohci_hcd
e0005000-e00050ff : 0000:00:02.2
  e0005000-e00050ff : ehci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

lots of stuff here - do you really need it?

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:

[7.7.] Other information that might be relevant to the problem

[X.] Other notes, patches, fixes, workarounds:

-- 
Michael Lindner
