Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUD1UAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUD1UAQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUD1T71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:59:27 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39462 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261205AbUD1TG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:06:29 -0400
Date: Wed, 28 Apr 2004 21:08:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Vincent C Jones <vcjones@NetworkingUnlimited.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6-rc3
Message-ID: <20040428190855.GA4069@mars.ravnborg.org>
Mail-Followup-To: Jari Ruusu <jariruusu@users.sourceforge.net>,
	Sam Ravnborg <sam@ravnborg.org>,
	Vincent C Jones <vcjones@NetworkingUnlimited.com>,
	linux-kernel@vger.kernel.org
References: <1PMQ9-5K6-3@gated-at.bofh.it> <20040428144801.B3708149A6@x23.networkingunlimited.com> <20040428160057.GA2252@mars.ravnborg.org> <408FE8C4.33B3BDB4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408FE8C4.33B3BDB4@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Full package:
> http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.0g.tar.bz2

Hi Jari.
I took a look at how you use the build system in the 2.6 kernel.
Inherited from the 2.4 days you assemble the commands yourself,
which is plain wrong in a 2.6 kernel.
The only sane way to build external modules with a 2.6 kernel is
to utilise the kbuild infrastructure.

For your reference here is a Makefile that I used to compile your
module (made a symling for loop-patched.c file).

To compile the kernel I used:
make -C /home/sam/bk/v2.6/ M=$PWD
[Assumes latest linus kernel - 2.6.6-rc3]

For older kernels append the modules target

This has the added benefit that Module versioning is also supported.

#########################
# Minimal kbuild Makefile for loop-AES

EXTRA_CFLAGS := $(LOOP_AES_CFLAGS)

obj-m := loop.o

i586-$(CONFIG_M586) := -i586
i586-$(CONFIG_M686) := -i586

loop-y := loop-patched.o aes$(i586-y).o glue.o md5$(i586-y).o

##########################

I see in the Makefile that you do a lot of tricks to support various
kernel versions. But they all end up in a few defines for the C compiler,
which you just needs to supply in the variable LOOP_AES_CFLAGS.
[And some file massaging whaich is done before starting the build]

What I would recommend you to do is to move all your backward compatibility
stuff and general rules to a file named 'makefile'.
Then provide individual Makefiles for each kernel version:
Makefile.2.4, Makefile.2.6
Then symlink Makfile to the right one and build the module.

This would clean up your Makefile and give you correct usage in 2.6

	Sam


