Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbUKXXtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbUKXXtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUKXXru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:47:50 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14993 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262928AbUKXXor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:44:47 -0500
Date: Wed, 24 Nov 2004 15:37:59 -0800
From: Greg KH <greg@kroah.com>
To: Lu?s Pinto <lmpinto@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in visor, since 2.6.10-rc1
Message-ID: <20041124233756.GC4649@kroah.com>
References: <Pine.LNX.4.61.0411151921140.5912@amarok.dei.uc.pt> <20041117231520.GB20701@kroah.com> <Pine.LNX.4.61.0411182254310.6221@amarok.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411182254310.6221@amarok.dei.uc.pt>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 02:53:42PM +0000, Lu?s Pinto wrote:
> 
> 	This sort of solves part of it. It doesn't oops anymore,
> 	however, for a 'pilot-xfer -l' (list all databases on palm) or
> 	a 'pilot-xfer -i xyz.pdb' (install a database on palm) it
> 	freezes at the middle, and the palm eventually times out. Here
> 	goes the corresponding dmesg: the first time it didn't do
> 	nothing (pilot-xfer didn't even start), the second and third
> 	it freezed.

Please try this patch.  It should solve the problem for you.  Sorry for
all of the problems with these recent changes.

thanks,

greg k-h


[PATCH] USB visor: Don't count outstanding URBs twice

Incrementing the outstanding_urbs counter twice for the same URB can't
be good. No wonder Simon didn't get far syncing his Palm.

Signed-off-by: Roger Luethi <rl@hellgate.ch>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
--- a/drivers/usb/serial/visor.c	2004-11-24 15:36:25 -08:00
+++ b/drivers/usb/serial/visor.c	2004-11-24 15:36:25 -08:00
@@ -497,7 +497,6 @@
 		dev_dbg(&port->dev, "write limit hit\n");
 		return 0;
 	}
-	++priv->outstanding_urbs;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	buffer = kmalloc (count, GFP_ATOMIC);
