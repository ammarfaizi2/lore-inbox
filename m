Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318931AbSHMEIw>; Tue, 13 Aug 2002 00:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318932AbSHMEIv>; Tue, 13 Aug 2002 00:08:51 -0400
Received: from codepoet.org ([166.70.99.138]:4253 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318931AbSHMEIv>;
	Tue, 13 Aug 2002 00:08:51 -0400
Date: Mon, 12 Aug 2002 22:12:44 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1
Message-ID: <20020813041243.GA23433@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
References: <20020811215914.GC27048@codepoet.org> <Pine.LNX.4.44.0208122357590.3620-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208122357590.3620-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 12, 2002 at 11:58:26PM -0300, Marcelo Tosatti wrote:
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

This allows it to falls back to READ_10 only when the drive
reports "Hey! You gave me an invalid command!" which is the one
and only case when a fall back to READ_10 is appropriate.  I am
not aware of any other reason for which a fallback to READ_10 is
useful.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
