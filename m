Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUHaSCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUHaSCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUHaSCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:02:49 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:45784 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266274AbUHaSAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:00:25 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 31 Aug 2004 19:52:36 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: [PATCH 2.6.9-rc1-mm1] Disable colour conversion in the CPiA Video Camera driver
Message-ID: <20040831175235.GA21130@bytesex>
References: <20040830013201.7d153288.akpm@osdl.org> <20040830133205.GC1727@bytesex> <20040830203117.5acca627.luca.risolia@studio.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830203117.5acca627.luca.risolia@studio.unibo.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 08:31:17PM +0200, Luca Risolia wrote:
> On Mon, 30 Aug 2004 15:32:05 +0200
> Gerd Knorr <kraxel@bytesex.org> wrote:
> 
> > First: there should be a reasonable warning time for the current users.
> > Some printk message telling them they are using a depricated feature.
> > Maybe even a insmod option to enable/disable it, with the default being
> > software conversion disabled.
> > 
> > Second: IMHO it would be a very good idea to port the driver to the v4l2
> > API before ripping the in-kernel colorspace conversion support.  v4l2
> > provides a sane API to get a list of supported color formats, whereas
> > with v4l1 it is dirty trial-and-error + guesswork for the applications.
> 
> I don't see why porting the driver to the V4L2 API has to precede the
> software conversion removal I was talking about. I think that the
> negotiation of the color formats is not the point here...

It's a suggestion, not a requirement.  The point simply is that due to
the lack of a sane negotiation of the color formats in the v4l1 API
you'll get warning printk's even if there is no real problem.  xawtv for
example doesn't depend on RGB formats being available, but will try to
use them (which then generates a warning printk), and failing that
fallback to yuv and software conversion.  With v4l2 you don't get those
bogous and confusing warnings as the app can simply ask the driver for a
list of supported formats instead of depending on trial-and-error games.

> For many years no one has ever cancelled deprecated code yet both
> users and developers know that software conversion should be made
> in userspace.

That isn't true.  I can remember that at least one usb webcam driver
stopped working with xawtv because in-kernel software conversion was
dropped and xawtv had no support the specific color format used by
that webcam at that time.

> It is worth to state that those who have preached this rule and have
> always, for instance, been opposed to optional decoders in kernel
> space, have never lifted a finger to correct already existing code.
> Now, I do not expect that these people wake up and even provide a V4L2
> driver.
> 
> In addition, aside from software conversion, it is enough to take a
> quick look at the code to understand that it is no longer maintained.

Oh.  That sounds like you don't even remotely intend to care about that
driver?  Why do you mail patches for it then?

> Having seen the recent occurrences, non-maintained drivers should be
> altogether removed.

What is the point in removing a working driver?  If a driver is broken
and nobody cares fixing it -- fine, rip it, user base likely is close to
zero anyway then.  But that isn't true for cpia as far I know.

> Nevertheless, there is below a new patch that adds a parameter to the
> module and warnings for users, as suggested by you.

> +		LOG("Palette %u not available by default. Set colorspace_conv "
> +		    "module parameter to 1 to enable it", (unsigned)(palette));

The message should be rate limited as suggested in the previous message
(because otherwise the log may be flooded with bogous warnings due to
the v4l1 API issues mentioned above).  Maybe a single message at insmod
time is even better.

In any case the message should make clear the intention of this, i.e.
that it is planned to drop in-kernel conversion altogether by -- say --
sept 2005 (should be enougth warning time), that is disabled by default
now to catch problem cases, and that the users should fix the apps in
case they don't work without conversion reenabled via insmod option.

  Gerd

-- 
return -ENOSIG;
