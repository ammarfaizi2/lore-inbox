Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271934AbTG2RqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271940AbTG2RqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:46:25 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:56837 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271934AbTG2RqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:46:20 -0400
Date: Tue, 29 Jul 2003 18:46:18 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Sven Schnelle <schnelle@kabelleipzig.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Framebuffer Console
In-Reply-To: <20030728201006.GA349@apollo.sven.bitebene.org>
Message-ID: <Pine.LNX.4.44.0307291827090.5874-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> while testing linux-2.6.0-test2 I have some strange framebuffer(rivafb,
> but maybe this appears on other card's too)
> behaviour:
> 
> 1) Screen is not restored after switching from X11 back to textmode

Try adding UseFBDev "true" to your XF86Config file. 

> 2) Cursor shows wrong characters

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

This is wrong. FB_CUR_SETCUR is used only by the userland cursor 
interface. We use it to turn the cursor on and off via userland this way.
Internal to the kernel we just toggle the enable flag.

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

This is a fluke that it helps. The cursor shows wrong characters because
the code logic is wrong. I'm working on the new code.


