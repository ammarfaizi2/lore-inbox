Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUIKU3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUIKU3i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUIKU3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:29:38 -0400
Received: from smtp.easystreet.com ([69.30.22.10]:10420 "EHLO
	smtp.easystreet.com") by vger.kernel.org with ESMTP id S268301AbUIKU3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:29:35 -0400
Subject: Re: radeon-pre-2
From: Eric Anholt <eta@lclark.edu>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391040911101331a584ec@mail.gmail.com>
References: <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
	 <9e473391040911101331a584ec@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1094934573.884.59.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 11 Sep 2004 13:29:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 10:13, Jon Smirl wrote:
> Coprocessor 3D mode is deeply pipelined
> 2D mode is immediate
> 
> How can you build a system that process swaps between these two modes?
> The 3D pipeline has to be emptied before you can enter 2D immediate
> mode.
> 
> My solution is to leave the coprocessor always running and convert
> everything to use the DMA based commands.

Now, I'll admit that I've only really worked on three sets of hardware
(SiS 300-series, Radeon, Rage 128), but they don't have any "3d mode"
and "2d mode" concept.  On SiS both 3d and 2d go through a FIFO, so for
switching between clients you just have to check how much free space
there is in the fifo.  For Radeon and Rage 128 you can send rendering
commands either through the CP/CCE (DMA) or an MMIO FIFO.  You can do 2d
and 3d commands both ways.  In fact, you can send DMA commands through
an MMIO aperture as well.  But there is nothing "immediate" about 2d. 
It goes through the FIFO or the CP just like 3d rendering.  If I'm not
mistaken about other hardware I've poked at (3dfx, mach64), they don't
have any "2d mode" and "3d mode" either.

To summarize, there is no "2d mode" and "3d mode."  Please stop
referring to it.  If you were actually trying to talk about
synchronization for MMIO vs DMA command submission (which is and would
be a very rare case anyway), well, I don't see why that can't be done
using Linus' example, which seemed like what Alan Cox has been driving
toward for a long time.

If you want to avoid idling to switch from DMA to MMIO in that rare
case, then have whatever client in question write all commands into a
DMA buffer, then dispatch it through either the DRM or decoding into
MMIO writes.  Xati is an example of doing just that, and it's not that
hard.   Or, you could go the route that the XFree86 X Server has and
just have two sets of your acceleration functions, generated through
macros, which write to MMIO or write DMA buffers depending on which has
been set up.

But I see nothing in this issue that requires all the drivers live in
one module together, which would only make life a little more convenient
for some developers, at the expense of all the users who don't want all
of those drivers necessarily.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


