Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVBORGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVBORGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVBORGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:06:14 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:27622 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261793AbVBORES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:04:18 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: dtor_core@ameritech.net
Cc: Vojtech Pavlik <vojtech@suse.cz>, harald.hoyer@redhat.de,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <d120d500050215064357fa60c@mail.gmail.com>
References: <20050211201013.GA6937@ucw.cz>
	 <1108457880.2843.5.camel@localhost> <20050215134308.GE7250@ucw.cz>
	 <d120d500050215064357fa60c@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 18:03:28 +0100
Message-Id: <1108487008.2843.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 15.02.2005, 09:43 -0500 schrieb Dmitry Torokhov:
> On Tue, 15 Feb 2005 14:43:08 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Tue, Feb 15, 2005 at 09:57:59AM +0100, Kenan Esau wrote:
> > > +static struct dmi_system_id lifebook_dmi_table[] = {
> > > +     {
> > > +             .ident = "Fujitsu Siemens Lifebook B-Sereis",
> > > +             .matches = {
> > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK B Series"),
> > > +             },
> > > +     },
> > > +     { }
> > > +};
> > 
> > This might be a bit too much generic. Are you sure there are no B Series
> > lifebooks without a touchscreen?
> > 
> 
> And another concern: does this notebook (or others using this
> touchscreen) have an active MUX? We don't want to force LBTOUCH
> protocol on an external mouse.

All B-Series Lifebooks have the same touchscreen-hardware. But Dmitri's
concern is correct -- at the moment I would enforce the LBTOUCH-protocol
on external mice...

I have to fix this. I will additionally to the DMI stuff use "Status
Request". On a "Request ID"-Command the Device always answers with a
0x00 -- could this also be helpfull?

> > > +static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
> > > +{
> > > +     unsigned char *packet = psmouse->packet;
> > > +     struct input_dev *dev = &psmouse->dev;
> > > +
> > > +        unsigned long x = 0;
> > > +        unsigned long y = 0;
> > > +        static uint8_t pkt_lst_touch = 0;
> > > +     static uint8_t pkt_cur_touch = 0;
> > > +     uint8_t pkt_lb = packet[0] & LBTOUCH_LB;
> > > +     uint8_t pkt_rb = packet[0] & LBTOUCH_RB;
> 
> We usually don't use userspace types here. unsigned char or u8 for kernel. 
> 
> > > +
> > > +                psmouse->protocol_handler = lifebook_process_byte;
> > > +                psmouse->disconnect = lifebook_disconnect;
> > > +                psmouse->reconnect  = lifebook_initialize;
> > > +                psmouse->initialize = lifebook_initialize;
> > > +                psmouse->pktsize = 3;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > 
> > The change to the psmouse interface I'm leaving to Dmitry to comment on.
> 
> I don't think that we need a separate initialize handler simply
> because it is called just once, at initialization time. Here we know
> exactly what device (protocol) we are dealing with, no need for
> indirection.

I introduced the new initialize-handler since psmouse->initialize() is
also used in psmouse-base.c. This is to prevent putting if-statements on
each place where the initialization-function for a certain protocol is
called in psmouse-base.c. 

I admit since I am also using a different reconnect-function than
psmouse-base it's not such a huge benefit but think of a new
protocol/device which uses the same reconnect-function as psmouse-base
but a different init-function.

My goal was to have no dependency from psmouse-base to the
lifebook-handling (none but lifebook_detect()). Thus the indirection is
IMHO needed.

