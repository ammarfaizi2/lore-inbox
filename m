Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946142AbWBDAjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946142AbWBDAjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946145AbWBDAjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:39:31 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:32205 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946142AbWBDAjb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:39:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C6LqK9ZbEzDN4tN8T7UOUPqvM1Rhk2MV/axRVCi/xfT0FPCufwd0P9bFYVAsrZ9wcxwF54jmdPaGNAjWpljA00fbgOjoufvsfX0sTZlswwxyvYk5tGTyp6x/ENYxSHBRybhek2gbqMPzAGDeoXBG8lzY9FeqGxvVyGVdOWu9aZU=
Message-ID: <7f45d9390602031639k3c5ae010gbd52a8fdd8bb863b@mail.gmail.com>
Date: Fri, 3 Feb 2006 17:39:30 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] liyitec: Liyitec PS/2 touchscreen driver
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000602021512x42be2006h31e63cb6d78ac1b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390602021502q325752d7oe635569cde7ce2c7@mail.gmail.com>
	 <d120d5000602021512x42be2006h31e63cb6d78ac1b3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 2/2/06, Shaun Jackman <sjackman@gmail.com> wrote:
> > [PATCH] liyitec: Liyitec PS/2 touchscreen driver
> >
> > Add an input driver for the Liyitec PS/2 touchscreen.
>
> I don't see any suibstantial differences from the older patch. I think
> it should be integrated into psmouse. Is there a way to query the
> device? What kind of boxes use this touchscreen? Maybe using DMI is an
> option, like lifebook does?

I've ran a number of experiments to attempt to detect the Liyitec
touch screen. I sent every PS/2 command from 0x00 to 0xff. It responds
in every way as a normal PS/2 mouse. To commands it doesn't
understand, it first responds with 0xfe (NAK), then if it also doesn't
understand the next command it responds with 0xfc (ERR).

I've tried setting every resolution (PS/2 command 0xe8) from 0x00 to
0xff. It responds to 0x00-0x03 with ACK. It responds to 0x04-0xff with
NAK/ERR.

I've tried setting every rate (PS/2 command 0xf3) from 0x00 to 0xff.
It responds to (10, 20, 40, 60, 80, 100, 200) with ACK. It responds to
every other rate with NAK/ERR.

I've even tried sending every valid rate "knock" sequence of length 3,
of which there are 7^3=343, and tried a get info (PS/2 command 0xe9)
and get ID (PS/2 command 0xf2). The get info command never returns
anything unusual, and the get ID command always returns 0 (standard
PS/2 mouse).

Liyitec provides a binary X11 driver for the touch screen. I set the
kernel to dump every byte going to and coming from /dev/psaux and ran
their binary. Their driver sends (enable, scale11, enable, rate, 200,
resolution, 2, enable) to /dev/psaux and nothing more.

So, after some heavy experimentation, I am now rather confident that
there is no trivial way to detect the touch panel's existence.
Although, I would love to hear any suggestions. If anyone's interested
in seeing the raw data, I'd be happy to send it on. In a previous
mail, I mentioned my particular hardware does not have any DMI data,
like the lifebook driver uses.

So, finally, assuming there is no way to detect the touch panel's
presence, should the driver still be rolled into psmouse? If so, how
should the user specify she wishes to use the liyitec driver, and
which serio (PS/2) port the liyitec touch screen is on?

My current patch implements the Liyitec driver as a serio driver that
grabs every available PS/2 port. Quite unfriendly, but works in the
typical case where the keyboard driver grabs the first port, and the
Liyitec driver grabs the psaux port.

Cheers,
Shaun
