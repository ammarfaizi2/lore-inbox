Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbTARJOi>; Sat, 18 Jan 2003 04:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTARJOi>; Sat, 18 Jan 2003 04:14:38 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:19219 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263589AbTARJOi>;
	Sat, 18 Jan 2003 04:14:38 -0500
Date: Sat, 18 Jan 2003 10:23:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, kai@tp1.ruhr-uni-bochum.de,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Message-ID: <20030118092331.GA1483@mars.ravnborg.org>
Mail-Followup-To: Mike Galbraith <efault@gmx.de>,
	Mikael Pettersson <mikpe@csd.uu.se>, kai@tp1.ruhr-uni-bochum.de,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <15911.64825.624251.707026@harpo.it.uu.se> <5.1.1.6.2.20030118085515.00c99e40@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.1.6.2.20030118085515.00c99e40@pop.gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2003 at 09:00:51AM +0100, Mike Galbraith wrote:
> At 01:55 PM 1/17/2003 +0100, Mikael Pettersson wrote:
> 
> >Reverting 2.5.59's patch to arch/i386/vmlinux.lds.S cured the
> >problem and modules now load correctly for me.
> 
> Hi,
> 
> Putting . = ALIGN(64) back in front of __start___ksymtab = . 
> (vmlinux.lds.h) fixed it here.

But that is just a way to hide the real problem.

With . = ALIGN(64);
you make sure that the linker does not do any alignment of .
when entering the section.
It is much better to let the linker do proper alignment, and not
to rely on a magic number in the .lds file.

Now consider if we decide to put in a new symbol with alignment 128 for
some reason. A little gcc magic is used to sepecy the alignment of
the symbol, but the resulting kernel oopses. Why?
Because the ALIGN() preceeding the section was not adjusted properly.
Only sane way is to move the labels inside the block, or at least let
them depend on the address of the section. The lables should not
be assigned the value of ., when we know the linker may adjust it.

The solution that Russell used for ARM is IMO the best way to do it.

The only issue remaining here is what the linker will do for an empty
section, as Eric points out. I have not investigated that.

	Sam
