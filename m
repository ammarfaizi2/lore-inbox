Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUIMTVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUIMTVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIMTVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:21:34 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:41181 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268886AbUIMTVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:21:14 -0400
Message-ID: <a728f9f9040913122160dd0134@mail.gmail.com>
Date: Mon, 13 Sep 2004 15:21:13 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
Cc: Vladimir Dergachev <volodya@mindspring.com>,
       =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409130803340.2378@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
	 <1095036743.22137.48.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409131047060.4885@node2.an-vo.com>
	 <Pine.LNX.4.58.0409130803340.2378@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How would any of these plans handle power management and ACPI events?
I'd like to be able to suspect my laptop with the DRI enabled, or have
the DDX (or whatever) handle acpi lid and button events or put the
chip into various power modes.

Alex

On Mon, 13 Sep 2004 08:20:58 -0700 (PDT), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Mon, 13 Sep 2004, Vladimir Dergachev wrote:
> >
> > The overlay window is currently using part of what is being proposed by
> > "multiple drivers" proponents. It has to make engine queiscent so it can
> > write data directly to the video memory. It does *not* have to save the
> > state.
> 
> It doesn't even really need to make the engine quiesce.
> 
> If two subsystems are aware of the locking rules (and the helper driver
> obviously doesn't much care), they can just design their own handoff
> trivially. For example, it might make sense to make the "wait for the
> engine to stop" be the responsibility of the side that actually _needs_
> it, namely the PIO user.
> 
> So if both users use the engine, not PIO, there's no need to ever stop the
> engine. In my example of how to use the locking, it looked something like
> this:
> 
>         if (get_lock(data->gfx.accelerator)) {
>                 /* Somebody else used the engine, need to re-load cached index */
>                 mydev->offset = readl(mydev->mmio + OFFSET_PORT);
>         }
>         OUT_RING(mydev, cmd);
>         OUT_RING(mydev, arg);
>         put_lock(data->gfx.accelerator);
> 
> See? You can have two clients doing accelerator things, and they _never_
> wait for anything (well, obviously "OUT_RING()" needs to wait for the
> buffer to be empty enough ;).
> 
> They still need to know whether there was a previous user, because
> efficient command filling does require that you don't read the "where is
> the command buffer end" thing all the time, so that's why you have to
> cache that one in real RAM instead of reading it from the card every op.
> And because you cache it, you have to update your cache if somebody else
> uses the engine.
> 
> Now, a PIO writer would look different
> 
>         if (get_lock(data->gfx.accelerator)) {
>                 /* Somebody else used the engine, need to quiesce */
>                 wait_for_engine_idle(mydev);
>         }
>         outl(cmd, mydev->pio + OFFSET_CMD);
>         ...
>         put_lock(data->gfx.accelerator);
> 
> and here if we switch back and forth between a client that uses
> synchronous commands (ie normally PIO) rather than the engine, then yes,
> we'd obviously halt the engine all the time. But hey, you can't avoid
> that: if you want good performance with most modern chips, you do all your
> work with the engine, not with synchronous commands.
> 
> > So, as Jon rightly points out the "multiple drivers" scheme only makes
> > sense in the current usage patter - you either use X or framebuffer, never
> > both at the same time and you consider a few seconds per switch normal.
> 
> I disagree. You can use a combination of X, framebuffer and "special
> clients", where the special client can be _exactly_ things like video
> overlays etc.
> 
> Now, obviously we'd wish that X has support for video overlays directly,
> and thus you wouldn't even need to switch between clients at that level,
> but there are certainly cases where you may end up with an "external
> client". It might be some very card-specific thing that X or DRM just
> doesn't support yet, so you whip up a quick client for just that.
> 
> For example (and this may be a horribly _bad_ example, for all I know),
> let's say that somebody decides that they want to do a DirectX library,
> and all the DRM people just throw their hands up in horror and say "over
> my dead body".
> 
> In that case you have two choices: kill the DRM people and dance on their
> graves, or just say "ok, I'll make this other client that does the DirectX
> interfaces". And the thing is, it shouldn't fundamentally not work. As far
> as I can tell, with some rudimentary locking support like the above (the
> trivial part) and some memory management support (the _hard_ part), you
> should be able to have the two clients work together quite well.
> 
> And yes, I realize that this is what DRM already does internally. I agree.
> I applaud it. I'm saying that if we moved that internal locking to be
> _external_, so that other clients can use it too, then fbcon and DRM and
> some random new subsystem could all live together in peace and harmony.
> 
> Now, let's all sit around the fire and sing Kumbaya.
> 
>                 Linus
> 
> 
> 
> 
>
