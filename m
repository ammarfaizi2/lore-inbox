Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268149AbRG3I0j>; Mon, 30 Jul 2001 04:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268157AbRG3I03>; Mon, 30 Jul 2001 04:26:29 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:16394 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S268149AbRG3I0T>;
	Mon, 30 Jul 2001 04:26:19 -0400
Date: Mon, 30 Jul 2001 12:26:24 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PNP BIOS fixes and additions
Message-ID: <20010730122624.B21907@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 11:14am  up 2 days, 18:18,  2 users,  load average: 0.46, 0.93, 0.65
X-Uname: Linux orbita1.ru 2.2.20pre2-acl 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--d01dLTUuW90fS44H
Content-Type: multipart/mixed; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

changes in this patch (applies to 2.4.7-ac3):
	- added '#ifdef CONFIG_HOTPLUG' aroud pnp_bios_dock_station_info() functio=
n=20
	  to shut up gcc warning;
	- better fix for pnpid32_to_pnpid() function (suggested by David Hinds);
	- pnpbios_rawdata_2_pci_dev(), pnpid32_to_pnpid() and pnpbios_insert_devic=
e()
	  functions declared __init;
	- added memory region, fixed location IO and and (most important !) device=
 name
	  parsing to pnpbios_rawdata_2_pci_dev() function.

Tested with 2.4.7-ac1 on my new SMP motherboard :)

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pnpbios
Content-Transfer-Encoding: quoted-printable

diff -urN linux.vanilla/drivers/pnp/pnp_bios.c linux/drivers/pnp/pnp_bios.c
--- linux.vanilla/drivers/pnp/pnp_bios.c	Mon Jul 30 12:01:10 2001
+++ linux/drivers/pnp/pnp_bios.c	Mon Jul 30 12:08:48 2001
@@ -290,6 +290,7 @@
 }
 #endif
=20
+#ifdef CONFIG_HOTPLUG
 /*
  * Call pnp bios with function 0x05, "get docking station information"
  */
@@ -303,6 +304,7 @@
 	status =3D call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1,=
 PNP_DS, 0, 0, 0, 0);
 	return status;
 }
+#endif
=20
 /*
  * Call pnp bios with function 0x09, "set statically allocated resource
@@ -630,16 +632,66 @@
 EXPORT_SYMBOL(pnp_bios_present);
 EXPORT_SYMBOL(pnp_bios_dev_node_info);
=20
+static void inline pnpbios_add_irqresource(struct pci_dev *dev, int irq)
+{
+	int i =3D 0;
+	while (dev->irq_resource[i].start && i < DEVICE_COUNT_IRQ) i++;
+	if (i < DEVICE_COUNT_IRQ)
+		dev->irq_resource[i].start =3D irq;
+}
+
+static void inline pnpbios_add_dmaresource(struct pci_dev *dev, int dma)
+{
+	int i =3D 0;
+	while (dev->dma_resource[i].start && i < DEVICE_COUNT_DMA) i++;
+	if (i < DEVICE_COUNT_DMA)
+		dev->dma_resource[i].start =3D dma;
+}
+
+static void __init pnpbios_add_ioresource(struct pci_dev *dev, int io,=20
+					  int len, int flags)
+{
+	int i =3D 0;
+	while (dev->resource[i].start && i < DEVICE_COUNT_RESOURCE) i++;
+	if (i < DEVICE_COUNT_RESOURCE) {
+		dev->resource[i].start =3D io;
+		dev->resource[i].end =3D io + len;
+		dev->resource[i].flags =3D IORESOURCE_MEM;
+	}
+}
+
 /* parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_=
dev */
-static void pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct p=
ci_dev *pci_dev)
+static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, s=
truct pci_dev *pci_dev)
 {
 	unsigned char *p =3D node->data, *lastp=3DNULL;
         int mask,i,io,irq=3D0,len,dma=3D-1;
=20
+	memset(pci_dev, 0, sizeof(struct pci_dev));
         while ( (char *)p < ((char *)node->data + node->size )) {
         	if(p=3D=3Dlastp) break;
=20
                 if( p[0] & 0x80 ) {// large item
+			switch (p[0] & 0x7f) {
+			case 0x01: // memory
+				io =3D *(short *) &p[4];
+				len =3D *(short *) &p[10];
+				pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_MEM);
+				break;
+			case 0x02: // device name
+				len =3D *(short *) &p[1];
+				memcpy(pci_dev->name, p + 3, len >=3D 80 ? 79 : len);
+				break;
+			case 0x05: // 32-bit memory
+				io =3D *(int *) &p[4];
+				len =3D *(int *) &p[16];
+				pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_MEM);
+				break;
+			case 0x06: // fixed location 32-bit memory
+				io =3D *(int *) &p[4];
+				len =3D *(int *) &p[8];
+				pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_MEM);
+				break;
+			}
                         lastp =3D p+3;
                         p =3D p + p[1] + p[2]*256 + 3;
                         continue;
@@ -651,36 +703,24 @@
                         mask=3D p[1] + p[2]*256;
                         for (i=3D0;i<16;i++, mask=3Dmask>>1)
                                 if(mask &0x01) irq=3Di;
-			i=3D0;
-			while(pci_dev->irq_resource[i].start && i<DEVICE_COUNT_IRQ)
-				i++;
-			if(i<DEVICE_COUNT_IRQ)
-				pci_dev->irq_resource[i].start=3Dirq;
+			pnpbios_add_irqresource(pci_dev, irq);
                         break;
                 case 0x05: // dma
                         mask =3D p[1];
                         for (i=3D0;i<8;i++, mask =3D mask>>1)
                                 if(mask&0x01) dma=3Di;
-			i=3D0;
-                        while(pci_dev->dma_resource[i].start && i<DEVICE_C=
OUNT_DMA)
-                                i++;
-                        if(i<DEVICE_COUNT_DMA)
-                                pci_dev->dma_resource[i].start=3Ddma;
-
+			pnpbios_add_dmaresource(pci_dev, dma);
                         break;
                 case 0x08: // io
 			io=3D p[2] + p[3] *256;
 			len =3D p[7];
-			i=3D0;
-                        while(pci_dev->resource[i].start && i<DEVICE_COUNT=
_RESOURCE)
-                                i++;
-                        if(i<DEVICE_COUNT_RESOURCE) {
-                                pci_dev->resource[i].start=3Dio;
-				pci_dev->resource[i].end=3Dio+len;
-				pci_dev->resource[i].flags=3DIORESOURCE_IO;
-			}
-
+			pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_IO);
                         break;
+		case 0x09: // fixed location io
+			io =3D p[1] + p[2] * 256;
+			len =3D p[3];
+			pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_IO);
+			break;
                 }
                 lastp=3Dp+1;
                 p =3D p + (p[0] & 0x07) + 1;
@@ -691,21 +731,21 @@
 #define HEX(id,a) hex[((id)>>a) & 15]
 #define CHAR(id,a) (0x40 + (((id)>>a) & 31))
=20
-static char *pnpid32_to_pnpid(u32 id)
+static char * __init pnpid32_to_pnpid(u32 id)
 {
 	const char *hex =3D "0123456789abcdef";
         static char str[8];
-	id =3D cpu_to_le32(id);
-	str[0] =3D CHAR(id, 2);
-	str[1] =3D CHAR((((id & 3) << 3) | ((id >> 13) & 7)), 0);
-	str[2] =3D CHAR(id, 8);
-	str[3] =3D HEX(id, 20);
-	str[4] =3D HEX(id, 16);
-	str[5] =3D HEX(id, 28);
-	str[6] =3D HEX(id, 24);
+	id =3D be32_to_cpu(id);
+	str[0] =3D CHAR(id, 26);
+	str[1] =3D CHAR(id, 21);
+	str[2] =3D CHAR(id,16);
+	str[3] =3D HEX(id, 12);
+	str[4] =3D HEX(id, 8);
+	str[5] =3D HEX(id, 4);
+	str[6] =3D HEX(id, 0);
 	str[7] =3D '\0';
 	return str;
-}
+}                                             =20
=20
 #undef CHAR
 #undef HEX =20
@@ -716,7 +756,7 @@
=20
 static LIST_HEAD(pnpbios_devices);
=20
-static int pnpbios_insert_device(struct pci_dev *dev)
+static int __init pnpbios_insert_device(struct pci_dev *dev)
 {
 	/* FIXME: Need to check for re-add of existing node */
 	list_add_tail(&dev->global_list, &pnpbios_devices);

--eRtJSFbw+EEWtPj3--

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZRowBm4rlNOo3YgRAgtqAJ9HhlUeuokZNNeRNMXQef/OX8F0HgCghSNZ
wrZTD6FW8lzGIoM2khbWsC8=
=aGTR
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
