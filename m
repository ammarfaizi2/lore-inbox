Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWE3Vx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWE3Vx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWE3Vx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:53:28 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:49620 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932502AbWE3Vx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:53:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ash4nROH15oznI+0NWd4LsnFts85MiJPU1OqRh+pb10wbaQXlmj41RTENtdS5N2z12wisk+G/5mn3swvL1qeG1pqF3CZ7x+HTH4/PqYJz56e1MolfnDzDZU3fR0XXUEbAe0mO+xWfcTguYW8+nmjWlwpi90I37vkzlUqRJHRhVg=
Message-ID: <447CBEC5.1080602@gmail.com>
Date: Wed, 31 May 2006 05:53:09 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>  <200605272245.22320.dhazelton@enter.net>  <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>  <200605280112.01639.dhazelton@enter.net>  <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Sun, 28 May 2006, Jon Smirl wrote:
> 
 > in part this dates back to my early experiances with the framebuffer
> code when it was first introduced, but I still find that the framebuffer
> is not as nice to use as the simpler direct access for text modes. and
> when I start X up it doesn't need a framebuffer, so why suffer with the
> performance hit of the framebuffer?

This might be true with the framebuffer in 2.2 and 2.4, but you may want
to reconsider in 2.6:

time cat linux/MAINTAINERS

vgacon (80x25 or 640x400, CONFIG_VGACON_SOFT_SCROLLBACK=n)

real    0m0.637s
user    0m0.000s
sys     0m0.637s

vesafb 640x480-8 (vga=0x305 video=vesafb:ypan,mtrr:3)

real    0m0.572s
user    0m0.001s
sys     0m0.571s

vesafb 640x480-8 (vga=0x305 video=vesafb:ypan,mtrr:3,vremap:4)

# vremap:4 gives approximately 12 extra pages of text for hardware
# scrolling, vgacon has 16.

real    0m0.409s
user    0m0.001s
sys     0m0.408s

So even a dumb driver such as vesafb that has to do on the fly
color conversions while pushing 64x more data to the bus can be
faster than vgacon.

Note the above is true for x86_32. For x86_64 and ia64, vesafb will
be slow because in it cannot do ypan in these archs.

But using a chipset specific driver on any arch, you can achieve a
fivefold increase:

nvidiafb 640x480-8 accel=true

real    0m0.145s
user    0m0.001s
sys     0m0.144s

> 
> yes, some hardware requires a framebuffer to display anything, but for
> most video cards, the hardware scrolling of a pure text mode is better
> (faster, smoother, less cpu required, etc) then the framebuffer equivalent.

A framebuffer driver can be faster than vgacon.  Scrolling is also smooth
even for vesafb because of a new scrolling method (pan_redraw) introduced
sometime in 2.6.10.  I don't know about less cpu required, that's probably
true.

Tony
