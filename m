Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbUJ3QQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUJ3QQs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUJ3QQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:16:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35088 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261270AbUJ3QCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 12:02:50 -0400
Date: Sat, 30 Oct 2004 17:02:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tim_T_Murphy@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Message-ID: <20041030170247.B15392@flint.arm.linux.org.uk>
Mail-Followup-To: Tim_T_Murphy@Dell.com, linux-kernel@vger.kernel.org
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC6@ausx2kmps304.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC6@ausx2kmps304.aus.amer.dell.com>; from Tim_T_Murphy@Dell.com on Fri, Oct 29, 2004 at 06:30:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 06:30:01PM -0500, Tim_T_Murphy@Dell.com wrote:
> 
> > Well, if you forward lspci -vvx and the "maddr" and "irqno"
> information
> > (in private mail if you prefer) then I'll fix 8250_pci to work.
> 
> maddr:	10		# note, this is for the UP kernel. for SMP,
> maddr=201
> irqno:	ec40
> lspci -d 1028:0008 -vvx:

Ok, could you check whether this patch automatically detects the serial
port please?

Thanks.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/serial/8250_pci.c linux/drivers/serial/8250_pci.c
--- orig/drivers/serial/8250_pci.c	Sat Oct 23 11:39:13 2004
+++ linux/drivers/serial/8250_pci.c	Sat Oct 30 16:57:59 2004
@@ -1026,6 +1026,7 @@ enum pci_board_num_t {
 
 	pbn_b1_bt_2_921600,
 
+	pbn_b1_1_1382400,
 	pbn_b1_2_1382400,
 	pbn_b1_4_1382400,
 	pbn_b1_8_1382400,
@@ -1253,6 +1254,12 @@ static struct pci_board pci_boards[] __d
 		.uart_offset	= 8,
 	},
 
+	[pbn_b1_1_1382400] = {
+		.flags		= FL_BASE1,
+		.num_ports	= 1,
+		.base_baud	= 1382400,
+		.uart_offest	= 8,
+	},
 	[pbn_b1_2_1382400] = {
 		.flags		= FL_BASE1,
 		.num_ports	= 2,
@@ -2109,6 +2116,13 @@ static struct pci_device_id serial_pci_t
 		pbn_b0_bt_1_460800 },
 
 	/*
+	 * Dell Remote Access Card III - Tim_T_Murphy@Dell.com
+	 */
+	{	PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RACIII,
+		PCI_ID_ANY, PCI_ID_ANY, 0, 0,
+		pbn_b1_1_1382400 },
+
+	/*
 	 * RAStel 2 port modem, gerg@moreton.com.au
 	 */
 	{	PCI_VENDOR_ID_MORETON, PCI_DEVICE_ID_RASTEL_2PORT,
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- orig/include/linux/pci_ids.h	Sat Oct 23 11:40:03 2004
+++ linux/include/linux/pci_ids.h	Sat Oct 30 16:52:46 2004
@@ -522,6 +522,7 @@
 #define PCI_DEVICE_ID_AI_M1435		0x1435
 
 #define PCI_VENDOR_ID_DELL              0x1028
+#define PCI_DEVICE_ID_DELL_RACIII	0x0008
 
 #define PCI_VENDOR_ID_MATROX		0x102B
 #define PCI_DEVICE_ID_MATROX_MGA_2	0x0518

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
