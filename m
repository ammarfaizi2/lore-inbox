Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWGNPrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWGNPrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 11:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWGNPrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 11:47:04 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.4.198]:41590 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1161134AbWGNPrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 11:47:03 -0400
Date: Fri, 14 Jul 2006 11:46:52 -0400
From: Michael Lindner <mikell@optonline.net>
Subject: PROBLEM: close(fd) doesn't wake up read(fd) or select() in another
 thread
To: linux-kernel@vger.kernel.org
Message-id: <200607141146.52908.mikell@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
	close(fd) doesn't wake up read(fd) or select() in another thread

[2.] Full description of the problem/report:
	In a multithreaded program, if a thread closes a file descriptor
	that another thread is reading from or selecting on, the thread
	doing the read() or select() does not see an EOF and does not
	rerturn.

	The context is a piece of code that farms work out to multiple
	worker threads via a pipe to each worker. When the main thread
	wants to shut down, it closes the pipes and joins the other threads.
	This code worked on Solaris 2.7, 8, & 9, but failed when we switched
	to Linux.

	In tests, the same behavior happens with other types of file
	descriptors (sockets and console - I did not test with a disk file
	for the obvious reason that the speed of a read would make
	the test very timing critical).

[3.] kernel

[4.] Kernel version (from /proc/version): Linux version 2.6.11-w4l (root@self) 
(gcc version 3.3.4 (Mandrakelinux 10.1 3.3.4-2mdk)) #2 Thu Nov 3 15:44:07 EST 
2005

[5.] Output of Oops.. message (if applicable)

[6.] A small shell script or example program which triggers the
     problem (if possible)

/*
 * Compile with:
 * 
 * gcc -o threadbug threadbug.c -lpthread
 * 
 * This code illustrates that then a thread reads from a file descriptor
 * and the file descriptor is closed by another thread, the read() never
 * returns. The same behavior happens with select().
 *
 * N.B. If the file descriptor is a socket and you call shutdown() for
 * reading, the read() does return.
 *
 */

#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>

void*
func(void* v)
{
    int n;
    char c;
    fprintf(stderr, "in thread function, reading from fd %d\n", 0);
    n = read(0, &c, 1);
    fprintf(stderr, "read returned %d\n", n);
}

main()
{
    pthread_t tid;
    pthread_create(&tid, 0, func, 0);
    sleep(2);
    fprintf(stderr, "in main thread closing fd %d\n", 0);
    close(0);
    fprintf(stderr, "in main thread waiting for thread function to return\n");
    fprintf(stderr, "...but it never will...\n");
    pthread_join(tid, 0);
}

[7.] Environment 

[7.1.] Software (add the output of the ver_linux script here)
Linux self 2.6.11-w4l #2 Thu Nov 3 15:44:07 EST 2005 i686 Unknown CPU Typ 
unknown GNU/Linux
 
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.17
reiser4progs           line
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   030
Modules Loaded         nls_iso8859_1 nls_cp850 vfat fat sd_mod tun sr_mod 
binfmt_misc eeprom w83l785ts asb100 i2c_sensor i2c_nforce2 i2c_core Win4Lin 
mki_adapter md5 ipv6 snd_pcm_oss snd_mixer_oss snd_cs46xx snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc 
gameport ppp_async ppp_generic slhc crc_ccitt af_packet floppy forcedeth 
ide_cd cdrom loop nvidia_agp agpgart usblp usb_storage scsi_mod ehci_hcd 
ohci_hcd usbcore reiserfs raid1

[7.2.] Processor information (from /proc/cpuinfo): 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : Unknown CPU Typ
stepping        : 0
cpu MHz         : 2305.674
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
pse36 mmx fxsr sse pni syscall mp mmxext 3dnowext 3dnow
bogomips        : 4571.13

[7.3.] Module information (from /proc/modules):
nls_iso8859_1 3840 0 - Live 0xf8caf000
nls_cp850 4608 0 - Live 0xf8d4b000
vfat 10880 0 - Live 0xf8b3a000
fat 35612 1 vfat, Live 0xf8d64000
sd_mod 15504 0 - Live 0xf8d53000
tun 8704 0 - Live 0xf8d1a000
sr_mod 15076 0 - Live 0xf8d4e000
binfmt_misc 8840 1 - Live 0xf8d16000
eeprom 5712 0 - Live 0xf8d13000
w83l785ts 5716 0 - Live 0xf8d09000
asb100 22036 0 - Live 0xf8d41000
i2c_sensor 2880 3 eeprom,w83l785ts,asb100, Live 0xf887e000
i2c_nforce2 5440 0 - Live 0xf8d06000
i2c_core 17808 5 eeprom,w83l785ts,asb100,i2c_sensor,i2c_nforce2, Live 
0xf8d0d000
Win4Lin 292936 1 - Live 0xf8e14000
mki_adapter 37736 1 Win4Lin, Live 0xf8cd2000
md5 3776 1 - Live 0xf8b4b000
ipv6 230848 29 - Live 0xf8d84000
snd_pcm_oss 48096 0 - Live 0xf8d34000
snd_mixer_oss 17088 1 snd_pcm_oss, Live 0xf8ccc000
snd_cs46xx 82056 0 - Live 0xf8d1e000
snd_rawmidi 19552 1 snd_cs46xx, Live 0xf8cc6000
snd_seq_device 6924 1 snd_rawmidi, Live 0xf8c5c000
snd_ac97_codec 73656 1 snd_cs46xx, Live 0xf8cf3000
snd_pcm 80200 3 snd_pcm_oss,snd_cs46xx,snd_ac97_codec, Live 0xf8cde000
snd_timer 20484 1 snd_pcm, Live 0xf8cb1000
snd 46436 8 
snd_pcm_oss,snd_mixer_oss,snd_cs46xx,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer, 
Live 0xf8cb9000
soundcore 7136 1 snd, Live 0xf8c59000
snd_page_alloc 7556 2 snd_cs46xx,snd_pcm, Live 0xf8c56000
gameport 3520 1 snd_cs46xx, Live 0xf8859000
ppp_async 9216 0 - Live 0xf8c52000
ppp_generic 24532 1 ppp_async, Live 0xf8ca2000
slhc 6720 1 ppp_generic, Live 0xf8b3e000
crc_ccitt 1728 1 ppp_async, Live 0xf887c000
af_packet 16328 2 - Live 0xf8c4d000
floppy 53904 0 - Live 0xf8c71000
forcedeth 15872 0 - Live 0xf8b35000
ide_cd 36228 0 - Live 0xf8c43000
cdrom 36320 2 sr_mod,ide_cd, Live 0xf8b41000
loop 12616 0 - Live 0xf8b30000
nvidia_agp 5916 1 - Live 0xf8876000
agpgart 28136 1 nvidia_agp, Live 0xf8b28000
usblp 10752 0 - Live 0xf884d000
usb_storage 66304 0 - Live 0xf8b6b000
scsi_mod 115016 3 sd_mod,sr_mod,usb_storage, Live 0xf8b4d000
ehci_hcd 27848 0 - Live 0xf8851000
ohci_hcd 18696 0 - Live 0xf8842000
usbcore 105592 5 usblp,usb_storage,ehci_hcd,ohci_hcd, Live 0xf885b000
reiserfs 258932 1 - Live 0xf8a56000
raid1 13824 1 - Live 0xf8815000

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
0cf8-0cff : PCI conf1
5000-5007 : nForce2 SMBus
5500-5507 : nForce2 SMBus
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
  00100000-002d6d22 : Kernel code
  002d6d23-0036733f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #02
  d0000000-d7ffffff : 0000:02:00.0
    d0000000-d7ffffff : vesafb
d8000000-dbffffff : 0000:00:00.0
dc000000-ddffffff : PCI Bus #02
  dc000000-dcffffff : 0000:02:00.0
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
