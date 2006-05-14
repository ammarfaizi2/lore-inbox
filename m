Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWENOZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWENOZY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 10:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWENOZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 10:25:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:30396 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751424AbWENOZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 10:25:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=HMVw+VPkJhL/QkTqIX8Mqq+sHpn0DpiC/L9f0Z7341A9+dlGU0bIQQPvAh2bMaDzzpQ9Z7JUJwP2HZ6newypcUqNt7b2uzy79yNIer+M+XH6ffDOHjwda8S+IiBmjPox8iOrYVMm8dVj/tIyrQCAhV4Yh+4t3vVj42q0rBUyNWU=
Date: Sun, 14 May 2006 18:24:09 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: [PATCH] fix potential NULL pointer deref in snd_sb8dsp_midi_interrupt()
Message-ID: <20060514142409.GC23387@mipter.zuzino.mipt.ru>
References: <200605140420.52710.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605140420.52710.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 04:20:52AM +0200, Jesper Juhl wrote:
> First testing if a pointer is NULL and if it is (or might be), proceeding
> with code that dereferences that same pointer is clearly a mistake.
> This happens in sound/isa/sb/sb8_midi.c::snd_sb8dsp_midi_interrupt()
> The patch below reworks the code so this unfortunate case doesn't happen.

All callers of snd_sb8dsp_midi_interrupt() dereference "chip" right
before calling.

> --- linux-2.6.17-rc4-git2-orig/sound/isa/sb/sb8_midi.c
> +++ linux-2.6.17-rc4-git2/sound/isa/sb/sb8_midi.c
> -irqreturn_t snd_sb8dsp_midi_interrupt(struct snd_sb * chip)
> +irqreturn_t snd_sb8dsp_midi_interrupt(struct snd_sb *chip)
>  {
>  	struct snd_rawmidi *rmidi;
>  	int max = 64;
>  	char byte;
>  
> -	if (chip == NULL || (rmidi = chip->rmidi) == NULL) {
> +	if (!chip)
> +		return IRQ_NONE;
> +	
> +	rmidi = chip->rmidi;
> +	if (!rmidi) {
>  		inb(SBP(chip, DATA_AVAIL));	/* ack interrupt */
>  		return IRQ_NONE;
>  	}

