Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281312AbRKLIOF>; Mon, 12 Nov 2001 03:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281313AbRKLINz>; Mon, 12 Nov 2001 03:13:55 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:37767 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S281312AbRKLINo>;
	Mon, 12 Nov 2001 03:13:44 -0500
Message-Id: <200111120813.fAC8DS628910@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Fix for i810_audio trouble under KDE [Was: Re: PATCH: partial fix for i810_audio.c problems under KDE]
Date: Mon, 12 Nov 2001 10:13:28 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15vdKC-0001eY-00@the-village.bc.nu> <200111030934.fA39YBf00763@hal.astr.lu.lv>
In-Reply-To: <200111030934.fA39YBf00763@hal.astr.lu.lv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Verified that included patch together with patch from 
Tobias Diedrich <ranma@gmx.at>:

	http://www.cs.helsinki.fi/linux/linux-kernel/2001-44/1023.html

completely fixes problems with i810_audio.c I had under KDE (kernel 
2.4.13-ac5). 

Andris

On Saturday 03 November 2001 11:34, Andris Pavenis wrote:
> On Monday 22 October 2001 14:32, Alan Cox wrote:
> > > reverted one of the patches between 2.4.6-ac1 and 2.4.6-ac2) which
> > > mostly works for KDE with fragment size up to 512 bytes. 2.4.7 worked
> > > with any fragment size set in kcontrol.
> >
> > Thanks
> >
> > > I haven't tested much under GNOME, as I'm starting it very seldom
> >
> > Gnome esd is very simple in how it drives the hardware - it works in many
> > cases where drivers are buggy and arts shows up problems
>
> Verified that reverting one patch from 2.4.6-ac time partially fixes
> i810_audio problems for 2.4.13-ac5 for KDE (it works with fragment size not
> larger than 512 bytes and gives garbled sound for larger fragment size).
> This is the same patch which reverting helped me earlier. Below are diffs.
>
> Andris
>
> --- i810_audio.c.orig	Tue Oct 30 09:17:35 2001
> +++ i810_audio.c	Sat Nov  3 11:00:45 2001
> @@ -1405,30 +1405,23 @@
>  		if (dmabuf->count < 0) {
>  			dmabuf->count = 0;
>  		}
> -		cnt = dmabuf->dmasize - dmabuf->fragsize - dmabuf->count;
> -		// this is to make the copy_from_user simpler below
> -		if(cnt > (dmabuf->dmasize - swptr))
> -			cnt = dmabuf->dmasize - swptr;
> +		cnt = dmabuf->dmasize - swptr;
> +		if(cnt > (dmabuf->dmasize - dmabuf->count))
> +			cnt = dmabuf->dmasize - dmabuf->count;
>  		spin_unlock_irqrestore(&state->card->lock, flags);
>
> -#ifdef DEBUG2
> -		printk(KERN_INFO "i810_audio: i810_write: %d bytes available space\n",
> cnt);
> -#endif
>  		if (cnt > count)
>  			cnt = count;
>  		if (cnt <= 0) {
>  			unsigned long tmo;
>  			// There is data waiting to be played
> +			i810_update_lvi(state,0);
>  			if(!dmabuf->enable && dmabuf->count) {
>  				/* force the starting incase SETTRIGGER has been used */
>  				/* to stop it, otherwise this is a deadlock situation */
>  				dmabuf->trigger |= PCM_ENABLE_OUTPUT;
>  				start_dac(state);
>  			}
> -			// Update the LVI pointer in case we have already
> -			// written data in this syscall and are just waiting
> -			// on the tail bit of data
> -			i810_update_lvi(state,0);
>  			if (file->f_flags & O_NONBLOCK) {
>  				if (!ret) ret = -EAGAIN;
>  				goto ret;
