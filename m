Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265147AbUELSDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUELSDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUELSDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:03:45 -0400
Received: from ext-nj2gw-1.online-age.net ([216.35.73.163]:36540 "EHLO
	ext-nj2gw-1.online-age.net") by vger.kernel.org with ESMTP
	id S265147AbUELSCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:02:52 -0400
Message-Id: <200405121802.NAA26824@neo.gso.med.ge.com>
To: linux-kernel@vger.kernel.org
From: richard.coe@med.ge.com
Reply-To: richard.coe@med.ge.com
Subject: finding floating point use in the kernel
Date: Wed, 12 May 2004 13:02:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While trying to track down a problem with some floating point calculations,
I wrote the following script.  Perhaps someone can add it to the 
kernel Makefile to run when the Platform is I386.

#!/bin/bash
# probably runs faster in perl
# d[89a-f] are floating point insns on I386
find . -type f | egrep '\.o$' | while read fn ; do  
    objdump -d $fn | egrep ':.d[89a-f]' > /tmp/od1.$$
    if [ -s "/tmp/od1.$$" ]; then 
	echo "$fn"
	cat /tmp/od1.$$
	rm /tmp/od1.$$
    fi
    done

On my 2.4.22 kernel, it found the following:

./fs/jbd/transaction.o
     5f1:	db 01                	fildl  (%ecx)
     664:	da 01                	fiaddl (%ecx)
     ae0:	d9 02                	flds   (%edx)
    14af:	de 04 10             	fiadd  (%eax,%edx,1)
./fs/jbd/commit.o
     7eb:	d9 02                	flds   (%edx)
     f64:	dd 00                	fldl   (%eax)
./fs/jbd/journal.o
     e30:	da 03                	fiaddl (%ebx)
./fs/jbd/jbd.o
     5f1:	db 01                	fildl  (%ecx)
     664:	da 01                	fiaddl (%ecx)
     ae0:	d9 02                	flds   (%edx)
    14af:	de 04 10             	fiadd  (%eax,%edx,1)
    2a2b:	d9 02                	flds   (%edx)
    31a4:	dd 00                	fldl   (%eax)
    467a:	df fe                	(bad)  
    5eb0:	da 03                	fiaddl (%ebx)
./fs/nfs/pagelist.o
 1ce:	dd 0f                	fisttpll (%edi)
./fs/nfs/write.o
    1704:	db fd                	(bad)  
./fs/nfs/nfs.o
    9674:	db fd                	(bad)  
./fs/udf/udf.o
    406d:	db 74 06 83          	(bad)  0xffffff83(%esi,%eax,1)
./fs/sysv/dir.o
 530:	dd 00                	fldl   (%eax)
./fs/sysv/sysv.o
    2c20:	dd 00                	fldl   (%eax)
./fs/fs.o
    4d62:	d8 89 04 24 75 e8    	fmuls  0xe8752404(%ecx)
   2e170:	db 10                	fistl  (%eax)
   2fdfa:	db 10                	fistl  (%eax)
   307d1:	db 01                	fildl  (%ecx)
   30844:	da 01                	fiaddl (%ecx)
   30cc0:	d9 02                	flds   (%edx)
   32c0b:	d9 02                	flds   (%edx)
   33384:	dd 00                	fldl   (%eax)
   36090:	da 03                	fiaddl (%ebx)
   46b8e:	dd 0f                	fisttpll (%edi)
./mm/mmap.o
     b77:	de 02                	fiadd  (%edx)
./mm/bootmem.o
 20e:	db c7                	fcmovnb %st(7),%st
 363:	d9 73 0a             	fnstenv 0xa(%ebx)
./mm/page_alloc.o
 3b5:	d9 00                	flds   (%eax)
./mm/mm.o
    2747:	de 02                	fiadd  (%edx)
    b4e5:	d9 00                	flds   (%eax)
    c16d:	d9 89 f6 53 8b 5c    	(bad)  0x5c8b53f6(%ecx)
 406:	d9 72 e7             	fnstenv 0xffffffe7(%edx)
 45e:	db c7                	fcmovnb %st(7),%st
 5b3:	d9 73 0a             	fnstenv 0xa(%ebx)
./ipc/ipc.o
    36f9:	da 8d b6 00 00 00    	fimull 0xb6(%ebp)
./net/core/skbuff.o
     d26:	db 02                	fildl  (%edx)
./net/core/dev.o
     859:	d8 03                	fadds  (%ebx)
     88b:	df 03                	fild   (%ebx)
     8c2:	dd 03                	fldl   (%ebx)
./net/core/core.o
    24a6:	db 02                	fildl  (%edx)
    58b9:	d8 03                	fadds  (%ebx)
    58eb:	df 03                	fild   (%ebx)
    5922:	dd 03                	fldl   (%ebx)
./net/ipv4/netfilter/arp_tables.o
     52e:	db 00 
./net/ipv4/ipv4.o
   14693:	d9 89 d0 d3 f8 e9    	(bad)  0xe9f8d3d0(%ecx)
./net/network.o
    4236:	db 02                	fildl  (%edx)
    7649:	d8 03                	fadds  (%ebx)
    767b:	df 03                	fild   (%ebx)
    76b2:	dd 03                	fldl   (%ebx)
   284c3:	d9 89 d0 d3 f8 e9    	(bad)  0xe9f8d3d0(%ecx)
   2d385:	dd 02 00 
   2d3b0:	d8 02 00 
./arch/i386/boot/bbootsect.o
 197:	df c3                	ffreep %st(3)
./arch/i386/boot/bsetup.o
     501:	db 57 72             	fistl  0x72(%edi)
     5a6:	db cd                	fcmovne %st(5),%st
     668:	db 31                	(bad)  (%ecx)
     693:	db 31                	(bad)  (%ecx)
     b51:	d8 05 b0 78 e8 08    	fadds  0x8e878b0
     ccf:	df ad 83 f8 fd 74    	fildll 0x74fdf883(%ebp)
     f1d:	db 01                	fildl  (%ecx)
./arch/i386/kernel/i387.o
  50:	db e3                	fninit 
  77:	db e2                	fnclex 
  90:	dd b2 b0 02 00 00    	fnsave 0x2b0(%edx)
  c5:	db e2                	fnclex 
  e0:	dd b1 b0 02 00 00    	fnsave 0x2b0(%ecx)
 120:	dd a2 b0 02 00 00    	frstor 0x2b0(%edx)
./arch/i386/kernel/kernel.o
    7710:	db e3                	fninit 
    7737:	db e2                	fnclex 
    7750:	dd b2 b0 02 00 00    	fnsave 0x2b0(%edx)
    7785:	db e2                	fnclex 
    77a0:	dd b1 b0 02 00 00    	fnsave 0x2b0(%ecx)
    77e0:	dd a2 b0 02 00 00    	frstor 0x2b0(%edx)
./arch/i386/kernel/head.o
     19d:	db e3                	fninit 
     1b7:	db e4                	fnsetpm(287 only) 
./init/main.o
  65:	db e3                	fninit 
  67:	dd 05 20 00 00 00    	fldl   0x20
  6d:	dc 35 28 00 00 00    	fdivl  0x28
  73:	dc 0d 28 00 00 00    	fmull  0x28
  79:	dd 05 20 00 00 00    	fldl   0x20
  7f:	de e1                	fsubp  %st,%st(1)
  81:	db 1d 70 00 00 00    	fistpl 0x70
./drivers/ide/pci/siimage.o
     272:	db 00                	fildl  (%eax)
./drivers/ide/pci/idedriver-pci.o
    9ff2:	db 00                	fildl  (%eax)
./drivers/ide/idedriver.o
    9ff2:	db 00                	fildl  (%eax)
./drivers/ide/ide-tape.o
     d42:	de 08                	fimul  (%eax)
./drivers/net/wireless/orinoco.o
    30b2:	de 09                	fimul  (%ecx)
./drivers/net/wireless/wireless_net.o
    30b2:	de 09                	fimul  (%ecx)
./drivers/net/bonding/bond_main.o
     1dd:	d8 5b c3             	fcomps 0xffffffc3(%ebx)
./drivers/net/bonding/bonding.o
     1dd:	d8 5b c3             	fcomps 0xffffffc3(%ebx)
./drivers/net/natsemi.o
    2e39:	db fe                	(bad)  
./drivers/net/tg3.o
    21b6:	de 06                	fiadd  (%esi)
    21c3:	da 06                	fiaddl (%esi)
./drivers/net/amd8111e.o
    1ee3:	df 2c 24             	fildll (%esp,1)
    1ee9:	d9 7c 24 0a          	fnstcw 0xa(%esp,1)
    1ef9:	dc 05 00 00 00 00    	faddl  0x0
    1eff:	d9 6c 24 08          	fldcw  0x8(%esp,1)
    1f03:	df 3c 24             	fistpll (%esp,1)
    1f06:	d9 6c 24 0a          	fldcw  0xa(%esp,1)
    1fe5:	df 2c 24             	fildll (%esp,1)
    1feb:	d9 7c 24 0a          	fnstcw 0xa(%esp,1)
    1ffb:	dc 05 08 00 00 00    	faddl  0x8
    2001:	d9 6c 24 08          	fldcw  0x8(%esp,1)
    2005:	df 3c 24             	fistpll (%esp,1)
    2008:	d9 6c 24 0a          	fldcw  0xa(%esp,1)
    2369:	df 2c 24             	fildll (%esp,1)
    236f:	d9 7c 24 12          	fnstcw 0x12(%esp,1)
    237f:	dc 05 10 00 00 00    	faddl  0x10
    2385:	d9 6c 24 10          	fldcw  0x10(%esp,1)
    2389:	df 7c 24 08          	fistpll 0x8(%esp,1)
    238d:	d9 6c 24 12          	fldcw  0x12(%esp,1)
./drivers/usb/host/uhci.o
    1bd8:	df 
./drivers/usb/host/usb-uhci.o
    1089:	df 
./drivers/block/ll_rw_blk.o
     5d9:	d9 01                	flds   (%ecx)
     5e0:	df 0f                	fisttp (%edi)
./drivers/block/block.o
     5d9:	d9 01                	flds   (%ecx)
     5e0:	df 0f                	fisttp (%edi)
    3a01:	dc 00 00 
    5f68:	db 00 00 
./drivers/sound/via82cxxx_audio.o
     3a8:	db 02                	fildl  (%edx)
./drivers/video/sis/sis_main.o
    1c0c:	df 2c 24             	fildll (%esp,1)
    1c16:	df 2c 24             	fildll (%esp,1)
    1c19:	d9 c9                	fxch   %st(1)
    1c22:	dc 3d 00 00 00 00    	fdivrl 0x0
    1c28:	de f1                	fdivp  %st,%st(1)
    1c2a:	df 2c 24             	fildll (%esp,1)
    1c30:	d9 7c 24 12          	fnstcw 0x12(%esp,1)
    1c34:	de f9                	fdivrp %st,%st(1)
    1c36:	d8 c0                	fadd   %st(0),%st
    1c44:	dc 05 08 00 00 00    	faddl  0x8
    1c4a:	d9 6c 24 10          	fldcw  0x10(%esp,1)
    1c4e:	df 7c 24 08          	fistpll 0x8(%esp,1)
    1c52:	d9 6c 24 12          	fldcw  0x12(%esp,1)
    26c6:	df 2c 24             	fildll (%esp,1)
    26d7:	da 0c 24             	fimull (%esp,1)
    26e7:	dc 0d 10 00 00 00    	fmull  0x10
    26ed:	da 0c 24             	fimull (%esp,1)
    26f3:	d9 7c 24 32          	fnstcw 0x32(%esp,1)
    2703:	dc 3d 18 00 00 00    	fdivrl 0x18
    2709:	d9 6c 24 30          	fldcw  0x30(%esp,1)
    270d:	df 7c 24 28          	fistpll 0x28(%esp,1)
    2711:	d9 6c 24 32          	fldcw  0x32(%esp,1)
./drivers/video/sis/sisfb.o
    1c0c:	df 2c 24             	fildll (%esp,1)
    1c16:	df 2c 24             	fildll (%esp,1)
    1c19:	d9 c9                	fxch   %st(1)
    1c22:	dc 3d 00 00 00 00    	fdivrl 0x0
    1c28:	de f1                	fdivp  %st,%st(1)
    1c2a:	df 2c 24             	fildll (%esp,1)
    1c30:	d9 7c 24 12          	fnstcw 0x12(%esp,1)
    1c34:	de f9                	fdivrp %st,%st(1)
    1c36:	d8 c0                	fadd   %st(0),%st
    1c44:	dc 05 08 00 00 00    	faddl  0x8
    1c4a:	d9 6c 24 10          	fldcw  0x10(%esp,1)
    1c4e:	df 7c 24 08          	fistpll 0x8(%esp,1)
    1c52:	d9 6c 24 12          	fldcw  0x12(%esp,1)
    26c6:	df 2c 24             	fildll (%esp,1)
    26d7:	da 0c 24             	fimull (%esp,1)
    26e7:	dc 0d 10 00 00 00    	fmull  0x10
    26ed:	da 0c 24             	fimull (%esp,1)
    26f3:	d9 7c 24 32          	fnstcw 0x32(%esp,1)
    2703:	dc 3d 18 00 00 00    	fdivrl 0x18
    2709:	d9 6c 24 30          	fldcw  0x30(%esp,1)
    270d:	df 7c 24 28          	fistpll 0x28(%esp,1)
    2711:	d9 6c 24 32          	fldcw  0x32(%esp,1)
./drivers/video/matrox/matroxfb_DAC1064.o
     e57:	df ff ff 
./drivers/video/matrox/matroxfb_misc.o
    15ab:	d8 03 00 
    15b5:	d8 03 00 
./drivers/message/i2o/i2o_core.o
    20b2:	de 
./drivers/ieee1394/ieee1394_transactions.o
 491:	de 8d b4 26 00 00    	fimul  0x26b4(%ebp)
./drivers/ieee1394/dma.o
 489:	db 8b 44 24 1c 39    	fisttpl 0x391c2444(%ebx)
./drivers/ieee1394/ieee1394.o
    20c1:	de 8d b4 26 00 00    	fimul  0x26b4(%ebp)
    7809:	db 8b 44 24 1c 39    	fisttpl 0x391c2444(%ebx)

--
Rich Coe		richard.coe@med.ge.com
General Electric Healthcare

