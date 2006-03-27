Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWC0Q2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWC0Q2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWC0Q2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:28:10 -0500
Received: from wproxy.gmail.com ([64.233.184.229]:56853 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750988AbWC0Q2J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:28:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M3H0Oz65C99iyxqfLG0TyPpB4e85zVA4WPww38N3nUBv2LdczCQ+jmqZEY+8z42phGTX8Cv00dLZLoEI/A/9JrxqbauHEIfBdCbFscbjnm0PJH3lauuu07mqGH2jyAdHhFfq190yxeDkN3XhCQu93xFq0r6DjYVsE8H+cSomsYU=
Message-ID: <d120d5000603270828w4aef947cy7202da6076dd1268@mail.gmail.com>
Date: Mon, 27 Mar 2006 11:28:08 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Shaun Jackman" <sjackman@gmail.com>
Subject: Re: [PATCH] elo: Support non-pressure-sensitive ELO touchscreens
Cc: LKML <linux-kernel@vger.kernel.org>, "Vojtech Pavlik" <vojtech@suse.cz>
In-Reply-To: <7f45d9390603151047t7f18b3afn4fcf899ff8368aa3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390602241045p45aec8auaf881a4dab00c17a@mail.gmail.com>
	 <7f45d9390603151047t7f18b3afn4fcf899ff8368aa3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/06, Shaun Jackman <sjackman@gmail.com> wrote:
> Comments, please?
>

Hi Shaun,

Sorry it took me long time to respond... Overall it looks good, I have
couple of comments though.

> >
> > * Use the touch status bit rather than the pressure bits to
> >   distinguish a BTN_TOUCH event. Non-pressure-sensitive touchscreens
> >   always report full pressure.
> > * Report ABS_PRESSURE information only if the touchscreen supports it.

We should not only omit reporting pressure if toucscreen does not
support it but also not set ABS_PRESSURE bit in input device.

> > * Implement the checksum calculation correctly, and verify that the
> >   transmitted checksum is correct.
> > * Use dev_dbg to log errors in the protocol.
> >
> > Signed-off-by: Shaun Jackman <sjackman@gmail.com>
> >
> > diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
> > index c86a2eb..23b269a 100644
> > --- a/drivers/input/touchscreen/elo.c
> > +++ b/drivers/input/touchscreen/elo.c
> > @@ -35,6 +35,8 @@ MODULE_LICENSE("GPL");
> >   */
> >
> >  #define        ELO_MAX_LENGTH  10
> > +#define ELO10_TOUCH 0x03
> > +#define ELO10_PRESSURE 0x80
> >
> >  /*
> >   * Per-touchscreen data.
> > @@ -53,38 +55,40 @@ struct elo {
> >   static void elo_process_data_10(struct elo* elo, unsigned char data,
> > struct pt_regs *regs)
> >  {
> >         struct input_dev *dev = elo->dev;
> > +       struct device *dbg = &elo->serio->dev;
> >
> > -       elo->csum += elo->data[elo->idx] = data;
> > -
> > +       elo->data[elo->idx] = data;
> >         switch (elo->idx++) {
> > -
> >                 case 0:
> > +                       elo->csum = 0xaa;
> >                         if (data != 'U') {
> > +                               dev_dbg(dbg, "unsynchronized data: 0x%02x\n", data);
> >                                 elo->idx = 0;
> > -                               elo->csum = 0;
> >                         }
> >                         break;
> > -
> > -               case 1:
> > -                       if (data != 'T') {
> > -                               elo->idx = 0;
> > -                               elo->csum = 0;
> > -                       }
> > -                       break;
> > -
> >                 case 9:
> > -                       if (elo->csum) {
> > -                               input_regs(dev, regs);
> > -                               input_report_abs(dev, ABS_X, (elo->data[4] << 8) | elo->data[3]);
> > -                               input_report_abs(dev, ABS_Y, (elo->data[6] << 8) | elo->data[5]);
> > -                               input_report_abs(dev, ABS_PRESSURE, (elo->data[8] << 8) | elo->data[7]);
> > -                               input_report_key(dev, BTN_TOUCH, elo->data[8] || elo->data[7]);
> > -                               input_sync(dev);
> > -                       }
> >                         elo->idx = 0;
> > -                       elo->csum = 0;
> > +                       if (elo->csum != elo->data[9]) {
> > +                               dev_dbg(dbg, "bad checksum: 0x%02x, expected 0x%02x\n",
> > +                                               elo->data[9], elo->csum);
> > +                               break;
> > +                       }
> > +                       if (elo->data[1] != 'T') {
> > +                               dev_dbg(dbg, "unexpected packet: 0x%02x\n",
> > +                                               elo->data[1]);
> > +                               break;
> > +                       }

What is the reason for postponing checking for 'T' until full packet
is assembled? Did you actually see packets with valid checksum but
without 'T'?

> > +                       input_regs(dev, regs);
> > +                       input_report_abs(dev, ABS_X, (elo->data[4] << 8) | elo->data[3]);
> > +                       input_report_abs(dev, ABS_Y, (elo->data[6] << 8) | elo->data[5]);
> > +                       if (elo->data[2] & ELO10_PRESSURE)
> > +                               input_report_abs(dev, ABS_PRESSURE,
> > +                                               (elo->data[8] << 8) | elo->data[7]);
> > +                       input_report_key(dev, BTN_TOUCH, elo->data[2] & ELO10_TOUCH);
> > +                       input_sync(dev);
> >                         break;
> >         }
> > +       elo->csum += data;
> >  }
> >
> >   static void elo_process_data_6(struct elo* elo, unsigned char data,
> > struct pt_regs *regs)
> > @@ -189,6 +193,7 @@ static void elo_disconnect(struct serio
> >  {
> >         struct elo* elo = serio_get_drvdata(serio);
> >
> > +       dev_dbg(&serio->dev, "disconnect\n");

I am not sure if we want to have this logging here. Serio core or
maybe even driver core might be better suited for this.

> >         input_unregister_device(elo->dev);
> >         serio_close(serio);
> >         serio_set_drvdata(serio, NULL);
> > @@ -207,6 +212,7 @@ static int elo_connect(struct serio *ser
> >         struct input_dev *input_dev;
> >         int err;
> >
> > +       dev_dbg(&serio->dev, "connect\n");

Same here.

> >         elo = kzalloc(sizeof(struct elo), GFP_KERNEL);
> >         input_dev = input_allocate_device();
> >         if (!elo || !input_dev) {
> >
>

--
Dmitry
