Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUDVV2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUDVV2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264684AbUDVV2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:28:23 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:1690 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S264686AbUDVV2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:28:13 -0400
Message-ID: <40883833.6080506@oracle.com>
Date: Thu, 22 Apr 2004 23:25:07 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040323
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Cisco VPN back to work after 2.6.5-bk1 breakage - needs kbuild syntax
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing not much noise about the thing I decided to try fixing
  it myself... turns out that 2.6.5-bk1 introduces some new rules
  for out-of-tree kernel builds, and that causes the Cisco VPN
  kernel module to be missing a section in its headers.

Specifically, this is the 2.6.5-bk1 and later top of the output
  from objdump -x cisco_ipsec built with driver_build.sh:

cisco_ipsec
architecture: i386, flags 0x00000011:
HAS_RELOC, HAS_SYMS
start address 0x00000000

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
   0 .text         0001a3d9  00000000  00000000  00000040  2**4
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
   1 .init.text    00000078  00000000  00000000  0001a41c  2**2
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
   2 .rodata       00001e3c  00000000  00000000  0001a4a0  2**5
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
   3 .rodata.str1.32 0000034a  00000000  00000000  0001c2e0  2**5
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   4 .rodata.str1.1 00000133  00000000  00000000  0001c62a  2**0
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   5 .modinfo      00000014  00000000  00000000  0001c75d  2**0
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   6 .data         0002d950  00000000  00000000  0001c780  2**5
                   CONTENTS, ALLOC, LOAD, RELOC, DATA
   7 .bss          0000ec2c  00000000  00000000  0004a0e0  2**5
                   ALLOC
   8 .comment      000007c2  00000000  00000000  0004a0e0  2**0
                   CONTENTS, READONLY


When I use kbuild to build it, the same command yields on top

cisco_ipsec.ko:     file format elf32-i386
cisco_ipsec.ko
architecture: i386, flags 0x00000011:
HAS_RELOC, HAS_SYMS
start address 0x00000000

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
   0 .text         0001a6ac  00000000  00000000  00000040  2**4
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
   1 .init.text    00000073  00000000  00000000  0001a6ec  2**0
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
   2 .rodata       00001dfc  00000000  00000000  0001a760  2**5
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
   3 .rodata.str1.4 00000216  00000000  00000000  0001c55c  2**2
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   4 .rodata.str1.1 0000014a  00000000  00000000  0001c772  2**0
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   5 .modinfo      0000005b  00000000  00000000  0001c8c0  2**5
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   6 __versions    00000740  00000000  00000000  0001c920  2**5
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   7 .data         0002d950  00000000  00000000  0001d060  2**5
                   CONTENTS, ALLOC, LOAD, RELOC, DATA
   8 .gnu.linkonce.this_module 00000200  00000000  00000000  0004aa00  2**7
                   CONTENTS, ALLOC, LOAD, RELOC, DATA, LINK_ONCE_DISCARD
   9 .bss          0000ec4c  00000000  00000000  0004ac00  2**5
                   ALLOC
  10 .comment      00000750  00000000  00000000  0004ac00  2**0
                   CONTENTS, READONLY
  11 .note.GNU-stack 00000000  00000000  00000000  0004b350  2**0
                   CONTENTS, READONLY, CODE


There may be extra sections in this latter since it's built
  with GCC 3.4.0 instead of RedHat 9's 3.2.2, but I think the
  .gnu.linkonce.this_module section is the one actually making
  the difference.

Net result, I can now use Cisco VPN even under 2.6.6-rc2 :)

What I did: added a Makefile in the vpnclient/ directory and
  another in its parent directory. To build the VPN client I
  now go to the parent directory and type 'make'.

Parent Makefile:

-----------------------
CC=/usr/local/bin/gcc
LD=ld

ifndef KERNELRELEASE
LINUX ?= /usr/src/linux
PWD := $(shell pwd)

all:
	$(MAKE) CC=$(CC) -C $(LINUX) SUBDIRS=$(PWD) modules

clean:
	cd vpnclient && rm -f *.o *.ko *~ core .depend *.mod.c *.cmd

else
	obj-m += vpnclient/
endif
-----------------------

vpnclient dir Makefile:

-----------------------
INCLUDES += -I. -I${LINUX}/include -I${LINUX}/include/asm-i386/mach-default
CFLAGS += -O2 -DCNI_LINUX_INTERFACE -D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -DHAVE_CONFIG_H -fno-common -DKBUILD_BASENAME=cisco_ipsec -DKBUILD_MODNAME=cisco_ipsec

cisco_ipsec-objs := frag.o linuxcniapi.o IPSecDrvOS_linux.o interceptor.o libdriver.so

obj-m += cisco_ipsec.o
------------------------


It's probably not elegant, since I didn't have time to dive in
  the kbuild system details - but it Works For Me (TM). Clearly
  if someone has a cleaner solution I'll take that over mine any
  time ;)

--alessandro

  "Once you've seen the light, you suddenly
    realize it might end up all right
    it might end up all right now"
       (Husker Du, "These Important Years")

