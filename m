Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUADA1e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUADA1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:27:34 -0500
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:20880 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S264361AbUADA1c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:27:32 -0500
Date: Sun, 4 Jan 2004 01:27:30 +0100 (CET)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Claas Langbehn <claas@rootdir.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: atyfb broken
In-Reply-To: <20040103233728.GA22427@rootdir.de>
Message-ID: <Pine.LNX.4.44.0401040041160.10711-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Claas Langbehn wrote:

> Hello!
>
>
> > > Does it work with 2.4.22 and earlier? Mobility support was changed a lot in
> > > 2.4.23.
>
> No, 2.4.22 does not work either. It has also screen-flickering.

Ok, that was expected; this most likely is because of the initialisation
code in 2.4.22; it is completely unsuitable for the Mobility M1 and programs
very bad values into the chip.

> 2.6.0 seems to be closest to a working solution.

Not at all. Your laptop has an LCD display. Unlike CRTs, LCD displays have
a fixed resolution; you LCD display has 1024x768 pixels. Because the
display is completely digital, the display needs its pixel data send at
a fixed rate, enforcing also the refresh rate, 60 Hz in your case.

(LCD monitors with VGA-connectors have special chips that adapt the
resolution and refresh rate of a VGA signal to the video mode desired by
the panel. Image quality suffers badly)

Because of this, a traditional video driver will fail on such a display.
I.e. Atyfb switches to 640x480 60 Hz, which is completely different from
what your display accepts, and it won't work.

Because of some VGA compatibility stuff normal 720x400 VGA text mode is
downscaled to 640x400 by your laptop. Therefore, it is not too different
from 640x480 and on some computers it displays something. I experienced
this on my Rage LT pro, the image was completely wrong, the bottom part of
the screen was a mirror of the upper part.

Therefore, it might happen that 2.6.0 does display something
(initialization is different from 2.4.x), but 2.6.0 will not display a
correct image in any case.

Years ago I started making the Atyfb support LCD displays. It was a very
difficult project; I got my own laptop working more than 2 years ago,
after that slowly all the other machines I knew of started working.
However, it was only until recently before Geert's laptop did work; that was a
really stupborn one. The LCD registers on the chips are very tricky to set
right; the clock code (which was completely wrong) was even more tricky
to get right.

My work was included in 2.4.23. Therefore that kernel
is the only one which has any chance of working. Apparently
there still is an LCD specific issue with your laptop, which needs to be
debugged.

What to do?

The best thing you can try is to connect a CRT. Its a handy tool (it
eats any video mode, including wrong ones) to check if the driver does
something wrong. Use it to inspect geometry and the horizontal & vertical
refresh rates. The CRT should dislay 1024x768 60 Hz in all resolutions
(unless you switch off the LCD display).

Compile Atyfb as module. Use fbset to switch video modes blindly. Check
the following modes: 640x400, 640x480, 1024x768.

If everything is ok, we'll start to do some register debugging.

Daniël

