Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSIHSds>; Sun, 8 Sep 2002 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSIHSds>; Sun, 8 Sep 2002 14:33:48 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:63498 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S313070AbSIHSdr>;
	Sun, 8 Sep 2002 14:33:47 -0400
Date: Sun, 8 Sep 2002 20:50:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "D. Hugh Redelmeier" <hugh@mimosa.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: clean before or after dep?
Message-ID: <20020908205011.A1671@mars.ravnborg.org>
Mail-Followup-To: "D. Hugh Redelmeier" <hugh@mimosa.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <1031490782.26902.4.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209081206590.21724-100000@redshift.mimosa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209081206590.21724-100000@redshift.mimosa.com>; from hugh@mimosa.com on Sun, Sep 08, 2002 at 02:09:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2002 at 02:09:00PM -0400, D. Hugh Redelmeier wrote:
> What are the ordering constraints on mrproper, clean, dep, and
> *config?  I'd like to characterise all sequences that properly prepare
> for a kernel build.
Lets go through the targets in question, and their purpose:
mrproper:
mrproper removes all files generated during the build process. This
includes the final kernel, the current configuration, firmware for
drivers, host-progs used during compilation, buildversion, 
the include/asm link and a few more files.
mrproper is the right choice when you are going to build a new kernel
or something weird happend during the build process.
make mrproper are needed from time to time with the 2.4 kernel, when the
kernel build system gets 'confused'.
When executing mrproper, the first step is actually a clean as described below.

clean:
Clean removes all intermidiate files generated during the build process.
make clean will force all SRC to be build because all the .o files are
deleted.
[Checking arch/i386/Makefile + arch/i386/boot/Makefile]
make clean delete the final bzImage as well, which kinf of suprised me,
I did expect that mrproper were needed to do that.

dep:
In the 2.4 kernel make dep is used to record all the dependencies.
In the 2.5 kernel it's used for much less than in 2.4 kernel.
==>You need someone more familiar than me to comment on that.

*config:
As you probarly know it is used to build the .config.
To my best knowledge make dep, make clean does not have any influence.
But make mrproper will delete the .config file.

> What these targets do, according to README:
> 
> 	mrproper: removes stale .o files and dependencies lying around
> 	clean: ? seems to remove files built by the build process
> 	*config: configure the kernel [build a .config]
> 	dep: set up dependencies
> 
> The normal sequence seems to be:
> 	mrproper && *config && dep && build
> I'm not sure where clean comes in this sequence.  mrproper includes
> clean, so this sequence will do it once.  Is it needed somewhere after
> the *config too?
No, if executed before that should do it.

> - is it safe to do an mrproper after a *config?  In other words, does
>   mrproper affect/damage/undo anything done by *config?
Yes, .config is deleted.

> - is it necessary to do a clean after a *config?  (README suggests no;
>   many things in Documentation suggest yes.)
>   One reason might be that dep requires this -- is this the case?
>   <http://www.van-dijk.net/linuxkernel/200223/0432.html> suggests yes.
>   Experience suggests no, at least until very recently.
>   Or is there some other way in which dep now requires that
>   it be preceded by a clean, perhaps after a failed build?
With the 2.5 kernel, if make clean or make mrproper is ever _required_
I would say you had triggered an error in the kernel build system.

> - theory: a clean should be done after a failing build so that
>   a subsequent build won't use the results of the failing build.
Should not be needed with the build system in the 2.5 kernel.

	Sam
