Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265745AbSKAVK7>; Fri, 1 Nov 2002 16:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265748AbSKAVK7>; Fri, 1 Nov 2002 16:10:59 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:28157 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265745AbSKAVK5>;
	Fri, 1 Nov 2002 16:10:57 -0500
Date: Fri, 1 Nov 2002 16:17:22 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: ewrk3 cli/sti removal by VDA
Message-ID: <20021101211722.GA26253@www.kroptech.com>
References: <20021019021340.GA8388@www.kroptech.com> <3DB49D81.6000607@pobox.com> <20021022020932.GA13818@www.kroptech.com> <3DB9C970.3010305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB9C970.3010305@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 06:45:04PM -0400, Jeff Garzik wrote:
> Adam Kropelin wrote:
> >			spin_unlock_irqrestore(&lp->hw_lock, flags);
> >-			ret = delay;
> >-			__wait_event_interruptible_timeout(wait, 0, ret);
> >+			set_current_state(TASK_INTERRUPTIBLE);
> >+			ret = schedule_timeout(HZ>>2);
> 
> close -- if schedule_timeout() returns greater than zero, that number is 
> the remaining jiffies that schedule_timeout _should_ have slept, but did 
> not.  Ideally you need to call it in a loop, that decrements a variable 
> based on schedule_timeout return code.

Try this one on for size...

--Adam


--- linux-2.5.45-virgin/drivers/net/ewrk3.c	Wed Oct 30 22:55:10 2002
+++ linux-2.5.45/drivers/net/ewrk3.c	Fri Nov  1 17:15:13 2002
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
@@ -1796,24 +1791,24 @@
 
 			/* Wait a little while */
 			spin_unlock_irqrestore(&lp->hw_lock, flags);
-			ret = delay;
-			__wait_event_interruptible_timeout(wait, 0, ret);
+			ret = HZ>>2;
+			while(ret && !signal_pending(current)) {
+				set_current_state(TASK_INTERRUPTIBLE);
+				ret = schedule_timeout(ret);
+			}
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
 

