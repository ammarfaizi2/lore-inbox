Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTIIAco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTIIAco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:32:44 -0400
Received: from www.mail15.com ([194.186.131.96]:10247 "EHLO www.mail15.com")
	by vger.kernel.org with ESMTP id S263830AbTIIAcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:32:42 -0400
Message-ID: <3F5D1FBA.6010703@myrealbox.com>
Date: Mon, 08 Sep 2003 17:32:58 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Linux 2.6.0-test5
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5D0B09.1040802@pobox.com>
In-Reply-To: <3F5D0B09.1040802@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Note that people seeing "ifconfig down ... ifconfig up" problems need to 
> apply this patch.  (to 2.4.23-pre, too)
> 
>     Jeff
> 
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Nru a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c	Mon Sep  8 18:14:36 2003
> +++ b/net/core/dev.c	Mon Sep  8 18:14:36 2003
> @@ -851,7 +851,11 @@
>  	 * engine, but this requires more changes in devices. */
>  
>  	smp_mb__after_clear_bit(); /* Commit netif_running(). */
> -	netif_poll_disable(dev);
> +	while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
> +		/* No hurry. */
> +		current->state = TASK_INTERRUPTIBLE;
> +		schedule_timeout(1);
> +	}
>  
>  	/*
>  	 *	Call the device specific close. This cannot fail.

Okay!  I'm at least back where I started.  This patch doen't fix the
ifconfig down/up problem, but it does reverse the disastrous effects
of the last tg3 updates in both 2.6 and 2.4

Is there any reason this patch should not be committed?

Thanks.

