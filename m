Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131664AbRAAIGw>; Mon, 1 Jan 2001 03:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131699AbRAAIGb>; Mon, 1 Jan 2001 03:06:31 -0500
Received: from duracef.shout.net ([204.253.184.12]:9234 "EHLO
	duracef.shout.net") by vger.kernel.org with ESMTP
	id <S131664AbRAAIGb>; Mon, 1 Jan 2001 03:06:31 -0500
Date: Mon, 1 Jan 2001 01:35:37 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200101010735.BAA12841@duracef.shout.net>
To: jjs@pobox.com, kaos@ocs.com.au
Subject: Re: [patch] 2.4.0-prerelease drm and modversions
Cc: alan@lxorguk.ukuu.org.uk, dri-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
kaos> drivers/char/drm/Makefile is breaking the Makefile rules.  It builds
kaos> drmlib.a and expects to link that library into both the kernel and into
kaos> modules.

Ah, shit.

kaos> The kernel makefile system assumes that everything is either kernel or
kaos> module, not both.  The components in drmlib.a get compiled for kernel
kaos> only, when used in a module they are missing the symbol versions.

I agree with Keith.

The kernel version is going to get compiled, and then the module version is
going to get compiled with different compilation flags: -DMODULE.  The two
versions are always going to fight.

kaos> +$(patsubst %.o,%.c,$(lib-objs-mod)): 
kaos> +	@ln -sf $(subst -mod,,$@) $@
kaos> +

This looks good to me.  It's missing a dependency though.  If foo-mod.c
exists, and someone edits or patches foo.c, then foo-mod.c needs to be
re-created.

Keith, what do you think of this:

  source-objs-mod := $(patsubst %-mod.o,%-mod.c,$(lib-objs-mod))
  $(source-objs-mod): $(patsubst %-mod.c,%.c,$(source-objs-mod))
    ln -sf $(patsubst %-mod.c,%.c,$@) $@

It suffers from the thundering herd problem (each *-mod.c depend on
all *.c files) but I think it's correct.

Michael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
