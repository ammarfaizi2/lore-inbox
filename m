Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWEXEVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWEXEVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWEXEVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:21:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:2176 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932558AbWEXEVO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:21:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nfycKd9R/RHqS8uBKyfdoG04vnw1j/i3sKGIUtwPxMS1MG2qi7wDWjmE/YkBxdr4zWUR4DOd1EOtJRcdG3FQ9cpFOQqB9GSiWrzNGcqx2kK2a24oUNKp4vNPV6qndjghoJviQezPFfsFp4o4RaLRXTbFFjBcZBPZsrrHV3Y1ssY=
Message-ID: <9e4733910605232121s259e97fdu755e1f2762026e5f@mail.gmail.com>
Date: Wed, 24 May 2006 00:21:12 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, "Dave Airlie" <airlied@linux.ie>
In-Reply-To: <200605232324.20876.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <E1Fifom-0003qk-00@chiark.greenend.org.uk>
	 <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
	 <200605232324.20876.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/06, D. Hazelton <dhazelton@enter.net> wrote:
> > 2) The ROM support in the kernel knows about the shadow RAM copy at
> > C000::0. When you request the ROM from a laptop video system it
> > returns a map to the shadow RAM copy, not to a physical ROM. You need
> > access to the shadow RAM copy to get to things the BIOS left there
> > when it ran.
>
> Of course. But then there are people who do stupid things like telling the
> BIOS not to provide a shadow copy of the ROM. However that isn't a big
> problem and those people should have their hardware properly configured in
> the first place...

Every recent system I've turned the shadow copy off on won't boot any more.

> Okay. This is good - exactly what I was thinking would be done anyway.  What
> about cards like the Radeon's with two CRTC's that can run multi-headed off a
> single card?
>
> Apparently the card is booted properly by the BIOS, but the second head
> (either the VGA port, the Composite/TV Out or the DVI) isn't setup properly
> by the BIOS because, apparently, the ROM can't detect the properties of the
> second head in some situations.

That is a card specific problem that needs to be addressed in the
driver for the card. As long as the ROM is run the hardware will
correctly respond to commands asking it about the secondary heads.

> However, for situations like that it might be best to have the API open so
> that userspace tools can be used to set those secondary outputs.
>
> > When running the ROMs you will need to add code to manage the active
> > VGA device since both adapters will try and turn it on when their ROMs
> > are run.
>
> Okay. This has me beat - any suggestions on how to manage it?

Don't worry about multiple cards in a single system yet.

>
> > You will also need to provide a mechanism to call out to userspace.
> > The userspace program will use vm86 or emu86 to run the ROM image.
>
> Yes - problem is that I have not been able to find any decent information on
> vm86/emu86 in order to capitalize on the system call. Might be better to have
> some people specifically working on the userspace stuff while others focuse
> on the in-kernel stuff.

BenH has source for a working emu86. I would wait on that project
until klibc has been merged.

> One problem is that Mesa is strictly OpenGL, so this would mean there would
> have to be a second library for the 2D stuff. Potential contenders for this
> are abundant, including one windowing system that actually, IIRC, is
> distributed as a kernel patch/module. I would love to leave the 2D stuff
> completely up to userspace, but all modern video cards contain acceleration
> for 2D drawing, so it would probably be best to include that in any userspace
> side of the system.

OpenGL is perfectly capable of doing 2D drawing as well as 3D. Check
out the profile option of OpenGL/ES. It has been proposed before to
chop mesa down into a smaller OpenGL/ES profile for system where space
is at a premium. There is a commercial minimum profile OpenGL/ES
implementation that fits in 100K.

I would leave accelerated 2D alone to begin with and I would remove
the fbdev 2D acceleration from any fbdev drivers that you merge. The
fbdev acceleration code conflicts with the DRM code. If you ask me,
there should be no in kernel access to acceleration of any kind.
Anything wanting acceleration would need to ask for it from user
space. More details on consoles and acceleration are in:
http://jonsmirl.googlepages.com/graphics.html

Merging and fixing the kernel graphics subsystem is a gigantic
project. My strategy would be to split it up into small steps and get
one step accepted at a time. Don't start writing code for the next
step until the first one is accepted. The number of changes you will
get on the first step will invalidate anything you do on the second
step.

A good first project would be to start building a set of user space
apps for doing the mode setting on each card. All of the code for
doing this exists in the X server but it is a pain to extract. X has
1000s of internal APIs and typedefs. You would end up with a set of
apps that would be able to list the valid modes on each head and then
set them. The code for achieving this is all over the map, sometimes
we know everything needed like for the Radeon, sometimes you need to
make a VM86 call to the BIOS to get the info (Intel). Load an fbdev
driver and check out the current support for this in sysfs.

When you get done with a command it should be a tiny app statically
linked to klibc and have no external dependencies. These apps should
be 30K or less in size. You probably will end up with about ten apps
since a lot of the uncommon cards only have a standard VBE BIOS and
will all use the same command.

You will also need to make a licensing decision. X and DRM are MIT
licensed and fbdev is GPL licensed. If you use any code from fbdev you
have to pick GPL for your license. This won't bother Linux but it will
bother BSD. I'm a Linux user and I've never booted BSD so I don't
care, but other people do.

-- 
Jon Smirl
jonsmirl@gmail.com
