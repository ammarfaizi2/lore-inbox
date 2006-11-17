Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932875AbWKQKxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875AbWKQKxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 05:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933518AbWKQKxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 05:53:12 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:56587 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S932875AbWKQKxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 05:53:10 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] usb: microtek possible memleak fix [second try]
Date: Fri, 17 Nov 2006 11:53:23 +0100
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>
References: <200611161857.31030.m.kozlowski@tuxland.pl> <200611162215.00934.m.kozlowski@tuxland.pl> <200611170914.09387.oliver@neukum.name>
In-Reply-To: <200611170914.09387.oliver@neukum.name>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171153.24570.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> > > Ist there a reason you are replacing at least somewhat descriptive labels
> > > with numbers?
> > 
> > Yes.
> > 
> > To me these numbers speak more than not really descriptive labels like
> > out_kfree out_kfree2 etc. I look at the code and see the flow. The most
> > important thing here is the order in which the resources are allocated and
> > if something goes wrong deallocated. Hence the numbers.
> > 
> > Anyway if that's a problem I can rewrite it.
> 
> Please do so, otherwise it's a good catch.

Ok. Second try.

Possible memleak fix on error path. The changes:

- out_kfree2 and out_free_urb replaced
- missing scsi_host_put() added

Here it goes:

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/usb/image/microtek.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.19-rc5-mm2-a/drivers/usb/image/microtek.c	2006-11-08 03:24:20.000000000 +0100
+++ linux-2.6.19-rc5-mm2-b/drivers/usb/image/microtek.c	2006-11-17 11:45:21.000000000 +0100
@@ -796,7 +796,7 @@ static int mts_usb_probe(struct usb_inte

 	new_desc->context.scsi_status = kmalloc(1, GFP_KERNEL);
 	if (!new_desc->context.scsi_status)
-		goto out_kfree2;
+		goto out_free_urb;

 	new_desc->usb_dev = dev;
 	new_desc->usb_intf = intf;
@@ -822,18 +822,20 @@ static int mts_usb_probe(struct usb_inte
 	new_desc->host = scsi_host_alloc(&mts_scsi_host_template,
 			sizeof(new_desc));
 	if (!new_desc->host)
-		goto out_free_urb;
+		goto out_kfree2;

 	new_desc->host->hostdata[0] = (unsigned long)new_desc;
 	if (scsi_add_host(new_desc->host, NULL)) {
 		err_retval = -EIO;
-		goto out_free_urb;
+		goto out_host_put;
 	}
 	scsi_scan_host(new_desc->host);

 	usb_set_intfdata(intf, new_desc);
 	return 0;

+ out_host_put:
+	scsi_host_put(new_desc->host);
  out_kfree2:
 	kfree(new_desc->context.scsi_status);
  out_free_urb:


-- 
Regards,

	Mariusz Kozlowski
