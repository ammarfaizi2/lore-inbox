Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268127AbTBWLuG>; Sun, 23 Feb 2003 06:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268135AbTBWLuG>; Sun, 23 Feb 2003 06:50:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8206 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268127AbTBWLuF>; Sun, 23 Feb 2003 06:50:05 -0500
Date: Sun, 23 Feb 2003 12:00:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: add socket_offset for multiple pci_sockets, correct suspend&resume
Message-ID: <20030223120011.A14488@flint.arm.linux.org.uk>
Mail-Followup-To: Dominik Brodowski <linux@brodo.de>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030223090608.GA11747@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030223090608.GA11747@brodo.de>; from linux@brodo.de on Sun, Feb 23, 2003 at 10:06:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 10:06:08AM +0100, Dominik Brodowski wrote:
> diff -ruN linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
> --- linux-original/drivers/pcmcia/cs.c	2003-02-23 10:04:03.000000000 +0100
> +++ linux/drivers/pcmcia/cs.c	2003-02-23 10:04:25.000000000 +0100
> @@ -337,13 +337,14 @@
>  		return -ENOMEM;
>  	memset(s_info, 0, cls_d->nsock * sizeof(socket_info_t));
>  
> +	cls_d->s_info = s_info;
> +
>  	/* socket initialization */
>  	for (i = 0; i < cls_d->nsock; i++) {
>  		socket_info_t *s = &s_info[i];
>  
> -		cls_d->s_info[i] = s;
>  		s->ss_entry = cls_d->ops;
> -		s->sock = i;
> +		s->sock = i + cls_d->sock_offset;
>  
>  		/* base address = 0, map = 0 */
>  		s->cis_mem.flags = 0;

I think you missed changing:

                s->ss_entry->inquire_socket(i, &s->cap);

to:

                s->ss_entry->inquire_socket(s->sock, &s->cap);

otherwise both sockets end up pointing at the same cb_dev.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
