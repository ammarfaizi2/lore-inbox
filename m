Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVJQWVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVJQWVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVJQWVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:21:50 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:29314 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S932347AbVJQWVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:21:50 -0400
Date: Tue, 18 Oct 2005 00:21:47 +0200
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: force feedback envelope incomplete
Message-ID: <20051017222147.GB24482@tink>
References: <20051015213953.GA27117@tink> <200510161335.48458.dtor_core@ameritech.net> <20051017114258.GC10522@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20051017114258.GC10522@ucw.cz>
User-Agent: Mutt/1.5.9i
From: emard@softhome.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > struct ff_envelope {
> > >         __u16 attack_length;    /* Duration of attack (ms) */
> > >         __u16 attack_level;     /* Level at beginning of attack */
> > >         __u16 sustain_length;   /* Duration of sustain (ms) */
> > >         __u16 sustain_level;    /* Sustain Level at end of attack and beginning of fade */
> > >         __u16 fade_length;      /* Duration of fade (ms) */
> > >         __u16 fade_level;       /* Level at end of fade */
> > > };
> > 
> > You might want to talk to Vojtech about this (CC-ed).
>  
> Your proposal seems reasonable. Please send me a patch that adds the
> sustain members to the envelope, and uses it in some driver, while
> making sure existing binary-only apps (if there are any) don't break.

I have thought about this.

I can not imagine ANY existing driver supporting such envelope
other than using this 64 bit field as a binary container for
it's private interpretation of the mechanical vibration envelope.

We may not go too far on with supporting such software 
(I even don't know of any).

So we actually need this

struct ff_envelope {
__u16  attack_length;
__u16  attack_level;    /* level at the beginning of attack */
__u16  decay_length;
__u16  decay_level;     /* level at the beginning of decay */
__u16  sustain_length;
__u16  sustain_level;   /* level at the end of decay and beginning of fade */
__u16  fade_length;
__u16  fade_level;      /* level at the end of fade */
};

WHY:

*** About the vibration envelope ***

As I understand the envelope, it's there to simulate physical
behaviour of transient vibrations of a string when triggered.

Such envelope has ATTACK, DECAY, SUSTAIN and FADE. (ADSF)

Microsoft simplified this by implementing only 
ATTACK, SUSTAIN and FADE (ASF).

But what linux has? Attack and fade without sustain.
That is slighty out of sense, because in this case we can not 
calculate the SLOPES of the attack and fade, making them
out of sense too.

I would use attack, decay sustain and fade. That's
the way synthesizers handle triggered wire vibrations 
like in guitars or pianos.
ASF may be sufficient only for short length of low 
frequency vibrations <50Hz. Some joysticks are capable only of that. 
But for frequencies >100 Hz, like tactile mice, ADSF envelope 
can produce additional exciting vibrant feel and sophisticated
vibrations over high dynamic range making it very realistic. 
That makes much difference compared to those crippled ASF only 
envelopes.
