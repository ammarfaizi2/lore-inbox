Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbSJVCDd>; Mon, 21 Oct 2002 22:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSJVCDd>; Mon, 21 Oct 2002 22:03:33 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:4338 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S261617AbSJVCDc>;
	Mon, 21 Oct 2002 22:03:32 -0400
Date: Mon, 21 Oct 2002 22:09:33 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: VDA@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: ewrk3 cli/sti removal by VDA
Message-ID: <20021022020932.GA13818@www.kroptech.com>
References: <20021019021340.GA8388@www.kroptech.com> <3DB49D81.6000607@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB49D81.6000607@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 08:36:17PM -0400, Jeff Garzik wrote:
> Adam Kropelin wrote:
> >Below is a patch from Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> 
> >which
> >removes cli/sti in the ewrk3 driver. It tests out fine here with SMP & 
> >preempt.
> 
> Applied and then cleaned up...  ETHTOOL_PHYS_ID needs to use 
> schedule_timeout(), and using typeof should be avoided.

The patch below (against yours) should fix ETHTOOL_PHYS_ID again. Let me
know if I got it wrong. Was my prior use of
wait_event_interruptible_tiumeout actually broken or rather
just a lot more complicated than it needed to be?

I didn't find any use of typeof. If you point me to it I'll fix that up,
too.

Thanks for bearing with me. I'm climbing the clue-ladder as fast as I
can... ;)

--Adam

--- linux-2.5.44/drivers/net/ewrk3.c	Mon Oct 21 22:01:01 2002
+++ linux-2.5.44/drivers/net/ewrk3.c.new	Mon Oct 21 21:58:13 2002
@@ -1759,23 +1759,18 @@
 		return 0;
 	}
 
-#ifdef BROKEN
 	/* Blink LED for identification */
 	case ETHTOOL_PHYS_ID: {
 		struct ethtool_value edata;
 		u_long flags;
-		long delay, ret;
+		long ret=0;
 		u_char cr;
 		int count;
-		wait_queue_head_t wait;
-
-		init_waitqueue_head(&wait);
 
 		if (copy_from_user(&edata, useraddr, sizeof(edata)))
 			return -EFAULT;
 
 		/* Toggle LED 4x per second */
-		delay = HZ >> 2;
 		count = edata.data << 2;
 
 		spin_lock_irqsave(&lp->hw_lock, flags);
@@ -1796,24 +1791,21 @@
 
 			/* Wait a little while */
 			spin_unlock_irqrestore(&lp->hw_lock, flags);
-			ret = delay;
-			__wait_event_interruptible_timeout(wait, 0, ret);
+			set_current_state(TASK_INTERRUPTIBLE);
+			ret = schedule_timeout(HZ>>2);
 			spin_lock_irqsave(&lp->hw_lock, flags);
 
 			/* Exit if we got a signal */
-			if (ret == -ERESTARTSYS)
-				goto out;
+			if (ret)
+				break;
 		}
 
-		ret = 0;
-out:
 		lp->led_mask = CR_LED;
 		cr = inb(EWRK3_CR);
 		outb(cr & ~CR_LED, EWRK3_CR);
 		spin_unlock_irqrestore(&lp->hw_lock, flags);
-		return ret;
+		return ret ? -ERESTARTSYS : 0;
 	}
-#endif /* BROKEN */
 
 	}
 

