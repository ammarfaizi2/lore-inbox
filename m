Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWDXVz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWDXVz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWDXVz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:55:29 -0400
Received: from mail.gmx.de ([213.165.64.20]:40627 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750705AbWDXVz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:55:28 -0400
X-Authenticated: #271361
Date: Mon, 24 Apr 2006 23:55:22 +0200
From: Edgar Toernig <froese@gmx.de>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bttv 2.6.16: wrong VBI_OFFSET?
Message-Id: <20060424235522.1fd87f6a.froese@gmx.de>
In-Reply-To: <444D2268.1030802@free.fr>
References: <20060424190200.653333fe.froese@gmx.de>
	<444D2268.1030802@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
>
> > in 2.6.16 the code in driver/media/video/bttv-vbi.c was changed
> > a little bit.  Beside other things, the constant 244 for the vbi
> > offset was replaced by a #define VBI_OFFSET 128.
> > 
> > Afaics, the old value 244 was correct - was the change to 128
> > intentionally?
> 
> You can have some comments about that in the git log : 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=67f1570a0659abba5efbf55cc986187af61bdd52;hp=7e57819169d4f9a1d7af55fb645ece3fb981e2e3

Hmmm... regarding VBI_OFFSET there's this:

| - V4L2_(G|S|TRY)_FMT returned incorrect VBI start lines for PAL-M,
|   NTSC-JP, and PAL-60. They also returned an inaccurate VBI offset.

I remember that I tried to figure out how to calculate the VBI offset
from the Bt8xx specs a couple years ago but resigned - somehow the
specs are wrong.  But given a teletext signal and the teletext specs
you can measure its value[1] and 244 is pretty accurate for PAL.


Regarding the 64 bit arithmetic there's this:

| - V4L2_(S|TRY)_FMT did not expect very large or small VBI start or
|   count values, returning wrong (but safe) counts due to an overflow.

Wow, previously the driver produced (safe) garbage when given garbage
and now it produces more accurate (safe) garbage???  I don't get it.
[My suspicion is that it was only inserted to shut up warnings...]

Ciao, ET.


[1] You know that the 7th peak of the teletext clock run-in is at
12us (+0.4us/-1.0us) from the falling hsync.  You look at which
sample the 7th peak is at its max.  The difference between this
number and 12e-6 * Fs (426 for Fs=35468950) is the VBI_OFFSET.

Btw, hsync ends at 166 (PAL/Fs=35468950) respectively 134 (NTSC/
Fs=28636363).  So any VBI_OFFSET lower than that would show the
hsync in the samples...
