Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbTCRK5a>; Tue, 18 Mar 2003 05:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262313AbTCRK53>; Tue, 18 Mar 2003 05:57:29 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:17412 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S262298AbTCRK5Y>;
	Tue, 18 Mar 2003 05:57:24 -0500
Date: Tue, 18 Mar 2003 14:08:20 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] crc16 consolidation (ppp part)
Message-ID: <20030318110820.GB866@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

attached patch (2.5.65-bk) converts async ppp driver to use common crc16 table.

Maintainer agreed with this change. Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1145, 2003-03-18 10:02:18+03:00, pazke@orbita1.ru
  Convert async ppp driver to use common crc16 module.


 drivers/net/Makefile.lib |    3 +++
 drivers/net/ppp_async.c  |   38 +-------------------------------------
 include/linux/ppp_defs.h |    2 +-
 3 files changed, 5 insertions(+), 38 deletions(-)


diff -Nru a/drivers/net/Makefile.lib b/drivers/net/Makefile.lib
--- a/drivers/net/Makefile.lib	Tue Mar 18 10:03:04 2003
+++ b/drivers/net/Makefile.lib	Tue Mar 18 10:03:04 2003
@@ -1,3 +1,6 @@
+# These drivers all require crc16.o
+obj-$(CONFIG_PPP_ASYNC)		+= crc16.o
+
 # These drivers all require crc32.o
 obj-$(CONFIG_8139CP)		+= crc32.o
 obj-$(CONFIG_8139TOO)		+= crc32.o
diff -Nru a/drivers/net/ppp_async.c b/drivers/net/ppp_async.c
--- a/drivers/net/ppp_async.c	Tue Mar 18 10:03:04 2003
+++ b/drivers/net/ppp_async.c	Tue Mar 18 10:03:04 2003
@@ -26,6 +26,7 @@
 #include <linux/tty.h>
 #include <linux/netdevice.h>
 #include <linux/poll.h>
+#include <linux/crc16.h>
 #include <linux/ppp_defs.h>
 #include <linux/if_ppp.h>
 #include <linux/ppp_channel.h>
@@ -464,43 +465,6 @@
 /*
  * Procedures for encapsulation and framing.
  */
-
-u16 ppp_crc16_table[256] = {
-	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
-	0x8c48, 0x9dc1, 0xaf5a, 0xbed3, 0xca6c, 0xdbe5, 0xe97e, 0xf8f7,
-	0x1081, 0x0108, 0x3393, 0x221a, 0x56a5, 0x472c, 0x75b7, 0x643e,
-	0x9cc9, 0x8d40, 0xbfdb, 0xae52, 0xdaed, 0xcb64, 0xf9ff, 0xe876,
-	0x2102, 0x308b, 0x0210, 0x1399, 0x6726, 0x76af, 0x4434, 0x55bd,
-	0xad4a, 0xbcc3, 0x8e58, 0x9fd1, 0xeb6e, 0xfae7, 0xc87c, 0xd9f5,
-	0x3183, 0x200a, 0x1291, 0x0318, 0x77a7, 0x662e, 0x54b5, 0x453c,
-	0xbdcb, 0xac42, 0x9ed9, 0x8f50, 0xfbef, 0xea66, 0xd8fd, 0xc974,
-	0x4204, 0x538d, 0x6116, 0x709f, 0x0420, 0x15a9, 0x2732, 0x36bb,
-	0xce4c, 0xdfc5, 0xed5e, 0xfcd7, 0x8868, 0x99e1, 0xab7a, 0xbaf3,
-	0x5285, 0x430c, 0x7197, 0x601e, 0x14a1, 0x0528, 0x37b3, 0x263a,
-	0xdecd, 0xcf44, 0xfddf, 0xec56, 0x98e9, 0x8960, 0xbbfb, 0xaa72,
-	0x6306, 0x728f, 0x4014, 0x519d, 0x2522, 0x34ab, 0x0630, 0x17b9,
-	0xef4e, 0xfec7, 0xcc5c, 0xddd5, 0xa96a, 0xb8e3, 0x8a78, 0x9bf1,
-	0x7387, 0x620e, 0x5095, 0x411c, 0x35a3, 0x242a, 0x16b1, 0x0738,
-	0xffcf, 0xee46, 0xdcdd, 0xcd54, 0xb9eb, 0xa862, 0x9af9, 0x8b70,
-	0x8408, 0x9581, 0xa71a, 0xb693, 0xc22c, 0xd3a5, 0xe13e, 0xf0b7,
-	0x0840, 0x19c9, 0x2b52, 0x3adb, 0x4e64, 0x5fed, 0x6d76, 0x7cff,
-	0x9489, 0x8500, 0xb79b, 0xa612, 0xd2ad, 0xc324, 0xf1bf, 0xe036,
-	0x18c1, 0x0948, 0x3bd3, 0x2a5a, 0x5ee5, 0x4f6c, 0x7df7, 0x6c7e,
-	0xa50a, 0xb483, 0x8618, 0x9791, 0xe32e, 0xf2a7, 0xc03c, 0xd1b5,
-	0x2942, 0x38cb, 0x0a50, 0x1bd9, 0x6f66, 0x7eef, 0x4c74, 0x5dfd,
-	0xb58b, 0xa402, 0x9699, 0x8710, 0xf3af, 0xe226, 0xd0bd, 0xc134,
-	0x39c3, 0x284a, 0x1ad1, 0x0b58, 0x7fe7, 0x6e6e, 0x5cf5, 0x4d7c,
-	0xc60c, 0xd785, 0xe51e, 0xf497, 0x8028, 0x91a1, 0xa33a, 0xb2b3,
-	0x4a44, 0x5bcd, 0x6956, 0x78df, 0x0c60, 0x1de9, 0x2f72, 0x3efb,
-	0xd68d, 0xc704, 0xf59f, 0xe416, 0x90a9, 0x8120, 0xb3bb, 0xa232,
-	0x5ac5, 0x4b4c, 0x79d7, 0x685e, 0x1ce1, 0x0d68, 0x3ff3, 0x2e7a,
-	0xe70e, 0xf687, 0xc41c, 0xd595, 0xa12a, 0xb0a3, 0x8238, 0x93b1,
-	0x6b46, 0x7acf, 0x4854, 0x59dd, 0x2d62, 0x3ceb, 0x0e70, 0x1ff9,
-	0xf78f, 0xe606, 0xd49d, 0xc514, 0xb1ab, 0xa022, 0x92b9, 0x8330,
-	0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
-};
-EXPORT_SYMBOL(ppp_crc16_table);
-#define fcstab	ppp_crc16_table		/* for PPP_FCS macro */
 
 /*
  * Procedure to encode the data for async serial transmission.
diff -Nru a/include/linux/ppp_defs.h b/include/linux/ppp_defs.h
--- a/include/linux/ppp_defs.h	Tue Mar 18 10:03:04 2003
+++ b/include/linux/ppp_defs.h	Tue Mar 18 10:03:04 2003
@@ -92,7 +92,7 @@
 
 #define PPP_INITFCS	0xffff	/* Initial FCS value */
 #define PPP_GOODFCS	0xf0b8	/* Good final FCS value */
-#define PPP_FCS(fcs, c)	(((fcs) >> 8) ^ fcstab[((fcs) ^ (c)) & 0xff])
+#define PPP_FCS(fcs, c) crc16_byte(fcs, c)
 
 /*
  * Extended asyncmap - allows any character to be escaped.

===================================================================


This BitKeeper patch contains the following changesets:
1.1145
## Wrapped with gzip_uu ##


begin 664 bkpatch8128
M'XL(`*C$=CX``[U66V^;,!A]CG^%I>ZA51?B*YAHJ=JENU2[-&K7AVF;(@-F
ML!"<&=*N$S]^!MJD%R51NW4)LM`G<S@^/N<S6_"L4*;?F<G?$P6VX%M=E/V.
M-D%:2NR8N2V=:&U+O41/5:^9UKO09M*;*).KK)>E^;SH$H<#.W4DRS"!Y\H4
M_0YVZ*)27LY4OW/RZLW9^X,3``8#.$QD_EV=JA(.!J#4YEQF4;$ORR33N5,:
MF1=354HGU--J,;4B"!'[Y]BCB+L5=A'SJA!'&$N&580($RX##<?]Y1)N`U!$
ML4`N%9Q5Q,6<@D.('8P9AXCV[(4%Q*B/2!^+743[",&[@'"7PBX"+^&_Y3T$
M(1SJW*I70EE<YB&<S68P,JFMV%?!>:&@Q9WJ'(8FQ"Z<ZFB>*0>\@X1ZG@]&
M2U5!]X$_`)!$8&_#DM(\S.:1:C;]5\_2&T<J+ISDY@I]ABI*"><5CX)(\)"I
MB!$1N_R>D&OQVHWR$":B8HPA?R.[5JJBEZNRP6I$=,(;Y)B]J[B'?%(%7F`]
M0)$*)")!?'^7U\'=YB8XL=QFM=,W$_L@)RI.[;9E:7#-S$4(4XHJY#([^JXG
M?(_(.*:QD-YZ8G?AELR\BC+!>).V54_4X7LJWB"2YVJ_3%249IF^*!QMOF^@
M3C!#+O<)JHA/+/4ZF>[M6.(^\?Y_+`\6<33JYSPUJF@CZ&@;OE;F8]@U%\UE
MPS1:J?@C@GF$8-U)/R7*-H`K7"BS[)K+@HH.?G2?;0^//[X^>C,>C4;C@]//
M'X<[G<[N8#'GZST_W+#VYE[\5Q$#9EZ4E_OU&&HSJP$=N39G!`GK9X]CABO.
ML6!MLT;W/+&Z56/8I=Z3F.)$3?6YJETQ;M0=ES+(U)=OS^%56X-M6VNE3VRU
M*)6,ZG[=]HPUEKFAPV,<0ZPP8.N:QHM;//;`(7,]:$6IG;"J`V^VPM^=!?\$
M'%>,^Q0UIB`/\P1^FN.[>0;6V7L]/-W>@5,9&KWA\&X/MSMF6"7`(]QPZ'/K
MAJ-FW+(H:;YD&(?%<QCNM)S&P66IKDO+S[DP4>&DF$\'2@@1>\H%?P``V'"/
$-0H`````
`
end
