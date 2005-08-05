Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVHEN4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVHEN4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 09:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVHEN4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 09:56:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59544 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263025AbVHENzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 09:55:53 -0400
Date: Fri, 5 Aug 2005 15:55:51 +0200
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       John B?ckstrand <sandos@home.se>
Subject: Re: lockups with netconsole on e1000 on media insertion
Message-ID: <20050805135551.GQ8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123249743.18332.16.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is fixing the symptom and is not the cure.  Unfortunately I don't
> have a e1000 card so I can't try a fix. But I did have a e100 card that
> would lock up the same way.  The problem was that netpoll_poll calls the
> cards netpoll routine (in e1000_main.c e1000_netpoll).  In the e100
> case, when the transmit buffer would fill up, the queue would go down.
> But the netpoll routine in the e100 code never put it back up after it
> was all transfered. So this would lock up the kernel when that happened.

In my case the hang happened when no cable was connected.

There is no way to handle this in any other way. You eventually
have to bail out.

>  
>  repeat:
> -	if(!np || !np->dev || !netif_running(np->dev)) {
> +	if(try-- == 0 || !np || !np->dev || !netif_running(np->dev)) {
> +		if (!try)
> +			printk(KERN_WARNING "net driver is stuck down, maybe a"
> +					" problem with the driver's netpoll\n");

... and nobody will see that. It will not even trigger an output.

-Andi

