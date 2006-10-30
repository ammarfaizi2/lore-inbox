Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbWJ3DeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbWJ3DeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 22:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbWJ3DeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 22:34:10 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:11650 "EHLO
	asav13.insightbb.com") by vger.kernel.org with ESMTP
	id S1030500AbWJ3DeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 22:34:09 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnoUACL/REVKhRUUXWdsb2JhbACBTIQyhiws
From: Dmitry Torokhov <dtor@insightbb.com>
To: Dave Neuer <mr.fred.smoothie@pobox.com>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Date: Sun, 29 Oct 2006 22:34:00 -0500
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200608232311.07599.dtor@insightbb.com> <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
In-Reply-To: <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610292234.02487.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 October 2006 18:20, Dave Neuer wrote:
> On 8/23/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > Hi everyone,
> >
> > Here is another version of the patch removing polling timer from i8042
> > which is needed if we want tickless kernel. Keyboards should now work
> > on boxes that do not have mouse plugged in. PLease give it a test.
> 
>  What's the intent of this; just to allow tickless? Or is it also to
> make the i8042 driver less racy? I ask because I've applied this over
> (a modified) 2.6.18 on my Compaq Presario X1010us laptop which has
> been driving me crazy w/ Synaptics problems and keyboard problems
> (intermittent, but   frequent enough lately that I finally figured I
> needed to do something about it).
> 
> If removing raciness is part of the goal, isn't the window in
> i8042_aux_write still a problem?
> 
> 	if (port->mux == -1)
> 		retval = i8042_command(&c, I8042_CMD_AUX_SEND);
> 	else
> 		retval = i8042_command(&c, I8042_CMD_MUX_SEND + port->mux);
> 
>         /* i8042_command has re-enabled interrupts;
>            what happens if real interrupt happens here, before we call
> the ISR ourselves? */
> 
> 	i8042_interrupt(0, NULL, NULL);
> 	return retval;
> }
>

Hi Dave,

i8042_interrupt() uses spinlock to serialize access to the KBC so if real
interrupt happens before we call i8042_interrupt() manually (and it should
normally happen) it will just process the response and second i8042_interrupt()
will be just a no-op.

Sorry, freel like crap, will try re-reading and responding to the rest of
your email later...
 
-- 
Dmitry
