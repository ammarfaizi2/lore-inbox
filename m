Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVBORmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVBORmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVBORmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:42:40 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:6553 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261622AbVBORmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:42:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iVL6wpn20UDo1paCcrqRE9RicfLlIWpPaYdqXz1G1JI1vzq0qvX5j2HqXrliMug5G5gozYzxNz437XEnqJQI1e7sCbdky75MAus/yYKp0en0rVRBDs4J0kosxkZuPHBUYlvkx2mhSvEmNmUBgBuKyzcRx63rBNugEOVxlfrGeoE=
Message-ID: <d120d5000502150942527fd4ea@mail.gmail.com>
Date: Tue, 15 Feb 2005 12:42:03 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Kenan Esau <kenan.esau@conan.de>
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Cc: Vojtech Pavlik <vojtech@suse.cz>, harald.hoyer@redhat.de,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <1108487008.2843.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050211201013.GA6937@ucw.cz> <1108457880.2843.5.camel@localhost>
	 <20050215134308.GE7250@ucw.cz>
	 <d120d500050215064357fa60c@mail.gmail.com>
	 <1108487008.2843.21.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005 18:03:28 +0100, Kenan Esau <kenan.esau@conan.de> wrote:
> Am Dienstag, den 15.02.2005, 09:43 -0500 schrieb Dmitry Torokhov:
> > On Tue, 15 Feb 2005 14:43:08 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > On Tue, Feb 15, 2005 at 09:57:59AM +0100, Kenan Esau wrote:
> > > > +static struct dmi_system_id lifebook_dmi_table[] = {
> > > > +     {
> > > > +             .ident = "Fujitsu Siemens Lifebook B-Sereis",
> > > > +             .matches = {
> > > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK B Series"),
> > > > +             },
> > > > +     },
> > > > +     { }
> > > > +};
> > >
> > > This might be a bit too much generic. Are you sure there are no B Series
> > > lifebooks without a touchscreen?
> > >
> >
> > And another concern: does this notebook (or others using this
> > touchscreen) have an active MUX? We don't want to force LBTOUCH
> > protocol on an external mouse.
> 
> All B-Series Lifebooks have the same touchscreen-hardware. But Dmitri's
> concern is correct -- at the moment I would enforce the LBTOUCH-protocol
> on external mice...
> 
> I have to fix this. I will additionally to the DMI stuff use "Status
> Request". On a "Request ID"-Command the Device always answers with a
> 0x00 -- could this also be helpfull?
> 
> > > > +static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
> > > > +{
> > > > +     unsigned char *packet = psmouse->packet;
> > > > +     struct input_dev *dev = &psmouse->dev;
> > > > +
> > > > +        unsigned long x = 0;
> > > > +        unsigned long y = 0;
> > > > +        static uint8_t pkt_lst_touch = 0;
> > > > +     static uint8_t pkt_cur_touch = 0;
> > > > +     uint8_t pkt_lb = packet[0] & LBTOUCH_LB;
> > > > +     uint8_t pkt_rb = packet[0] & LBTOUCH_RB;
> >
> > We usually don't use userspace types here. unsigned char or u8 for kernel.
> >
> > > > +
> > > > +                psmouse->protocol_handler = lifebook_process_byte;
> > > > +                psmouse->disconnect = lifebook_disconnect;
> > > > +                psmouse->reconnect  = lifebook_initialize;
> > > > +                psmouse->initialize = lifebook_initialize;
> > > > +                psmouse->pktsize = 3;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > The change to the psmouse interface I'm leaving to Dmitry to comment on.
> >
> > I don't think that we need a separate initialize handler simply
> > because it is called just once, at initialization time. Here we know
> > exactly what device (protocol) we are dealing with, no need for
> > indirection.
> 
> I introduced the new initialize-handler since psmouse->initialize() is
> also used in psmouse-base.c. This is to prevent putting if-statements on
> each place where the initialization-function for a certain protocol is
> called in psmouse-base.c.

It would be good idea if protocols were initialized in many difefrent
places, but the all are called from one place - psmouse_extensions.
Some protocols that can be detected without changing hardware state
have 2 functions - detect and init and the others have ony detect
which does initialization as well. But they all are called from the
same place.

psmouse_initialize has somewhat confising name, it is not "initialize
protocol", it is "enable streaming and initialize common parameters,
such as rate and resolution". Plus I think it is too late to do
protocol init in psmouse_initialize as this will not allow falling
back to "lesser" protocols if higher prtocol initialization fails.

> I admit since I am also using a different reconnect-function than
> psmouse-base it's not such a huge benefit but think of a new
> protocol/device which uses the same reconnect-function as psmouse-base
> but a different init-function.

I am not sure what difference does it make - if there is no reconnect
hamdler psmosue will end up calling psmouse_extensions which will
re-initialize hardware with proper function for the protocol. It still
does not require a handler in psmouse structure.

> 
> My goal was to have no dependency from psmouse-base to the
> lifebook-handling (none but lifebook_detect()). Thus the indirection is
> IMHO needed.

You can hide all of it right in lifebook_detect or acknowledge that
you have 2 fucntions and call them from psmouse-base, like synaptics
and alps do. I don't think it exposes lbtouch internals too much.

-- 
Dmitry
