Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbTGBKNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTGBKNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:13:12 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:37808 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264900AbTGBKM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:12:58 -0400
Date: Wed, 2 Jul 2003 12:17:47 +0200
From: Manuel Estrada Sainz <ranty-bulk@ranty.pantax.net>
To: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
Cc: LKML <linux-kernel@vger.kernel.org>, orinoco-usb-devel@ranty.pantax.net
Subject: Re: orinoco_usb Request For Comments
Message-ID: <20030702101747.GA4137@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20030626205811.GA25783@ranty.pantax.net> <200306262341.19110.oliver@neukum.org> <20030627082737.GA19302@ranty.pantax.net> <Pine.LNX.4.53.0306271213350.5135@fachschaft.cup.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0306271213350.5135@fachschaft.cup.uni-muenchen.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 27, 2003 at 12:15:04PM +0200, Oliver Neukum wrote:
> 
> 
> On Fri, 27 Jun 2003, Manuel Estrada Sainz wrote:
> 
> > On Thu, Jun 26, 2003 at 11:41:18PM +0200, Oliver Neukum wrote:
> > > 		/* We don't like racing :) */
> > > 		ctx->outurb->transfer_flags &= ~URB_ASYNC_UNLINK;
> > > 		usb_unlink_urb(ctx->outurb);
> > > 		del_timer_sync(&ctx->timer);
> > >
> > > But neither do we like sleeping in interrupt. You can't simply unset the flag
> > > if somebody else may be needing it.
> > >
> > > More when I am rested :-)
> >
> >  How about the attached patch, not pretty, but it should work.
> 
> It is much too ugly. Please use a struct completion or a waitqueue.
 
 How about this?

 The other choice is to just wait on the completion unconditionally and
 let timers expire on their own if needed.
 
 That would probably be more robust, and waiting a few extra seconds on
 module removal (which would just happen when the card hangs) is
 probably OK.  What do you think?

 Thanks

 	Manuel

 PS: Ideas on how to make the PCMCIA vs. USB integration (specially the
 locking) cleaner would be very, very welcomed. 

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="orinoco-oliver.diff"

Index: orinoco_usb.c
===================================================================
RCS file: /usr/local/cvsroot/ranty/orinoco/driver/orinoco_usb.c,v
retrieving revision 1.85
diff -u -r1.85 orinoco_usb.c
--- orinoco_usb.c	1 Jul 2003 23:52:11 -0000	1.85
+++ orinoco_usb.c	2 Jul 2003 10:00:50 -0000
@@ -400,7 +400,7 @@
 			netif_wake_queue(net_dev);
 			break;
 		}
-		complete(&ctx->done);
+		complete_all(&ctx->done);
 		bridge_request_context_put(ctx);
 		break;
 		
@@ -410,7 +410,7 @@
 			/* This is normal, as all request contexts get flushed
 			 * when the device is disconnected */
 			err("Called, CTLX not terminating, but device gone");
-			complete(&ctx->done);
+			complete_all(&ctx->done);
 			bridge_request_context_put(ctx);
 			break;
 		}
@@ -1881,13 +1881,9 @@
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
@@ -1899,8 +1895,10 @@
 		spin_unlock_irqrestore(&dev->ctxq.lock, flags);
 		
 		/* We don't like racing :) */
-		ctx->outurb->transfer_flags &= ~URB_ASYNC_UNLINK;
-		usb_unlink_urb(ctx->outurb);
+		if (ctx->outurb->status == -EINPROGRESS) {
+			usb_unlink_urb(ctx->outurb);
+			wait_for_completion(&ctx->done);
+		}
 		del_timer_sync(&ctx->timer);
 		
 		if (!list_empty(&ctx->list))

--IS0zKkzwUGydFO0o--
