Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbUKQXTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbUKQXTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUKQXRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:17:43 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:41915 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262632AbUKQXPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:15:35 -0500
Date: Wed, 17 Nov 2004 15:15:20 -0800
From: Greg KH <greg@kroah.com>
To: Lu?s Pinto <lmpinto@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in visor, since 2.6.10-rc1
Message-ID: <20041117231520.GB20701@kroah.com>
References: <Pine.LNX.4.61.0411151921140.5912@amarok.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411151921140.5912@amarok.dei.uc.pt>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 07:28:23PM +0000, Lu?s Pinto wrote:
> 
> 	Hi all!
> 
> 	I have been getting a oops in my kernel when trying to sync my
> 	palm tungsten E, using pilot-xfer version 0.11.8.
> 
> 	The affected kernel versions are all since the 2.6.10-rc1,
> 	including mm and bk branches.

The following patch should solve this.  Let me know if it doesn't.

thanks,

greg k-h

-----------


generic_startup in visor.c was not called for some hardware, resulting
in attempts to access memory that had never been allocated, which in
turn caused the problem several people reported with recent (2.6.10ish)
kernels.

Signed-off-by: Roger Luethi <rl@hellgate.ch>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


--- linux-2.6.10-rc2/drivers/usb/serial/visor.c.orig	2004-11-16 16:03:05.000000000 +0100
+++ linux-2.6.10-rc2/drivers/usb/serial/visor.c	2004-11-16 16:31:24.235249944 +0100
@@ -930,7 +930,7 @@ static int treo_attach (struct usb_seria
 	if (!((serial->dev->descriptor.idVendor == HANDSPRING_VENDOR_ID) ||
 	      (serial->dev->descriptor.idVendor == KYOCERA_VENDOR_ID)) ||
 	    (serial->num_interrupt_in == 0))
-		return 0;
+		goto generic_startup;
 
 	dbg("%s", __FUNCTION__);
 
@@ -957,6 +957,7 @@ static int treo_attach (struct usb_seria
 	COPY_PORT(serial->port[1], swap_port);
 	kfree(swap_port);
 
+generic_startup:
 	return generic_startup(serial);
 }
 

