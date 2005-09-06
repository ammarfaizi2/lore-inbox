Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVIFMxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVIFMxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 08:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVIFMxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 08:53:05 -0400
Received: from tumsa.unibanka.lv ([193.178.151.91]:43151 "EHLO fax.unibanka.lv")
	by vger.kernel.org with ESMTP id S964847AbVIFMxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 08:53:04 -0400
From: Aivils Stoss <aivils@unibanka.lv>
To: vojtech@suse.cz
Subject: Re: INPUT: keyboard_tasklet - don't touch LED's of already grabed device
Date: Tue, 6 Sep 2005 15:55:25 +0300
User-Agent: KMail/1.7.2
Cc: Hugo Vanwoerkom <hvw59601@yahoo.com>, linux-kernel@vger.kernel.org,
       bruby <linuxconsole-dev@lists.sourceforge.net>
References: <200509061034.55963.aivils@unibanka.lv> <20050906115228.80715.qmail@web31008.mail.mud.yahoo.com> <20050906115750.GA10001@ucw.cz>
In-Reply-To: <20050906115750.GA10001@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509061555.26753.aivils@unibanka.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Otrdiena, 6. Septembris 2005 14:57, Vojtech Pavlik wrote:
> On Tue, Sep 06, 2005 at 04:52:28AM -0700, Hugo Vanwoerkom wrote:
> > --- Aivils Stoss <aivils@unibanka.lv> wrote:
> > > Hi, Vojtech!
> > >
> > > Recent kernels allow exclusive usage of input device
> > > when
> > > input device is grabed. keyboard_tasklet does not
> > > check
> > > device state and switch LED's of all keyboards.
> > > However
> > > grabed device may be use another LED steering code.
> > >
> > > This patch forbid keyboard_tasklet switch LED's of
> > > grabed devices.
> > >
> > > Aivils Stoss
> >
> > While trying this with 2.6.12 it gets a compilation
> > error. Not when you move the added statements after
> > the structure declaration.
> >
> > Is that me heading for them thar hills?
>
> The patch probably wasn't tested. ;)

How a soul who hates kernel compilation can test a patch?
Runtime modifcation:
http://www.ltn.lv/~aivils/files/hijackled-2.6.11-12mdk.tar.bz2

Aivils

--- linux-2.6.13/drivers/char/keyboard.c        2005-08-29 02:41:01.000000000 +0300
+++ linux-2.6.13/drivers/char/keyboard.c~       2005-09-06 15:32:28.000000000 +0300
@@ -896,16 +896,18 @@ static inline unsigned char getleds(void
 static void kbd_bh(unsigned long dummy)
 {
        struct list_head * node;
        unsigned char leds = getleds();

        if (leds != ledstate) {
                list_for_each(node,&kbd_handler.h_list) {
                        struct input_handle * handle = to_handle_h(node);
+                       if (handle->dev->grab)
+                               continue;
                        input_event(handle->dev, EV_LED, LED_SCROLLL, !!(leds & 0x01));
                        input_event(handle->dev, EV_LED, LED_NUML,    !!(leds & 0x02));
                        input_event(handle->dev, EV_LED, LED_CAPSL,   !!(leds & 0x04));
                        input_sync(handle->dev);
                }
        }

        ledstate = leds;
