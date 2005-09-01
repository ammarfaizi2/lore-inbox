Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVIAP0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVIAP0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbVIAP0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:26:04 -0400
Received: from admin.zirkelwireless.com ([209.216.203.65]:6797 "EHLO
	admin.zirkelwireless.com") by vger.kernel.org with ESMTP
	id S1030203AbVIAP0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:26:02 -0400
Message-ID: <43171D33.9020802@tungstengraphics.com>
Date: Thu, 01 Sep 2005 09:24:35 -0600
From: Brian Paul <brian.paul@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: State of Linux graphics
References: <9e47339105083009037c24f6de@mail.gmail.com>	<1125422813.20488.43.camel@localhost>	<20050831063355.GE27940@tuolumne.arden.org>	<1125512970.4798.180.camel@evo.keithp.com>	<20050831200641.GH27940@tuolumne.arden.org>	<1125522414.4798.222.camel@evo.keithp.com>	<20050901015859.GA11367@tuolumne.arden.org> <1125547173.4798.289.camel@evo.keithp.com>
In-Reply-To: <1125547173.4798.289.camel@evo.keithp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few comments...

Keith Packard wrote:

> Again, the question is whether a mostly-software OpenGL implementation
> can effectively compete against the simple X+Render graphics model for
> basic 2D application operations, and whether there are people interested
> in even trying to make this happen.

I don't know of anyone who's writen a "2D-centric" Mesa driver, but 
it's feasible.  The basic idea would be to simply fast-path a handful 
of basic OpenGL paths that correspond to the basic X operations:

1. Solid rect fill: glScissor + glClear
2. Blit/copy: glCopyPixels
3. Monochrome glyphs: glBitmap
4. PutImage: glDrawPixels

Those OpenGL commands could be directly implemented with whatever 
mechanism is used in conventional X drivers.  I don't think the 
overhead of going through the OpenGL/Mesa API would be significant.

If Xgl used those commands and you didn't turn on fancy blending, etc. 
the performance should be fine.  If the hardware supported blending, 
that could be easily exposed too.  The rest of OpenGL would go through 
the usual software paths (slow, but better than nothing).

It might be an interesting project for someone.  After one driver was 
done subsequent ones should be fairly easy.


>>|                                            ... However, at the
>>| application level, GL is not a very friendly 2D application-level API.
>>
>>The point of OpenGL is to expose what the vast majority of current
>>display hardware does well, and not a lot more.  So if a class of apps
>>isn't "happy" with the functionality that OpenGL provides, it won't be
>>happy with the functionality that any other low-level API provides.  The
>>problem lies with the hardware.
> 
> 
> Not currently; the OpenGL we have today doesn't provide for
> component-level compositing or off-screen drawable objects. The former
> is possible in much modern hardware, and may be exposed in GL through
> pixel shaders, while the latter spent far too long mired in the ARB and
> is only now on the radar for implementation in our environment.
> 
> Off-screen drawing is the dominant application paradigm in the 2D world,
> so we can't function without it while component-level compositing
> provides superior text presentation on LCD screens, which is an
> obviously increasing segment of the market.

Yeah, we really need to make some progress with off-screen rendering 
in our drivers (either Pbuffers or renderbuffers).  I've been working 
on renderbuffers but we really need that overdue memory manager.


>>Jon's right about this:  If you can accelerate a given simple function
>>(blending, say) for a 2D driver, you can accelerate that same function
>>in a Mesa driver for a comparable amount of effort, and deliver a
>>similar benefit to apps.  (More apps, in fact, since it helps
>>OpenGL-based apps as well as Cairo-based apps.)
> 
> Yes, you *can*, but the amount of code needed to perform simple
> pixel-aligned upright blends is a tiny fraction of that needed to deal
> with filtering textures and *then* blending. All of the compositing code
> needed for the Render extension, including accelerated (MMX) is
> implemented in 10K LOC. Optimizing a new case generally involves writing
> about 50 lines of code or so.

If the blending is for screen-aligned rects, glDrawPixels would be a 
far easier path to optimize than texturing.  The number of state 
combinations related to texturing is pretty overwhelming.


Anyway, I think we're all in agreement about the desirability of 
having a single, unified driver in the future.

-Brian
