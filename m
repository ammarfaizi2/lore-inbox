Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVBOOnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVBOOnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 09:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVBOOnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 09:43:15 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:53155 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261736AbVBOOnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 09:43:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dvQC+BUUutg5Yheu02GEZBckd/s6t8s8LOE/St2jtiy9CbZWe4wHUZig0zSHMRVTPJ83xtwlPIPkwT1fDBm/NJNLp3ppwACHo6oXhq7smYkFMf++ZRmi7e3/vEf1libhFgKoqiXW/w4PfDx4maEOI81pnxG7+e9S5k2LcZjs4rQ=
Message-ID: <d120d500050215064357fa60c@mail.gmail.com>
Date: Tue, 15 Feb 2005 09:43:07 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Cc: Kenan Esau <kenan.esau@conan.de>, harald.hoyer@redhat.de,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050215134308.GE7250@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050211201013.GA6937@ucw.cz> <1108457880.2843.5.camel@localhost>
	 <20050215134308.GE7250@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005 14:43:08 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Feb 15, 2005 at 09:57:59AM +0100, Kenan Esau wrote:
> > +static struct dmi_system_id lifebook_dmi_table[] = {
> > +     {
> > +             .ident = "Fujitsu Siemens Lifebook B-Sereis",
> > +             .matches = {
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK B Series"),
> > +             },
> > +     },
> > +     { }
> > +};
> 
> This might be a bit too much generic. Are you sure there are no B Series
> lifebooks without a touchscreen?
> 

And another concern: does this notebook (or others using this
touchscreen) have an active MUX? We don't want to force LBTOUCH
protocol on an external mouse.

> > +static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
> > +{
> > +     unsigned char *packet = psmouse->packet;
> > +     struct input_dev *dev = &psmouse->dev;
> > +
> > +        unsigned long x = 0;
> > +        unsigned long y = 0;
> > +        static uint8_t pkt_lst_touch = 0;
> > +     static uint8_t pkt_cur_touch = 0;
> > +     uint8_t pkt_lb = packet[0] & LBTOUCH_LB;
> > +     uint8_t pkt_rb = packet[0] & LBTOUCH_RB;

We usually don't use userspace types here. unsigned char or u8 for kernel. 

> > +
> > +                psmouse->protocol_handler = lifebook_process_byte;
> > +                psmouse->disconnect = lifebook_disconnect;
> > +                psmouse->reconnect  = lifebook_initialize;
> > +                psmouse->initialize = lifebook_initialize;
> > +                psmouse->pktsize = 3;
> > +     }
> > +
> > +     return 0;
> > +}
> 
> The change to the psmouse interface I'm leaving to Dmitry to comment on.

I don't think that we need a separate initialize handler simply
because it is called just once, at initialization time. Here we know
exactly what device (protocol) we are dealing with, no need for
indirection.

-- 
Dmitry
