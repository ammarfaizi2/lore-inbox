Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWCQCqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWCQCqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 21:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWCQCqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 21:46:09 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:40620 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751017AbWCQCqI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 21:46:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KHT9yZL/bp02WZS4dGpOWQmUaobSI1wdj9esMzpGOi2CUJupLx9zMYDfrpoE6+751OfbS0xAV5HWg2PsipGcAMS6PDgdVena80E1tFPuXz9WYXZJ2ejFJe7S3RU4RZIMBA2pz8SVu/F6wOtHljgJ2RiqUNQ1nM/JCXYt4VSLNn4=
Message-ID: <38c09b90603161846n47b5d47fnc6b4d4b9ff2d078b@mail.gmail.com>
Date: Fri, 17 Mar 2006 10:46:07 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Cc: "Greg KH" <greg@kroah.com>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
In-Reply-To: <200603152253.24194.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com>
	 <20060314103854.GC32065@lug-owl.de>
	 <38c09b90603142030o7092a39aq8ace7758972ce09a@mail.gmail.com>
	 <200603152253.24194.daniel.ritz-ml@swissonline.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/06, Daniel Ritz <daniel.ritz-ml@swissonline.ch> wrote:
> On Wednesday 15 March 2006 05.30, Lanslott Gish wrote:
> > did you mean like that? thx.
> >
> > regards,
> >
> > Lanslott Gish
> > ===================================================================
> > --- linux-2.6.16-rc6.patched/drivers/usb/input/usbtouchscreen.c
> > +++ linux-2.6.16-rc6/drivers/usb/input/usbtouchscreen.c
> > @@ -49,6 +49,13 @@
> >  static int swap_xy;
> >  module_param(swap_xy, bool, 0644);
> >  MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
> > +static int swap_x;
> > +module_param(swap_x, bool, 0644);
> > +MODULE_PARM_DESC(swap_x, "If set X axe is swapped before XY swapped.");
> > +static int swap_y;
> > +module_param(swap_y, bool, 0644);
> > +MODULE_PARM_DESC(swap_y, "If set Y axe is swapped before XY swapped.");
> > +
> >
> (i prefer invert_x and invert_y...)
>
"invert" is great, thx.
evtouch(X11 driver) called these swap_x and swap_y

> >
> >  /* device specifc data/functions */
> > @@ -224,13 +231,17 @@
> >   * PanJit Part
> >   */
> >  #ifdef CONFIG_USB_TOUCHSCREEN_PANJIT
> > +
> >  static int panjit_read_data(char *pkt, int *x, int *y, int *touch, int *press)
> >  {
> > -       *x = pkt[1] | (pkt[2] << 8);
> > -       *y = pkt[3] | (pkt[4] << 8);
> > +       *x = (pkt[1] & 0x0F) | ((pkt[2]& 0xFF) << 8);
> > +       *y = (pkt[3] & 0x0F) | ((pkt[4]& 0xFF) << 8);
>
> that just can't be right. you probably mean
> +       *y = pkt[3] | ((pkt[4] & 0x0F) << 8);
>
> otherwise you mask out bits 4-7. but you want to limit it to 12 bits...
> (btw. no need for the & 0xFF mask since *pkt is char)
>

you are right, sorry for my fault. the truely way is

+       *x = (pkt[1] & 0xFF) | ((pkt[2] & 0x0F) << 8);
+       *y = (pkt[3] & 0xFF) | ((pkt[4] & 0x0F) << 8);

still need 12 bits( 0x0FFF) and the masks to avoid get negative.


BTW, may i also suggest add more module_param to max_x, max_y, min_x, min_y  ?
i think these options is useful, too.

regards,

Lanslott Gish
--
L.G, Life's Good~
