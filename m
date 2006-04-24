Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWDXRCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWDXRCH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWDXRCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:02:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:14505 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750967AbWDXRCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:02:06 -0400
X-Authenticated: #271361
Date: Mon, 24 Apr 2006 19:02:00 +0200
From: Edgar Toernig <froese@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com
Subject: bttv 2.6.16: wrong VBI_OFFSET?
Message-Id: <20060424190200.653333fe.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in 2.6.16 the code in driver/media/video/bttv-vbi.c was changed
a little bit.  Beside other things, the constant 244 for the vbi
offset was replaced by a #define VBI_OFFSET 128.

Afaics, the old value 244 was correct - was the change to 128
intentionally?

The reason I ask is because it broke the teletext decoder AleVT.
The teletext standard defines where the clock run-in pulses
have to lie (13th bit at 12us/-1us/+0.4us).  For the complete
16 bits of clock run-in that comes down to 9.2us for the start
of the first bit and 12.9us for the end of the last bit.

Here are two oscilloscope shots showing the difference between
offset 244 and 128 - the red line is the interval 9.2us-12.9us:

	http://goron.de/~froese/vbi-offset244.gif
	http://goron.de/~froese/vbi-offset128.gif

As one can see, offset 244 fits very well.  The clock run-in
lies where it's expected.  With offset 128 it's completely
off - no way to find it at that position.

One can also see that the sampling starts somewhere within
the color burst, not at the trailing edge of hsync as some
comment in the code may imply.

Ciao, ET.


PS: In bttv_vb_try_fmt code was changed from 32 to 64 bit
arithmetic:

|        /* s64 to prevent overflow. */
|        count0 = (s64) f->fmt.vbi.start[0] + f->fmt.vbi.count[0]
|                - tvnorm->vbistart[0];
|        ...

What should that change fix?  These values will never overflow -
they fit into 16 bits each.
