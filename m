Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTF0INi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 04:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTF0INi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 04:13:38 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:9179 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262319AbTF0INg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 04:13:36 -0400
Date: Fri, 27 Jun 2003 10:27:37 +0200
From: Manuel Estrada Sainz <ranty-bulk@ranty.pantax.net>
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
       orinoco-devel@lists.sf.net, jt@hpl.hp.com
Subject: Re: orinoco_usb Request For Comments
Message-ID: <20030627082737.GA19302@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20030626205811.GA25783@ranty.pantax.net> <200306262341.19110.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <200306262341.19110.oliver@neukum.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2003 at 11:41:18PM +0200, Oliver Neukum wrote:
> 
> >  Please comment, how much of that or what else needs to be done to get
> >  it in the kernel?
> 
> 	if(dev->read.urb->status == -EINPROGRESS){
> 		warn("%s: Unlinking pending IN urb", __FUNCTION__);
> 		retval = bridge_remove_in_urb(dev);
> 		if(retval){
> 			dbg("retval %d status %d", retval,
> 			    dev->read.urb->status);
> 		}
> 	}
> 
> Unlink unconditionally.
> 
> 		/* We don't like racing :) */
> 		ctx->outurb->transfer_flags &= ~URB_ASYNC_UNLINK;
> 		usb_unlink_urb(ctx->outurb);
> 		del_timer_sync(&ctx->timer);
> 
> But neither do we like sleeping in interrupt. You can't simply unset the flag
> if somebody else may be needing it.
> 
> More when I am rested :-)

 How about the attached patch, not pretty, but it should work.

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="diff.diff"

Index: orinoco_usb.c
===================================================================
RCS file: /usr/local/cvsroot/ranty/orinoco/driver/orinoco_usb.c,v
retrieving revision 1.80
diff -u -r1.80 orinoco_usb.c
--- orinoco_usb.c	25 Jun 2003 18:37:59 -0000	1.80
+++ orinoco_usb.c	27 Jun 2003 08:24:09 -0000
@@ -1858,13 +1858,9 @@
 	dev->udev = NULL;
 	//priv->hw_unavailable = 1;
 
-	if(dev->read.urb->status == -EINPROGRESS){
-		warn("%s: Unlinking pending IN urb", __FUNCTION__);
-		retval = bridge_remove_in_urb(dev);
-		if(retval){
-			dbg("retval %d status %d", retval,
-			    dev->read.urb->status);
-		}
+	retval = bridge_remove_in_urb(dev);
+	if (retval) {
+		dbg("retval %d status %d", retval, dev->read.urb->status);
 	}
 restart_list:
 	spin_lock_irqsave(&dev->ctxq.lock, flags);
@@ -1876,8 +1872,11 @@
 		spin_unlock_irqrestore(&dev->ctxq.lock, flags);
 		
 		/* We don't like racing :) */
-		ctx->outurb->transfer_flags &= ~URB_ASYNC_UNLINK;
 		usb_unlink_urb(ctx->outurb);
+		while (ctx->outurb->status == -EINPROGRESS) {
+			set_current_state (TASK_UNINTERRUPTIBLE);
+			schedule_timeout ((3  /*ms*/ * HZ)/1000)
+		}
 		del_timer_sync(&ctx->timer);
 		
 		if (!list_empty(&ctx->list))

--n8g4imXOkfNTN/H1--
