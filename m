Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTEAKLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 06:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbTEAKLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 06:11:24 -0400
Received: from AMarseille-201-1-1-130.abo.wanadoo.fr ([193.252.38.130]:25127
	"EHLO gaston") by vger.kernel.org with ESMTP id S261196AbTEAKLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 06:11:19 -0400
Subject: Re: [HINTS] Re:  More radeonfb fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20030501011950.GA641@pasky.ji.cz>
References: <1050062592.562.14.camel@zion.wanadoo.fr>
	 <20030501011950.GA641@pasky.ji.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051784603.10240.53.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 May 2003 12:23:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> thanks a lot, this patch solved my quite annoying framebuffer problems with the
> stock 2.4.21rc1 radeonfb driver on ATI Radeon 7000 w/ 64MB RAM :-).

Good ;)

> If you are interested in some bugreports and don't want to read the following
> semi-minihowto, please just look for the [PERHAPS-BUGREPORT] string.
> 
> In order to give advice to the fellow googlers possibly seeing this in
> archives: if you have annoying long delays when switching between consoles or
> the video mode you specify on the cmdline carefully results in just an ugly
> mess,

Known. I have to work on this next

> [PERHAPS-BUGREPORT]
> 
>   - BE CAREFUL when specifying depth! This is basically where I was most burnt,
>     I kept specifying 24 but for some strange reason, this did very strange
>     things here. If you will specify some other depth (8,15,16,32,...), you may
>     experience problems with cursor (or it just won't work at all ;) --- it
>     could have different colors (which will change by time), eventually
>     disappearing completely (this could mean it just went black..?).
> 
>     The best solution is probably not to specify the depth at all. Apparently,
>     24 is used by default, but it seems to work when chosen defaultly :^).

8 is the default and works fine. 15,16 and 32 work but the cursor isn't
properly rendered, this is a known fbdev problem in 2.4, I'll probably
fix it by implementing HW cursor support in radeonfb. 24 bpp is a weird
mode that isn't really supported by the driver

> * when you will have your Radeon in some weird state (after trying to run some
>   svgalibish application or naively selecting vesa video output in mplayer or
>   so..), you can either:
> 
> [PERHAPS-BUGREPORT]
> 
>   - startx or switch to X and back if you have it already running. This will
>     repair it, but it won't reset all the flags (ie. accel), so you will get
>     delays when switching to the affected console caused by video mode changes.
> 
>   - fbset on the affected console, which will also properly reset all these
>     flags. You can obviously first get usable console by letting X to reset it
>     and then running fbset on it, if you like to see what are you typing. Note
>     that you should reset the console to the same mode you are running on the
>     other consoles, otherwise you won't get rid of that delays.

What is a bug ? the delays ? The fact that some apps leave garbage ? The
former is normal when an actual mode switch occurs. The later is a
problem with apps that bang the HW (and with X as well in some cases as
it will occasionally fuck up the accel engine configuration).

The problem is that currently, the fbcon/fbdev interface doesn't provide
a hook for fbdev's to force a restore of the mode & engine setting when
an app leaves the KD_GRAPHICS mode.
 
> [PERHAPS-BUGREPORT]
> 
> * you will have that ugly video mode change also the first time you switch to
>   some console. This appears to be a bug, I think it could be fixed quite
>   easily. You can either live with it or fix it or workaround it by doing
>   something smart with for, seq and chvt in your rc scripts (let this be a
>   homework ;-).

The "new" consoles aren't initialized, thus the driver do a mode change
when switching to them. Well... I can try to fix that...
> 
> It is just a mix of generic fb usage advices and Radeon-specific ones... well,
> what I had to discover by myself in the last few hours ;-). Perhaps it could
> find a comfortable place in Documentation/fb/, dunno.
> 
> Kind regards,
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
