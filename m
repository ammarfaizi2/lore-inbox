Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSHMIj3>; Tue, 13 Aug 2002 04:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSHMIj3>; Tue, 13 Aug 2002 04:39:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31186 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314077AbSHMIj2>;
	Tue, 13 Aug 2002 04:39:28 -0400
Date: Tue, 13 Aug 2002 10:42:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Erik Andersen <andersen@codepoet.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1
Message-ID: <20020813084257.GU5583@suse.de>
References: <20020811215914.GC27048@codepoet.org> <Pine.LNX.4.44.0208122357590.3620-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208122357590.3620-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12 2002, Marcelo Tosatti wrote:
> 
> 
> On Sun, 11 Aug 2002, Erik Andersen wrote:
> 
> > --- drivers/cdrom/cdrom.c~	Sun Aug 11 15:37:20 2002
> > +++ drivers/cdrom/cdrom.c	Sun Aug 11 15:37:24 2002
> > @@ -1916,6 +1916,7 @@
> >  {
> >  	struct cdrom_device_ops *cdo = cdi->ops;
> >  	struct cdrom_generic_command cgc;
> > +	struct request_sense sense;
> >  	kdev_t dev = cdi->dev;
> >  	char buffer[32];
> >  	int ret = 0;
> > @@ -1951,9 +1952,11 @@
> >  		cgc.buffer = (char *) kmalloc(blocksize, GFP_KERNEL);
> >  		if (cgc.buffer == NULL)
> >  			return -ENOMEM;
> > +		memset(&sense, 0, sizeof(sense));
> > +		cgc.sense = &sense;
> >  		cgc.data_direction = CGC_DATA_READ;
> >  		ret = cdrom_read_block(cdi, &cgc, lba, 1, format, blocksize);
> > -		if (ret) {
> > +		if (ret && sense.sense_key==0x05 && sense.asc==0x20 && sense.ascq==0x00) {
> 
> Do you really need to hardcode this values ?

the values above are well known to anyone familiar with atapi and/or
scsi, so it's not a worry. the patch looks good to me, I can recommend
it for inclusion.

-- 
Jens Axboe

