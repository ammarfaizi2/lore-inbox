Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317999AbSHHUrr>; Thu, 8 Aug 2002 16:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSHHUrr>; Thu, 8 Aug 2002 16:47:47 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:55478 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S317999AbSHHUrq>; Thu, 8 Aug 2002 16:47:46 -0400
Date: Thu, 8 Aug 2002 13:51:20 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: kernel@street-vision.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.20-pre1] Watchdog Stuff (1/4)
Message-ID: <20020808205119.GG1038@nic1-pc.us.oracle.com>
References: <20020808001238.GB1038@nic1-pc.us.oracle.com> <200208081206.g78C6j402355@tench.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208081206.g78C6j402355@tench.street-vision.com>
User-Agent: Mutt/1.3.28i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 12:06:44PM +0000, kernel@street-vision.com wrote:
> You might cc the driver author...

	Sorry, with so many drivers to patch, I went with a recommended
list of "interested parties".  I'll add you to that list.  It is posted
to linux-kernel in the hopes that interested persons do get a chance to
look at it.  I got no responses outside of my "interested parties" when
I posted this patch originally.  It's good to hear from you.

> > +
> > +	case WDIOC_SETTIMEOUT:
> > +		if (get_user(new_margin, (int *)arg))
> > +			return -EFAULT;
> > +		if ((new_margin < 1) || (new_margin > 255))
> > +			return -EINVAL;
> > +		wd_margin = new_margin;
> > +		wafwdt_stop();
> > +		wafwdt_start();
> > +		/* Fall */
> > +	case WDIOC_GETTIMEOUT:
> > +		return put_user(wd_margin, (int *)arg);
> 
> I really wouldnt do wafwdt_stop(); wafwdt_start(); here. The new timeout
> will be set on the next watchdog ping anyway, and you need to spin_lock
> and unlock round this too. Much cleaner just to drop it.

	Um, am I missreading: 

     59 static void wafwdt_ping(void)
     60 {
     61         /* pat watchdog */
     62         spin_lock(&wafwdt_lock);
     63         inb_p(WDT_STOP);
     64         inb_p(WDT_START);
     65         spin_unlock(&wafwdt_lock);
     66 }

I don't see it writing the new timeout.  Also, the semantic of
WDIOC_SETTIMEOUT (at least as I've implemented it in all the drivers
I've touched) is to ping the device to verify the new timeout is active.
	I also note that the calls to wafwdt_stop()/start() in the
open()/close() functions doesn't take the spinlock.  Granted, open() and
close() should be protected by wafwdt_is_open.
	If I add the locking, are you comfortable with the changes?

Joel

-- 

"To fall in love is to create a religion that has a fallible god."
        -Jorge Luis Borges

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
