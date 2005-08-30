Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVH3UAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVH3UAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVH3UAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:00:31 -0400
Received: from witte.sonytel.be ([80.88.33.193]:62641 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932433AbVH3UAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:00:30 -0400
Date: Tue, 30 Aug 2005 21:59:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
In-Reply-To: <43149E5B.7040006@t-online.de>
Message-ID: <Pine.LNX.4.62.0508302151520.9194@numbat.sonytel.be>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
 <43149E5B.7040006@t-online.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584334533-959120381-1125431980=:9194"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584334533-959120381-1125431980=:9194
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 30 Aug 2005, Knut Petersen wrote:
> > Probably you can make it even faster by avoiding the multiplication, like
> > 
> >    unsigned int offset = 0;
> >    for (i = 0; i < image.height; i++) {
> > 	dst[offset] = src[i];
> > 	offset += pitch;
> >    }
> 
> More than two decades ago I learned to avoid mul and imul. Use shifts, add and
> lea instead,
> that was the credo those days. The name of the game was CP/M 80/86, a86, d86
> and ddt ;-)
> 
> But let´s get serious again.

On modern CPUs, a multiplication indeed takes 1 cycle, just like an addition.
But on older CPUs (still supported by Linux), this is not true.

> Your proposed change of the patch results in a 21 ms performance decrease on
> my system.
> Yes, I do know that this is hard to believe. I tested a similar variation
> before, and the results
> were even worse.
> 
> Avoiding mul is a good idea in assembly language today, but often it is better
> to write a
> multiplication  with the loop counter in C and not to introduce an extra
> variable instead. The
> compiler will optimize the code and it´s easier for gcc without that extra
> variable.

But you are right. On actual inspection of the generated assembly code for a
very simple test case, it turns out both (m68k-linux-)gcc 2.95.2 and 3.3.3 are
smart enough to convert the multiplication to an addition...

And interestingly, if I avoid the multiplication explicitly, gcc 2.95.2 still
generates the same code, but 3.3.3 adds a few extra instructions to
save/restore local vars. So this probably explains why it turned out to be
slower for you. Ugh...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---584334533-959120381-1125431980=:9194--
