Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTK3JAg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 04:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTK3JAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 04:00:36 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:27578 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262310AbTK3JAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 04:00:32 -0500
Date: Sun, 30 Nov 2003 10:00:09 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 RFC/PATCH] Input: possible deadlock in i8042
Message-ID: <20031130090009.GA17038@ucw.cz>
References: <200311300303.57654.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311300303.57654.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 03:03:57AM -0500, Dmitry Torokhov wrote:
> If request_irq fails in i8042_open it will call serio_unregister_port,
> which takes serio_sem. i8042_open may be called:
> 
> serio_register_port - serio_find_dev - dev->connect
> serio_register_device - dev->connect
> 
> Both serio_register_port and serio_register_device take serio_sem as well.
> 
> I think that serio_{register|unregister}_port can be converted into
> submitting requests to kseriod thus removing deadlock on the serio_sem.
> 
> The patch below is on top of serio* patches in Andrew Morton's -mm tree.

It's nice to avoid the deadlock this way, but I think it's not a good
idea to make the register/unregister asynchronous - it could be a nasty
surprise for an unsuspecting driver writer.

> Dmitry
> 
> ===================================================================
> 
> 
> ChangeSet@1.1512, 2003-11-30 02:42:54-05:00, dtor_core@ameritech.net
>   Input: Use kseriod to register/unregister serio ports
> 
> 
>  serio.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)
> 
> ===================================================================
> 
> diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> --- a/drivers/input/serio/serio.c	Sun Nov 30 03:01:40 2003
> +++ b/drivers/input/serio/serio.c	Sun Nov 30 03:01:40 2003
> @@ -83,8 +83,10 @@
>  	}
>  }
>  
> -#define SERIO_RESCAN	1
> -#define SERIO_RECONNECT	2
> +#define SERIO_RESCAN		1
> +#define SERIO_RECONNECT		2
> +#define SERIO_REGISTER_PORT	3
> +#define SERIO_UNREGISTER_PORT	4
>  
>  static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
>  static DECLARE_COMPLETION(serio_exited);
> @@ -111,6 +113,14 @@
>  			goto event_done;
>  		
>  		switch (event->type) {
> +			case SERIO_REGISTER_PORT :
> +				__serio_register_port(event->serio);
> +				break;
> +
> +			case SERIO_UNREGISTER_PORT :
> +				__serio_unregister_port(event->serio);
> +				break;
> +
>  			case SERIO_RECONNECT :
>  				if (event->serio->dev && event->serio->dev->reconnect)
>  					if (event->serio->dev->reconnect(event->serio) == 0)
> @@ -192,9 +202,7 @@
>  
>  void serio_register_port(struct serio *serio)
>  {
> -	down(&serio_sem);
> -	__serio_register_port(serio);
> -	up(&serio_sem);
> +	serio_queue_event(serio, SERIO_REGISTER_PORT);
>  }
>  
>  /*
> @@ -210,9 +218,7 @@
>  
>  void serio_unregister_port(struct serio *serio)
>  {
> -	down(&serio_sem);
> -	__serio_unregister_port(serio);
> -	up(&serio_sem);
> +	serio_queue_event(serio, SERIO_UNREGISTER_PORT);
>  }
>  
>  /*
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
