Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292233AbSBTTWB>; Wed, 20 Feb 2002 14:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292223AbSBTTVt>; Wed, 20 Feb 2002 14:21:49 -0500
Received: from toole.uol.com.br ([200.231.206.186]:62702 "EHLO
	toole.uol.com.br") by vger.kernel.org with ESMTP id <S292150AbSBTTVh>;
	Wed, 20 Feb 2002 14:21:37 -0500
Date: Wed, 20 Feb 2002 16:20:56 -0300 (BRT)
From: Jean Paul Sartre <sartre@linuxbr.com>
To: Thomas Winischhofer <tw@webit.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sis_malloc / sis_free
In-Reply-To: <3C73EA06.82394673@webit.com>
Message-ID: <Pine.LNX.4.40.0202201556280.2588-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Thomas Winischhofer wrote:

> > > Yes, the sisfb/drm code has some design lacks.

> Well, well. I have by now come to the conclusion that this isn't really
> the case...

	Hm, now it is clear, thanks for the explanation. :)

> > > Another lack is the necessary memory offset between framebuffer/drm and
> > > the X driver (see http://www.webit.at/~twinny/linuxsis630.shtml for
> > > details).

> > Oh, okay. Should that memory offset be a source of processor time
> > waste for allocating memory when switching through FB and X, for an
> > example? If so, sharing the code (instead of duplicating it) is the ideal
> > approach.

> This has nothing whatsoever with processor time to do. It's to keep
> DRM/DRI from overwriting X's screen and off-screen buffers.

	(hm, you still lose CPU time when deallocating memory when
switching back to console (fb) and switching to X, it they are not really
shared, as with copy_from_user() and copy_to_user()...)

> > > I don't think that it would be a problem to duplicate the code. the
> > > sis_malloc / sis_free functions seems quite stable. I don't think that
> > > there will be big updates for this code.

> > Hmm, but as you stated, I do not think code duplication should be
> > the best approach.

> No, it would not. You've obviously not understood the problems.
>
> It's not done by simply duplicating the sis_malloc/sis_free functions as
> these also require
>
> - detecting the type and size of the memory (of many different SiS
> chipsets),

	Yes, with those DRAM detection routines.

> - initializing a heap (based on which you later allocate/free the
> memory) taking into account a possibe TurboQueue, a possible AGP command
> queue and the HWCursor memory area.

	With the sisfb_poh_allocate() (which I by found itself the
complicated part), the display struct, the *huge* heap initializer which
depends on all the rest, eheh, the duplication would cost too much.

> Believe me: I know the code by heart right now, and moving the memory
> management out of the framebuffer driver will require HUGE parts of the
> code copied (not speaking about maintainance issues).

> Finally: I intend to implement (real) 2D accelleration in the
> framebuffer driver. Thus, I will need a >common< memory management (ie.
> ONE SINGLE heap) for both the framebuffer driver as well as the X
> driver. Otherwise these two will again overwrite each others video
> memory, very possibly leading into problems with the accellerator
> engines (which use parts of the video RAM for buffering).

	Ahn, then you are speaking of moving SIS common heap functions,
command queue determination, queue area size and whatsoever common outside
to a common area? This is really a good approach. :)

> This can only be avoided by keeping the memory management inside the
> framebuffer driver. I don't think it's good to be forced to load the DRM
> module (if that one then contains memory management) for only being able
> to use the framebuffer driver...

	In this current way, yes. But one can compile, let's say, the SIS
FB support as a module and the SIS DRM support as a builtin, which would
break the driver. I threw a patch in the list with a brief description for
Documentation/Configure.help (which is lacking) and the correct dependency
checking for Config.in (that will make FB and DRM support be both modules
or builtin).

> It's not a time issue. As said, the concept isn't that bad for future
> development. I consider it wise enough to keep the drivers separated, as
> this also allows separate usage (framebuffer only, X only) without
> memory clashes.

> > If I have such time, I'll contact him. But for the moment, if the
> > code does not compile (still with 2.4.18-rc2-ac1) I'll duplicate the code
> > to get it working until a better solution raises.

> You don't have to do that. If you don't like a graphical console, simple
> start the framebuffer driver with "mode=none" (or as a kernel parameter
> "mode:none"). In this case, sisfb will only initialize the memory but
> leave the console alone.

> I don't recommend changing anything that big in the framebuffer driver
> at the moment. I am currently in close contact with SiS who help me
> fixing the (still) remaining problems with it - based on the existing
> code. In the very only case you'd like to reinclude a number of changes
> for a number of times - well, go ahead :)

	Well, now that I've got into the code, neither I do. :)

	Any idea on when you'll split allocation codes from the FB code?
(Or will you work on doing just one common module that'll give support for
both FB and DRM?)

	Regards,
	Cesar Suga <sartre@linuxbr.com>


