Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262335AbTCRK7M>; Tue, 18 Mar 2003 05:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262329AbTCRK7M>; Tue, 18 Mar 2003 05:59:12 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:18436 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S262313AbTCRK5d>;
	Tue, 18 Mar 2003 05:57:33 -0500
Date: Tue, 18 Mar 2003 14:08:29 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] crc16 consolidation (irda part)
Message-ID: <20030318110829.GD866@pazke>
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

attached patch (2.5.65-bk) converts irda subsystem to use common crc16 table.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1147, 2003-03-18 10:23:46+03:00, pazke@orbita1.ru
  Convert irda subsystem to use common crc16 module.


 b/drivers/net/irda/donauboe.c |   44 ----------------------------
 b/include/net/irda/crc.h      |   10 +-----
 b/net/irda/Makefile           |    2 -
 b/net/irda/irsyms.c           |    2 -
 net/irda/crc.c                |   65 ------------------------------------------
 5 files changed, 5 insertions(+), 118 deletions(-)


diff -Nru a/drivers/net/irda/donauboe.c b/drivers/net/irda/donauboe.c
--- a/drivers/net/irda/donauboe.c	Tue Mar 18 10:24:19 2003
+++ b/drivers/net/irda/donauboe.c	Tue Mar 18 10:24:19 2003
@@ -52,10 +52,6 @@
 
 /* See below for a description of the logic in this driver */
 
-/* Is irda_crc16_table[] exported? not yet */
-/* define this if you get errors about multiple defns of irda_crc16_table */
-#undef CRC_EXPORTED
-
 /* User servicable parts */
 /* Enable the code which probes the chip and does a few tests */
 /* Probe code is very useful for understanding how the hardware works */
@@ -159,6 +155,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/rtnetlink.h>
+#include <linux/crc16.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -205,45 +202,6 @@
 
 /**********************************************************************/
 /* Fcs code */
-
-#ifdef CRC_EXPORTED
-extern __u16 const irda_crc16_table[];
-#else
-static __u16 const irda_crc16_table[256] = {
-  0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
-  0x8c48, 0x9dc1, 0xaf5a, 0xbed3, 0xca6c, 0xdbe5, 0xe97e, 0xf8f7,
-  0x1081, 0x0108, 0x3393, 0x221a, 0x56a5, 0x472c, 0x75b7, 0x643e,
-  0x9cc9, 0x8d40, 0xbfdb, 0xae52, 0xdaed, 0xcb64, 0xf9ff, 0xe876,
-  0x2102, 0x308b, 0x0210, 0x1399, 0x6726, 0x76af, 0x4434, 0x55bd,
-  0xad4a, 0xbcc3, 0x8e58, 0x9fd1, 0xeb6e, 0xfae7, 0xc87c, 0xd9f5,
-  0x3183, 0x200a, 0x1291, 0x0318, 0x77a7, 0x662e, 0x54b5, 0x453c,
-  0xbdcb, 0xac42, 0x9ed9, 0x8f50, 0xfbef, 0xea66, 0xd8fd, 0xc974,
-  0x4204, 0x538d, 0x6116, 0x709f, 0x0420, 0x15a9, 0x2732, 0x36bb,
-  0xce4c, 0xdfc5, 0xed5e, 0xfcd7, 0x8868, 0x99e1, 0xab7a, 0xbaf3,
-  0x5285, 0x430c, 0x7197, 0x601e, 0x14a1, 0x0528, 0x37b3, 0x263a,
-  0xdecd, 0xcf44, 0xfddf, 0xec56, 0x98e9, 0x8960, 0xbbfb, 0xaa72,
-  0x6306, 0x728f, 0x4014, 0x519d, 0x2522, 0x34ab, 0x0630, 0x17b9,
-  0xef4e, 0xfec7, 0xcc5c, 0xddd5, 0xa96a, 0xb8e3, 0x8a78, 0x9bf1,
-  0x7387, 0x620e, 0x5095, 0x411c, 0x35a3, 0x242a, 0x16b1, 0x0738,
-  0xffcf, 0xee46, 0xdcdd, 0xcd54, 0xb9eb, 0xa862, 0x9af9, 0x8b70,
-  0x8408, 0x9581, 0xa71a, 0xb693, 0xc22c, 0xd3a5, 0xe13e, 0xf0b7,
-  0x0840, 0x19c9, 0x2b52, 0x3adb, 0x4e64, 0x5fed, 0x6d76, 0x7cff,
-  0x9489, 0x8500, 0xb79b, 0xa612, 0xd2ad, 0xc324, 0xf1bf, 0xe036,
-  0x18c1, 0x0948, 0x3bd3, 0x2a5a, 0x5ee5, 0x4f6c, 0x7df7, 0x6c7e,
-  0xa50a, 0xb483, 0x8618, 0x9791, 0xe32e, 0xf2a7, 0xc03c, 0xd1b5,
-  0x2942, 0x38cb, 0x0a50, 0x1bd9, 0x6f66, 0x7eef, 0x4c74, 0x5dfd,
-  0xb58b, 0xa402, 0x9699, 0x8710, 0xf3af, 0xe226, 0xd0bd, 0xc134,
-  0x39c3, 0x284a, 0x1ad1, 0x0b58, 0x7fe7, 0x6e6e, 0x5cf5, 0x4d7c,
-  0xc60c, 0xd785, 0xe51e, 0xf497, 0x8028, 0x91a1, 0xa33a, 0xb2b3,
-  0x4a44, 0x5bcd, 0x6956, 0x78df, 0x0c60, 0x1de9, 0x2f72, 0x3efb,
-  0xd68d, 0xc704, 0xf59f, 0xe416, 0x90a9, 0x8120, 0xb3bb, 0xa232,
-  0x5ac5, 0x4b4c, 0x79d7, 0x685e, 0x1ce1, 0x0d68, 0x3ff3, 0x2e7a,
-  0xe70e, 0xf687, 0xc41c, 0xd595, 0xa12a, 0xb0a3, 0x8238, 0x93b1,
-  0x6b46, 0x7acf, 0x4854, 0x59dd, 0x2d62, 0x3ceb, 0x0e70, 0x1ff9,
-  0xf78f, 0xe606, 0xd49d, 0xc514, 0xb1ab, 0xa022, 0x92b9, 0x8330,
-  0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
-};
-#endif
 
 STATIC int
 toshoboe_checkfcs (unsigned char *buf, int len)
diff -Nru a/include/net/irda/crc.h b/include/net/irda/crc.h
--- a/include/net/irda/crc.h	Tue Mar 18 10:24:19 2003
+++ b/include/net/irda/crc.h	Tue Mar 18 10:24:19 2003
@@ -15,19 +15,15 @@
 #define IRDA_CRC_H
 
 #include <linux/types.h>
+#include <linux/crc16.h>
 
 #define INIT_FCS  0xffff   /* Initial FCS value */
 #define GOOD_FCS  0xf0b8   /* Good final FCS value */
 
-extern __u16 const irda_crc16_table[];
-
 /* Recompute the FCS with one more character appended. */
-static inline __u16 irda_fcs(__u16 fcs, __u8 c)
-{
-	return (((fcs) >> 8) ^ irda_crc16_table[((fcs) ^ (c)) & 0xff]);
-}
+#define irda_fcs(fcs, c) crc16_byte(fcs, c)
 
 /* Recompute the FCS with len bytes appended. */
-unsigned short irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len);
+#define irda_calc_crc16(fcs, buf, len) crc16(fcs, buf, len)
 
 #endif
diff -Nru a/net/irda/Makefile b/net/irda/Makefile
--- a/net/irda/Makefile	Tue Mar 18 10:24:19 2003
+++ b/net/irda/Makefile	Tue Mar 18 10:24:19 2003
@@ -9,7 +9,7 @@
 
 irda-y := iriap.o iriap_event.o irlmp.o irlmp_event.o irlmp_frame.o \
           irlap.o irlap_event.o irlap_frame.o timer.o qos.o irqueue.o \
-          irttp.o irda_device.o irias_object.o crc.o wrapper.o af_irda.o \
+          irttp.o irda_device.o irias_object.o wrapper.o af_irda.o \
 	  discovery.o parameters.o irsyms.o
 irda-$(CONFIG_PROC_FS) += irproc.o
 irda-$(CONFIG_SYSCTL) += irsysctl.o
diff -Nru a/net/irda/crc.c b/net/irda/crc.c
--- a/net/irda/crc.c	Tue Mar 18 10:24:19 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,65 +0,0 @@
-/*********************************************************************
- *                
- * Filename:      crc.c
- * Version:       0.1
- * Description:   CRC calculation routines
- * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
- * Created at:    Mon Aug  4 20:40:53 1997
- * Modified at:   Sun May  2 20:28:08 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
- * Sources:       ppp.c by Michael Callahan <callahan@maths.ox.ac.uk>
- *                Al Longyear <longyear@netcom.com>
- *
- ********************************************************************/
-
-#include <net/irda/crc.h>
-
-/*
- * This mysterious table is just the CRC of each possible byte.  It can be
- * computed using the standard bit-at-a-time methods.  The polynomial can
- * be seen in entry 128, 0x8408.  This corresponds to x^0 + x^5 + x^12.
- * Add the implicit x^16, and you have the standard CRC-CCITT.
- */
-__u16 const irda_crc16_table[256] =
-{
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
-
-unsigned short irda_calc_crc16( __u16 fcs, __u8 const *buf, size_t len) 
-{
-	while (len--)
-                fcs = irda_fcs(fcs, *buf++);
-	return fcs;
-}
diff -Nru a/net/irda/irsyms.c b/net/irda/irsyms.c
--- a/net/irda/irsyms.c	Tue Mar 18 10:24:19 2003
+++ b/net/irda/irsyms.c	Tue Mar 18 10:24:19 2003
@@ -164,8 +164,6 @@
 
 EXPORT_SYMBOL(async_wrap_skb);
 EXPORT_SYMBOL(async_unwrap_char);
-EXPORT_SYMBOL(irda_calc_crc16);
-EXPORT_SYMBOL(irda_crc16_table);
 EXPORT_SYMBOL(irda_start_timer);
 EXPORT_SYMBOL(setup_dma);
 EXPORT_SYMBOL(infrared_mode);

===================================================================


This BitKeeper patch contains the following changesets:
1.1147
## Wrapped with gzip_uu ##


begin 664 bkpatch8506
M'XL(`*/)=CX``[5776_;-A1]#G\%@;PT:"SQ2Y1D+$769-B"=EB0H4_;$%`D
M52F6)4.BDJ40]MM+T8[KSZ3R&EL6))JZ/+SG\/#J&'YJ=#T^FHDO$PV.X6]5
M8\9'59WD1F"O;FW33579)C^KIMIWW?R'JI[X$UV7NO"+O&R;$?$"8+M>"R,S
M>*_K9GR$/;IL,8\S/3ZZ^>773Q]_O@'@[`Q>9*+\K/_4!IZ=`5/5]Z)0S;DP
M65&5GJE%V4RU$9ZLIMVR:T<0(O8;X)"B@'>8(Q9V$BN,!<-:(<(BSH##>/YM
M"NL!**(X0B%&E-A;&B!P";&',0LAHKX]<`0Q&A,Z9OPMHF.$X&9`^#:`(P3>
MPQ^+^P)(>%&5-GL&YK42L&F3YK$Q>FH'@FVCH8TZK4HH:XDYG%:J+;0'/D#2
MQP77WW(*1@,_`""!P+L7)E1JX_?`?`O`DRNS8@BA#M$8TRY&"0\BSE/&E4JH
MVDI>]SXW'[2>Z=I7NM!&*]^S%R,7\[_-QU<8LV-%'6((#P":U\WCM-G&2EC`
M6)>R*%$<2ZIXQ"C9)GIWH"<\%/&.$A['%L^=.<]FA9?-W/BJSOLUX"\?5U4I
MVJ32"R0888Q#PFE@M<!LUHA,E(HY)6E(PU2&VTA>"+F*";$X9B_F*"]ET2KM
MKY&:K4HU9E&'(Q*1CN,HH"E+`A%I%NAT&][^:*O(.`J"Z/O9^UU,=)H7>DMI
MB,>TDX+PE%*L0Y7&BC]#WFJ<-?+B..3.C9[);N]//YA=</=9U%_RR7FM52;,
M]P2EJ#<L%%`4=B2."':NQ38M"^VW+`Q'C+Z*9]WH:76OG67=.FNZ-2(I]"E<
MB`+V6\2_OOO+RVRKM32A>N-R0OT#CNH'=U@?NGZ.B@-L[3(((`-7F&.(P?$3
MH)_6$+T#EP1%D,9."KN5_/(N]7_6TX;`G@FUT%:,>[\E?+YYT0$RH'`4OHH*
MKG:1?0IK/2N$7*@CE<V;$_B0FVR^A]TFCT:_.>FE,+>&#2WL3L0!,KC"X?/\
M$TCLV6F%1'U791VC7(%M?Z=0GJSB7C2!2]J+Z\J=UYZ3HI#S%3'OF[3I*2QT
MN8BRT>C4M^59+POO,+L$$Y&?FUDOBJP>M64^2BJ9M5.[%^\S3ELM$8)C&G?,
MJB!TTHN'.1!^30/JQ5'!'F\OJ+FY;PAJ:V:'6`HF/=WN#)>?O#9F9H=WQ"M]
MGTOM[G+1W%;)G9;&WC[48F8+'WLETMN^I[WZV_$^J"@:H(D!E=J&">T(L6(^
MF!/*=YF//:*]"D"O539?NJ2-X3KH?H?IR\4-$0S*]0$"65O'3X7C`,Z&%:U@
MFMLLB]QZFR?%7T]C_+.O=B4DL&\]88`[&B%KN>[M9T@A84DDKU]'+*T3BE)M
LU19N@;O2>]\"?YKT00N<AW8[6+Z\RDS+2=-.SQ!)`QX',?@*TD3TT#4/````
`
end
