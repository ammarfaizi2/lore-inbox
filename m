Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSFRT2U>; Tue, 18 Jun 2002 15:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSFRT2T>; Tue, 18 Jun 2002 15:28:19 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:38359 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317570AbSFRT2R>; Tue, 18 Jun 2002 15:28:17 -0400
Date: Tue, 18 Jun 2002 14:28:02 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Various kbuild problems in 2.5.22
In-Reply-To: <20020618211639.A2659@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0206181417230.5695-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Sam Ravnborg wrote:

> > 	The standard for make is that if you name the target, it
> > builds the target.  If I want to make bzImage and modules, I should type
> > "make bzImage modules".

Nitpick: 
[kai@chaos linux-2.5.make]$ make bzImage && ls bzImage
[..]
ls: bzImage: No such file or directory

So you that bzImage isn't a real target (arch/i386/boot/bzImage would be).

> As it is in 2.5.22 make bzImage compares to make installable in kbuild-2.5.
> What about combining best of both worlds?
> 
> Let
> make bzImage	-> Build bzImage
> make modules	-> Build modules
> 
> And the new member of the family:
> make kernel	-> Build selected binary and modules.
> 
> So "make kernel" is similar to kbuild-2.5 "make installable" a name 
> that I dislike. Obviously "make kernel" requires support for selecting
> the appropriate binary utilising make *config.

Well, let's say I agree that the kind of semantics change regarding 
building modules at the same time isn't the nicest. So I propose the 
following:

make bzImage -> compile built-in, build bzImage
make modules -> compile modules
make bzImage modules -> build bzImage + modules (I found a way to do so
                        without having to descend twice)

make,
make all     -> compile vmlinux + modules as a general default,
                on i386 build bzImage + modules.
	        (other archs can change the behavior as they wish)

> >        If I want to the kernel to build to continue even when a module
> > fails to compile, I should be able to do that by just using "-k".  Not
> > being able to build include/linux/modversions.h prevents me from doing
> > that.
> >From a conceptual point I disagree here. I would like make to
> avoid completion in case an error is flagged.
> My prediction is that the new behaviour may result in more errors being
> corrected, due to the incentitive to do it. Today you ignore it
> and hardly cannot spot it in all the noise generated during the build
> process.

Let me second this. In particular, there is no way to reliably generate
module versions when the affected files cannot even be preprocessed. So 
it's the right thing to error out. If someone dislikes that, they can
still turn MODVERSIONS of and proceed in their broken world.

> By the way - anyone having feedback on the "make KBUILD_VERBOSE=0"
> mode. Why not make it default?

I fear there won't be feedback unless it is made default, since nobody 
even notices otherwise.

Anyway, before making it default, I'm planning to call gcc from the 
topdir, so error/warning messages get prefixed with the complete
path to the source, which will allow a smart editor to automatically
jump to the place where the message occured.

(Currently it works due to make's 'Entering directory [...]' messages,
 which are disabled in quiet mode)

--Kai


