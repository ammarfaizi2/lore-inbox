Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbTCVCMJ>; Fri, 21 Mar 2003 21:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbTCVCMJ>; Fri, 21 Mar 2003 21:12:09 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:65408 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S261403AbTCVCMI>;
	Fri, 21 Mar 2003 21:12:08 -0500
Date: Sat, 22 Mar 2003 03:23:04 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: vt.c in 2.5.65-ac1
Message-ID: <20030322022304.GA2050@vana.vc.cvut.cz>
References: <1010F960E4@vcnet.vc.cvut.cz> <20030322012453.GA1168@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322012453.GA1168@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 10:24:53AM +0900, Osamu Tomita wrote:
> On Fri, Mar 21, 2003 at 02:57:51PM +0100, Petr Vandrovec wrote:
> > On 21 Mar 03 at 10:46, Osamu Tomita wrote:
> > 
> > > I have a aquestion about patch in patch-2.5.65-ac1 for vt.c.
> > > Here is a extracted patch from patch-2.5.65-ac1.
> > > I think it's no need for 2.5.65.
> > 
> > There should be none of these two resize_screen calls. If you'll
> > resize non-foreground VT, they'll trigger fbcon_resize with 
> > con != visible_con, resizing your display even if they should not.
> > 
> > Only the "if (IS_VISIBLE) err = resize_screen(...);" resize should
> > be there (AFAIK), if con_resize follows other con_* APIs: call it
> > only if con is visible, like it is done with putcs and others.
> > >     old_origin = origin;
> I understand. But if resize_screen() failed this attempt to kfree
> before kmalloc. Is there case resize_screen success but kmalloc
> fail?
> How about patch bellow.

As I said: currently there is one unconditional call to resize_screen
and one conditional (depending on IS_VISIBLE). Unconditional one
should not be moved around, but removed completely. Look at
fbcon_resize (only con_resize user) implementation, it will do
wrong things if called with non-visible currcons. I believe that
James has this correct in his latest patches.
						Petr Vandrovec
						vandrove@vc.cvut.cz

> 
> --- linux-2.5.65/drivers/char/vt.c.orig	2003-03-18 06:44:42.000000000 +0900
> +++ linux-2.5.65/drivers/char/vt.c	2003-03-22 10:06:49.000000000 +0900
> @@ -736,6 +736,12 @@
>  	if (!newscreen)
>  		return -ENOMEM;
>  
> +	err = resize_screen(currcons, new_cols, new_rows);
> +	if (err) {
> +		kfree(newscreen);
> +		return err;
> +	}
> +
>  	old_rows = video_num_lines;
>  	old_cols = video_num_columns;
>  	old_row_size = video_size_row;
> @@ -746,12 +752,6 @@
>  	video_size_row = new_row_size;
>  	screenbuf_size = new_screen_size;
>  
> -	err = resize_screen(currcons, new_cols, new_rows);
> -	if (err) {
> -		kfree(newscreen);
> -		return err;
> -	}
> -
>  	rlth = min(old_row_size, new_row_size);
>  	rrem = new_row_size - rlth;
>  	old_origin = origin;
> Regards,
> Osamu Tomita
> 
> 
