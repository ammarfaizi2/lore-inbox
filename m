Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSILSus>; Thu, 12 Sep 2002 14:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317017AbSILSus>; Thu, 12 Sep 2002 14:50:48 -0400
Received: from [213.4.129.129] ([213.4.129.129]:39224 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id <S317030AbSILSup>;
	Thu, 12 Sep 2002 14:50:45 -0400
Date: Thu, 12 Sep 2002 20:48:23 +0200
From: Arador <diegocg@teleline.es>
To: alsa-devel@alsa-project.org
Cc: gstalusan@uwaterloo.ca, linux-kernel@vger.kernel.org
Subject: ALSA bug, isa cmi8330
Message-Id: <20020912204823.1e1fc19a.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please cc me)
Hi. I've a isa cmi8330 card, and it seems it doesn't works
corrrectly. Looking at the code I've found that __ISAPNP__
is *never* defined (regardless of being bulilt-in or as a
module). So I've done the same that other devices under
sound/isa/, I've applied the following patch:

--- cmi8330.c.broken	Thu Sep 12 16:39:04 2002
+++ cmi8330.c	Thu Sep 12 16:39:10 2002
@@ -46,6 +46,11 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#ifndef LINUX_ISAPNP_H
+#include <linux/isapnp.h>
+#define isapnp_card pci_bus
+#define isapnp_dev pci_dev
+#endif
 #include <sound/core.h>
 #include <sound/ad1848.h>
 #include <sound/sb.h>


Now the driver compiles and should work correctly.
btw, when i do a modprobe snd-cmi8330 it seems that the driver
doesn't recognize the isapnp data, and i've to set the values
myself with parameters:

root@diego:~# modprobe snd-cmi8330
ALSA cmi8330.c:272: CMI8330/C3D (SB16) PnP configure failure
ALSA cmi8330.c:344: PnP detection failed
CMI8330 not found or device busy
/lib/modules/2.5.34/kernel/sound/isa/snd-cmi8330.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.5.34/kernel/sound/isa/snd-cmi8330.o: insmod /lib/modules/2.5.34/kernel/sound/isa/snd-cmi8330.o failed
/lib/modules/2.5.34/kernel/sound/isa/snd-cmi8330.o: insmod snd-cmi8330 failed
root@diego:~#

Well, this is no annoying, the annoying
thing ;) is that output when i modprobe the module with the correct
values:

root@diego:~# modprobe snd-cmi8330 snd_wssport=0x530 snd_wssirq=9 snd_wssdma=0 snd_sbport=0x220 snd_sbirq=5 snd_sbdma8=1 snd_sbdma16=5
AD1848 REGS:      INDEX = 0x40                   STATUS = 0xcc
  0x00: left input      = 0x00    0x08: playback format = 0x00
  0x01: right input     = 0x00    0x09: iface (CFIG 1)  = 0x08
  0x02: AUXA left       = 0x80    0x0a: pin control     = 0x00
  0x03: AUXA right      = 0x80    0x0b: init & status   = 0x20
  0x04: AUXB left       = 0x80    0x0c: revision & mode = 0x0a
  0x05: AUXB right      = 0x80    0x0d: loopback        = 0x00
  0x06: left output     = 0x80    0x0e: data upr count  = 0x00
  0x07: right output    = 0x80    0x0f: data lwr count  = 0x00
ALSA sb_common.c:131: SB [0x220]: DSP chip found, version = 4.13
Unable to handle kernel paging request at virtual address 40015000
 printing eip:
4009ad65
*pde = 013f1067
*pte = 00000000
Oops: 0006
CPU:    0
EIP:    0023:[<4009ad65>]    Not tainted
EFLAGS: 00010203
eax: 00000fd2   ebx: 4013de48   ecx: 000003f4   edx: 080a9e68
esi: bfffb0d4   edi: 40015000   ebp: bfffafcc   esp: bfffafc4
ds: 002b   es: 002b   ss: 002b
Process modprobe (pid: 2307, threadinfo=c125c000 task=c14726a0)
 <6>note: modprobe[2307] exited with preempt_count 1
Violación de segmento
(That's segmentation fault)



Now the module is loaded, i can unload it without problems,
and it repeats when i try again, but it adds lines like those:

modprobe: page allocation failure. order:4, mode:0x21
modprobe: page allocation failure. order:3, mode:0x21
modprobe: page allocation failure. order:4, mode:0x21
modprobe: page allocation failure. order:3, mode:0x21

after/before the "ALSA sb_common.c:131: SB [0x220]: DSP chip found, version = 4.13"

If it helps, the /proc/interrupt and /proc/ioports for the module are there when it's loaded.


The oops decoded:
ksymoops 2.4.5 on i686 2.5.34.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.34/ (default)
     -m /boot/System.map-2.5.34 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 40015000
4009ad65
*pde = 013f1067
Oops: 0006
CPU:    0
EIP:    0023:[<4009ad65>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: 00000fd2   ebx: 4013de48   ecx: 000003f4   edx: 080a9e68
esi: bfffb0d4   edi: 40015000   ebp: bfffafcc   esp: bfffafc4
ds: 002b   es: 002b   ss: 002b
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; 4009ad65 Before first symbol   <=====

>>eax; 00000fd2 Before first symbol
>>ebx; 4013de48 Before first symbol
>>edx; 080a9e68 Before first symbol
>>esi; bfffb0d4 Before first symbol
>>edi; 40015000 Before first symbol
>>ebp; bfffafcc Before first symbol
>>esp; bfffafc4 Before first symbol


2 warnings issued.  Results may not be reliable.


Diego Calleja
