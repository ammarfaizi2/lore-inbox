Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265915AbTIJWm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbTIJWm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:42:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27142 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265915AbTIJWmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:42:09 -0400
Date: Wed, 10 Sep 2003 23:41:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: What happened to SUSPEND_SAVE_STATE?
Message-ID: <20030910234159.R30046@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030910201124.GA11449@elf.ucw.cz> <20030910204940.GA11571@elf.ucw.cz> <20030910232527.O30046@flint.arm.linux.org.uk> <20030910223640.GD257@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910223640.GD257@elf.ucw.cz>; from pavel@ucw.cz on Thu, Sep 11, 2003 at 12:36:40AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 12:36:40AM +0200, Pavel Machek wrote:
> > diff -Nru a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
> > --- a/drivers/pcmcia/i82365.c	Wed Sep 10 23:18:34 2003
> > +++ b/drivers/pcmcia/i82365.c	Wed Sep 10 23:18:34 2003
> > @@ -1351,11 +1351,27 @@
> >  
> >  /*====================================================================*/
> >  
> > +static int i82365_suspend(struct device *dev, u32 state, u32 level)
> > +{
> > +	int ret = 0;
> > +	if (level == SUSPEND_SAVE_STATE)
> > +		ret = pcmcia_socket_dev_suspend(dev, state);
> > +	return ret;
> > +}
> > +
> > +static int i82365_resume(struct device *dev, u32 level)
> > +{
> > +	int ret = 0;
> > +	if (level == RESUME_RESTORE_STATE)
> > +		ret = pcmcia_socket_dev_resume(dev);
> > +	return ret;
> > +}
> > +
> >  static struct device_driver i82365_driver = {
> >  	.name = "i82365",
> >  	.bus = &platform_bus_type,
> > -	.suspend = pcmcia_socket_dev_suspend,
> > -	.resume = pcmcia_socket_dev_resume,
> > +	.suspend = i82365_suspend,
> > +	.resume = i82365_resume,
> >  };
> >  
> >  static struct platform_device i82365_device = {
> 
> I was not able to find *any* place in the tree that would call suspend
> with SUSPEND_SAVE_STATE as level. Maybe just my grep was wrong?

It is correct for the time being.  Well, as far as the ARM tree goes.
At the moment, the attitude towards platform devices seems to be "tough,
live with it."  So, I have my own work-arounds, and until such time that
mainline comes up with a solution, I'm happy.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
