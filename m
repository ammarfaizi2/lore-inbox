Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWDZTJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWDZTJP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWDZTJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:09:15 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:51206 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S964836AbWDZTJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:09:14 -0400
Date: Wed, 26 Apr 2006 21:09:08 +0200
From: bjdouma <bjdouma@xs4all.nl>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Message-ID: <20060426190908.GA19282@skyscraper.unix9.prv>
References: <20060422204844.GA16968@skyscraper.unix9.prv> <d120d5000604250823p4f2ed2acv4287f7d70c71c7c0@mail.gmail.com> <20060425152600.GA30398@suse.cz> <200604260106.38480.dtor_core@ameritech.net> <20060426104301.GA4634@skyscraper.unix9.prv> <d120d5000604260724q45f52117t27920f2ae59bea76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000604260724q45f52117t27920f2ae59bea76@mail.gmail.com>
X-Disclaimer: sorry
X-Operating-System: human brain v1.04E11
Organization: A training zoo
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 10:24:32AM -0400, Dmitry Torokhov wrote:

> Are you saying that both bits were set to 0 or that you could not hear
> the tone after killing bell? If latter then it is sort of pcspkr
> problem as from input core POV tone is still active.
> 
> Btw, your patch - did it resemble something like attached?

> Index: linux/drivers/input/input.c
> ===================================================================
> --- linux.orig/drivers/input/input.c
> +++ linux/drivers/input/input.c
> @@ -155,6 +155,9 @@ void input_event(struct input_dev *dev, 
>  			if (code > SND_MAX || !test_bit(code, dev->sndbit))
>  				return;
>  
> +			if (!!test_bit(code, dev->snd) != !!value)
> +				change_bit(code, dev->snd);
> +
>  			if (dev->event) dev->event(dev, type, code, value);
>  
>  			break;

Before I made the change of dev->snd to an int array, yes it did
exactly this same thing.

Basically what I'm saying is that when you query the input driver
for the state of EV_SND, it doesn't tell you much about what tone
is actually audible, if at all.

Let me give two examples.  I am using here my program inputcntrl
that I am working on -- basically a wrapper with a parser and
interpreter around some of the uinput driver's functions (if you
want a copy of the WIP tree, let me know).

Just regard both examples as a complete session, i.e. no other
commands influencing the pcspkr are interspersed in what you see
below (/dev/input/pcspkr happens to be a symlink to /dev/input/event1).

These examples are with your latest small patch in place, the one
doing the change_bit(code, dev->snd).



Example i.

$> inputcntrl -d /dev/input/pcspkr set-snd 'bell=0;tone=0'    # part 1; reset
$> inputcntrl -d /dev/input/pcspkr set-snd bell=1
$> inputcntrl -d /dev/input/pcspkr get-snd bell,tone
SND_BELL               1
SND_TONE               0
	tone 1000Hz, see pcspkr.c

$> inputcntrl -d /dev/input/pcspkr set-snd tone=1200
$> inputcntrl -d /dev/input/pcspkr get-snd bell,tone
SND_BELL               1
SND_TONE               1
	tone 1200Hz
	note that bell remains 1
	ok, let's conclude that if bell=1 then sound=1000Hz unless tone=1

$> inputcntrl -d /dev/input/pcspkr set-snd 'bell=0;tone0'    # part 2; reset
$> inputcntrl -d /dev/input/pcspkr set-snd tone=1200
$> inputcntrl -d /dev/input/pcspkr get-snd bell,tone
SND_BELL               0
SND_TONE               1
	tone 1200Hz

$> inputcntrl -d /dev/input/pcspkr set-snd bell=1
$> inputcntrl -d /dev/input/pcspkr get-snd bell,tone
SND_BELL               1
SND_TONE               1
	tone 1000Hz
	oddness: state of EV_SND (1,1) is same as in part 1,
	only now is sound a tone of 1000Hz.
	conclusion in part 1 apparently wrong.
	so when state is (1,1), actual sound can be anything



Example ii.

$> inputcntrl -d /dev/input/pcspkr set-snd 'bell=0;tone=0'    # part 3; reset
$> inputcntrl -d /dev/input/pcspkr set-snd tone=1200
inputcntrl -d /dev/input/pcspkr get-snd bell,tone
SND_BELL               0
SND_TONE               1
	tone 1200Hz

$> inputcntrl -d /dev/input/pcspkr set-snd bell=1
$> inputcntrl -d /dev/input/pcspkr get-snd bell,tone
SND_BELL               1
SND_TONE               1
	tone 1000Hz

$> inputcntrl -d /dev/input/pcspkr set-snd bell=0
$> inputcntrl -d /dev/input/pcspkr get-snd bell,tone
SND_BELL               0
SND_TONE               1
	silence!, but SND_TONE = 1!
	on top of that, state is same as in part 2, only then
	we heard a tone of 1200Hz, now we have silence


bjd
