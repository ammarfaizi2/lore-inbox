Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVBOAC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVBOAC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVBOAC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:02:59 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:51656 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261348AbVBOAC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:02:56 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: Radeon FB troubles with recent kernels
Date: Tue, 15 Feb 2005 08:02:46 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>, adaplas@pol.net
References: <20050214203902.GH15058@waste.org> <1108420723.12740.17.camel@gaston> <1108422492.12653.30.camel@gaston>
In-Reply-To: <1108422492.12653.30.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502150802.46361.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2005 07:08, Benjamin Herrenschmidt wrote:
> > Appeared ? hah... that's strange. X is known to fuck up the chip when
> > quit, but I wouldn't have expected any change due to the new version of
> > radeonfb. From what you describe, it looks like an offset register is
> > changed by X, or the surface control.
> >
> > My patch did not change any of radeonfb accel code though...
> >
> > I'll catch up with you on IRC ...
>
> Ok, from our discussions, it's not related to the power management code,
> and an engine reset triggered by fbset fixes it. So at this point, I can
> see no change in the driver explaining it...
>
> We did some changes to the VT layer to force a mode setting (and thus an
> engine reset) when going away from X, so I can't see why that wouldn't
> work, while using fbset later on works ... this goes through the same
> code path in the driver... unless we are facing a timing issue...

You can also try inserting something like this before register_framebuffer()

info->flags |= FBINFO_MISC_MODESWITCHLATE;

to delay the call to set_par as late as possible.  It's the same hack used
in rivafb, but there were reports before that it does not work with a few 
radeon setups.

Tony

>
> X is known to play funny tricks, like touching the engine when it's in
> the background (not frontmost VT) and quit, or possibly other bad things
> on console switch. Maybe I changed enough delays (speeded up) the mode
> switch so that we fall into a case where X has not finished mucking up
> with us...
>
> Can you try adding some msleep(200) or so at the beginning at
> radeonfb_set_par() or radeon_write_mode() to see if that makes any
> difference ?
>
> Some printk's in there would help to... I expect calls to
> radeon_engine_init() to fix it and such a call is present in the mode
> restore unless accel is disabled...
>
> Can you check what's happening ?
>
> Ben.


