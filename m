Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274469AbRIYEEW>; Tue, 25 Sep 2001 00:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274471AbRIYEEM>; Tue, 25 Sep 2001 00:04:12 -0400
Received: from sushi.toad.net ([162.33.130.105]:50923 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S274469AbRIYEDz>;
	Tue, 25 Sep 2001 00:03:55 -0400
Message-ID: <3BB0021E.D1977DBD@yahoo.co.uk>
Date: Tue, 25 Sep 2001 00:03:42 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Small change to pnp_bios.c
Content-Type: multipart/mixed;
 boundary="------------6AB18E735AE343543B7005CA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6AB18E735AE343543B7005CA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have been trying to find out why the PnP BIOS driver
causes the disabling of all the PnP-configurable devices
on my ThinkPad 600.  (One other user has reported the same
problem.)  I've been checking the pnp_bios.c driver against
the spec and I found one little nit.

The spec says that after this call to the BIOS:
   Q2_SET_SEL(PNP_TS1, nodenum, sizeof(char));
   Q2_SET_SEL(PNP_TS2, data, 64 * 1024);
   status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0);
nodenum will be set to the next node number, or to 0xFF
if there are no more nodes.  I added a check so that
the build-devlist loop will terminate if nodenum is 0xff.
This didn't solve my problem but it does seem like the
kosher thing to do.  The patch also initializes the
variable "num" to zero.  I know that static variables
in the kernel are automatically initialized to zero, but
I assume that the same is not true of stack variables.
Am I wrong?

The attached patch is against -ac13.  Sorry, but the
-ac15 differential patch hasn't come out yet.  :(

Thomas
--------------6AB18E735AE343543B7005CA
Content-Type: text/plain; charset=us-ascii;
 name="pnpbios-patch-20010924-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpbios-patch-20010924-1"

--- linux-2.4.9-ac13-mwave/drivers/pnp/pnp_bios.c_1	Fri Sep 21 16:15:44 2001
+++ linux-2.4.9-ac13-mwave/drivers/pnp/pnp_bios.c	Mon Sep 24 18:32:26 2001
@@ -839,13 +839,13 @@
                 return;
 
         node = kmalloc(node_info.max_node_size, GFP_KERNEL);
         if (!node)
                 return;
 
-	for(i=0;i<0xff;i++) {
+	for(i=0,num=0;i<0xff,num!=0xff;i++) {
 		dev =  kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
 		if (!dev)
 			break;
 			
                 if (pnp_bios_get_dev_node((u8 *)&num, (char )0 , node))
 			continue;

--------------6AB18E735AE343543B7005CA--

