Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbTCVBOt>; Fri, 21 Mar 2003 20:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbTCVBOt>; Fri, 21 Mar 2003 20:14:49 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:13696 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261755AbTCVBOr>; Fri, 21 Mar 2003 20:14:47 -0500
Date: Sat, 22 Mar 2003 10:24:53 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: vt.c in 2.5.65-ac1
Message-ID: <20030322012453.GA1168@yuzuki.cinet.co.jp>
References: <1010F960E4@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1010F960E4@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 02:57:51PM +0100, Petr Vandrovec wrote:
> On 21 Mar 03 at 10:46, Osamu Tomita wrote:
> 
> > I have a aquestion about patch in patch-2.5.65-ac1 for vt.c.
> > Here is a extracted patch from patch-2.5.65-ac1.
> > I think it's no need for 2.5.65.
> 
> There should be none of these two resize_screen calls. If you'll
> resize non-foreground VT, they'll trigger fbcon_resize with 
> con != visible_con, resizing your display even if they should not.
> 
> Only the "if (IS_VISIBLE) err = resize_screen(...);" resize should
> be there (AFAIK), if con_resize follows other con_* APIs: call it
> only if con is visible, like it is done with putcs and others.
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
> 
> > --- linux-2.5.65/drivers/char/vt.c  2003-03-18 16:46:47.000000000 +0000
> > +++ linux-2.5.65-ac1/drivers/char/vt.c  2003-03-18 16:58:38.000000000 +0000
> > @@ -732,6 +732,12 @@
> >     if (new_cols == video_num_columns && new_rows == video_num_lines)
> >         return 0;
> >  
> > +   err = resize_screen(currcons, new_cols, new_rows);
> > +   if (err) {
> > +       kfree(newscreen);
> > +       return err;
> > +   }
> > +
> >     newscreen = (unsigned short *) kmalloc(new_screen_size, GFP_USER);
> >     if (!newscreen)
> >         return -ENOMEM;
> > @@ -746,12 +752,6 @@
> >     video_size_row = new_row_size;
> >     screenbuf_size = new_screen_size;
> >  
> > -   err = resize_screen(currcons, new_cols, new_rows);
> > -   if (err) {
> > -       kfree(newscreen);
> > -       return err;
> > -   }
> > -
> >     rlth = min(old_row_size, new_row_size);
> >     rrem = new_row_size - rlth;
> >     old_origin = origin;
I understand. But if resize_screen() failed this attempt to kfree
before kmalloc. Is there case resize_screen success but kmalloc
fail?
How about patch bellow.

--- linux-2.5.65/drivers/char/vt.c.orig	2003-03-18 06:44:42.000000000 +0900
+++ linux-2.5.65/drivers/char/vt.c	2003-03-22 10:06:49.000000000 +0900
@@ -736,6 +736,12 @@
 	if (!newscreen)
 		return -ENOMEM;
 
+	err = resize_screen(currcons, new_cols, new_rows);
+	if (err) {
+		kfree(newscreen);
+		return err;
+	}
+
 	old_rows = video_num_lines;
 	old_cols = video_num_columns;
 	old_row_size = video_size_row;
@@ -746,12 +752,6 @@
 	video_size_row = new_row_size;
 	screenbuf_size = new_screen_size;
 
-	err = resize_screen(currcons, new_cols, new_rows);
-	if (err) {
-		kfree(newscreen);
-		return err;
-	}
-
 	rlth = min(old_row_size, new_row_size);
 	rrem = new_row_size - rlth;
 	old_origin = origin;
Regards,
Osamu Tomita

