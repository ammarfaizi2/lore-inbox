Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSLGN1w>; Sat, 7 Dec 2002 08:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSLGN1w>; Sat, 7 Dec 2002 08:27:52 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:57051 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262808AbSLGN1u>; Sat, 7 Dec 2002 08:27:50 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.20-BK
Date: Sat, 7 Dec 2002 14:35:23 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Message-Id: <200212071434.11514.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZE4RGEIVHCEBFBW72EJ5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ZE4RGEIVHCEBFBW72EJ5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

using 2.4.20-BK tree gives me:

flushing ide devices: hda hdd

at reboot time in an endless loop drawing over the screen. No reboot will=
 be=20
made, I have to do that either by sysrq-b or reset button.

Using:

[*]   PCI IDE chipset support
[*]     Generic PCI bus-master DMA support
[*]       Use PCI DMA by default when available
<*>     Intel PIIXn chipsets support
[*]   IGNORE word93 Validation BITS

root@codeman:[/] # hdparm -i /dev/hda

/dev/hda:

 Model=3DMAXTOR 6L060J3, FwRev=3DA93.0500, SerialNo=3D663219752652
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D32256, SectSize=3D21298, ECCbytes=3D4
 BuffType=3DDualPortCache, BuffSize=3D1819kB, MaxMultSect=3D16, MultSect=3D=
16
 CurCHS=3D4047/16/255, CurSects=3D16511760, LBA=3Dyes, LBAsects=3D1172666=
88
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4=20
 DMA modes:  mdma0 mdma1 mdma2=20
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6=20
 AdvancedPM=3Dno WriteCache=3Denabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  1 2 3 4 5


BTW: The attached patch is needed to build the 2.4.20-BK tree successfull=
y
     because "local_irq_*" is missing and ld complains about undefined
     reference at linking time.

Any hints to fix that flushing ide bla foobar thing?

TIA!

ciao, Marc
--------------Boundary-00=_ZE4RGEIVHCEBFBW72EJ5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ide-i386-stuff-2.4.21.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ide-i386-stuff-2.4.21.patch"

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/asm-i386/system.h linux.20-ac1/include/asm-i386/system.h
--- linux.vanilla/include/asm-i386/system.h	2002-11-29 21:27:23.000000000 +0000
+++ linux.20-ac1/include/asm-i386/system.h	2002-11-11 15:59:38.000000000 +0000
@@ -322,8 +319,18 @@
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 
+#define __save_and_cli(x)	do { __save_flags(x); __cli(); } while(0);
+#define __save_and_sti(x)	do { __save_flags(x); __sti(); } while(0);
+
 /* For spinlocks etc */
+#if 0
 #define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+#define local_irq_set(x)	__asm__ __volatile__("pushfl ; popl %0 ; sti":"=g" (x): /* no input */ :"memory")
+#else
+#define local_irq_save(x)	__save_and_cli(x)
+#define local_irq_set(x)	__save_and_sti(x)
+#endif
+
 #define local_irq_restore(x)	__restore_flags(x)
 #define local_irq_disable()	__cli()
 #define local_irq_enable()	__sti()
@@ -338,6 +345,8 @@
 #define sti() __global_sti()
 #define save_flags(x) ((x)=__global_save_flags())
 #define restore_flags(x) __global_restore_flags(x)
+#define save_and_cli(x) do { save_flags(x); cli(); } while(0);
+#define save_and_sti(x) do { save_flags(x); sti(); } while(0);
 
 #else
 
@@ -345,6 +354,8 @@
 #define sti() __sti()
 #define save_flags(x) __save_flags(x)
 #define restore_flags(x) __restore_flags(x)
+#define save_and_cli(x) __save_and_cli(x)
+#define save_and_sti(x) __save_and_sti(x)
 
 #endif
 

--------------Boundary-00=_ZE4RGEIVHCEBFBW72EJ5--

