Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVBIRYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVBIRYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 12:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVBIRYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 12:24:50 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:49026 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261856AbVBIRY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 12:24:28 -0500
Message-ID: <420A474B.2030608@acm.org>
Date: Wed, 09 Feb 2005 11:24:27 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Update to IPMI driver to support old DMI spec
Content-Type: multipart/mixed;
 boundary="------------070803070304050808050104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070803070304050808050104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

BTW, I'm also working with the person who had the trouble with the I2C 
non-blocking driver updates, but we haven't figured it out yet.  
Hopefully soon.  (Though that has nothing to do with this patch.)

Thanks,

-Corey

--------------070803070304050808050104
Content-Type: text/plain;
 name="ipmi_olddmi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_olddmi.diff"

The 1999 version of the DMI spec had a different configuration
than the newer versions for the IPMI configuration information.
This patch handles the differences between the two.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc3/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.11-rc3.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.11-rc3/drivers/char/ipmi/ipmi_si_intf.c
@@ -1578,46 +1578,53 @@
 	u8		*data = (u8 *)dm;
 	unsigned long  	base_addr;
 	u8		reg_spacing;
+	u8              len = dm->length; 
 	dmi_ipmi_data_t *ipmi_data = dmi_data+intf_num;
 
 	ipmi_data->type = data[4];
 
 	memcpy(&base_addr, data+8, sizeof(unsigned long));
-	if (base_addr & 1) {
-		/* I/O */
-		base_addr &= 0xFFFE;
+	if (len >= 0x11) {
+		if (base_addr & 1) {
+			/* I/O */
+			base_addr &= 0xFFFE;
+			ipmi_data->addr_space = IPMI_IO_ADDR_SPACE;
+		}
+		else {
+			/* Memory */
+			ipmi_data->addr_space = IPMI_MEM_ADDR_SPACE;
+		}
+		/* If bit 4 of byte 0x10 is set, then the lsb for the address
+		   is odd. */
+		ipmi_data->base_addr = base_addr | ((data[0x10] & 0x10) >> 4);
+
+		ipmi_data->irq = data[0x11];
+
+		/* The top two bits of byte 0x10 hold the register spacing. */
+		reg_spacing = (data[0x10] & 0xC0) >> 6;
+		switch(reg_spacing){
+		case 0x00: /* Byte boundaries */
+		    ipmi_data->offset = 1;
+		    break;
+		case 0x01: /* 32-bit boundaries */
+		    ipmi_data->offset = 4;
+		    break;
+		case 0x02: /* 16-byte boundaries */
+		    ipmi_data->offset = 16;
+		    break;
+		default:
+		    /* Some other interface, just ignore it. */
+		    return -EIO;
+		}
+	} else {
+		/* Old DMI spec. */
+		ipmi_data->base_addr = base_addr;
 		ipmi_data->addr_space = IPMI_IO_ADDR_SPACE;
-	}
-	else {
-		/* Memory */
-		ipmi_data->addr_space = IPMI_MEM_ADDR_SPACE;
-	}
-
-	/* The top two bits of byte 0x10 hold the register spacing. */
-	reg_spacing = (data[0x10] & 0xC0) >> 6;
-	switch(reg_spacing){
-	case 0x00: /* Byte boundaries */
 		ipmi_data->offset = 1;
-		break;
-	case 0x01: /* 32-bit boundaries */
-		ipmi_data->offset = 4;
-		break;
-	case 0x02: /* 16-byte boundaries */
-		ipmi_data->offset = 16;
-		break;
-	default:
-		/* Some other interface, just ignore it. */
-		return -EIO;
 	}
 
 	ipmi_data->slave_addr = data[6];
 
-	/* If bit 4 of byte 0x10 is set, then the lsb for the address
-	   is odd. */
-	ipmi_data->base_addr = base_addr | ((data[0x10] & 0x10) >> 4);
-
-	ipmi_data->irq = data[0x11];
-
 	if (is_new_interface(-1, ipmi_data->addr_space,ipmi_data->base_addr)) {
 		dmi_data_entries++;
 		return 0;

--------------070803070304050808050104--
