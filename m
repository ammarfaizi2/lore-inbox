Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293048AbSDQP6S>; Wed, 17 Apr 2002 11:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293132AbSDQP6R>; Wed, 17 Apr 2002 11:58:17 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:22475 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S293048AbSDQP6O>; Wed, 17 Apr 2002 11:58:14 -0400
Date: Wed, 17 Apr 2002 17:58:12 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [BKPATCH 2.5] sonypi driver: forward port from 2.5
Message-ID: <20020417155812.GG1519@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch forward ports the sonypi driver from the 2.4 kernels:
  - fix order and syntax for driver parameters on the kernel command line
  - add the nojogdial parameter for dealing with Vaio FX series

Linus, please apply.

Stelian.


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.532, 2002-04-17 16:13:38+02:00, stelian@popies.net
  Forward port from 2.4:
  - fix order and syntax for driver parameters on the kernel command line
  - add the nojogdial parameter for dealing with Vaio FX series


 Documentation/sonypi.txt |    7 +++++--
 drivers/char/sonypi.c    |   19 +++++++++++++++----
 drivers/char/sonypi.h    |    3 ++-
 3 files changed, 22 insertions(+), 7 deletions(-)


diff -Nru a/Documentation/sonypi.txt b/Documentation/sonypi.txt
--- a/Documentation/sonypi.txt	Wed Apr 17 16:14:01 2002
+++ b/Documentation/sonypi.txt	Wed Apr 17 16:14:01 2002
@@ -36,14 +36,14 @@
 driver and the ACPI BIOS, because Sony doesn't agree to release any programming
 specs for its laptops. If someone convinces them to do so, drop me a note.
 
-Module options:
+Driver options:
 ---------------
 
 Several options can be passed to the sonypi driver, either by adding them
 to /etc/modules.conf file, when the driver is compiled as a module or by
 adding the following to the kernel command line (in your bootloader):
 
-	sonypi=minor[[[[,camera],fnkeyinit],verbose],compat]
+	sonypi=minor[,verbose[,fnkeyinit[,camera[,compat[,nojogdial]]]]]
 
 where:
 
@@ -70,6 +70,9 @@
 			events. If the driver worked for you in the past
 			(prior to version 1.5) and does not work anymore,
 			add this option and report to the author.
+
+	nojogdial:	gives more accurate PKEY events on those Vaio models
+			which don't have a jogdial (like the FX series).
 
 Module use:
 -----------
diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	Wed Apr 17 16:14:01 2002
+++ b/drivers/char/sonypi.c	Wed Apr 17 16:14:01 2002
@@ -50,6 +50,7 @@
 static int fnkeyinit; /* = 0 */
 static int camera; /* = 0 */
 static int compat; /* = 0 */
+static int nojogdial; /* = 0 */
 
 /* Inits the queue */
 static inline void sonypi_initq(void) {
@@ -310,24 +311,28 @@
 	int i;
 	u8 sonypi_jogger_ev, sonypi_fnkey_ev;
 	u8 sonypi_capture_ev, sonypi_bluetooth_ev;
+	u8 sonypi_pkey_ev;
 
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
 		sonypi_jogger_ev = SONYPI_TYPE2_JOGGER_EV;
 		sonypi_fnkey_ev = SONYPI_TYPE2_FNKEY_EV;
 		sonypi_capture_ev = SONYPI_TYPE2_CAPTURE_EV;
 		sonypi_bluetooth_ev = SONYPI_TYPE2_BLUETOOTH_EV;
+		sonypi_pkey_ev = nojogdial ? SONYPI_TYPE2_PKEY_EV 
+					   : SONYPI_TYPE1_PKEY_EV;
 	}
 	else {
 		sonypi_jogger_ev = SONYPI_TYPE1_JOGGER_EV;
 		sonypi_fnkey_ev = SONYPI_TYPE1_FNKEY_EV;
 		sonypi_capture_ev = SONYPI_TYPE1_CAPTURE_EV;
 		sonypi_bluetooth_ev = SONYPI_TYPE1_BLUETOOTH_EV;
+		sonypi_pkey_ev = SONYPI_TYPE1_PKEY_EV;
 	}
 
 	v1 = inb_p(sonypi_device.ioport1);
 	v2 = inb_p(sonypi_device.ioport2);
 
-	if ((v2 & SONYPI_TYPE1_PKEY_EV) == SONYPI_TYPE1_PKEY_EV) {
+	if ((v2 & sonypi_pkey_ev) == sonypi_pkey_ev) {
 		for (i = 0; sonypi_pkeyev[i].event; i++)
 			if (sonypi_pkeyev[i].data == v1) {
 				event = sonypi_pkeyev[i].event;
@@ -713,11 +718,12 @@
 	       SONYPI_DRIVER_MAJORVERSION,
 	       SONYPI_DRIVER_MINORVERSION);
 	printk(KERN_INFO "sonypi: detected %s model, "
-	       "camera = %s, compat = %s\n",
+	       "camera = %s, compat = %s, nojogdial = %s\n",
 	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
 			"type1" : "type2",
 	       camera ? "on" : "off",
-	       compat ? "on" : "off");
+	       compat ? "on" : "off",
+	       nojogdial ? "on" : "off");
 	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
 	       sonypi_device.irq, 
 	       sonypi_device.ioport1, sonypi_device.ioport2);
@@ -773,7 +779,7 @@
 
 #ifndef MODULE
 static int __init sonypi_setup(char *str)  {
-	int ints[6];
+	int ints[7];
 
 	str = get_options(str, ARRAY_SIZE(ints), ints);
 	if (ints[0] <= 0) 
@@ -791,6 +797,9 @@
 	if (ints[0] == 4)
 		goto out;
 	compat = ints[5];
+	if (ints[0] == 5)
+		goto out;
+	nojogdial = ints[6];
 out:
 	return 1;
 }
@@ -817,5 +826,7 @@
 MODULE_PARM_DESC(camera, "set this if you have a MotionEye camera (PictureBook series)");
 MODULE_PARM(compat,"i");
 MODULE_PARM_DESC(compat, "set this if you want to enable backward compatibility mode");
+MODULE_PARM(nojogdial, "i");
+MODULE_PARM_DESC(nojogdial, "set this if you have a Vaio without a jogdial (like the fx series)");
 
 EXPORT_SYMBOL(sonypi_camera_command);
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	Wed Apr 17 16:14:01 2002
+++ b/drivers/char/sonypi.h	Wed Apr 17 16:14:01 2002
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	10
+#define SONYPI_DRIVER_MINORVERSION	12
 
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -141,6 +141,7 @@
 #define SONYPI_TYPE1_BLUETOOTH_EV	0x30
 #define SONYPI_TYPE2_BLUETOOTH_EV	0x08
 #define SONYPI_TYPE1_PKEY_EV		0x40
+#define SONYPI_TYPE2_PKEY_EV		0x08
 #define SONYPI_BACK_EV			0x08
 #define SONYPI_LID_EV			0x38
 

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch15352
M'XL(`"F#O3P``\U7^V_:2!#^V?XK1D1WE[0\=M?K%Q'7]`*]0VT21"[116F%
MMO:"W8`7V880'7_\C>T`22"/THM4`UZ\.SOSS>.;A1TX2V1<UY)4#D,1Z3OP
METK2NC96XU`FU4BF.-55"J=J@1K)6AI&H9K4KF0<R6%M&$:3685531W%.B+U
M`IC*.*EKM&HL9]*;L:QKW=:?9Y_>=W6]T8##0$0#>2I3:#3T5,53,?23`Y$&
M0Q55TUA$R4BFHNJIT7PI.F>$,'R9U#:(:<VI1;@]]ZA/J>!4^H1QQ^(K;6,9
M#2;A,^HXM1AE)C'FE#)&]";0JFDP(*Q&>(W:0*TZ->J&\Y:P.B%P&Z:#57C@
MK0$5HO\!_Z\;A[H''U1\+6(?QBI.H1^K$;`JK^-"!?KA#%3LRQA$Y$-R$Z5B
M!GT5@Q^'F``8BUB@;4P%J`C20$*1,$`LHVP+)D[FFH3OY^N1^J8&?BB&J[V%
M0BE0=@#781K`N0@5?/@'L&30??TC4.9BU#JKA.J5[[QTG0BB_XY6L50VQZZI
MO,E(HHMIJ*):HJ*;<5A-9W="Z5)BT#DGILWGGL<Y=>A7YE-7<.%NR-DS&CFU
M*:>&P>:6R6W^-+@BX$G-"T2\T.2M(:,VM^:&2?J.;3N<<,?Q3&L3LB?4K6!1
M;AGV]\,*UF$YKCTW+,]%-_O,MOL6]>V7P@H>PN+<LNV<WX_%-Z/[JR5:]\54
M?CM()HFL^O*Y'*,>ES'*YR:GIIL3WUZC/7N"]B94V*O0_N=A=U'^)U")K_,W
MLK7S:&ZW8'[3<('J[?S>+%Q3XTQM4M>;W,K6\KM66&F,PDC%EV64^ZH2>5GN
M1U?R!L^C]++LH5.QP%&-L,`NRTN'OV27WK89&/IG75O.U[4!&DQ@I&()PO,F
ML4@E=#ZV+D!.T;W;T**=(BXCY<MAHFN:=AV$>*CY*OHMA0!+#@0L@KL[#*]D
M'O!E&/>J.2,V\OH9.OQ`:WG`A:>ZRI((W&$NWX((%)G`7XD)/W@ZY7WR0?UN
MC,46Q=LV&99FDO'`@S!*5QCWH?8&&D#@30V+FV9BVL2!PE9OC#7;D]/];,D!
MAA5U?P%WKKQ]!Z<GQQ>==N_OBTZ+];+R[+7.(2M#30.`^MUUNEC/=#.>F5W7
MO5F^:1@DIV(^:&$?=G>G#'Y]`'H/*W9MZE^]:=.<K,60X<JN4L%)M/E+4H:"
MF+</*P>SY\]1J8PZ6(X@&]A2Q^VN=U!240F]+:E^'X47RW<#=5=B#SVR[0)3
M/FA9@O"37-I?,#JV:V`[R-W,)\F7S#%S#P,V4*D"-4GW[_0*1)F+6=E>A[H(
M\.BD>?:IU>N\[Q[M+N7*4`HSVW<6>\W6Z>$]B00YDP9A`FC]1DT6+20OWJR,
MT?;&CM*?+3I*9N*QGA)LT5->^+O@!3TE6.LIC#ALBY["H$)_RI92_,9Y04L)
MMCH/G9R$V7W'EWT\Q1=\;7;;YZUN[ZA]?-+%+Z?MDV.-,KU-N;$N?*]9:!J9
<$6?U_\P+I'>53$8-XOHN,RQ+_P]JG;!2!`X`````
`
end

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
