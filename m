Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263620AbTCUNr0>; Fri, 21 Mar 2003 08:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263621AbTCUNr0>; Fri, 21 Mar 2003 08:47:26 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:42180 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S263620AbTCUNrY>;
	Fri, 21 Mar 2003 08:47:24 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Osamu Tomita <tomita@cinet.co.jp>
Date: Fri, 21 Mar 2003 14:57:51 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: vt.c in 2.5.65-ac1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1010F960E4@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Mar 03 at 10:46, Osamu Tomita wrote:

> I have a aquestion about patch in patch-2.5.65-ac1 for vt.c.
> Here is a extracted patch from patch-2.5.65-ac1.
> I think it's no need for 2.5.65.

There should be none of these two resize_screen calls. If you'll
resize non-foreground VT, they'll trigger fbcon_resize with 
con != visible_con, resizing your display even if they should not.

Only the "if (IS_VISIBLE) err = resize_screen(...);" resize should
be there (AFAIK), if con_resize follows other con_* APIs: call it
only if con is visible, like it is done with putcs and others.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

> --- linux-2.5.65/drivers/char/vt.c  2003-03-18 16:46:47.000000000 +0000
> +++ linux-2.5.65-ac1/drivers/char/vt.c  2003-03-18 16:58:38.000000000 +0000
> @@ -732,6 +732,12 @@
>     if (new_cols == video_num_columns && new_rows == video_num_lines)
>         return 0;
>  
> +   err = resize_screen(currcons, new_cols, new_rows);
> +   if (err) {
> +       kfree(newscreen);
> +       return err;
> +   }
> +
>     newscreen = (unsigned short *) kmalloc(new_screen_size, GFP_USER);
>     if (!newscreen)
>         return -ENOMEM;
> @@ -746,12 +752,6 @@
>     video_size_row = new_row_size;
>     screenbuf_size = new_screen_size;
>  
> -   err = resize_screen(currcons, new_cols, new_rows);
> -   if (err) {
> -       kfree(newscreen);
> -       return err;
> -   }
> -
>     rlth = min(old_row_size, new_row_size);
>     rrem = new_row_size - rlth;
>     old_origin = origin;

