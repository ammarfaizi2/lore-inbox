Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVI1CuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVI1CuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 22:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbVI1CuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 22:50:13 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:61089 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S965257AbVI1CuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 22:50:12 -0400
Date: Wed, 28 Sep 2005 04:49:56 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Request only really used I/O ports in w83627hf driver
Message-ID: <20050928024956.GA24527@vana.vc.cvut.cz>
References: <20050907181415.GA468@vana.vc.cvut.cz> <20050907210753.3dbad61b.khali@linux-fr.org> <431F4006.6060901@vc.cvut.cz> <20050925195735.1ef98b40.khali@linux-fr.org> <43371F89.7090704@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43371F89.7090704@vc.cvut.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 12:07:05AM +0200, Petr Vandrovec wrote:
> Jean Delvare wrote:
> 
> >I would also want you to check that all of the W83627HF, W83627THF,
> >W83697HF and W83637HF chips do not decode ports other than +5 and +6. I
> >hope and guess so, but if not we will need slightly more complex code.
> 
> I've tested multiple revisions of W83627HF and W83627THF in various Tyan 
> and ASUS boards.  I'll perform some search accross my other computers, but 
> I'm not aware about any using W83697HF or W83637HF.
> 
> Their datasheet has paragraph about LPC interface identical to 
> W83627{HF,THF}, but it may be insufficient for you (spec says 'The first 
> interface uses LPC Bus to access which ports of low byte (bit2-bit0) are 
> defined in the port 5h and 6h. The other higher bits of these ports is set 
>  by W83697HF itself.  The general decoded address is set to port 295h and 
> port 296h.'  It is identical for 627HF, 637HF, 697HF and 627EHF.  For 
> 627THF 'The first interface' is just reworded as THF does not have i2c 
> interface.)
> 
> >Could you please additionally check whether this applies to the
> >W83627EHF/EHG chips as well? Maybe we need to modify the w83627ehf
> >driver in a similar way.
> 
> I'll try them tomorrow, I know we have boards with this chip, unfortunately 
> they run Windows by default, so it will need some preparation.

Hello,
  W83627EHF/EHG behave like other Winbond chips - 290-294 & 297 do nothing.
I've not found any box with 637HF or 697HF, but I just prefer to use no
additional if-s around request/release region.

I've left *_REG_OFFSET at 5/6 to make it simillar to the other drivers as 
much as possible.
						Thanks,
							Petr Vandrovec

---

This patch changes w83627hf and w83627ehf drivers to reserve only ports
0x295-0x296, instead of full 0x290-0x297 range.  While some other sensors
chips respond to all addresses in 0x290-0x297 range, Winbond chips respond
to 0x295-0x296 only (this behavior is implied by documentation, and matches
behavior observed on real systems).  This is not problem alone, as no
BIOS was found to put something at these unused addresses, and sensors
chip itself provides nothing there as well.

But in addition to only respond to these two addresses, also BIOS vendors 
report in their ACPI-PnP structures that there is some resource at I/O 
address 0x295 of length 2.  And when later this hwmon driver attempts to
request region with base 0x290/length 8, it fails as one request_region
cannot span more than one device.

Due to this we have to ask only for region this hardware really occupies,
otherwise driver cannot be loaded on systems with ACPI-PnP enabled.


Signed-off-by:  Petr Vandrovec <vandrove@vc.cvut.cz>


diff -urdN linux/drivers/hwmon/w83627ehf.c linux/drivers/hwmon/w83627ehf.c
--- linux/drivers/hwmon/w83627ehf.c	2005-09-26 21:00:36.000000000 +0200
+++ linux/drivers/hwmon/w83627ehf.c	2005-09-26 23:40:37.000000000 +0200
@@ -105,7 +105,9 @@
  * ISA constants
  */
 
-#define REGION_LENGTH		8
+#define REGION_ALIGNMENT	~7
+#define REGION_OFFSET		5
+#define REGION_LENGTH		2
 #define ADDR_REG_OFFSET		5
 #define DATA_REG_OFFSET		6
 
@@ -673,7 +675,8 @@
 	struct w83627ehf_data *data;
 	int i, err = 0;
 
-	if (!request_region(address, REGION_LENGTH, w83627ehf_driver.name)) {
+	if (!request_region(address + REGION_OFFSET, REGION_LENGTH,
+	                    w83627ehf_driver.name)) {
 		err = -EBUSY;
 		goto exit;
 	}
@@ -762,7 +765,7 @@
 exit_free:
 	kfree(data);
 exit_release:
-	release_region(address, REGION_LENGTH);
+	release_region(address + REGION_OFFSET, REGION_LENGTH);
 exit:
 	return err;
 }
@@ -776,7 +779,7 @@
 
 	if ((err = i2c_detach_client(client)))
 		return err;
-	release_region(client->addr, REGION_LENGTH);
+	release_region(client->addr + REGION_OFFSET, REGION_LENGTH);
 	kfree(data);
 
 	return 0;
@@ -807,7 +810,7 @@
 	superio_select(W83627EHF_LD_HWM);
 	val = (superio_inb(SIO_REG_ADDR) << 8)
 	    | superio_inb(SIO_REG_ADDR + 1);
-	*addr = val & ~(REGION_LENGTH - 1);
+	*addr = val & REGION_ALIGNMENT;
 	if (*addr == 0) {
 		superio_exit();
 		return -ENODEV;
diff -urdN linux/drivers/hwmon/w83627hf.c linux/drivers/hwmon/w83627hf.c
--- linux/drivers/hwmon/w83627hf.c	2005-09-26 21:00:36.000000000 +0200
+++ linux/drivers/hwmon/w83627hf.c	2005-09-26 23:30:18.000000000 +0200
@@ -142,10 +142,14 @@
 #define WINB_BASE_REG 0x60
 /* Constants specified below */
 
-/* Length of ISA address segment */
-#define WINB_EXTENT 8
+/* Alignment of the base address */
+#define WINB_ALIGNMENT		~7
 
-/* Where are the ISA address/data registers relative to the base address */
+/* Offset & size of I/O region we are interested in */
+#define WINB_REGION_OFFSET	5
+#define WINB_REGION_SIZE	2
+
+/* Where are the sensors address/data registers relative to the base address */
 #define W83781D_ADDR_REG_OFFSET 5
 #define W83781D_DATA_REG_OFFSET 6
 
@@ -981,7 +985,7 @@
 	superio_select(W83627HF_LD_HWM);
 	val = (superio_inb(WINB_BASE_REG) << 8) |
 	       superio_inb(WINB_BASE_REG + 1);
-	*addr = val & ~(WINB_EXTENT - 1);
+	*addr = val & WINB_ALIGNMENT;
 	if (*addr == 0 && force_addr == 0) {
 		superio_exit();
 		return -ENODEV;
@@ -1000,9 +1004,10 @@
 	const char *client_name = "";
 
 	if(force_addr)
-		address = force_addr & ~(WINB_EXTENT - 1);
+		address = force_addr & WINB_ALIGNMENT;
 
-	if (!request_region(address, WINB_EXTENT, w83627hf_driver.name)) {
+	if (!request_region(address + WINB_REGION_OFFSET, WINB_REGION_SIZE,
+	                    w83627hf_driver.name)) {
 		err = -EBUSY;
 		goto ERROR0;
 	}
@@ -1148,7 +1153,7 @@
       ERROR2:
 	kfree(data);
       ERROR1:
-	release_region(address, WINB_EXTENT);
+	release_region(address + WINB_REGION_OFFSET, WINB_REGION_SIZE);
       ERROR0:
 	return err;
 }
@@ -1163,7 +1168,7 @@
 	if ((err = i2c_detach_client(client)))
 		return err;
 
-	release_region(client->addr, WINB_EXTENT);
+	release_region(client->addr + WINB_REGION_OFFSET, WINB_REGION_SIZE);
 	kfree(data);
 
 	return 0;
