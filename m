Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLAQjs>; Fri, 1 Dec 2000 11:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLAQjh>; Fri, 1 Dec 2000 11:39:37 -0500
Received: from nread2.inwind.it ([212.141.53.75]:34526 "EHLO relay4.inwind.it")
	by vger.kernel.org with ESMTP id <S129226AbQLAQj2> convert rfc822-to-8bit;
	Fri, 1 Dec 2000 11:39:28 -0500
From: Roberto Ragusa <robertoragusa@technologist.com>
To: linux-kernel@vger.kernel.org
CC: Roberto Ragusa <robertoragusa@technologist.com>
Date: Fri, 01 Dec 2000 16:50:49 +0200
Message-ID: <yam8370.2457.159377448@a4000>
X-Mailer: YAM 2.1 [060] AmigaOS E-Mail Client (c) 1995-2000 by Marcel Beck  http://www.yam.ch
Subject: kernel panic in SoftwareRAID autodetection
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC to me because I'm not a LKML subscriber.

Hi,

I found a real showstopper problem in the SoftwareRAID autodetect
code; 2.4.0-test10 and 2.4.0-test11 are affected (I didn't test
previous versions).

I'm using two IDE disk with some RAIDed partitions:

  md5 : active raid0 hdc5[1] hda5[0] 2056064 blocks 32k chunks
  md6 : active raid0 hdc6[1] hda6[0] 1027968 blocks 32k chunks
  md7 : active raid0 hdc7[1] hda7[0] 634752 blocks 32k chunks
  md8 : active raid0 hdc8[1] hda8[0] 1027968 blocks 32k chunks
  md9 : active raid0 hdc9[1] hda9[0] 2237568 blocks 32k chunks
  md10 : active raid0 hdc10[1] hda10[0] 60288 blocks 32k chunks
  md11 : active linear hdc13[3] hdc11[1] hda13[2] hda11[0] 422912 blocks 32k rounding

that is 6 of them are RAID0 and 1 is RAIDlinear.

I compiled the 2.4.0-test11 kernel on a RH7.0 installation (using kgcc),
with the following options:

  CONFIG_MD=y
  CONFIG_BLK_DEV_MD=y
  CONFIG_MD_LINEAR=y
  CONFIG_MD_RAID0=y
  CONFIG_MD_RAID1=y
  CONFIG_MD_RAID5=m
  # CONFIG_MD_BOOT is not set
  CONFIG_AUTODETECT_RAID=y
  # CONFIG_BLK_DEV_LVM is not set
  # CONFIG_LVM_PROC_FS is not set

but when I try to boot the kernel panics during the RAID autodetect phase
(without autodetection it seems OK). Tried many times, not a random problem.
So I used "console=ttyS0" to grab the output and I found it is booting
without errors (!). Tried many times.
I had to hand copy the text from the screen to this mail.

This is what I see when everything is OK (serial console grab):

  Linux version 2.4.0-test11 (root@linux86.end) (gcc version egcs-2.91.66 19990314
  /Linux (egcs-1.1.2 release)) #1 Fri Dec 1 12:27:42 CET 2000
[...]
  Partition check:
   hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda
  14 >
   hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 hdc11 hdc12 hdc13 hdc
  14 >
   hdd: hdd1 hdd2 hdd3 hdd4
[...]
  md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
  linear personality registered
  raid0 personality registered
  raid1 personality registered
  md.c: sizeof(mdp_super_t) = 4096
  autodetecting RAID arrays
  (read) hda5's sb offset: 1028032 [events: 00000ace]
  (read) hda6's sb offset: 513984 [events: 00000aca]
  (read) hda7's sb offset: 317376 [events: 00000aca]
  (read) hda8's sb offset: 513984 [events: 00000aca]
  (read) hda9's sb offset: 1118784 [events: 00000096]
  (read) hda10's sb offset: 30144 [events: 00000096]
  (read) hda11's sb offset: 105728 [events: 000000a4]
  (read) hda13's sb offset: 105728 [events: 000000a4]
  (read) hdc5's sb offset: 1028032 [events: 00000ace]
  (read) hdc6's sb offset: 513984 [events: 00000aca]
  (read) hdc7's sb offset: 317376 [events: 00000aca]
  (read) hdc8's sb offset: 513984 [events: 00000aca]
  (read) hdc9's sb offset: 1118784 [events: 00000096]
  (read) hdc10's sb offset: 30144 [events: 00000096]
  (read) hdc11's sb offset: 105728 [events: 000000a4]
  (read) hdc13's sb offset: 105728 [events: 000000a4]
  autorun ...
  considering hdc13 ...
    adding hdc13 ...
    adding hdc11 ...
    adding hda13 ...
    adding hda11 ...
  created md11
  bind<hda11,1>
  md11: WARNING: hda13 appears to be on the same physical disk as hda11. True
       protection against single-disk failure might be compromised.
  bind<hda13,2>
  bind<hdc11,3>
  md11: WARNING: hdc13 appears to be on the same physical disk as hdc11. True
       protection against single-disk failure might be compromised.
  bind<hdc13,4>
  running: <hdc13><hdc11><hda13><hda11>
  now!
  hdc13's event counter: 000000a4
  hdc11's event counter: 000000a4
  hda13's event counter: 000000a4
  hda11's event counter: 000000a4
  md11: max total readahead window set to 124k
  md11: 1 data-disks, max readahead per data-disk: 124k
  md: updating md11 RAID superblock on device
  hdc13 [events: 000000a5](write) hdc13's sb offset: 105728
  hdc11 [events: 000000a5](write) hdc11's sb offset: 105728
  hda13 [events: 000000a5](write) hda13's sb offset: 105728
  hda11 [events: 000000a5](write) hda11's sb offset: 105728
  .
  considering hdc10 ...
    adding hdc10 ...
    adding hda10 ...
  created md10
  bind<hda10,1>
  bind<hdc10,2>
  running: <hdc10><hda10>
  now!
  hdc10's event counter: 00000096
  hda10's event counter: 00000096
  md10: max total readahead window set to 496k
  md10: 2 data-disks, max readahead per data-disk: 248k
  raid0: looking at hda10
  raid0:   comparing hda10(30144) with hda10(30144)
  raid0:   END
  raid0:   ==> UNIQUE
  raid0: 1 zones
  raid0: looking at hdc10
  raid0:   comparing hdc10(30144) with hda10(30144)
  raid0:   EQUAL
  raid0: FINAL 1 zones
  zone 0
   checking hda10 ... contained as device 0
    (30144) is smallest!.
   checking hdc10 ... contained as device 1
   zone->nb_dev: 2, size: 60288
  current zone offset: 30144
  done.
  raid0 : md_size is 60288 blocks.
  raid0 : conf->smallest->size is 60288 blocks.
  raid0 : nb_zone is 1.
  raid0 : Allocating 8 bytes for hash.
  md: updating md10 RAID superblock on device
  hdc10 [events: 00000097](write) hdc10's sb offset: 30144
  hda10 [events: 00000097](write) hda10's sb offset: 30144
  .
  considering hdc9 ...
[...]

When I don't use the serial console, only the first RAID is well
detected; I get something different: (hand copied)

  md: updating md11 RAID superblock on device
  hdc13 [events: 000000a7](write) hdc13's sb offset: 105728
  hdc11 [events: 000000a7](write) hdc11's sb offset: 105728
  hda13 [events: 000000a7](write) hda13's sb offset: 105728
  hda11 [events: 000000a7](write) hda11's sb offset: 105728
  .
  considering hdc10 ...
  Unable to handle kernel NULL pointer dereference at virtual address 00000000
   printing eip:
  c0127da2
  *pde = 000000
  Oops: 0002
  CPU:    0
  EIP:    0010:[<c0127da2>]
  EFLAGS: 00010093
  eax: 00000000   ebx: cbf4a1e0   ecx: cbff8f40   edx: 00000001
  esi: cbffc638   edi: 00000286   ebp: 00000000   esp: c133df6c
  ds: 0018   es: 0018  ss: 0018
  Process swapper (pid: 1, stackpage=c133d000)
  Stack: cbf1c000 00000001 cbf4b080 cbf4b000 00001000 000bf1c0 c01af03f cbf1c000
         cbf27090 cbf27180 c133dfc4 cbf27180 c01b08b1 cbf23000 cbf23000 0000160d
         00000010 c0105000 0008e000 00160001 cbf27480 c133dfc4 c133dfc4 c133dfc4
  Call Trace: [<c01af03f>] [<c01b08b1>] [<c0105000>] [<c0107007>] [<c01089ff>]
  Code: 89 18 8b 46 04 89 4e 04 89 31 89 41 04 89 08 eb 27 8b 43 08
  kernel panic: Attempted to kill init!

Ksymoops says:

  >>EIP; c0127da2 <kfree+7e/c0>   <=====
  Trace; c01af03f <sb_equal+7b/94>
  Trace; c01b08b1 <autorun_devices+85/230>
  Trace; c0105000 <empty_bad_page+0/1000>
  Trace; c0107007 <init+7/150>
  Trace; c01089ff <kernel_thread+23/30>
  Code;  c0127da2 <kfree+7e/c0>                  00000000 <_EIP>:
  Code;  c0127da2 <kfree+7e/c0>                     0:   89 18                     mov    %ebx,(%eax)   <=====
  Code;  c0127da4 <kfree+80/c0>                     2:   8b 46 04                  mov    0x4(%esi),%eax
  Code;  c0127da7 <kfree+83/c0>                     5:   89 4e 04                  mov    %ecx,0x4(%esi)
  Code;  c0127daa <kfree+86/c0>                     8:   89 31                     mov    %esi,(%ecx)
  Code;  c0127dac <kfree+88/c0>                     a:   89 41 04                  mov    %eax,0x4(%ecx)
  Code;  c0127daf <kfree+8b/c0>                     d:   89 08                     mov    %ecx,(%eax)
  Code;  c0127db1 <kfree+8d/c0>                     f:   eb 27                     jmp    38 <_EIP+0x38> c0127dda <kfree+b6/c0>
  Code;  c0127db3 <kfree+8f/c0>                    11:   8b 43 08                  mov    0x8(%ebx),%eax
  
  kernel panic: Attempted to kill init!

I hope this is enough to track down the problem.
Please CC to me because I'm not a LKML subscriber.

--
             Roberto Ragusa   robertoragusa at technologist.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
