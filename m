Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030523AbWJ3JIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbWJ3JIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbWJ3JIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:08:55 -0500
Received: from styx.suse.cz ([82.119.242.94]:16563 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030523AbWJ3JIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:08:53 -0500
Date: Mon, 30 Oct 2006 10:08:51 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Dave Neuer <mr.fred.smoothie@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Message-ID: <20061030090851.GA2687@suse.cz>
References: <200608232311.07599.dtor@insightbb.com> <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com> <200610292234.02487.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610292234.02487.dtor@insightbb.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 10:34:00PM -0500, Dmitry Torokhov wrote:
> On Sunday 29 October 2006 18:20, Dave Neuer wrote:
> > On 8/23/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > > Hi everyone,
> > >
> > > Here is another version of the patch removing polling timer from i8042
> > > which is needed if we want tickless kernel. Keyboards should now work
> > > on boxes that do not have mouse plugged in. PLease give it a test.
> > 
> >  What's the intent of this; just to allow tickless? Or is it also to
> > make the i8042 driver less racy? I ask because I've applied this over
> > (a modified) 2.6.18 on my Compaq Presario X1010us laptop which has
> > been driving me crazy w/ Synaptics problems and keyboard problems
> > (intermittent, but   frequent enough lately that I finally figured I
> > needed to do something about it).
> > 
> > If removing raciness is part of the goal, isn't the window in
> > i8042_aux_write still a problem?
> > 
> > 	if (port->mux == -1)
> > 		retval = i8042_command(&c, I8042_CMD_AUX_SEND);
> > 	else
> > 		retval = i8042_command(&c, I8042_CMD_MUX_SEND + port->mux);
> > 
> >         /* i8042_command has re-enabled interrupts;
> >            what happens if real interrupt happens here, before we call
> > the ISR ourselves? */
> > 
> > 	i8042_interrupt(0, NULL, NULL);
> > 	return retval;
> > }
> 
> Hi Dave,
> 
> i8042_interrupt() uses spinlock to serialize access to the KBC so if real
> interrupt happens before we call i8042_interrupt() manually (and it should
> normally happen) it will just process the response and second i8042_interrupt()
> will be just a no-op.

This would, however, create two reads of the i8042 controller
back-to-back, which has been a problem on old i8042's: IIRC IBM
documentation states that between the reads there should be a delay.

-- 
Vojtech Pavlik
Director SuSE Labs
