Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265066AbUABGjD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 01:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbUABGjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 01:39:03 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:10486 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S265066AbUABGi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 01:38:58 -0500
Subject: Re: [PATCH 355] Mac ADB IOP fix
From: Stan Bubrouski <stan@ccs.neu.edu>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <200401012001.i01K1uWh031775@callisto.of.borg>
References: <200401012001.i01K1uWh031775@callisto.of.borg>
Content-Type: text/plain
Message-Id: <1073025537.1597.0.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 02 Jan 2004 01:38:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-01 at 15:01, Geert Uytterhoeven wrote:
> Mac ADB IOP: Fix improperly initialized request struct in the reset code,
> causing a bogus pointer (from Matthias Urlichs)
> 
> --- linux-2.6.0/drivers/macintosh/adb-iop.c	Thu Jan  2 12:54:27 2003
> +++ linux-m68k-2.6.0/drivers/macintosh/adb-iop.c	Mon Oct 20 21:45:56 2003
> @@ -105,18 +105,19 @@
>  	struct adb_iopmsg *amsg = (struct adb_iopmsg *) msg->message;
>  	struct adb_request *req;
>  	uint flags;
> +#ifdef DEBUG_ADB_IOP
> +	int i;
> +#endif
>  

Why not move this down into the ifdef below?  2 extra lines aren't
needed.

-sb

>  	local_irq_save(flags);
>  
>  	req = current_req;
>  
>  #ifdef DEBUG_ADB_IOP
> -	printk("adb_iop_listen: rcvd packet, %d bytes: %02X %02X",
> +	printk("adb_iop_listen %p: rcvd packet, %d bytes: %02X %02X", req,
>  		(uint) amsg->count + 2, (uint) amsg->flags, (uint) amsg->cmd);
> -	i = 0;
> -	while (i < amsg->count) {
> -		printk(" %02X", (uint) amsg->data[i++]);
> -	}
> +	for (i = 0; i < amsg->count; i++)
> +		printk(" %02X", (uint) amsg->data[i]);
>  	printk("\n");
>  #endif
>  
> @@ -134,7 +135,7 @@
>  			adb_iop_end_req(req, idle);
>  		}
>  	} else {
> -		/* TODO: is it possible for more tha one chunk of data  */
> +		/* TODO: is it possible for more than one chunk of data  */
>  		/*       to arrive before the timeout? If so we need to */
>  		/*       use reply_ptr here like the other drivers do.  */
>  		if ((adb_iop_state == awaiting_reply) &&
> @@ -163,6 +164,9 @@
>  	unsigned long flags;
>  	struct adb_request *req;
>  	struct adb_iopmsg amsg;
> +#ifdef DEBUG_ADB_IOP
> +	int i;
> +#endif
>  
>  	/* get the packet to send */
>  	req = current_req;
> @@ -171,7 +175,7 @@
>  	local_irq_save(flags);
>  
>  #ifdef DEBUG_ADB_IOP
> -	printk("adb_iop_start: sending packet, %d bytes:", req->nbytes);
> +	printk("adb_iop_start %p: sending packet, %d bytes:", req, req->nbytes);
>  	for (i = 0 ; i < req->nbytes ; i++)
>  		printk(" %02X", (uint) req->data[i]);
>  	printk("\n");
> @@ -267,13 +271,17 @@
>  
>  int adb_iop_reset_bus(void)
>  {
> -	struct adb_request req;
> +	struct adb_request req = {
> +		.reply_expected = 0,
> +		.nbytes = 2,
> +		.data = { ADB_PACKET, 0 },
> +	};
>  
> -	req.reply_expected = 0;
> -	req.nbytes = 2;
> -	req.data[0] = ADB_PACKET;
> -	req.data[1] = 0; /* RESET */
>  	adb_iop_write(&req);
> -	while (!req.complete) adb_iop_poll();
> +	while (!req.complete) {
> +		adb_iop_poll();
> +		schedule();
> +	}
> +
>  	return 0;
>  }
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

