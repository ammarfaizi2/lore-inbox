Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbUK0A5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbUK0A5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUK0AzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:55:05 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:41700 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262402AbUK0Aus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:50:48 -0500
Message-ID: <41A7CF6A.8010603@free.fr>
Date: Sat, 27 Nov 2004 01:50:50 +0100
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
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>  <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>  <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>  <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>  <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee>  <41A0DB78.2010807@free.fr> <Pine.SOC.4.61.0411212050490.11420@math.ut.ee>  <41A0F893.9020106@free.fr> <1101086961.2940.7.camel@sli10-desk.sh.intel.com> <Pine.SOC.4.61.0411221016270.16427@math.ut.ee> <41A753A0.1070305@free.fr> <Pine.SOC.4.61.0411262018170.26264@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0411262018170.26264@math.ut.ee>
Content-Type: multipart/mixed;
 boundary="------------010604010901080505060508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010604010901080505060508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Meelis Roos wrote:
>> could you try this patch with the previous one. (You must enable ACPI 
>> DEBUG in kernel config)
> 
> 
> After fixing one res -> resource, it compiled.
Oups that's the wrong fix : there was a line missing in my previous patch

> 
> The output is uninteresting - it only prints one debug message during 
> echoing activate to resources:
> 
That's because resource point at the end of the resources list, so there 
is nothing to read. With this patch, you should see something.

> ******845*******
> pnp: Device 00:0a activated.
> NET: Registered protocol family 23
> found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
> smsc_superio_flat(): IrDA not enabled
> smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02
> 

thanks for testing


Matthieu

--------------010604010901080505060508
Content-Type: text/x-patch;
 name="rs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rs.patch"

--- drivers/pnp/pnpacpi/rsparser.c.int	2004-11-27 01:46:10.000000000 +0100
+++ drivers/pnp/pnpacpi/rsparser.c	2004-11-26 16:33:42.000000000 +0100
@@ -29,6 +29,18 @@
 #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
 #endif
 
+static void debug_pnp(struct acpi_resource *res, int line) {
+	int tmp = acpi_dbg_level;
+	int tmp1 = acpi_dbg_layer;
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
@@ -152,6 +164,8 @@
 {
 	struct pnp_resource_table * res_table = (struct pnp_resource_table *)data;
 
+	debug_pnp(res,__LINE__);
+
 	switch (res->id) {
 	case ACPI_RSTYPE_IRQ:
 		if ((res->data.irq.number_of_interrupts > 0) &&
@@ -455,6 +469,8 @@
 	struct pnp_dev *dev = parse_data->dev;
 	struct pnp_option *option = parse_data->option;
 
+	debug_pnp(res,__LINE__);
+
 	switch (res->id) {
 		case ACPI_RSTYPE_IRQ:
 			pnpacpi_parse_irq_option(option, &res->data.irq);
@@ -765,6 +781,7 @@
 	/* pnpacpi_build_resource_template allocates extra mem */
 	int res_cnt = (buffer->length - 1)/sizeof(struct acpi_resource) - 1;
 	struct acpi_resource *resource = (struct acpi_resource*)buffer->pointer;
+	struct acpi_resource *res = resource;
 	int port = 0, irq = 0, dma = 0, mem = 0;
 
 	pnp_dbg("res cnt %d", res_cnt);
@@ -826,5 +843,7 @@
 		resource ++;
 		i ++;
 	}
+	debug_pnp(res,__LINE__);
+
 	return 0;
 }

--------------010604010901080505060508--
