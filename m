Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVA1U7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVA1U7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbVA1U5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:57:30 -0500
Received: from [195.23.16.24] ([195.23.16.24]:23424 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262755AbVA1Uwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:52:39 -0500
Message-ID: <41FAA5F7.4000202@grupopie.com>
Date: Fri, 28 Jan 2005 20:52:07 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Sims <dpsims@virtualdave.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: I need a hardware wizard... I have been beating my head on the
 wall..
References: <Pine.LNX.4.21.0501272102280.27754-100000@ernie.virtualdave.com>
In-Reply-To: <Pine.LNX.4.21.0501272102280.27754-100000@ernie.virtualdave.com>
Content-Type: multipart/mixed;
 boundary="------------070508000605050208060506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070508000605050208060506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Sims wrote:
> On Thu, 27 Jan 2005, Jeff Garzik wrote:
>>David Sims wrote:
>>
>>>[...]
>>>  You can insert the module in a running kernel and after barking as
>>>follows (once for each disk attached) it runs just fine.
>>
>>Basically nobody has ever had hardware to test sata_vsc with that 
>>hardware.  We should probably remove the PCI ID until an engineer can 
>>fix it...
> 
> Hi again,
> 
>   I am willing to make this hardware available to any engineer that wants
> to help me solve this problem.... and I will do whatever I can to make it
> an easy job... Please help me...

Well, I don't consider myself a hardware wizard, but at least I'm an 
engineer, so I decided to give it a go :)

It seems that the driver is not acknowledging the interrupt from the 
controller. It would be nice to know what kind of interrupt is 
triggering this.

Could you run the attached patch and show the output from dmesg?

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

--------------070508000605050208060506
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- sata_vsc.c.orig	2005-01-28 12:23:47.000000000 +0000
+++ sata_vsc.c	2005-01-28 20:51:13.993868526 +0000
@@ -160,12 +160,17 @@ irqreturn_t vsc_sata_interrupt (int irq,
 	struct ata_host_set *host_set = dev_instance;
 	unsigned int i;
 	unsigned int handled = 0;
+        static int int_count = 0;
 	u32 int_status;
 
 	spin_lock(&host_set->lock);
 
 	int_status = readl(host_set->mmio_base + VSC_SATA_INT_STAT_OFFSET);
 
+	int_count++;
+	if (int_count > 1000 && int_count <= 1020)
+		printk("vsc_sata int status: %08x\n", int_status);
+
 	for (i = 0; i < host_set->n_ports; i++) {
 		if (int_status & ((u32) 0xFF << (8 * i))) {
 			struct ata_port *ap;

--------------070508000605050208060506--
