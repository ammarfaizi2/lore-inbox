Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267460AbSKQEPN>; Sat, 16 Nov 2002 23:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267462AbSKQEPM>; Sat, 16 Nov 2002 23:15:12 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:44674 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267460AbSKQEPL>;
	Sat, 16 Nov 2002 23:15:11 -0500
Date: Sat, 16 Nov 2002 23:25:28 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@digeo.com>, Justin A <ja6447@albany.edu>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pnpbios oops on boot w/ 2.5.47
Message-ID: <20021116232528.GA1273@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@digeo.com>, Justin A <ja6447@albany.edu>,
	greg@kroah.com, linux-kernel@vger.kernel.org
References: <200211161700.29653.ja6447@albany.edu> <3DD6C1DC.44966373@digeo.com> <3DD6F655.4214A594@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD6F655.4214A594@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 05:52:21PM -0800, Andrew Morton wrote:
> Andrew Morton wrote:
> > 
> > Justin A wrote:
> > >
> > > Hi :)
> > >
> > > I tried to "port" kmsgdump to 2.5.47 and for some reason, it worked.
> > >
> > > Attached is the full dmesg
> > >
> > > Alan: I ran dmidecode under 2.4.19 which said simply "PNP BIOS present"
> > >
> > > This is a thinkpad 760e, really old..I don't even think I need pnpbios
support


If it was calling pnpbios_set_resources you probably do.  This means it was
trying to activate a device.  If a device is not active you cannot use it.
This device was most likely a serial port or modem.  Try turning on PnP
Debug after applying the below patch and see if a device is activated.


> > > for anything.  2.5.47/2.5.47-ac5 boot with pnpbios turned off, so I think 
you
> > > just need to add this to your blacklist?
> > >
> > 
> > The BUG in slab indicates that something overran the end of a kmalloced
> > buffer.  That'll be either pnp_bios_get_dev_node() or node_set_resources()
> > ran off the end of `node'.
> 
> err...
> 
>         node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
> 
> max_node_size appears to never be initialised.


Oops.  I put the pnpbios_kmalloc in the wrong place.  It's amazing it still 
worked on my test box.  Here's a patch that should fix it.  Justin: could you
please try it.

Thanks,
Adam

The typo appears to be in pnpbios_set_resources.  Andrew: Is this where you 
found it?


--- a/drivers/pnp/pnpbios/core.c	Wed Nov  6 17:51:53 2002
+++ b/drivers/pnp/pnpbios/core.c	Sat Nov 16 23:03:00 2002
@@ -1285,9 +1285,9 @@
 		return -EBUSY;
 	if (flags == PNP_DYNAMIC && !pnp_is_dynamic(dev))
 		return -EPERM;
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return -ENODEV;
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))

