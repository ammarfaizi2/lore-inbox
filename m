Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265856AbUFOSwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbUFOSwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbUFOSwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:52:16 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:28453 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265856AbUFOSwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:52:07 -0400
Date: Tue, 15 Jun 2004 21:01:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615190119.GC2310@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615175453.GD14528@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615175453.GD14528@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 10:54:53AM -0700, Tom Rini wrote:
> > 
> > - One has to select the default kernel image only once
> >   when configuring the kernel.
> 
> in the case where 'all' wasn't correct to start with.  And i386 isn't
> the convincing case here.
If all was correct in first place this patch does not change behaviour.
For the embedded space all: is often not the right choice,
but for i386 (as you note) all: is always OK (except some rare cases).

> > - There exist a possibility to add more than half a line of text
> >   describing individual targets. All relevant information can be
> >   specified in the help section in the Kconfig file
> 
> Honestly, I'm indifferent to this.  This problem is equally, if not
> better solved by documenting in the board-specific help "and use 'make
> fooImage for foo firmware"

For ppc I see nowhere documented what znetboot, vmlinux.sm neither
zimage is used for.
In total 5 different kernel targets that is un-documented.
Adding this patch gives you a good way to document
them - and room for it.
For the uimage target, I would at least expect a reference
to the relevant bootloader, and maybe a few notes about
the format as well. But there is not room for it on half a line.
If you know what uImage is, not problem. But for newcomers
wondering what it is - this is relevant.

> 
> > - Other programs now have access to what kernel image has been built.
> >   This is needed when creating kernel packages like rpm.
> 
> I suppose this can clean up some of the globbing that might otherwise be
> done, but I know for a fact that there's been kernel rpms before this :)
Did you actually take a look in the mkspec script?
If ARCH equals i386 select bzImage, otherwise select vmlinux.
Not scalable at all - and this type of information should be part
of the architecture specific files, not the mkspec script.

> 
> > Where I see this really pay off is for architectures like MIPS with
> > at least four different targets, depending on selected config.
> > When one has selected to build a certain kernel, including a specific
> > bootloader only the make command is needed.
> > No need to remember the 'make rom.bin' or whatever target.
> 
> This is where I see it blowing up, quite badly.  As Russell noted,
> you're going to have a horrible, unmaintainable list of boards and
> firmware supported, or not, on each.  Even on PPC32 where we really only
> have "needs vmlinux, raw", "needs vmlinux, for U-Boot" and "can use
> arch/ppc/boot/", it'll still get ugly noting which boards can use
> U-Boot, which can use arch/ppc/boot/ and which can use both.

What the patch does is to create a placeholder for
existing targets. No requirements exist for doing what you propose.
But for a given board I would expect the defconfig to select the correct
kernel image.
So when executing:
make ARCH=ppc FADS_defconfig && make ARCH=ppc CROSS...
Kbuild shall build a kernel that works with the selected board with a
default bootloader.
This would be enabled by FADS_defconfig having CONFIG_KERNEL_IMAGE_ZNETBOOT
selected.

In contrast the walnut board has a sane bootloader that accepts a vmlinux,
so here CONFIG_KERNEL_IMAGE_VMLINUX is selected in defconfig.
[Not knowing the baords in question, just as examples].

In this way the board specific config files select the target
to be build, not the other way around.

	Sam
