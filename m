Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262802AbSKDVE4>; Mon, 4 Nov 2002 16:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSKDVE4>; Mon, 4 Nov 2002 16:04:56 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:32384 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262790AbSKDVEy>;
	Mon, 4 Nov 2002 16:04:54 -0500
Date: Mon, 4 Nov 2002 16:15:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
Message-ID: <20021104161504.GA316@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, CaT <cat@zip.com.au>,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	alan@lxorguk.ukuu.org.uk
References: <20021104025458.GA3088@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104025458.GA3088@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 01:54:59PM +1100, CaT wrote:
> When I unselect PNP BIOS the kernel boots fine. With it I get the
> oops below. Please note that it was typed out manually and that that was
> all that I could get as I could not scroll up or down in any way.
>
> The PC is a Gateway laptop.
>
> If you need more info, please holler.
>

Instead of adding your PnP BIOS to the black list, I may know a way to 
support it completely even though it is broken.

To prove this idea could you please do the following:

1.) apply patch 1 (attached below) to a clean kernel (2.5.45).  Compile the 
kernel with PnP BIOS support and list the last few messages that start with 
"pnp!!!:" before it panics.  You probably will want to have kernel debugging
off so it doesn't scroll the messages off the screen.

2.) Apply patch 2 (attached below) to a clean kernel (2.5.45).  Compile the 
kernel with PnP BIOS support.  It should start up completely without a panic.  
This is not a complete fix however.  Anyway attach a copy of the output from 
dmesg.

If my theory is correct I will have a fix out soon.

thanks,
Adam


patch 1---------------------------------------------------------------------

diff -ur stock/drivers/pnp/pnpbios/core.c debug/drivers/pnp/pnpbios/core.c
--- stock/drivers/pnp/pnpbios/core.c	Thu Oct 31 00:41:38 2002
+++ debug/drivers/pnp/pnpbios/core.c	Mon Nov  4 15:48:56 2002
@@ -1421,6 +1421,7 @@
 		memcpy(dev->name,"Unknown Device",13);
 		dev->name[14] = '\0';
 		pnpid32_to_pnpid(node->eisa_id,id);
+		printk(KERN_ERR "PNP!!!: Node number: 0x%x EISA ID: %s\n", (unsigned int)thisnodenum, id);
 		memcpy(dev_id->id,id,8);
 		pnp_add_id(dev_id, dev);
 		pos = node_current_resource_data_to_dev(node,dev);



patch 2---------------------------------------------------------------------

diff -ur stock/drivers/pnp/pnpbios/core.c debug/drivers/pnp/pnpbios/core.c
--- stock/drivers/pnp/pnpbios/core.c	Thu Oct 31 00:41:38 2002
+++ debug/drivers/pnp/pnpbios/core.c	Mon Nov  4 15:50:41 2002
@@ -1405,7 +1405,7 @@
 		 * asking for the "current" config causes some
 		 * BIOSes to crash.
 		 */
-		if (pnp_bios_get_dev_node(&nodenum, (char )0 , node))
+		if (pnp_bios_get_dev_node(&nodenum, (char )1 , node))
 			break;
 		nodes_got++;
 		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
@@ -1421,6 +1421,7 @@
 		memcpy(dev->name,"Unknown Device",13);
 		dev->name[14] = '\0';
 		pnpid32_to_pnpid(node->eisa_id,id);
+		printk(KERN_ERR "PNP!!!: Node number: 0x%x EISA ID: %s\n", (unsigned int)thisnodenum, id);
 		memcpy(dev_id->id,id,8);
 		pnp_add_id(dev_id, dev);
 		pos = node_current_resource_data_to_dev(node,dev);
