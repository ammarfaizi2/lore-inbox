Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316626AbSE0OUA>; Mon, 27 May 2002 10:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316625AbSE0OT7>; Mon, 27 May 2002 10:19:59 -0400
Received: from mailrelay1.inwind.it ([212.141.54.101]:33771 "EHLO
	mailrelay1.inwind.it") by vger.kernel.org with ESMTP
	id <S316624AbSE0OT6>; Mon, 27 May 2002 10:19:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: d_vangreg <d.vangreg@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: CompilationBugs_kernel-2.2.5
Date: Mon, 27 May 2002 16:29:19 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020527141958Z316624-22651+61951@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BEGIN-COMPILATION-BUG-REPORT for kernel version 2.5.15

ver_linux:

Linux c7 2.5.18 #1 Sun May 26 10:32:28 CEST 2002 i686 unknown
 
Gnu C                  3.0.4
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         soundcore ppp_deflate zlib_inflate zlib_deflate 
ppp_async ppp_generic slip slhc lp rtc

#################

COMPILATION-BUG-1, encountered while executing:  'make bzImage'

/opt/gcc304a/bin/gcc -D__KERNEL__ -I/usr/src/linux-2.5.14/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon    -DKBUILD_BASENAME=dev  -c -o dev.o dev.c

dev.c: In function `netif_receive_skb':
dev.c:1465: void value not ignored as it ought to be
dev.c:1465:    ret = handle_diverter(skb); 

REASON-WHY-1:
in file 'net/core/dev.c' lines 1418 and 1465 are in contradiction with each 
other: 
.......................
1417:	#ifdef CONFIG_NET_DIVERT
1418:	static inline void handle_diverter(struct sk_buff *skb)
........................
1463:   #ifdef CONFIG_NET_DIVERT
1464:		if (skb->dev->divert && skb->dev->divert->divert)
1465:			ret = handle_diverter(skb);
........................


PROPOSED-SOLUTION-1: changing line 1465 to:
......................
1465			{ handle_diverter(skb); ret=0; }
......................

#################

COMPILATION-BUG-2, encountered while executing:  'make modules'
..................
make[2]: Entering directory `/usr/src/linux-2.5.18/drivers/ide'
/opt/gcc304a/bin/gcc -D__KERNEL__ -I/usr/src/linux-2.5.18/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.5.18/include/linux/modversions.h   
-DKBUILD_BASENAME=ide_tape  -c -o ide-tape.o ide-tape.c

ide-tape.c: In function `__idetape_kmalloc_stage':
ide-tape.c:2810: `BH_Lock' undeclared (first use in this function)
ide-tape.c:2810: (Each undeclared identifier is reported only once
ide-tape.c:2810: for each function it appears in.)
ide-tape.c: In function `idetape_chrdev_read':
ide-tape.c:4562: warning: comparison of distinct pointer types lacks a cast
ide-tape.c:4581: warning: comparison of distinct pointer types lacks a cast
ide-tape.c: In function `idetape_chrdev_write':
ide-tape.c:4856: warning: comparison of distinct pointer types lacks a cast
ide-tape.c: In function `idetape_setup':
ide-tape.c:6008: warning: duplicate `const'
make[2]: *** [ide-tape.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.18/drivers/ide'
make[1]: *** [_modsubdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.18/drivers'
make: *** [_mod_drivers] Error 2

PROPOSED-SOLUTION-2:
edit file:  linux/drivers/ide/ide_tape.c
after line 419, insert new line: #include <linux/buffer_head.h>

#################

COMPILATION-BUG-3 encountered while executing:  'make modules'
........................
/opt/gcc304a/bin/gcc -D__KERNEL__ -I/usr/src/linux-2.5.18/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.5.18/include/linux/modversions.h   
-DKBUILD_BASENAME=usbvideo -DEXPORT_SYMTAB -c -o usbvideo.o usbvideo.c

usbvideo.c: In function `usbvideo_StartDataPump':
usbvideo.c:1906: structure has no member named `next'
usbvideo.c:1908: structure has no member named `next'
make[3]: *** [usbvideo.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.18/drivers/usb/media'
make[2]: *** [_modsubdir_media] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.18/drivers/usb'
make[1]: *** [_modsubdir_usb] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.18/drivers'
make: *** [_mod_drivers] Error 2


PROPOSED-SOLUTION-3:
replacing string  '->next'  with string  '->urb_list.next' 
in file:  linux/drivers/usb/media/usbvideo.c    lines: 1906, 1908

REMAINING-BUG-3
usbvideo.c:1906: warning: assignment from incompatible pointer type
usbvideo.c:1908: warning: assignment from incompatible pointer type

#################

COMPILATION-BUG-4 encountered while executing:  'make modules'
.........................
/opt/gcc304a/bin/gcc -D__KERNEL__ -I/usr/src/linux-2.5.18/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.5.18/include/linux/modversions.h   -DKBUILD_BASENAME=ov511 
-DEXPORT_SYMTAB -c -o ov511.o ov511.c

ov511.c: In function `ov51x_init_isoc':
ov511.c:3978: structure has no member named `next'
ov511.c:3980: structure has no member named `next'
make[3]: *** [ov511.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.18/drivers/usb/media'
make[2]: *** [_modsubdir_media] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.18/drivers/usb'
make[1]: *** [_modsubdir_usb] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.18/drivers'
make: *** [_mod_drivers] Error 2

PROPOSED-SOLUTION-4:
replacing string '->next' with string '->urb_list.next' 
in file: linux/drivers/usb/media/ov511.c    lines: 3879, 3980

REMAINING-BUG-4
ov511.c:3978: warning: assignment from incompatible pointer type
ov511.c:3980: warning: assignment from incompatible pointer type

#################

COMPILATION-BUG-5 encountered while executing:  'make modules'
............................
/opt/gcc304a/bin/gcc -D__KERNEL__ -I/usr/src/linux-2.5.18/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.5.18/include/linux/modversions.h   -DKBUILD_BASENAME=pwc_if  
-c -o pwc-if.o pwc-if.c

pwc-if.c: In function `pwc_isoc_init':
pwc-if.c:818: structure has no member named `next'
pwc-if.c: In function `pwc_isoc_cleanup':
pwc-if.c:861: structure has no member named `next'
make[3]: *** [pwc-if.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.18/drivers/usb/media'
make[2]: *** [_modsubdir_media] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.18/drivers/usb'
make[1]: *** [_modsubdir_usb] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.18/drivers'
make: *** [_mod_drivers] Error 2

PROPOSED-SOLUTION-5:
replacing string '->next' with string '->urb_list.next' 
in file: linux/drivers/usb/media/pwc-if.c    lines: 818, 861

REMAINING-BUG-5
pwc-if.c:818: warning: assignment from incompatible pointer type

#################

END-COMPILATION-BUG-REPORT

sender:   d.vangreg@inwind.it

