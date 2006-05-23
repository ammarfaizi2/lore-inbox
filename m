Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWEXDYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWEXDYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 23:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWEXDYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 23:24:32 -0400
Received: from smtp.enter.net ([216.193.128.24]:29715 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932171AbWEXDYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 23:24:32 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Tue, 23 May 2006 23:24:20 +0000
User-Agent: KMail/1.8.1
Cc: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <E1Fifom-0003qk-00@chiark.greenend.org.uk> <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
In-Reply-To: <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605232324.20876.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 May 2006 23:38, Jon Smirl wrote:
> On 5/23/06, Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
> > Jon Smirl <jonsmirl@gmail.com> wrote:
> > > 1) Running the video ROM at boot to reset cards, emu86
> >
> > Jon, how many times am I going to have to tell you that this won't work?
> > The video ROM is not always present on laptop hardware, and even when it
> > is it may jump into sections of ROM that have vanished since boot.
> > In the long run, graphics drivers need to know how to program cards from
> > scratch rather than depending on 80x25 text mod being there for them.
>
> 1) I didn't put a lot of detail into the line item but you only need
> to use the ROM to reset secondary cards on x86 architectures. Primary
> cards are always initialized by the system BIOS so you don't need to
> run their ROM on boot. I think the only way to get a secondary card
> into a laptop is through a PCMCIA slot and I've only seen one PCMCIA
> video card.

Agreed. I'll see about doing this using a method similar to the X int10 model. 
I don't have access to the specs on anything other than x86, so if someone 
could provide some information to help with the non-x86 side of the code I'd 
be grateful.

> 2) The ROM support in the kernel knows about the shadow RAM copy at
> C000::0. When you request the ROM from a laptop video system it
> returns a map to the shadow RAM copy, not to a physical ROM. You need
> access to the shadow RAM copy to get to things the BIOS left there
> when it ran.

Of course. But then there are people who do stupid things like telling the 
BIOS not to provide a shadow copy of the ROM. However that isn't a big 
problem and those people should have their hardware properly configured in 
the first place...

> So to add more detail,
> Run the ROM on primary adapters if the arch is non-x86 and the ROM
> contains x86 code.
> Run the ROM on primary adapters on embedded systems if the system BIOS
> doesn't do it.
> Otherwise don't run a primary ROM. The kernel ROM API tracks primary
> versus secondary for you.
> Always run the ROM on secondary adapters. Secondary adapters don't
> have the compressed laptop ROM problem.

Okay. This is good - exactly what I was thinking would be done anyway.  What 
about cards like the Radeon's with two CRTC's that can run multi-headed off a 
single card?

Apparently the card is booted properly by the BIOS, but the second head 
(either the VGA port, the Composite/TV Out or the DVI) isn't setup properly 
by the BIOS because, apparently, the ROM can't detect the properties of the 
second head in some situations.

However, for situations like that it might be best to have the API open so 
that userspace tools can be used to set those secondary outputs.

> When running the ROMs you will need to add code to manage the active
> VGA device since both adapters will try and turn it on when their ROMs
> are run.

Okay. This has me beat - any suggestions on how to manage it?

> You will also need to provide a mechanism to call out to userspace.
> The userspace program will use vm86 or emu86 to run the ROM image.

Yes - problem is that I have not been able to find any decent information on 
vm86/emu86 in order to capitalize on the system call. Might be better to have 
some people specifically working on the userspace stuff while others focuse 
on the in-kernel stuff.

> The contents of the ROM image should be put back into the kernel using
> the ROM copy APIs but no one has gotten that far yet. Video ROMs
> assume they are running out of shadow RAM so they alter things and
> leave pointers to what they found.
>
> I can provide more detail on how to set all of this up if needed.

Yes, please. I made the post I did - dumping my immediate thoughts on the 
subject into it - because I was interested in working on this and making some 
contribution to the kernel. I have a feeling I can get the DRM stuff working 
as the backend for the framebuffer drivers and export that API, or something 
slightly different, to userspace for the userspace tools to take advantage 
of.

In this case, I was thinking that the exo-kernel model used in ALSA would be 
the best solution. For that matter, it wouldn't be trivial, but your 
suggestion about modifying Mesa to be the main userspace interface to the 
kernel graphics system has a lot of merit.

One problem is that Mesa is strictly OpenGL, so this would mean there would 
have to be a second library for the 2D stuff. Potential contenders for this 
are abundant, including one windowing system that actually, IIRC, is 
distributed as a kernel patch/module. I would love to leave the 2D stuff 
completely up to userspace, but all modern video cards contain acceleration 
for 2D drawing, so it would probably be best to include that in any userspace 
side of the system.

DRH
