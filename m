Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSHPDIm>; Thu, 15 Aug 2002 23:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSHPDIm>; Thu, 15 Aug 2002 23:08:42 -0400
Received: from waste.org ([209.173.204.2]:40089 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318086AbSHPDIl>;
	Thu, 15 Aug 2002 23:08:41 -0400
Date: Thu, 15 Aug 2002 22:12:03 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Erik Andersen <andersen@codepoet.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1
Message-ID: <20020816031203.GA5418@waste.org>
References: <20020811215914.GC27048@codepoet.org> <Pine.LNX.4.44.0208122357590.3620-100000@freak.distro.conectiva> <20020813041243.GA23433@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020813041243.GA23433@codepoet.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 10:12:44PM -0600, Erik Andersen wrote:
> On Mon Aug 12, 2002 at 11:58:26PM -0300, Marcelo Tosatti wrote:
> > 
> > 
> > On Sun, 11 Aug 2002, Erik Andersen wrote:
> > 
> > > +++ drivers/cdrom/cdrom.c	Sun Aug 11 15:37:24 2002
> > > @@ -1916,6 +1916,7 @@
> > >  {
> > >  	struct cdrom_device_ops *cdo = cdi->ops;
> > >  	struct cdrom_generic_command cgc;
> > > +	struct request_sense sense;
> > >  	kdev_t dev = cdi->dev;
> > >  	char buffer[32];
> > >  	int ret = 0;
> > > @@ -1951,9 +1952,11 @@
> > >  		cgc.buffer = (char *) kmalloc(blocksize, GFP_KERNEL);
> > >  		if (cgc.buffer == NULL)
> > >  			return -ENOMEM;
> > > +		memset(&sense, 0, sizeof(sense));
> > > +		cgc.sense = &sense;
> > >  		cgc.data_direction = CGC_DATA_READ;
> > >  		ret = cdrom_read_block(cdi, &cgc, lba, 1, format, blocksize);
> > > -		if (ret) {
> > > +		if (ret && sense.sense_key==0x05 && sense.asc==0x20 && sense.ascq==0x00) {
> > 
> > Do you really need to hardcode this values ?
> 
> This allows it to falls back to READ_10 only when the drive
> reports "Hey! You gave me an invalid command!" which is the one
> and only case when a fall back to READ_10 is appropriate.  I am
> not aware of any other reason for which a fallback to READ_10 is
> useful.

A comment to that effect would be useful. Not so much the
interpretation of the numbers (which are easy enough to look up) but
the rationale.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
