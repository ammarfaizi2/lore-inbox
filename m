Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318925AbSHMDok>; Mon, 12 Aug 2002 23:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318929AbSHMDok>; Mon, 12 Aug 2002 23:44:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16651 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318925AbSHMDok>; Mon, 12 Aug 2002 23:44:40 -0400
Date: Mon, 12 Aug 2002 23:58:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Erik Andersen <andersen@codepoet.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1
In-Reply-To: <20020811215914.GC27048@codepoet.org>
Message-ID: <Pine.LNX.4.44.0208122357590.3620-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Aug 2002, Erik Andersen wrote:

> --- drivers/cdrom/cdrom.c~	Sun Aug 11 15:37:20 2002
> +++ drivers/cdrom/cdrom.c	Sun Aug 11 15:37:24 2002
> @@ -1916,6 +1916,7 @@
>  {
>  	struct cdrom_device_ops *cdo = cdi->ops;
>  	struct cdrom_generic_command cgc;
> +	struct request_sense sense;
>  	kdev_t dev = cdi->dev;
>  	char buffer[32];
>  	int ret = 0;
> @@ -1951,9 +1952,11 @@
>  		cgc.buffer = (char *) kmalloc(blocksize, GFP_KERNEL);
>  		if (cgc.buffer == NULL)
>  			return -ENOMEM;
> +		memset(&sense, 0, sizeof(sense));
> +		cgc.sense = &sense;
>  		cgc.data_direction = CGC_DATA_READ;
>  		ret = cdrom_read_block(cdi, &cgc, lba, 1, format, blocksize);
> -		if (ret) {
> +		if (ret && sense.sense_key==0x05 && sense.asc==0x20 && sense.ascq==0x00) {

Do you really need to hardcode this values ?

