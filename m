Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVKUAbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVKUAbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVKUAbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:31:09 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:3849 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1750780AbVKUAbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:31:08 -0500
From: James Cloos <cloos@jhcloos.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>,
       Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: make kernelrelease ignoring LOCALVERSION_AUTO
In-Reply-To: <m3acfz88qj.fsf@lugabout.cloos.reno.nv.us> (James Cloos's message
	of "Sun, 20 Nov 2005 13:39:00 -0500")
References: <m3acfz88qj.fsf@lugabout.cloos.reno.nv.us>
Copyright: Copyright 2005 James Cloos
X-Hashcash: 1:23:051121:linux-kernel@vger.kernel.org::TKCIDFTWvS9ZRUaV:00000000000000000000000000000000071lG
X-Hashcash: 1:23:051121:torvalds@osdl.org::erOhtabgrWzI0dTt:000000000000000000000000000000000000000000007VFJ
X-Hashcash: 1:23:051121:zeisberg@informatik.uni-freiburg.de::qAp2v8rreD8ELbSK:00000000000000000000000000SlOg
X-Hashcash: 1:23:051121:sam@ravnborg.org::XU5U+AtqDvPafFod:1MpuQ
Date: Sun, 20 Nov 2005 19:30:53 -0500
Message-ID: <m3mzjy7sg2.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a $(git-repack -a -d && git-prune-packed) before trying the bisect.  

Wow.  Talk about a speed improvement.

I also found that $(make oldconfig; make kernelrelease) was enough to
bisect down to the commit in question.

The final git bisect bad reported:

,---- :; git bisect bad
| ac4d5f74a9b243d9f3f123fe5ce609478df208d8 is first bad commit
| diff-tree ac4d5f74a9b243d9f3f123fe5ce609478df208d8 (from ab919c06144cfb11c05b5b5cd291daa96ac2e423)
| Author: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
| Date:   Wed Nov 9 15:54:08 2005 +0100
| 
|     [PATCH] kbuild: make kernelrelease in unconfigured kernel prints an error
| 
|     Do not include .config for target kernelrelease
| 
|     Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
|     Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
| 
| :100644 100644 2dac8010c14296bf71b20da92d7256d6a5b41f22 3152d6377eb20bb79a95850fabf7b6fee3a64ad2 M      Makefile
`----

The unidiff is:

,---- git diff ab919c06144cfb11c05b5b5cd291daa96ac2e423 ac4d5f74a9b243d9f3f123fe5ce609478df208d8
| diff --git a/Makefile b/Makefile
| index 2dac801..3152d63 100644
| --- a/Makefile
| +++ b/Makefile
| @@ -407,7 +407,7 @@ outputmakefile:
|  # of make so .config is not included in this case either (for *config).
| 
|  no-dot-config-targets := clean mrproper distclean \
| -                        cscope TAGS tags help %docs check%
| +                        cscope TAGS tags help %docs check% kernelrelease
| 
|  config-targets := 0
|  mixed-targets  := 0
`----

That means that $(make kernelrelease) sets dot_config := 0.

And since the block:

,---- linux-2.6/Makefile lines 571-574
| ifdef CONFIG_LOCALVERSION_AUTO
|         localversion-auto := $(shell $(PERL) $(srctree)/scripts/setlocalversion $(srctree))
|         LOCALVERSION := $(LOCALVERSION)$(localversion-auto)
| endif
`----

is in the ifeq ($(dot-config),1) section, localversion-auto does not
get set anymore when the target is kernelrelease.

Which really makes kernelrelease useless.


I understand why the patch was proposed and included.

But the kernelrelease is really .config dependant, given the
CONFIG_LOCALVERSION and CONFIG_LOCALVERSION_AUTO options.

Unless it is OK to force a defconfig when kernelrelease is called on
an unconfigured tree?

Whatever the solution, it is commit ac4d5f74a9b243d9f3f123fe5ce609478df208d8
that breaks $(make kernelrelease).

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>

