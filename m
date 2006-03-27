Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWC0PGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWC0PGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWC0PGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:06:52 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:54533 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751074AbWC0PGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:06:51 -0500
Date: Mon, 27 Mar 2006 16:06:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Build system runs ld more often than needed
Message-ID: <20060327140606.GA10649@mars.ravnborg.org>
References: <20060327143848.3da1ac02.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327143848.3da1ac02.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 02:38:48PM +0200, Jean Delvare wrote:
> Hi Sam,
> 
> I have noticed the following problem:
> 
> khali@arrakis:~/src/linux-2.6.16-git> make modules
>   CHK     include/linux/version.h
>   Building modules, stage 2.
>   MODPOST
> khali@arrakis:~/src/linux-2.6.16-git> touch drivers/media/video/zoran_card.c 
> khali@arrakis:~/src/linux-2.6.16-git> make modules
>   CHK     include/linux/version.h
>   CC [M]  drivers/media/video/zoran_card.o
>   LD [M]  drivers/media/video/zr36067.o
>   LD [M]  drivers/media/video/msp3400.o
>   LD [M]  drivers/media/video/tuner.o
>   Building modules, stage 2.
>   MODPOST
>   LD [M]  drivers/media/video/msp3400.ko
>   LD [M]  drivers/media/video/tuner.ko
>   LD [M]  drivers/media/video/zr36067.ko
> khali@arrakis:~/src/linux-2.6.16-git>
> 
> See how unrelated modules are linked again?

This is an unfortunate side-effect. Following snippet from
scripts/Makfile.build explains it:

# We would rather have a list of rules like
# 	foo.o: $(foo-objs)
# but that's not so easy, so we rather make all composite objects depend
# on the set of all their parts
$(multi-used-y) : %.o: $(multi-objs-y) FORCE
	$(call if_changed,link_multi-y)

The problem is that we have no easy way to say that this specific
module depends on this list of .o files.
With make 3.81 this would be possible utilising $(eval ...),
but the benefit is too low to introduce such a dependency.

> 
> I investigated further and it seems to happen whenever a given Makefile
> has more than one composite object definition. In the case of
> drivers/media/video, the following composite objects are defined:
> 
> zoran-objs      :=	zr36120.o zr36120_i2c.o zr36120_mem.o
> zr36067-objs	:=	zoran_procfs.o zoran_device.o \
> 			zoran_driver.o zoran_card.o
> tuner-objs	:=	tuner-core.o tuner-types.o tuner-simple.o \
> 			mt20xx.o tda8290.o tea5767.o
> 
> msp3400-objs	:=	msp3400-driver.o msp3400-kthreads.o
> 
> I have the following enabled:
> 
> CONFIG_VIDEO_MSP3400=m
> CONFIG_VIDEO_ZORAN=m
> CONFIG_VIDEO_TUNER=m
> 
> So msp3400 and tuner are relinked whenever I make a change to the
> zr36067 driver.

You could do:
make drivers/media/video/zr36067.ko
to avoid linking the others.

But kbuild will unfortunately link to much modules for a normal build.

One day I may try to generate one big Makefile and then it could
be addressed but I have yet to find 'the' reason to invest time in that
task.

	Sam
