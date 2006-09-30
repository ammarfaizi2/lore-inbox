Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWI3I4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWI3I4l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWI3I4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:56:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751162AbWI3I4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:56:40 -0400
Date: Sat, 30 Sep 2006 01:49:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>, Dmitry Torokhov <dtor@mail.ru>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 23/23] dynticks: decrease I8042_POLL_PERIOD
Message-Id: <20060930014931.230c5fdb.akpm@osdl.org>
In-Reply-To: <20060929234441.435573000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234441.435573000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:43 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> decrease the rate of timers going off. Also work around apparent
> kbd-init bug by making the first timeout short.
> 

Again, please don't make unrelated kernel functions behave differently like
this.

> 
> Index: linux-2.6.18-mm2/drivers/input/serio/i8042.c
> ===================================================================
> --- linux-2.6.18-mm2.orig/drivers/input/serio/i8042.c	2006-09-30 01:41:08.000000000 +0200
> +++ linux-2.6.18-mm2/drivers/input/serio/i8042.c	2006-09-30 01:41:20.000000000 +0200
> @@ -1101,7 +1101,7 @@ static int __devinit i8042_probe(struct 
>  		goto err_controller_cleanup;
>  	}
>  
> -	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
> +	mod_timer(&i8042_timer, jiffies + 2); //I8042_POLL_PERIOD);
>  	return 0;
>  
>   err_unregister_ports:
> Index: linux-2.6.18-mm2/drivers/input/serio/i8042.h
> ===================================================================
> --- linux-2.6.18-mm2.orig/drivers/input/serio/i8042.h	2006-09-30 01:41:08.000000000 +0200
> +++ linux-2.6.18-mm2/drivers/input/serio/i8042.h	2006-09-30 01:41:20.000000000 +0200
> @@ -43,7 +43,7 @@
>   * polling.
>   */
>  
> -#define I8042_POLL_PERIOD	HZ/20
> +#define I8042_POLL_PERIOD	(10*HZ)

That's a huge change.  Perhaps the interval was too short in the first
case.  I guess waiting ten seconds for your keyboard or mouse to come to
life after hot-add is liveable with.

But whatever.  This timer gets deleted in Dmitry's current development tree:

commit de9ce703c6b807b1dfef5942df4f2fadd0fdb67a
Author: Dmitry Torokhov <dtor@insightbb.com>
Date:   Sun Sep 10 21:57:21 2006 -0400

    Input: i8042 - get rid of polling timer
    
    Remove polling timer that was used to detect keybord/mice hotplug and
    register both IRQs right away instead of waiting for a driver to
    attach to a port.
    
    Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

so problem solved.
