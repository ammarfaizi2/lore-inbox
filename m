Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268899AbRHBL5x>; Thu, 2 Aug 2001 07:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268902AbRHBL5o>; Thu, 2 Aug 2001 07:57:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18909 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268899AbRHBL5e>;
	Thu, 2 Aug 2001 07:57:34 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 2 Aug 2001 11:55:51 GMT
Message-Id: <200108021155.LAA89271@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, garloff@suse.de, torvalds@transmeta.com
Subject: Re: [PATCH] make psaux reconnect adjustable
Cc: brent@linux1.org, linux-kernel@vger.kernel.org, mantel@suse.de,
        rubini@vision.unipv.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Kurt Garloff <garloff@suse.de>

    working on notebooks I got used to the touchpads.
    Now, a lot of notebooks have a Synaptics touchpad.
    It offers a few additional features, such as tossing or the third mouse
    button (by a short click in the corner) ...

    Unfortunately, the synps2 generates nonstandard codes when in
    extended mode, amongst which the reconnect (170) token.
    The kernel (since 2.2.15) does interpret it as such and empties the queue.

    This seems to appropriate for a real plug event. For a synps2, it's not,
    but makes your mouse dead for a second. Instead the data should just
    be passed to userspace (gpm).

    So I made the behaviour switchable via a sysctl.=20

Hmm. I don't think there exists a "reconnect token" AA.
At power up or after a reset (FF) the mouse sends AA
(self test passed) followed by 00 (the ID: I am a PS/2 mouse).
During operation the value AA is entirely legal and has no special
significance.

Moreover, it seems that the specs say that the host should not react
to the AA but wait for the 00. The expected protocol at power up is:
Mouse: AA 00. Host: F4 (enable). Mouse: FA (ack).
Afterwards the host will send F3 to set the sample rate
(or to initialize a wheelmouse).

A quote [1]:
"At power-on, the PS/2 device performs a self-test and calibration,
then transmits the completion code $AA and ID code $00.  If the
device fails its self-test, it transmits error code $FC and ID code $00.
This processing also occurs when a software Reset ($FF) command is received.
The host should not attempt to send commands to the device until
the calibration/self-test is complete.
Power-on self-test and calibration takes 300­1000ms."

The reaction to FF (reset) from the host is an immediate FA (ack)
followed half a second later by AA 00.

Therefore, I think the kernel mouse handling was broken when this
strange AUX_RECONNECT stuff was introduced. It caused a tiny trickle
of complaints.
Bug 1: AA is not necessarily anything special
Bug 2: the sequence AA 00 from the mouse should not be interrupted

I don't think that it is a good idea to start building infrastructure
around it. By default this AUX_RECONNECT should be disabled, since
it is just plain wrong. Then the Synaptics touchpad will work.
In other words, no sysctl but #if 0 ... #endif.

For people who unplug and replug their PS/2 mouse with running
machine, or who use a KVM switch (I think it was only Brent Verner
who asked for this code): if what I say is correct you should
always see 00 following the AA. So, there may exist a more cautious
patch that will bite fewer people and does not react to AA but to
the sequence AA 00.

Andries

[1] See http://www.synaptics.com/decaf/utilities/tp-intf2-4.PDF
