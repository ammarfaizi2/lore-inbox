Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271286AbTG2HTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271287AbTG2HTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:19:33 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:61062 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S271286AbTG2HTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:19:31 -0400
Date: Tue, 29 Jul 2003 09:19:27 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Sven Schnelle <schnelle@kabelleipzig.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Framebuffer Console
Message-ID: <20030729071927.GA21795@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <20030728201006.GA349@apollo.sven.bitebene.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030728201006.GA349@apollo.sven.bitebene.org>
X-Operating-System: vega Linux 2.6.0-test1 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Though I did not check this patch below, with 2.6.0-test1 kernel MGA
framebuffer console is totally unusable. Eg scrolling and major screen
update tasks corrupt the screen heavily with vertical lines everywhere
and other even "funnier" effects occured. With plain text consol there is
no problem however I NEED framebuffer console (eg playing video on the
console without X). It as a Matrox G400 card.

On Mon, Jul 28, 2003 at 10:10:06PM +0200, Sven Schnelle wrote:
> Hi,
> 
> while testing linux-2.6.0-test2 I have some strange framebuffer(rivafb,
> but maybe this appears on other card's too)
> behaviour:
> 
> 1) Screen is not restored after switching from X11 back to textmode
> 2) Cursor shows wrong characters
> 
> 
> This patch solve the problems for me:
> 
> -------------------------------------8<--------------------------------
> diff -ur linux-2.6.0-test2/drivers/video/console/fbcon.c linux-2.6.0-test2-sv/drivers/video/console/fbcon.c
> --- linux-2.6.0-test2/drivers/video/console/fbcon.c	2003-07-27 19:05:15.000000000 +0200
> +++ linux-2.6.0-test2-sv/drivers/video/console/fbcon.c	2003-07-28 10:40:38.000000000 +0200
> @@ -1056,7 +1056,7 @@
>  			cursor.set |= FB_CUR_SETHOT;
>  		}
>  
> -		if ((cursor.set & FB_CUR_SETSIZE) || ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)) {
> +		if ((cursor.set & FB_CUR_SETSIZE) || (cursor.set & FB_CUR_SETCUR) || ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)) {
>  			char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
>  			int cur_height, size, i = 0;
>  
> @@ -1704,8 +1704,13 @@
>  	if (blank < 0)		/* Entering graphics mode */
>  		return 0;
>  
> +	/* FIXME: Dirty Hack */
> +	info->cursor.image.height = 0;	/* Need to set cursor size */
> +	info->cursor.image.width = 0;
>  	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
>  
> +	fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
> +	update_screen(vc->vc_num);
>  	if (!info->fbops->fb_blank) {
>  		if (blank) {
>  			unsigned short oldc;
> -----------------------------------8<--------------------------------------
> 
> don't know if this is the right way, but it works...
> 
> Regards,
> -- 
> Sven Schnelle, <schnelle@kabelleipzig.de>
> -----------------------------------------



-- 
- Gábor (larta'H)
