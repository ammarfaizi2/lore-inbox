Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbSLDRCB>; Wed, 4 Dec 2002 12:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbSLDRCB>; Wed, 4 Dec 2002 12:02:01 -0500
Received: from host194.steeleye.com ([66.206.164.34]:63237 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266981AbSLDRB6>; Wed, 4 Dec 2002 12:01:58 -0500
Message-Id: <200212041709.gB4H9LA02808@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: mochel@osdl.org
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: [BKPATCH] bus notifiers for the generic device model
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Dec 2002 11:09:21 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are certain bus types (notably MCA and parisc internal ones) that like 
to do generic houskeeping operations (claim slots, claim uniform resources 
etc.) when drivers are attached to devices.

I've added a fairly generic notifier callback to the bus_type so that these 
busses can intercept and process the events they're interested in.

At the moment, the only events are attachment and detachment of drivers but in 
principle, more could be added.

James

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.928, 2002-12-04 10:21:28-06:00, jejb@raven.il.steeleye.com
  make bus notify events more general in generic device model

ChangeSet@1.927, 2002-12-03 14:16:53-06:00, jejb@raven.il.steeleye.com
  add device model bus notifier
  
  This adds a bus notifier (per bus type) which is called after a device
  driver successfully attaches to a device.  The idea behind this is
  that there are certain operations that need to be performed globally
  after driver attachment (bus resource claiming etc.).  This notifier
  is set by the bus so that it can do these.


 drivers/base/bus.c     |    4 ++++
 include/linux/device.h |    9 +++++++++
 2 files changed, 13 insertions(+)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Wed Dec  4 11:05:18 2002
+++ b/drivers/base/bus.c	Wed Dec  4 11:05:18 2002
@@ -145,6 +145,8 @@
 		 dev->bus_id,dev->driver->name);
 	list_add_tail(&dev->driver_list,&dev->driver->devices);
 	sysfs_create_link(&dev->driver->kobj,&dev->kobj,dev->kobj.name);
+	if(dev->bus && dev->bus->notify)
+		dev->bus->notify(dev, BUS_NOTIFIER_DRIVER_ATTACHED);
 }
 
 
@@ -260,6 +262,8 @@
 		if (drv->remove)
 			drv->remove(dev);
 		dev->driver = NULL;
+		if(dev->bus && dev->bus->notify)
+			dev->bus->notify(dev, BUS_NOTIFIER_DRIVER_DETACHED);
 	}
 }
 
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Wed Dec  4 11:05:18 2002
+++ b/include/linux/device.h	Wed Dec  4 11:05:18 2002
@@ -58,6 +58,13 @@
 	DEVICE_GONE		= 3,
 };
 
+/* bus notifier events: events that the bus type may choose to be notified
+ * about */
+enum bus_notifier {
+	BUS_NOTIFIER_DRIVER_ATTACHED,
+	BUS_NOTIFIER_DRIVER_DETACHED,
+};
+
 struct device;
 struct device_driver;
 struct device_class;
@@ -75,6 +82,8 @@
 	struct device * (*add)	(struct device * parent, char * bus_id);
 	int		(*hotplug) (struct device *dev, char **envp, 
 				    int num_envp, char *buffer, int buffer_size);
+	/* notify the bus that something happened */
+	void		(*notify)(struct device *dev, enum bus_notifier event);
 };
 
 

===================================================================


This BitKeeper patch contains the following changesets:
1.927..1.928
## Wrapped with gzip_uu ##


begin 664 bkpatch486
M'XL(`,\U[CT``]57:T_C.!3]7/^**XTT`I8\[#S;$8A'F9V*U0YB8#^MA)S$
M;3*3)E7L,E-M]K_O==*4!3I=0"#8-F_;U\?WG'MMOX-+*:I![ZOX&I%W\*F4
M:M"K^+4HS"PWI1(B%PMAQN442\_+$DNMM)P*2S>PCDXMN9!C:41S:12ERL:9
MJ*3!3,_T;((MSKB*4[C&CX,>-9W5%[68B4'O_.37R]\.SPG9VX/CE!<3\44H
MV-LCJJRN>9[(`Z[2O"Q,5?%"3H7B&DB]JEHSVV;X]VC@V)Y?4]]V@SJF":7<
MI2*QF1OZ[HTU#7RC+4I9P)CC>&%MA[;#R!"HV6<!V,RBS+(=H.Z`^@//,6Q_
M8-N@O7"PUEWP"P/#)D?PO&,Y)C'P)(%$7&>Q@&F9B!S0^]!Y'\OQN$@SJ>OA
MY58I;,WPHK]H!K;A>YHA&U@WYGDN$N!CA>5\:1X-)56&[(&<Q[&0<CS/\P5P
MI7B<"K11KJJ:@'T*R!*!'8HT*Q)0&D,FT8A*N<*+J`1P/&-1*9X54"(6KK*R
MD&V-0B`"M!D)P))Q64WQ?9*7$6);Z'$WX):(6A!342C8TN.IA"SG%;HDSGDV
MS8H)"!6;VPVN[)9[\$VBS**%AM3X0I8M@$RA'PI(]*N0PB2G0&U*/7)V(T]B
M//)'B,UMLH]4H<_R@XD0!3=GR0^SE$EN%LA\.R)I15P*"_&8<2L&C[F,XNG5
MOL<"KW;BI.\Y'@_[@2?&`=V@OI_9I`Q5;5.?LIKY`0L1UTP'Y'IQ9D6<SQ-A
MY5DQ_V$MB4Y72F48)Q25&O1#5M.^'86<(X61-^8>WP1N@]U_`?3=P*>$;+!S
M)WB733VG;EEK@S?L@M=%,@>,#ECXFL$[Y=_$34@N0&#W2J(Z,#`FHL"(R`%C
MHWG,XEMQOI1C^"QR?'.TN]3'_.O6U'5<_PW%2X?+\?J>VTQ5]^OJ.>OY\78F
M&T-E-?DI2,HHF@MI6#.*I#3"9_[=28NRMSMIG4*;CCZ#47UO#E3JV1I//T'O
M(^H&P$@O&V\A`&-?=_S^/73/QGX;B=NDU[O[33?8_K`Q!STTT3:<!'=S$74?
MP(D#!GVM7(3,M,)_"6:&U.T#U03IVWKW[\+1Y9>KWS]?C#Z.3LZOAN>C/_!V
M>'%Q>/SI9(CDC)CO:GH?PN\C>AB>K'K0,;\^=^FX?Z%$>B_X-V5/G0"0;.;7
MGD^]5FR^]_]*`.UT?T=FZP?]E"00-#G`VNFTWJW]FH4?[U:5*9=KU[H)[%BD
M=UUF2:^WM;,4U)94U3Q6W:AV_CM9/&;ATW#H/REA],%@KY@PVAG\Q9CT;0@(
M$GEK7],B&72(NAW':JN#T!<0IV4IQ7*+L6R:$-@!'I5SI2D6Q7RJVURM#/]%
M>IL2T.[ZXBY[[)*_/Y`_R3`(47VCH+]!@Q(WI[AEPHU+RF<S=.9#-;<+]U$W
=;M!B[#;<J.'XFYQ/]Y#*,(HC1OX!&:=4)OH/````
`
end


