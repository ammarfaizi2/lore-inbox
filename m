Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWE2XX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWE2XX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWE2XX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:23:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:33604 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932089AbWE2XXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:23:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SFOp3al2bSRdv+Zo839LjjqAAQLM4On8sJoN7eL3El9W9IVhQHFJR8jAdATXYUhP9CNlW0RGi3CzEBHTvRmzfxQakFEjEQbsdEQCtS8j+ghQjpx9YtRMGz3pBUpK3ZZeXRcx+pt8XsykxgOegQZzM9eXgGvfVF1tGV2YbHuVvek=
Message-ID: <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
Date: Tue, 30 May 2006 09:23:54 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Jon Smirl" <jonsmirl@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060529124840.GD746@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <20060529102339.GA746@elf.ucw.cz>
	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
	 <20060529124840.GD746@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We have to support what we support now, regressions in what we support
> > are not acceptable, we would spend all our time just having Linus
> > backing out changes, I'm sorry Pavel I respect what you've done with
> > input, but your list below cuts out a number of currently support
> > configurations the main ones currently in use are:
>
> Vojtech Pavlik is the one who done inputs... not me. (I admit we have
> similar names).

Sorry by brain slipped I meant suspend/resume... not enough sleep too
much flamage..

>
> No, to the contrary. suspend/resume can't ever work properly with
> vgacon and vesafb. It works okay with radeonfb tooday, and in fact
> radeonfb is neccessary today for saving power over S3.

But the things is today for many users suspend/resume to RAM works for
people running X drivers, I know on my laptop that my radeon
suspends/resumes fine when running vgacon/DRM/accelerated X, it
doesn't suspend/resume at all well when running vgacon on its own of
course. or with radeonfb for that matter. so I still believe the
suspend/resume code for a card can live in userspace if necessary but
it just shouldn't be part of X... it needs to be part of another
graphics controller process.

> > Here are the rules
> > 1. No regressions.
> > 2. Doesn't require lockstep changes in X and kernel, i.e. a new kernel
> > can't break old X, and new kernel can't require a new X, new config
> > features in the kernel can require a new X of course but anything
> > using and old config feature must still work.
>
> These are very reasonable rules... but still, I think we need to move
> away from vgacon/vesafb. We need proper hardware drivers for our
> hardware.
>
> Now, having DRM depend on framebuffer driver sounds like a right
> long-term solution. We probably need to do something with
> vesafb/vgacon... like stub it out or something, and deprecate them,
> long-term.

To be honest, not using fbdev may be a better long-term solutions I'm
wholly not convinced we can put enough support for things into the
fbdev drivers without a lot of work, I've concentrated before on
splitting X.org into two pieces, a device setup and control process
running most of the X driver, and a rendering server. The thing
currently missing from the equation is the memory management unit, so
I can say this buffer is the current front buffer, and things like
that, so that we can invalidate the front buffer on rotations and
other operations where it needs to be. This can all be built on top of
the DRM. We can then perhaps have an fbcon or drmcon that knows where
the card's frontbuffer is and what mode is set on it, so it can dump
oops etc...

vgacon causes problems of course with memory management, as I believe
that most graphics cards when in text mode, don't allow you to specify
what pieces of their VRAM are being used to display the text mode, so
you have to try and keep framebuffers at the start of RAM, when really
you'd like to not have that sort of restriction.

Dave.
