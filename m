Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVFJF7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVFJF7W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 01:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVFJF7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 01:59:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:24760 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261460AbVFJF7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 01:59:16 -0400
Date: Thu, 9 Jun 2005 22:58:55 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Re: BUG in i2c_detach_client
Message-ID: <20050610055854.GB15873@kroah.com>
References: <JctXv2LZ.1118303243.5186830.khali@localhost> <200506090932.59679.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com> <20050609175744.6f950b4f.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050609175744.6f950b4f.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 05:57:44PM +0200, Jean Delvare wrote:
> Hi Andrew,
> 
> > Mystery solved.
> > 
> > ERROR3:
> > 	i2c_detach_client(data->lm75[1]); <-- HERE
> > 	i2c_detach_client(data->lm75[0]);
> > 	kfree(data->lm75[1]);
> > 	kfree(data->lm75[0]);
> > 
> > The missing i2c_detach_client call meant that data->lm75[1] was still
> > on the list of i2c devices when it was freed. This was corrupting the
> > list. The ERROR3 path now works on my kernel.
> 
> Oh my, I had it right under my nose and didn't see it ;) Thanks for the
> clarification.
> 
> Greg, please apply the following patch on top of the hwmon patches until
> Mark submits an updated version of the whole thing.
> 
> ----------------------------------
> 
> Fix a broken error path in the asb100 driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> --- linux-2.6.12-rc6/drivers/i2c/chips/asb100.c.orig	Wed Jun  8 09:47:53 2005
> +++ linux-2.6.12-rc6/drivers/i2c/chips/asb100.c	Thu Jun  9 11:58:34 2005
> @@ -859,6 +859,7 @@
>  	return 0;
>  
>  ERROR3:
> +	i2c_detach_client(data->lm75[1]);
>  	i2c_detach_client(data->lm75[0]);
>  	kfree(data->lm75[1]);
>  	kfree(data->lm75[0]);

Hm, what tree is this against?  Am I missing some inbetween patch here?

thanks,

greg k-h
