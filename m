Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUJCPdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUJCPdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 11:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUJCPdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 11:33:19 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:64741 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267974AbUJCPdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 11:33:15 -0400
Message-ID: <9e4733910410030833e8a6683@mail.gmail.com>
Date: Sun, 3 Oct 2004 11:33:14 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: Merging DRM and fbdev
Cc: dri-devel@lists.sf.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410030824280.2325@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104100220553c57624a@mail.gmail.com>
	 <Pine.LNX.4.58.0410030824280.2325@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resource reservations are not the central problem with merging fbdev
and drm. The central problem is that both card specific drivers
initialize the hardware, program it in conflicting ways, allocate the
video memory differently, etc. Moving to a single card specific driver
lets me fix that.

In the final form both the VGA scheme and my code provide shared
resource reservation code. The main difference between the schemes is
that the VGA scheme allows multiple independent card drivers while
mine only allow a single merged one.

Multiple card drivers in the past has resulted in conflicting
programming of the hardware. I suppose we could write a bunch of rules
about how to share the hardware but that seems like a lot of
complicated work. The radeon has over 200 registers that would need
rules for what settings are allowed. It's a lot easier to simply merge
20K of radeonfb  driver into the radeondrm and eliminate this error
prone process.

If we could all just concentrate on fixing the radeondrm driver we
could build a complete driver for the radeon cards instead of the ten
half finished ones we have today. Once we get a complete driver the
incentive for people to write new ones will be gone.

The two models look like this:

vga - attached to hardware
   radeon-drm
      drm - library
   radeon-fb
      fb - library
         fbcon - library

My model....

radeon - attached to hardware
   drm - library
   fb - library
      fbcon - library

vga - independent driver, there is only one VGA device even if
multiple radeons. This driver is responsible for secondary card
resets.

In the first model radeon-drm and radeon-fb can run independently.
This requires duplication of the initialization code. Since the are
separate drivers they can and do have completely different models for
programming the hardware. At VT switch time the drivers have to
save/restore state.

In the second model it is not required that a driver support both fb
and drm. Something like cyber2000 does have to link in drm since it
has no use for it.

A complaint in the second model might be that the radeon driver is
120K. If some embedded system is really, really tight on RAM and they
are embedding a radeon but don't want to use its advanced abilities,
there is nothing stopping someone from splitting the radeon driver up
into pieces. I will happily take the patch. Doing this is probably a
week's worth of coding and testing to get maybe 50K memory savings.
Simplest way to do this is to add IFDEFs to remove drm support from
the merged radeon driver.

-- 
Jon Smirl
jonsmirl@gmail.com
