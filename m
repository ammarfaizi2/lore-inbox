Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVD2KYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVD2KYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 06:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVD2KYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 06:24:31 -0400
Received: from relay.rost.ru ([80.254.111.11]:55432 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S262271AbVD2KYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 06:24:16 -0400
Date: Fri, 29 Apr 2005 14:24:11 +0400
From: Andrey Panin <pazke@donpac.ru>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] add SIIG Quartet Serial support
Message-ID: <20050429102411.GH8497@pazke>
Mail-Followup-To: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
X-Uname: Linux 2.6.12-rc2-mm1-pazke i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

attached patch adds support for SIIG Quartet Serial card.
This card has Oxford Semiconducor 16954 quad UART which is
clocked by 10x faster (18.432 MHz) quartz.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-siig-quartet-serial

diff -urdpNX /usr/share/dontdiff linux-2.6.11.vanilla/drivers/serial/8250_pci.c linux-2.6.11/drivers/serial/8250_pci.c
--- linux-2.6.11.vanilla/drivers/serial/8250_pci.c	2005-03-02 10:38:17.000000000 +0300
+++ linux-2.6.11/drivers/serial/8250_pci.c	2005-04-29 12:16:43.000000000 +0400
@@ -387,6 +387,9 @@ static void __devexit sbs_exit(struct pc
  *     - 10x cards have control registers in IO and/or memory space;
  *     - 20x cards have control registers in standard PCI configuration space.
  *
+ * There are also Quartet Serial cards which use Oxford Semiconductor
+ * 16954 quad UART PCI chip clocked by 18.432 MHz quartz.
+ *
  * Note: some SIIG cards are probed by the parport_serial object.
  */
 
@@ -1014,6 +1017,8 @@ enum pci_board_num_t {
 	pbn_b0_bt_4_921600,
 	pbn_b0_bt_8_921600,
 
+	pbn_b0_4_1152000,
+
 	pbn_b1_1_115200,
 	pbn_b1_2_115200,
 	pbn_b1_4_115200,
@@ -1196,6 +1201,12 @@ static struct pci_board pci_boards[] __d
 		.base_baud	= 921600,
 		.uart_offset	= 8,
 	},
+	[pbn_b0_4_1152000] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 1152000,
+		.uart_offset	= 8,
+	},
 
 	[pbn_b1_1_115200] = {
 		.flags		= FL_BASE1,
@@ -1940,6 +1951,9 @@ static struct pci_device_id serial_pci_t
 		PCI_VENDOR_ID_SPECIALIX, PCI_SUBDEVICE_ID_SPECIALIX_SPEED4, 0, 0,
 		pbn_b0_4_921600 },
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
+		PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_QUARTET_SERIAL, 0, 0,
+		pbn_b0_4_1152000 },
+	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_4_115200 },
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
diff -urdpNX /usr/share/dontdiff linux-2.6.11.vanilla/include/linux/pci_ids.h linux-2.6.11/include/linux/pci_ids.h
--- linux-2.6.11.vanilla/include/linux/pci_ids.h	2005-03-02 10:38:37.000000000 +0300
+++ linux-2.6.11/include/linux/pci_ids.h	2005-04-29 11:45:19.000000000 +0400
@@ -1730,6 +1730,7 @@
 #define PCI_DEVICE_ID_CBOARDS_DAS1602_16 0x0001
 
 #define PCI_VENDOR_ID_SIIG		0x131f
+#define PCI_SUBVENDOR_ID_SIIG		0x131f
 #define PCI_DEVICE_ID_SIIG_1S_10x_550	0x1000
 #define PCI_DEVICE_ID_SIIG_1S_10x_650	0x1001
 #define PCI_DEVICE_ID_SIIG_1S_10x_850	0x1002
@@ -1767,6 +1768,7 @@
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_550	0x2060
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_650	0x2061
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_850	0x2062
+#define PCI_SUBDEVICE_ID_SIIG_QUARTET_SERIAL	0x2050
 
 #define PCI_VENDOR_ID_RADISYS		0x1331
 #define PCI_DEVICE_ID_RADISYS_ENP2611	0x0030

--ieNMXl1Fr3cevapt--
