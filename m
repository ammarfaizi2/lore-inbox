Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTI2RXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263888AbTI2RX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:23:27 -0400
Received: from havoc.gtf.org ([63.247.75.124]:48049 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263879AbTI2RWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:22:18 -0400
Date: Mon, 29 Sep 2003 13:22:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: davej@redhat.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unnecessary checks in pcmcia
Message-ID: <20030929172217.GC6526@gtf.org>
References: <E1A41Rq-0000NP-00@hardwired>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A41Rq-0000NP-00@hardwired>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 06:04:34PM +0100, davej@redhat.com wrote:
> io->stop/start are 16 bits, so will never be >0xffff
> 
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pcmcia/i82092.c linux-2.5/drivers/pcmcia/i82092.c
> --- bk-linus/drivers/pcmcia/i82092.c	2003-09-13 14:44:55.000000000 +0100
> +++ linux-2.5/drivers/pcmcia/i82092.c	2003-09-13 16:20:24.000000000 +0100
> @@ -675,7 +675,7 @@ static int i82092aa_set_io_map(struct pc
>  		leave("i82092aa_set_io_map with invalid map");
>  		return -EINVAL;
>  	}
> -	if ((io->start > 0xffff) || (io->stop > 0xffff) || (io->stop < io->start)){
> +	if (io->stop < io->start) {
>  		leave("i82092aa_set_io_map with invalid io");
>  		return -EINVAL;
>  	}

I would think the code should fail on ==0 and ==0xffff, no?

Also, does this need the "if map > 1" check the code below has?


> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pcmcia/i82365.c linux-2.5/drivers/pcmcia/i82365.c
> --- bk-linus/drivers/pcmcia/i82365.c	2003-09-11 21:18:34.000000000 +0100
> +++ linux-2.5/drivers/pcmcia/i82365.c	2003-09-12 15:37:05.000000000 +0100
> @@ -1143,8 +1143,8 @@ static int i365_set_io_map(u_short sock,
>  	  "%#4.4x-%#4.4x)\n", sock, io->map, io->flags,
>  	  io->speed, io->start, io->stop);
>      map = io->map;
> -    if ((map > 1) || (io->start > 0xffff) || (io->stop > 0xffff) ||
> -	(io->stop < io->start)) return -EINVAL;
> +    if ((map > 1) || (io->stop < io->start))
> +	return -EINVAL;
>      /* Turn off the window before changing anything */
>      if (i365_get(sock, I365_ADDRWIN) & I365_ENA_IO(map))
>  	i365_bclr(sock, I365_ADDRWIN, I365_ENA_IO(map));

likewise


> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pcmcia/tcic.c linux-2.5/drivers/pcmcia/tcic.c
> --- bk-linus/drivers/pcmcia/tcic.c	2003-09-11 21:18:34.000000000 +0100
> +++ linux-2.5/drivers/pcmcia/tcic.c	2003-09-12 15:37:05.000000000 +0100
> @@ -786,8 +786,8 @@ static int tcic_set_io_map(struct pcmcia
>      DEBUG(1, "tcic: SetIOMap(%d, %d, %#2.2x, %d ns, "
>  	  "%#4.4x-%#4.4x)\n", lsock, io->map, io->flags,
>  	  io->speed, io->start, io->stop);
> -    if ((io->map > 1) || (io->start > 0xffff) || (io->stop > 0xffff) ||
> -	(io->stop < io->start)) return -EINVAL;
> +    if ((io->map > 1) || (io->stop < io->start))
> +		return -EINVAL;
>      tcic_setw(TCIC_ADDR+2, TCIC_ADR2_INDREG | (psock << TCIC_SS_SHFT));
>      addr = TCIC_IWIN(psock, io->map);

likewise

