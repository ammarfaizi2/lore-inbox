Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbUJWS0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUJWS0P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 14:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbUJWS0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 14:26:15 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:30671 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S261270AbUJWSZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 14:25:54 -0400
Message-ID: <313680C9A886D511A06000204840E1CF0A6472F3@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'mikpe@csd.uu.se'" <mikpe@csd.uu.se>,
       "'jamagallon@able.es'" <jamagallon@able.es>,
       "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
       "'kaos@ocs.com.au'" <kaos@ocs.com.au>,
       "'vda@port.imtp.ilyichevsk.odessa.ua'" 
	<vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: stdarg.h: No such  file or directory (gcc misplacement/miscon
	figuration)
Date: Sat, 23 Oct 2004 14:25:00 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just want to contribute to the "knowledge base" with some possibly helpful
to others information ...
I was getting the same problem,
stdarg.h: No such  file or directory 
 discussed before with regards to building Linux 2.4 - 
Linux Kernel Mailing List -- Re: Does kernel use system stdarg.h?
<http://www.spinics.net/lists/kernel/old/2002-q3/msg20414.html>
LKML: Denis Vlasenko: Re: Small bug in linux-2.4.20/include/linux
<http://lkml.org/lkml/2003/2/4/14>
Re: 2.4.27+stdarg+gcc-3.4.1
<http://marc.free.net.ph/message/20040725.013146.957ba10b.html>

but in my case -  I was facing this problem in building vanilla Linux
2.6.8-rc4
on the ppc system with non-standard installation of gcc (and everything else
...).

This system is, actually, -  an embedded ppc diskless board (with NFS
mounted root file system), 
to which I have added (cross-built on my cygwin host/build machine) native
gcc 3.3.2 compiler and  binutils (older than 2.12.1), etc .
(hence the "non-standard" installation - mainly due to my "goofy" manual
install of above).

I need to be able to natively build/compile the Linux kernel on such
embedded ppc diskless board,
 in order to run on it the Cerberus Test Control System (aka ctcs).
(Actually to satisfy ctcs reqs - I was forced to "upgrade" my board with so
many s/w "widgets" - it "looks and feels"  like Desktop system now  (;-) )

Firstly I was "told" by the kernel defconfig/build (Thanks for telling
explicitly !) that: 

*** 2.6 kernels no longer build correctly with old versions of binutils.
*** Please upgrade your binutils to 2.12.1 or newer

So I went back to my build/host system (cygwin), cross-compiled there
binutils 2.15
and "manually" placed resulted binaries on my "target<->host" Power PC
system. 
To be safe, I placed those binaries into all "popular" "bin" directories:
/bin, usr/bin, /usr/sbin, /usr/local/bin, /usr/local/sbin
(which is probably a big "overkill").

I also tried to rebuild natively gcc and binutils (having in mind of getting
the complete "set" of the binaries locally,
and then using standard "make install" to insure "sane" system configuration
) - ...
but this failed ... - both builds ran out of memory (32 Mb of RAM on the
board).
Making second attempt of cross-building "better" native compiler
( with correct prefix ?  is not an option for me - since I am not exactly
sure what directories needed to be included in there).

Then I started to get stdarg.h problem ...

So I have tried to adopt Denis's recommendations - ... of course just to the
level of my limited comprehension of the subject  ;-).

>GCC_EXEC_PREFIX=/usr/app/gcc-3.3.3/lib/gcc-lib/
and it worked ! - Thanks Denis !
In more details, I put togeteher the following script (see below) 
and made the following settings in the Makefile
(Note that I am "faking" "CROSS_COMPILE", though actually compiling natively
on the PowerPC)
This elliminated the above "binutils" complaint.and 
***********************************************
********************************************
************ native build Makefile**********
SUBARCH :=ppc
ARCH:=ppc
CROSS_COMPILE   = powerpc-linux-
.......
AS              = /usr/local/bin/as
LD              = /usr/local/bin/ld
CC              = $(CROSS_COMPILE)gcc
CPP             = $(CC) -E
AR              = /usr/local/bin/ar
NM              = /usr/local/bin/nm
STRIP           = /usr/local/bin/strip
OBJCOPY         = /usr/local/bin/objcopy
OBJDUMP         = /usr/local/bin/objdump
AWK             = awk
GENKSYMS        = scripts/genksyms/genksyms
DEPMOD          = /sbin/depmod
KALLSYMS        = scripts/kallsyms
PERL            = perl
CHECK           = sparse
MODFLAGS        = -DMODULE
CFLAGS_MODULE   = $(MODFLAGS)
AFLAGS_MODULE   = $(MODFLAGS)
LDFLAGS_MODULE  = -r
CFLAGS_KERNEL   =
AFLAGS_KERNEL   =

NOSTDINC_FLAGS  = -nostdinc -iwithprefix include

CPPFLAGS        := -D__KERNEL__ -Iinclude \
                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)

CFLAGS          := -Wall -Wstrict-prototypes -Wno-trigraphs \
                   -fno-strict-aliasing -fno-common
AFLAGS          := -D__ASSEMBLY__

export  VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
        CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
        CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
        HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB LDFLAGS_MODULE CHECK

export CPPFLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
*****************************************
*************native  build.sh**********
#!/bin/sh
AR=/usr/local/bin/ar \
NM=/usr/local/bin/nm \
CC=/usr/local/bin/powerpc-linux-gcc-3.3.2 \
GCC=/usr/local/bin/powerpc-linux-gcc-3.3.2 \
HOSTCC=/usr/local/bin/powerpc-linux-gcc-3.3.2 \
CXX=/usr/local/bin/powerpc-linux-g++ \
CFLAGS=-stdvOs \
CXXFLAGS=-Os \
RANLIB= /usr/local/bin/ranlib
make clean
make defconfig
GCC_EXEC_PREFIX=/usr/local/lib/gcc-lib/ make ARCH=ppc
CROSS_COMPILE=powerpc-linux- uImage
****************
Thanks,
Hope this experience could be helpful to others,
Alex


