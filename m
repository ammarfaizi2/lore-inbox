Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266928AbSLDRLB>; Wed, 4 Dec 2002 12:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSLDRLB>; Wed, 4 Dec 2002 12:11:01 -0500
Received: from host194.steeleye.com ([66.206.164.34]:3334 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266928AbSLDRK7>; Wed, 4 Dec 2002 12:10:59 -0500
Message-Id: <200212041718.gB4HIO702869@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: mj@ucw.cz
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: [BKPATCH] allow pci primary peer busses to have parents
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Dec 2002 11:18:24 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the generic device model allows a coherent bus tree to be built, 
there are certain architectures that hang the PCI primary busses off another 
bus (I need this patch for parisc, but I'm sure infiniband would have similar 
issues).

This patch allows the allocation of parented pci primary peer busses so that 
they slot correctly into the device model.

James

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.927, 2002-12-03 09:28:37-06:00, jejb@raven.il.steeleye.com
  allow pci primary busses to have parents in the device model


 drivers/pci/probe.c |    7 ++++---
 include/linux/pci.h |   12 ++++++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Wed Dec  4 11:11:38 2002
+++ b/drivers/pci/probe.c	Wed Dec  4 11:11:38 2002
@@ -547,7 +547,7 @@
 	return 0;
 }
 
-struct pci_bus * __devinit pci_alloc_primary_bus(int bus)
+struct pci_bus * __devinit pci_alloc_primary_bus_parented(struct device 
*parent, int bus)
 {
 	struct pci_bus *b;
 
@@ -566,6 +566,7 @@
 	memset(b->dev,0,sizeof(*(b->dev)));
 	sprintf(b->dev->bus_id,"pci%d",bus);
 	strcpy(b->dev->name,"Host/PCI Bridge");
+	b->dev->parent = parent;
 	device_register(b->dev);
 
 	b->number = b->secondary = bus;
@@ -574,9 +575,9 @@
 	return b;
 }
 
-struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops, void 
*sysdata)
+struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int 
bus, struct pci_ops *ops, void *sysdata)
 {
-	struct pci_bus *b = pci_alloc_primary_bus(bus);
+	struct pci_bus *b = pci_alloc_primary_bus_parented(parent, bus);
 	if (b) {
 		b->sysdata = sysdata;
 		b->ops = ops;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Wed Dec  4 11:11:38 2002
+++ b/include/linux/pci.h	Wed Dec  4 11:11:38 2002
@@ -520,8 +520,16 @@
 /* Generic PCI functions used internally */
 
 int pci_bus_exists(const struct list_head *list, int nr);
-struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
-struct pci_bus *pci_alloc_primary_bus(int bus);
+struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus, struct 
pci_ops *ops, void *sysdata);
+static inline struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void 
*sysdata)
+{
+	return pci_scan_bus_parented(NULL, bus, ops, sysdata);
+}
+struct pci_bus *pci_alloc_primary_bus_parented(struct device * parent, int 
bus);
+static inline struct pci_bus *pci_alloc_primary_bus(int bus)
+{
+	return pci_alloc_primary_bus_parented(NULL, bus);
+}
 struct pci_dev *pci_scan_slot(struct pci_dev *temp);
 int pci_proc_attach_device(struct pci_dev *dev);
 int pci_proc_detach_device(struct pci_dev *dev);

===================================================================


This BitKeeper patch contains the following changesets:
1.927
## Wrapped with gzip_uu ##


begin 664 bkpatch568
M'XL(`$HW[CT``\U6:V_3,!3]7/^**_%EC"7U(\].G<9+@)A@&MHGA"HW,6NV
M-*ELIS`1_CO7R>C&:,LV@413Q9)S?>\YQ_<X>02G1NG1X%R=3\DC>%T;.QIH
MN5257Y2^L4J5ZE+Y63W'IR=UC4^'LWJNAF[!\-G;X2(KO(74JK)%=>9Q/_1#
M2C#V6-IL!DNES6C`?+&:L9<+-1J<O'QU>O3TA)#Q&)[/9'6F/B@+XS&QM5[*
M,C>'TL[*NO*MEI69*RL=A'85VG)*.5XABP4-HY9%-(C;C.6,R8"IG/(@B8+K
M;`[RUER,\9AS(<*DI0D5G+P`YJ<\!LJ'C`^I`)J.>#(2L4>C$:7@^!^N%0J>
M</`H>09_E\MSDH$LR_H+H.2PT,5<ZDN8-L8H@Z5@AEB@WPD#105VIB!7RR)3
M,*]S59*W$"%-<GPM./'N^2.$2DH.,&$V4^6A46>?95-:OS9YZ=?ZK,UUX;;<
M=<5PH>LI"M+3"Q@6YZ%(VU"@OFV:Y"J@4\DRFH8AS;;HN3$IXU2PD,=AW*)"
M,4-@VR4OJJQL<C4LBZKYZM+YLYOBIP%M&1-QU$9<)(E4/$]#F49!N@W=IJ0W
MT-&`1[SK]3547-?_?3U)45T<GC=:&E-D/K;%A3\WC:^;CS\E^K195X3.XH`A
M<I'$-.Z\P.FO5HA'X5VL$(`G_D<K]`WS'CS]I?MC;Q^OVYT'6.0%Z@^,O.D'
M8W6360=T@@!A%R83!Z4J^CE'(YM<47`1DQZWRG>N5EX!W^WG]Y"/=50?8X$H
MP0*#J7>`,=Y!'P#C*^;[""2..R#=\`<@)I/5?>KOP8V$]0(3XFT/EG61PZZY
M-+FT\K&#D/80W#"XC6'JT&Y7X6=91WF_\]`:P_WYS?%@Z]_%2!N/`,8Y2VD0
M1*U(61)U1@K%@XS$*'C\OW22.]MN&6F-(`\R$A?`L7EX`(S^UL#_K&OWL92T
M18:+D("";85W[F6';V2@E6UTM<%R[TZ/CO;Z=-WR:T3?U]*_^^D!MX^/NY#\
H+?W.ZO#YE<D6'"M*'8G59R"^[[(+T\S'TSQA:(XI^0$X3;EMB@H`````
`
end


