Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWIZP4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWIZP4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIZP4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:56:38 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59780 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932152AbWIZP4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:56:36 -0400
Message-ID: <45194DAD.6060904@garzik.org>
Date: Tue, 26 Sep 2006 11:56:29 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Diego Calleja <diegocg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: pata_serverworks oopses in latest -git
References: <20060926140016.54d532ba.diegocg@gmail.com> <1159275010.11049.215.camel@localhost.localdomain>
In-Reply-To: <1159275010.11049.215.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------060408000705050602010907"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408000705050602010907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> Ar Maw, 2006-09-26 am 14:00 +0200, ysgrifennodd Diego Calleja:
>> When trying to test the new libata PATA drivers in the latest -git tree, I 
>> got this when udev tried to load the module:
> 
> Yes something seems to be very ill in the -git tree but I'm not sure
> what has changed in the libata core to trigger all this at the moment.

One thing I notice in pata_serverworks.c is the lack of an ->irq_clear() 
hook, which is called unconditionally in ata_device_add().  It's a bit 
strange that it wasn't caught before, since ->irq_clear() has been 
called unconditionally for a great many kernel releases.

Diego, does the attached patch help?

	Jeff




--------------060408000705050602010907
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index af45611..9c1719c 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -356,6 +356,8 @@ static struct ata_port_operations server
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
+	.irq_clear	= ata_bmdma_irq_clear,
+
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
 	.host_stop	= ata_host_stop
@@ -389,6 +391,8 @@ static struct ata_port_operations server
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
+	.irq_clear	= ata_bmdma_irq_clear,
+
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
 	.host_stop	= ata_host_stop

--------------060408000705050602010907--
