Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWENOlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWENOlH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWENOlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 10:41:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55046 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751428AbWENOlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 10:41:06 -0400
Date: Sun, 14 May 2006 16:40:54 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       perex@suse.cz
Subject: Re: [PATCH] fix potential NULL pointer deref in snd_sb8dsp_midi_interrupt()
Message-ID: <20060514144054.GM11191@w.ods.org>
References: <200605140420.52710.jesper.juhl@gmail.com> <20060514142409.GC23387@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060514142409.GC23387@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 06:24:09PM +0400, Alexey Dobriyan wrote:
> On Sun, May 14, 2006 at 04:20:52AM +0200, Jesper Juhl wrote:
> > First testing if a pointer is NULL and if it is (or might be), proceeding
> > with code that dereferences that same pointer is clearly a mistake.
> > This happens in sound/isa/sb/sb8_midi.c::snd_sb8dsp_midi_interrupt()
> > The patch below reworks the code so this unfortunate case doesn't happen.
> 
> All callers of snd_sb8dsp_midi_interrupt() dereference "chip" right
> before calling.

So the "if (chip == NULL)" part should be removed to avoid confusion.

> 
> > --- linux-2.6.17-rc4-git2-orig/sound/isa/sb/sb8_midi.c
> > +++ linux-2.6.17-rc4-git2/sound/isa/sb/sb8_midi.c
> > -irqreturn_t snd_sb8dsp_midi_interrupt(struct snd_sb * chip)
> > +irqreturn_t snd_sb8dsp_midi_interrupt(struct snd_sb *chip)
> >  {
> >  	struct snd_rawmidi *rmidi;
> >  	int max = 64;
> >  	char byte;
> >  
> > -	if (chip == NULL || (rmidi = chip->rmidi) == NULL) {
> > +	if (!chip)
> > +		return IRQ_NONE;
> > +	
> > +	rmidi = chip->rmidi;
> > +	if (!rmidi) {
> >  		inb(SBP(chip, DATA_AVAIL));	/* ack interrupt */
> >  		return IRQ_NONE;
> >  	}

Willy

