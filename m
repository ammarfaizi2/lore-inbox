Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbULHXza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbULHXza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 18:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbULHXza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 18:55:30 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.27]:12332 "EHLO smtp4.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261404AbULHXzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 18:55:21 -0500
Date: Thu, 9 Dec 2004 00:56:23 +0100
From: Philippe Elie <phil.el@wanadoo.fr>
To: Greg Banks <gnb@sgi.com>
Cc: John Levon <levon@movementarian.org>, Akinobu Mita <amgta@yacht.ocn.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041208235623.GA563@zaniah>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041208160055.GA82465@compsoc.man.ac.uk> <20041208223156.GB4239@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208223156.GB4239@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2004 at 09:31 +0000, Greg Banks wrote:

> On Wed, Dec 08, 2004 at 04:00:55PM +0000, John Levon wrote:
> > On Wed, Dec 08, 2004 at 06:30:51PM +0900, Akinobu Mita wrote:
> > 
> > > When I forced the oprofile to use timer interrupt with specifying
> > > "timer=1" module parameter. "oprofile_operations->backtrace" did
> > > not initialized on i386.
> > > 
> > > Please apply this patch, or make oprofile initialize the backtrace
> > > operation in case of using timer interrupt in your preferable way.
> > 
> > I don't like this patch. The arches should just set the backtrace
> > always, then try to init the hardware. oprofile_init() should then force
> > the timer ops as needed.
> > 
> > Greg?
> 
> Agreed, that's a cleaner approach.  The attached patch (untested)
> implements that.  Akinobu-san, can you please test the patch?

> +++ linux/drivers/oprofile/oprof.c	2004-12-09 09:25:02.%N +1100
> @@ -155,13 +155,11 @@ static int __init oprofile_init(void)
>  {
>  	int err = 0;
>  
> -	/* this is our fallback case */
> -	oprofile_timer_init(&oprofile_ops);
> +	oprofile_arch_init(&oprofile_ops);

oprofile_arch_init() --> nmi_init() which setup oprofile_ops->setup/shutdown
etc.

>  	if (timer) {
>  		printk(KERN_INFO "oprofile: using timer interrupt.\n");
> -	} else {
> -		oprofile_arch_init(&oprofile_ops);
> +		oprofile_timer_init(&oprofile_ops);
>  	}

oprofile_timer_init doesn't reset op->setup/shutdown, I don't like the idea to
reset them in oprofile_timer_init() it's error prone. John any idea ?

-- 
Philippe Elie

