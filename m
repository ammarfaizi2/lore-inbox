Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVBIBY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVBIBY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 20:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVBIBY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 20:24:56 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:8853 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261730AbVBIBYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 20:24:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OufTdufqiMPY4avMCACDtdhNgD4YpgV4i6R/DrvBP/brL8AVfeLu5x+fZlFv44WaXpLMXBzVg/vDvs4HUSWbkj6lwXXKY9x+dcY/7+94uwG1/pSlQnlO23F+dlu1lviIcq5JiIOQx5JGs1LE5+thjMd5f86atdUqhNll4SPkmjY=
Message-ID: <58cb370e05020817241aa42631@mail.gmail.com>
Date: Wed, 9 Feb 2005 02:24:19 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
Cc: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <42095A0B.2080400@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42094ADB.9040403@mvista.com>
	 <58cb370e05020816017431b38@mail.gmail.com>
	 <42095A0B.2080400@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Feb 2005 17:32:11 -0700, Mark A. Greer <mgreer@mvista.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >Hi,
> >
> >just a minor thing
> >
> >
> >
> >>+static int __devinit
> >>+mv64xxx_i2c_init(void)
> >>+{
> >>+       return driver_register(&mv64xxx_i2c_driver);
> >>+}
> >>
> >>
> >
> >__init
> >
> >
> >
> >>+static void __devexit
> >>+mv64xxx_i2c_exit(void)
> >>+{
> >>+       driver_unregister(&mv64xxx_i2c_driver);
> >>+       return;
> >>+}
> >>
> >>
> >
> >__exit
> >
> >these functions relate to module not device
> >
> 
> Gahhh.  Thanks Bartlomiej.
> 
> Below is yet another replacement patch

Thanks, I see that you did global replacement of __devinit
by __init and __devexit by __exit - it seems correct *only* if:
- there can be only one i2c controller in the system
- there can be only one host bridge in the system
- i2c core calls ->probe only once during driver init
  and ->remove only once during driver exit

If all conditions are really true some comment about
this in the code would still be be nice.

While at it more silly, minor nitpicking ;)

> +static void
> +mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
> +{
> +       long    flags, time_left;

'flags' are of 'unsigned long' not 'long' type

> +       char    abort = 0;
> +
> +       time_left = wait_event_interruptible_timeout(drv_data->waitq,
> +               !drv_data->block, msecs_to_jiffies(drv_data->adapter.timeout));
> +
> +       spin_lock_irqsave(&drv_data->lock, flags);
> +       if (!time_left) { /* Timed out */
> +               drv_data->rc = -ETIMEDOUT;
> +               abort = 1;
> +       } else if (time_left < 0) { /* Interrupted/Error */
> +               drv_data->rc = time_left; /* errno value */
> +               abort = 1;
> +       }
> +
> +       if (abort && drv_data->block) {
> +               drv_data->state = MV64XXX_I2C_STATE_ABORTING;
> +               spin_unlock_irqrestore(&drv_data->lock, flags);
> +
> +               time_left = wait_event_timeout(drv_data->waitq,
> +                       !drv_data->block,
> +                       msecs_to_jiffies(drv_data->adapter.timeout));
> +
> +               if (time_left <= 0) {
> +                       drv_data->state = MV64XXX_I2C_STATE_IDLE;
> +                       dev_err(&drv_data->adapter.dev,
> +                               "mv64xxx: I2C bus locked\n");
> +               }
> +       } else
> +               spin_unlock_irqrestore(&drv_data->lock, flags);
> +
> +       return;

there is no need for explicit return in void functions

[ These two comments also apply to other code in the driver. ]

Thanks,
Bartlomiej
