Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284791AbRLUQ7T>; Fri, 21 Dec 2001 11:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284882AbRLUQ7J>; Fri, 21 Dec 2001 11:59:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35665 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S284952AbRLUQ6w>; Fri, 21 Dec 2001 11:58:52 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
In-Reply-To: <200112181605.KAA00820@tomcat.admin.navo.hpc.mil>
	<m18zbzwp34.fsf@frodo.biederman.org> <3C205FBC.60307@zytor.com>
	<m1zo4fursh.fsf@frodo.biederman.org>
	<9vrlef$mat$1@cesium.transmeta.com>
	<m1r8pqv1w3.fsf@frodo.biederman.org> <3C218BF3.6010603@zytor.com>
	<m1n10dvobd.fsf@frodo.biederman.org> <3C222F84.4060509@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Dec 2001 09:57:09 -0700
In-Reply-To: <3C222F84.4060509@zytor.com>
Message-ID: <m17krgse8q.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> 
> > Agreed.  And to completely dispel the myth.  Etherboot has been doing
> > something similar for years.  It disables interrupts in 32bit mode so
> > it doesn't have quite as much work to do but otherwise it is pretty
> > much the same picture.
> >
> 
> 
> If you disable interrupts in 32-bit mode a lot of things will not work.

The basic technique use by etherboot is:
In 32bit mode handle no interrupts.  When you want to do a BIOS call
switch to 16bit mode enable interrupts do the call.  disable interrupts
and switch back to 32bit mode.

As far as I can tell this is a similar idea to what you are doing in
genesis.  etherboot doesn't need everything so it doesn't handle the
general case.  But given that it is public program, I mentioned it
because to help dispell the myth that you can do bios call from 32 bit
protected mode..

> > I finally tracked down the reason why Setup.S is run in real mode,
> > instead of being called from protected mode.  And that is in extremely
> > hostile environments (like loadlin works in) loading the kernel wrecks
> > the firmware callbacks.  So you must do your BIOS calls as a special
> > case before you switch to protected mode.
> 
> 
> No, it's because it was easier to do it that way -- do all BIOS calls once and
> for all in the early part of the execution of the kernel, and then forget about
> it.

That may have been the original reason.  But the reason to keep the
code that way is so we work with loadlin, (and any kin it might have).  

I have tested it and after you are loaded by loadlin you cannot go
back and make BIOS calls.  The problem is that dos TSR's and device
drivers have intercepted BIOS interrupts, and we stomp all over
those.

It may be possible to overcome this by saving the state of the entire
dos session but to be safe we would need to take a core dump of the
entire machine.  And for such little gain I don't think that is worth
it.

Eric

