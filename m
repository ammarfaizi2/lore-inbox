Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSJFR5R>; Sun, 6 Oct 2002 13:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbSJFR5R>; Sun, 6 Oct 2002 13:57:17 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:30173 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261750AbSJFR5M>; Sun, 6 Oct 2002 13:57:12 -0400
To: torvalds@transmeta.com
Subject: [PATCH] Bluetooth kbuild fix and config cleanup
Cc: linux-kernel@vger.kernel.org, maxk@qualcomm.com, marcel@holtmann.org
Message-Id: <E17yFj4-0006ll-00@pegasus>
From: Marcel Holtmann <marcel@holtmann.org>
Date: Sun, 06 Oct 2002 20:01:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.755, 2002-10-06 19:14:49+02:00, marcel@holtmann.org
  Bluetooth kbuild fix and config cleanup
  
  This patch removes the obsolete O_TARGET and cleans up the Config.in
  and Config.help files to have a unique CONFIG_BLUEZ prefix. Additional
  two missing help entries are added.


 drivers/bluetooth/Makefile       |   15 ++++++++++-----
 net/bluetooth/Config.help        |   26 --------------------------
 net/bluetooth/Config.in          |    4 +++-
 net/bluetooth/Makefile           |   26 ++++++++------------------
 net/bluetooth/bnep/Config.help   |   21 +++++++++++++++++++++
 net/bluetooth/bnep/Config.in     |    6 ++++--
 net/bluetooth/bnep/Makefile      |    7 +++----
 net/bluetooth/rfcomm/Config.help |   12 ++++++++++++
 net/bluetooth/rfcomm/Config.in   |    4 +++-
 net/bluetooth/rfcomm/Makefile    |   12 +++++++-----
 10 files changed, 71 insertions(+), 62 deletions(-)


diff -Nru a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
--- a/drivers/bluetooth/Makefile	Sun Oct  6 19:19:06 2002
+++ b/drivers/bluetooth/Makefile	Sun Oct  6 19:19:06 2002
@@ -1,5 +1,5 @@
 #
-# Makefile for Bluetooth HCI device drivers.
+# Makefile for the Linux Bluetooth HCI device drivers.
 #
 
 obj-$(CONFIG_BLUEZ_HCIUSB)	+= hci_usb.o
@@ -9,9 +9,14 @@
 obj-$(CONFIG_BLUEZ_HCIBT3C)	+= bt3c_cs.o
 obj-$(CONFIG_BLUEZ_HCIBLUECARD)	+= bluecard_cs.o
 
-hci_uart-y				:= hci_ldisc.o
-hci_uart-$(CONFIG_BLUEZ_HCIUART_H4)	+= hci_h4.o
-hci_uart-$(CONFIG_BLUEZ_HCIUART_BCSP)	+= hci_bcsp.o
-hci_uart-objs				:= $(hci_uart-y)
+hci_uart-objs := hci_ldisc.o
+
+ifeq ($(CONFIG_BLUEZ_HCIUART_H4),y)
+  hci_uart-objs += hci_h4.o
+endif
+
+ifeq ($(CONFIG_BLUEZ_HCIUART_BCSP),y)
+  hci_uart-objs += hci_bcsp.o
+endif
 
 include $(TOPDIR)/Rules.make
diff -Nru a/net/bluetooth/Config.help b/net/bluetooth/Config.help
--- a/net/bluetooth/Config.help	Sun Oct  6 19:19:06 2002
+++ b/net/bluetooth/Config.help	Sun Oct  6 19:19:06 2002
@@ -33,19 +33,6 @@
   Say Y here to compile L2CAP support into the kernel or say M to
   compile it as module (l2cap.o).
 
-RFCOMM protocol support
-CONFIG_BLUEZ_RFCOMM
-  RFCOMM provides connection oriented stream transport. RFCOMM
-  support is required for Dialup Networking, OBEX and other Bluetooth
-  applications.
-
-  Say Y here to compile RFCOMM support into the kernel or say M to
-  compile it as module (rfcomm.o).
-
-RFCOMM TTY emulation support
-CONFIG_RFCOMM_TTY
-  This options enables TTY emulation support for RFCOMM channels.
-
 SCO links support
 CONFIG_BLUEZ_SCO
   SCO link provides voice transport over Bluetooth. SCO support is
@@ -53,17 +40,4 @@
 
   Say Y here to compile SCO support into the kernel or say M to
   compile it as module (sco.o).
-
-BNEP protocol support
-CONFIG_BLUEZ_BNEP
-  BNEP (Bluetooth Network Encapsulation Protocol) is Ethernet
-  emulation layer on top of Bluetooth. BNEP is required for Bluetooth
-  PAN (Personal Area Network).
-
-  To use BNEP, you will need user-space utilities provided in the 
-  BlueZ-PAN package.
-  For more information, see <http://bluez.sourceforge.net>.
-
-  Say Y here to compile BNEP support into the kernel or say M to
-  compile it as module (bnep.o).
 
diff -Nru a/net/bluetooth/Config.in b/net/bluetooth/Config.in
--- a/net/bluetooth/Config.in	Sun Oct  6 19:19:06 2002
+++ b/net/bluetooth/Config.in	Sun Oct  6 19:19:06 2002
@@ -1,8 +1,9 @@
 #
-# Bluetooth configuration
+# Bluetooth subsystem configuration
 #
 
 if [ "$CONFIG_NET" != "n" ]; then
+
    mainmenu_option next_comment
    comment 'Bluetooth support'
    dep_tristate 'Bluetooth subsystem support' CONFIG_BLUEZ $CONFIG_NET
@@ -14,6 +15,7 @@
       source net/bluetooth/bnep/Config.in
       source drivers/bluetooth/Config.in
    fi
+
    endmenu
 fi
 
diff -Nru a/net/bluetooth/Makefile b/net/bluetooth/Makefile
--- a/net/bluetooth/Makefile	Sun Oct  6 19:19:06 2002
+++ b/net/bluetooth/Makefile	Sun Oct  6 19:19:06 2002
@@ -1,25 +1,15 @@
 #
-# Makefile for the Bluetooth subsystem
+# Makefile for the Linux Bluetooth subsystem.
 #
 
-export-objs	:= syms.o
+export-objs := syms.o
 
-obj-$(CONFIG_BLUEZ) += bluez.o
-obj-$(CONFIG_BLUEZ_L2CAP) += l2cap.o
-obj-$(CONFIG_BLUEZ_SCO) += sco.o
+obj-$(CONFIG_BLUEZ)		+= bluez.o
+obj-$(CONFIG_BLUEZ_L2CAP)	+= l2cap.o
+obj-$(CONFIG_BLUEZ_SCO)		+= sco.o
+obj-$(CONFIG_BLUEZ_RFCOMM)	+= rfcomm/
+obj-$(CONFIG_BLUEZ_BNEP)	+= bnep/
 
-subdir-$(CONFIG_BLUEZ_BNEP) += bnep
-
-ifeq ($(CONFIG_BLUEZ_BNEP),y)
-obj-y += bnep/bnep.o
-endif
-
-subdir-$(CONFIG_BLUEZ_RFCOMM) += rfcomm
-
-ifeq ($(CONFIG_BLUEZ_RFCOMM),y)
-obj-y += rfcomm/rfcomm.o
-endif
-
-bluez-objs	:= af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o lib.o syms.o
+bluez-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o lib.o syms.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/net/bluetooth/bnep/Config.help b/net/bluetooth/bnep/Config.help
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/net/bluetooth/bnep/Config.help	Sun Oct  6 19:19:06 2002
@@ -0,0 +1,21 @@
+BNEP protocol support
+CONFIG_BLUEZ_BNEP
+  BNEP (Bluetooth Network Encapsulation Protocol) is Ethernet
+  emulation layer on top of Bluetooth. BNEP is required for Bluetooth
+  PAN (Personal Area Network).
+
+  To use BNEP, you will need user-space utilities provided in the 
+  BlueZ-PAN package.
+  For more information, see <http://bluez.sourceforge.net>.
+
+  Say Y here to compile BNEP support into the kernel or say M to
+  compile it as module (bnep.o).
+
+BNEP multicast filter support
+CONFIG_BLUEZ_BNEP_MC_FILTER
+  This option enables the multicast filter support for BNEP.
+
+BNEP protocol filter support
+CONFIG_BLUEZ_BNEP_PROTO_FILTER
+  This option enables the protocol filter support for BNEP.
+
diff -Nru a/net/bluetooth/bnep/Config.in b/net/bluetooth/bnep/Config.in
--- a/net/bluetooth/bnep/Config.in	Sun Oct  6 19:19:06 2002
+++ b/net/bluetooth/bnep/Config.in	Sun Oct  6 19:19:06 2002
@@ -1,6 +1,8 @@
 
 dep_tristate 'BNEP protocol support' CONFIG_BLUEZ_BNEP $CONFIG_BLUEZ_L2CAP
+
 if [ "$CONFIG_BLUEZ_BNEP" != "n" ]; then
-   bool '  Multicast filter support' CONFIG_BNEP_MC_FILTER
-   bool '  Protocol filter support'  CONFIG_BNEP_PROTO_FILTER
+   bool '  Multicast filter support' CONFIG_BLUEZ_BNEP_MC_FILTER
+   bool '  Protocol filter support'  CONFIG_BLUEZ_BNEP_PROTO_FILTER
 fi
+
diff -Nru a/net/bluetooth/bnep/Makefile b/net/bluetooth/bnep/Makefile
--- a/net/bluetooth/bnep/Makefile	Sun Oct  6 19:19:06 2002
+++ b/net/bluetooth/bnep/Makefile	Sun Oct  6 19:19:06 2002
@@ -1,10 +1,9 @@
 #
-# Makefile for BNEP protocol
+# Makefile for the Linux Bluetooth BNEP layer.
 #
 
-O_TARGET := bnep.o
+obj-$(CONFIG_BLUEZ_BNEP) += bnep.o
 
-obj-y	 := core.o sock.o netdev.o crc32.o
-obj-m    += $(O_TARGET)
+bnep-objs := core.o sock.o netdev.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/net/bluetooth/rfcomm/Config.help b/net/bluetooth/rfcomm/Config.help
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/net/bluetooth/rfcomm/Config.help	Sun Oct  6 19:19:06 2002
@@ -0,0 +1,12 @@
+RFCOMM protocol support
+CONFIG_BLUEZ_RFCOMM
+  RFCOMM provides connection oriented stream transport. RFCOMM
+  support is required for Dialup Networking, OBEX and other Bluetooth
+  applications.
+
+  Say Y here to compile RFCOMM support into the kernel or say M to
+  compile it as module (rfcomm.o).
+
+RFCOMM TTY emulation support
+CONFIG_BLUEZ_RFCOMM_TTY
+  This option enables TTY emulation support for RFCOMM channels.
diff -Nru a/net/bluetooth/rfcomm/Config.in b/net/bluetooth/rfcomm/Config.in
--- a/net/bluetooth/rfcomm/Config.in	Sun Oct  6 19:19:06 2002
+++ b/net/bluetooth/rfcomm/Config.in	Sun Oct  6 19:19:06 2002
@@ -1,5 +1,7 @@
 
 dep_tristate 'RFCOMM protocol support' CONFIG_BLUEZ_RFCOMM $CONFIG_BLUEZ_L2CAP
+
 if [ "$CONFIG_BLUEZ_RFCOMM" != "n" ]; then
-   bool '  RFCOMM TTY support' CONFIG_RFCOMM_TTY
+   bool '  RFCOMM TTY support' CONFIG_BLUEZ_RFCOMM_TTY
 fi
+
diff -Nru a/net/bluetooth/rfcomm/Makefile b/net/bluetooth/rfcomm/Makefile
--- a/net/bluetooth/rfcomm/Makefile	Sun Oct  6 19:19:06 2002
+++ b/net/bluetooth/rfcomm/Makefile	Sun Oct  6 19:19:06 2002
@@ -1,11 +1,13 @@
 #
-# Makefile for BNEP protocol
+# Makefile for the Linux Bluetooth RFCOMM layer.
 #
 
-O_TARGET := rfcomm.o
+obj-$(CONFIG_BLUEZ_RFCOMM) += rfcomm.o
 
-obj-y	 := core.o sock.o crc.o
-obj-$(CONFIG_RFCOMM_TTY) += tty.o
-obj-m    += $(O_TARGET)
+rfcomm-objs := core.o sock.o crc.o
+
+ifeq ($(CONFIG_BLUEZ_RFCOMM_TTY),y)
+  rfcomm-objs += tty.o
+endif
 
 include $(TOPDIR)/Rules.make

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch22794
M'XL(`(IPH#T``\U::V_;N!+]'/V*`;K`)FAMDQ3U,FX6S;,UFC1!FBYV%P4"
M6J9C-;*DZI$F%_KQ=TC9CI/(EA/?;-H&CB.3A\.9PYE#TF_@:R;3[L98I+X,
MC3?P,<[R[L8H#O.QB*)VG%[BP[,XQH>=43R6G>E'G7Z07TF9R+33#POYWQ9K
M6P:V/16Y/X)KF6;=#=HV9T_RVT1V-\X./GP]VCDSC.UMV!N)Z%)^D3EL;QMY
MG%Z+<)"]%_DHC*-VGHHH&\M<M/UX7,Z:EHP0AO\MZIC$LDMJ$^Z4/AU0*CB5
M`\*X:W/CN_S>?S\NPLM47,OV9A1'<NL!""7$1AA"S9)R[&7L`VT[E@6$=2CI
M$!NHUZ6\R[VWA'4)@<I%[^==`V\I@18Q=N'_:_Z>X<,N.C5'OX_@JE\$X0"&
MP0V(:`!^'`V#2_!#*:(BP9;X<SX*,DBTGU,YCJ]E!OE(0MS/XE#F$DXNSG?.
M/AR<5P"J9P9%HMOL:;AV$"&,^G3R]TB&"0X9*J081NA&$%!$P8\"NYQ\/NQ]
MN-@]^GKP#R2I1,O:L#,8!'D01R)$H/QG#.,@RX+H$C22C/(T0"R1(LY@(`=M
MXQ-P;E/'.+TC@M%ZXC_#(((8?U13K_?](`T4&35)M3\[Q^)*JIG=!<,U+9.7
MU.(N+4T^Y)9@2`E*>%_*NK@W@2IN49<29I8<!_"66QC)?`YHSO]3`VU"J*-X
MZN+?I<\L[C!G*#S3P7'L6@.78U;V$4X4`VVWP8.U6$'TR'V.P[Q2LCY':GO4
M'5#A"7=UZR:(VC;'<IE;<LY,_A3;%D;6<4T,A8EKRW8]Z3J^WQ?6"J8]CJIC
M.<0JF4>9@Y8U(_0CF2SROX=(IDT<7DI_8''"Y=!S'&HY:^/:I4TH)=K"FZOW
MUP&FZ6D:7(QS%P%TO.DQ7`P,J592WQ4<(R+Z#I7$I$\T;SZP+G:W2NIY'EO5
MN(<QF-J&%CE6V:>.9/;0XK9O"9_6INE54+5IW"LI8Y:U4F33(1)PO"`&5*T%
M8C*U:J7CXHJUAH(*TY5L?6B3(&VH;:[@P?M(=Y&P",Z6TY)A6%F)B\VA7#@<
MS>3#X2HI91&P\J.J:=1T&5W=P(?AJ.QC)4)Q&Y>'18=]0N2P;W-_L+IY-5%F
M5!'0<4Q7BY#EJTHID\_RIRZ$W8:VQI_`#>.%,H)6)^1.FS#2)5Z76,NTR8M(
M$Q0F0?Y)ZS[M%6A6A9T&OWT"/644`@T-S^"A5_X"<J-X]G3=\**!HD\+%*.O
M+2(/@6(8JIIQ`JWTI_Y!/S7&Y.F>[Q'`B.U^/CA%[1CGL1^'D!5)$J>Y,:\L
M+U03`T"WW+R;R6>)ZC*]@H/(%TE6A$*I3CB=0&T!*N$#%+8I&HZ]Y7C:(A2W
MR%E\D\<)Q,,[W[2K(;!?*G\402K137%Z]SFBG.Y\ALU35'Q*W\).*L74C*VV
M\0T;G,=09%(#O8/;N("?01BB[Q`+GZ>M+!&^A"(/0A3)J(-QYM<!RF`((JW"
MU3QQO']::B1L>R4N91L?'J(AXQA%<Q"A36,]DW>0H2S]SRC/DVZG6F;M+"Z0
M6-@$N^'$_ZBL^B)NX6\4X-@?13R2*%$K5L]VXG'$Q4^4!5?*8R'@>!GV.L8.
M"##M$N0@,C1D4.`?FXH$[5C/7&.AB_/`%UFN,D*.3EX8SHOCO8O#WM'YP9GR
MF=JTQ(D.CHQ$/YSL6A;!55%!E-G`,_XTCGMZ=G)^TCST`L![(S^N&H_+];*Z
M\;CUJI7CN8JCIGA0I\N6;FQ_T>)1XSPL'SCI1YFJIN49//+,BQ:0M>)%GQ8O
MRGZ-&E()TZ4UI"8RSZHBE!EGAWLGQ\<-=:1JA*O^KK7*O9F:0"1]G03B-)!1
MCODXRS&YCT&[34&U8=9]EC(?%(K]0(1%,BT(073Y#DYV#_[2/HI5);I72D22
MA)C=U*C9LBP],7:=/%TY>I*I)WCGYW_/U<0E_KK`E@LR92V&=L5D$!]IAD;B
M_)9+;"Q^F"A?8HNZ%BC">025D%J&[+Z4,[MTJ93CT&*ON@H_0;6Y7EG%!=%S
M5A_#Q?[-V.?`C)Z%+P#0CW$!_@YPO*!\_P[+Y<`,X+2^".,G#76]9VNK%G!N
MNA=<F7)/.WA8!Q,)1_%!/>&6'T";T.*O33A]9-),N.G<G\&W?<4W3;HW,(NC
M2C@J(QX%47$S9Z^6AEKMMXU]2W54+W'_>^NWS4<,VH*WVU`)6F/?471VL;%Z
MT,(>&72W<<*I;,>0Q?X5_L*)#>0UMF[2@:LEM^<=T*P)BWPS35;+-]+E3@/?
MZ&OS31\M/4%BK)GBD$#J92Y#S=72^N0V5T(U^9;L&IZ2EIYS6+8>*(I3YKE>
M#5,8;2B%#K2LUV:*/N9;A2G_5FZ:,&>5[%0UU?EI*N14AC*-G@>643U:D*/\
MU,?&WXQ@*'_`9BVNXN;6N]LMI/4\%`Z6Y[?864:#8*A9N_BN2U'V!6_>:IC;
M?._&&1(%(4T72VIUIWM_(X7,-9MN=%^;M]6EX0/>+I[[2Y/VXUX/L.8%OIP:
M@=3%#2<W>M0"SQCYP44ATGS&1O4@'`39$A8BYM>=L_.+CWS"POL@;RN0$9]1
ML0%G=^_+Z3*DOI\E]VB]\(:T@=5KWM8VIN.:TP*5BEWFE,PFIJDY;=TOVKQ+
M[(;#'&:_=B[6%\U+<_%Z)P+[)LI_=(^E?RT,<27+7NJZ>]7PWE=D*KC<I([U
M,+C4ZUINE[F_N"*K+NI7B>VSI-A\LKHS*BOZV6V6R_'$GB+5YQ%3P=6CBW:#
M*Y:O=;Y:T$B#.K6E6&"Z%C,?EBW%`J?A#LE%%KBO3(/J6Q%+:?!OE:P9.>9%
MEKQ14GU6I;+;<79/4ST685L;&VI[J*]8XCJ1=L3V=DZW5*.0^2*I;_1E[Z0"
MRORXOL5$ZVW,M%YGX7YU8[)?[6`)IBK3]9BI=JSZP'PZ-3&\F/D<]:`J@!.%
M6+U5K-%OY;6,\LG[B7@,@[Y2DI5S9E_?\T?2O\J*\383WH#;?=_X'^4060T[
#*```
`
end
