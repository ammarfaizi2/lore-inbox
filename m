Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbUK0OCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbUK0OCy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 09:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUK0OCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 09:02:54 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:23002 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261209AbUK0OCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 09:02:46 -0500
Message-ID: <41A88904.3070305@free.fr>
Date: Sat, 27 Nov 2004 15:02:44 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: Li Shaohua <shaohua.li@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>  <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>  <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>  <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>  <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee>  <41A0DB78.2010807@free.fr> <Pine.SOC.4.61.0411212050490.11420@math.ut.ee>  <41A0F893.9020106@free.fr> <1101086961.2940.7.camel@sli10-desk.sh.intel.com> <Pine.SOC.4.61.0411221016270.16427@math.ut.ee> <41A753A0.1070305@free.fr> <Pine.SOC.4.61.0411262018170.26264@math.ut.ee> <41A7CF6A.8010603@free.fr> <Pine.SOC.4.61.0411271411190.1904@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0411271411190.1904@math.ut.ee>
Content-Type: multipart/mixed;
 boundary="------------040104010308080502030205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040104010308080502030205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
Meelis Roos wrote:
>> That's because resource point at the end of the resources list, so 
>> there is nothing to read. With this patch, you should see something.
> 
> 
> On bootup there are loads on lines 167 and 472.
> 
> On auto there are none.
> 
> On activate there are
> ******846*******
> pnp: Device 00:0a activated.
> 
> On modprobe smsc-ircc2 there are no more debug lines, just
> found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
> smsc_superio_flat(): IrDA not enabled
> smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02
> 
> And I checked that I am using the new patch.
> 
thanks.
it seems there is no resource in your __CRS. Like Shaohua said the acpi 
spec say that it must return valid template even if the device is 
disable [1].

Just for confirmation, could you try this patch. It should enable 
pnp_dbg message and print your _CRS when you activate the device.
If there is nothing between ******574******* and ******857*******, you 
bios is likely broken.


thanks

Matthieu CASTET



[1]
If a device is disabled, then _CRS returns a valid resource template for 
the device, but the actual
resource assignments in the return byte stream are ignored. If the 
device is disabled when _CRS is called, it
must remain disabled.


--------------040104010308080502030205
Content-Type: text/x-patch;
 name="rs2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rs2.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/rsparser.c.int	2004-11-27 01:46:10.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/rsparser.c	2004-11-27 14:11:32.000000000 +0100
@@ -29,6 +29,22 @@
 #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
 #endif
 
+static int first = 1;
+static void debug_pnp(struct acpi_resource *res, int line) {
+	int tmp = acpi_dbg_level;
+	int tmp1 = acpi_dbg_layer;
+	if (!first)
+		return;
+	first = 0;
+
+	acpi_dbg_level = 0x00010000;
+	acpi_dbg_layer = 0x00000100;
+	printk("******%d*******\n",line);
+	ACPI_DUMP_RESOURCE_LIST(res);
+	acpi_dbg_level = tmp;
+	acpi_dbg_layer = tmp1;
+}
+	
 /*
  * Allocated Resources
  */
@@ -152,6 +168,8 @@
 {
 	struct pnp_resource_table * res_table = (struct pnp_resource_table *)data;
 
+	debug_pnp(res,__LINE__);
+
 	switch (res->id) {
 	case ACPI_RSTYPE_IRQ:
 		if ((res->data.irq.number_of_interrupts > 0) &&
@@ -233,6 +251,7 @@
 	/* Blank the resource table values */
 	pnp_init_resource_table(res);
 
+	first = 1;
 	return acpi_walk_resources(handle, METHOD_NAME__CRS, pnpacpi_allocated_resource, res);
 }
 
@@ -455,6 +474,8 @@
 	struct pnp_dev *dev = parse_data->dev;
 	struct pnp_option *option = parse_data->option;
 
+	//debug_pnp(res,__LINE__);
+
 	switch (res->id) {
 		case ACPI_RSTYPE_IRQ:
 			pnpacpi_parse_irq_option(option, &res->data.irq);
@@ -535,6 +556,7 @@
 		return AE_ERROR;
 	parse_data.independent_option = parse_data.option;
 	parse_data.dev = dev;
+	first=1;
 	status = acpi_walk_resources(handle, METHOD_NAME__PRS, 
 		pnpacpi_option_resource, &parse_data);
 
@@ -548,6 +570,9 @@
 	void *data)
 {
 	int *res_cnt = (int *)data;
+
+	debug_pnp(res,__LINE__);
+
 	switch (res->id) {
 	case ACPI_RSTYPE_IRQ:
 	case ACPI_RSTYPE_EXT_IRQ:
@@ -603,6 +628,7 @@
 	int res_cnt = 0;
 	acpi_status status;
 
+	first = 1;
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
 		pnpacpi_count_resources, &res_cnt);
 	if (ACPI_FAILURE(status)) {
@@ -765,6 +791,7 @@
 	/* pnpacpi_build_resource_template allocates extra mem */
 	int res_cnt = (buffer->length - 1)/sizeof(struct acpi_resource) - 1;
 	struct acpi_resource *resource = (struct acpi_resource*)buffer->pointer;
+	struct acpi_resource *res = resource;
 	int port = 0, irq = 0, dma = 0, mem = 0;
 
 	pnp_dbg("res cnt %d", res_cnt);
@@ -826,5 +853,8 @@
 		resource ++;
 		i ++;
 	}
+	first=1;
+	debug_pnp(res,__LINE__);
+
 	return 0;
 }
--- linux-2.6.9/drivers/pnp/pnpacpi/pnpacpi.h.old	2004-11-27 14:54:22.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/pnpacpi.h	2004-11-27 14:14:00.000000000 +0100
@@ -1,6 +1,8 @@
 #ifndef ACPI_PNP_H
 #define ACPI_PNP_H
 
+#define DEBUG
+
 #include <acpi/acpi_bus.h>
 #include <linux/acpi.h>
 #include <linux/pnp.h>

--------------040104010308080502030205--
