Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbVAKVmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVAKVmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVAKVl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:41:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:33182 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262891AbVAKVkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:40:41 -0500
Date: Tue, 11 Jan 2005 13:40:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: DHollenbeck <dick@softplc.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       magnus.damm@gmail.com
Subject: Re: yenta_socket rapid fires interrupts
In-Reply-To: <41E44248.2000500@softplc.com>
Message-ID: <Pine.LNX.4.58.0501111322060.2373@ppc970.osdl.org>
References: <41E2BC77.2090509@softplc.com> <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com> <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
 <41E44248.2000500@softplc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jan 2005, DHollenbeck wrote:
> 
> only the last several lines were caught.  There is toggling between two 
> states, the very first state was not captured.

That's fine. This is interesting:

> yenta: event 00000000 state 30000006 csc 00

30000006 means (apart from the socket voltage information) "CB_CDETECT1 | 
CB_CDETECT2", which just means that a socket detect is pending.

> yenta: event 00000000 state 30000829 csc 00

And this means "CB_CARDSTS | CB_PWRCYCLE | CB_CBCARD | CB_3VCARD", ie that
it's become ready, powered, 32-bit card at 3.3V. Goodie. Everything looks 
fine, as far as I can tell.

But then something makes it back to detect pending again:

> yenta: event 00000000 state 30000006 csc 00

and it bounces between those two states forever. 

That certainly would seem to explain why you get a lot of interrupts, 
except the actual "event" flags are never set, so afaik it wasn't actually 
this yenta controller that sent those events in the first place. In fact, 
at no point would "yenta_events()" have returned non-zero, which is why 
the Yenta driver says "this interrupt was not for me".

What I don't see is why the port changes state, then. Since the yenta 
driver doesn't care for the interrupt anyway, it shouldn't be touching the 
hardware, and if it doesn't touch the hardware, then the pcmcia thing 
should eventually just calm down, even if it were to de-bounce a few 
times.

The above is what you'd likely see if somebody was forcing a reset on the
card or a card voltage re-interrogation all the time, which I don't see
why it would happen.

Can you change the "#if 0" at top of yenta_socket.c (around the debug 
thing), into a "#if 1"? That will make it _really_ noisy and totally 
unusable, but since it's unusable already.. I'd like to see what the 
accesses are in a full "cycle" of those bounces.

And don't worry about capturing the whole log - the only thing that I'm 
interested in is one full cycle (from likely 5000 of them - since every 
other interrupt is in the reset state, and every other is PWRCYCLE).

		Linus
