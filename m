Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTK0UYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 15:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTK0UYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 15:24:17 -0500
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:55471
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S261176AbTK0UYP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 15:24:15 -0500
Date: Thu, 27 Nov 2003 12:22:45 -0800
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: APM Suspend Problem
Message-ID: <20031127202245.GA3892@nasledov.com>
References: <20031127062057.GA31974@nasledov.com> <1069933566.2144.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069933566.2144.1.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No luck; my ThinkPad still does not go into the proper power-saving mode. The LCD
blanks out and the HD spins down, but it is not a real sleep mode.

On Thu, Nov 27, 2003 at 12:46:06PM +0100, Felipe Alfaro Solana wrote:
> On Thu, 2003-11-27 at 07:20, Misha Nasledov wrote:
> > Since about 2.6.0-test9, my ThinkPad T21 no longer suspends with APM. I had
> > issues with it suspending before, I don't remember exactly what issues, but I
> > know that it definitely worked in -test2. When I hit the key on my laptop to
> > suspend, it will turn off the LCD and the HD will spin down, but the machine
> > will not actually suspend. Here is what is printed out on the console when I
> > hit the suspend key and then when I hit another key to "wake" it up:
> 
> Could you please try the attached patch? It allows my system to suspend
> and resume using APM flawlessly.

> --- 1.11/drivers/base/power/resume.c	Mon Aug 25 11:08:21 2003
> +++ edited/drivers/base/power/resume.c	Fri Oct 10 21:06:07 2003
> @@ -22,8 +22,17 @@
>  
>  int resume_device(struct device * dev)
>  {
> -	if (dev->bus && dev->bus->resume)
> -		return dev->bus->resume(dev);
> +	if (dev->bus && dev->bus->resume) {
> +		int retval;
> +
> +		/* drop lock so the call can use device_del() to clean up
> +		 * after unplugged (or otherwise vanished) child devices
> +		 */
> +		up(&dpm_sem);
> +		retval = dev->bus->resume(dev);
> +		down(&dpm_sem);
> +		return retval;
> +	}
>  	return 0;
>  }

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
