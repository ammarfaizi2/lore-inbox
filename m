Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291825AbSBTSeC>; Wed, 20 Feb 2002 13:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292180AbSBTSdy>; Wed, 20 Feb 2002 13:33:54 -0500
Received: from [62.47.19.142] ([62.47.19.142]:4737 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S291825AbSBTSdq>;
	Wed, 20 Feb 2002 13:33:46 -0500
Message-ID: <3C73EA06.82394673@webit.com>
Date: Wed, 20 Feb 2002 19:25:10 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jean Paul Sartre <sartre@linuxbr.com>
Subject: Re: sis_malloc / sis_free
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Christoph Pittracher wrote: 
> > Hello! 

Hi everyone,

> > Yes, the sisfb/drm code has some design lacks.

Well, well. I have by now come to the conclusion that this isn't really
the case...

> > Another lack is the necessary memory offset between framebuffer/drm and
> > the X driver (see http://www.webit.at/~twinny/linuxsis630.shtml for
> > details). 
>
> Oh, okay. Should that memory offset be a source of processor time
> waste for allocating memory when switching through FB and X, for an
> example? If so, sharing the code (instead of duplicating it) is the ideal
> approach. 

This has nothing whatsoever with processor time to do. It's to keep
DRM/DRI from overwriting X's screen and off-screen buffers.

> > I don't think that it would be a problem to duplicate the code. the
> > sis_malloc / sis_free functions seems quite stable. I don't think that
> > there will be big updates for this code. 
>
> Hmm, but as you stated, I do not think code duplication should be
> the best approach. 

No, it would not. You've obviously not understood the problems.

It's not done by simply duplicating the sis_malloc/sis_free functions as
these also require

- detecting the type and size of the memory (of many different SiS
chipsets),

- initializing a heap (based on which you later allocate/free the
memory) taking into account a possibe TurboQueue, a possible AGP command
queue and the HWCursor memory area.

Believe me: I know the code by heart right now, and moving the memory
management out of the framebuffer driver will require HUGE parts of the
code copied (not speaking about maintainance issues).

Finally: I intend to implement (real) 2D accelleration in the
framebuffer driver. Thus, I will need a >common< memory management (ie.
ONE SINGLE heap) for both the framebuffer driver as well as the X
driver. Otherwise these two will again overwrite each others video
memory, very possibly leading into problems with the accellerator
engines (which use parts of the video RAM for buffering). 

This can only be avoided by keeping the memory management inside the
framebuffer driver. I don't think it's good to be forced to load the DRM
module (if that one then contains memory management) for only being able
to use the framebuffer driver...

> > Thomas Winischhofer <tw@webit.com> is working on that SiS stuff for
> > about 2 months. I think it would be best if you contact him and ask
> > what he thinks about that. I know that he said it would be a good idea
> > to seperate the sisfb and sis_drm code but he doesn't have enough time
> > to do it... 

It's not a time issue. As said, the concept isn't that bad for future
development. I consider it wise enough to keep the drivers separated, as
this also allows separate usage (framebuffer only, X only) without
memory clashes.

> If I have such time, I'll contact him. But for the moment, if the
> code does not compile (still with 2.4.18-rc2-ac1) I'll duplicate the code
> to get it working until a better solution raises.

You don't have to do that. If you don't like a graphical console, simple
start the framebuffer driver with "mode=none" (or as a kernel parameter
"mode:none"). In this case, sisfb will only initialize the memory but
leave the console alone.

I don't recommend changing anything that big in the framebuffer driver
at the moment. I am currently in close contact with SiS who help me
fixing the (still) remaining problems with it - based on the existing
code. In the very only case you'd like to reinclude a number of changes
for a number of times - well, go ahead :)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com                  *** http://www.webit.com/tw
