Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVIMGac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVIMGac (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVIMGac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:30:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7344 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932361AbVIMGab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:30:31 -0400
Date: Tue, 13 Sep 2005 07:30:28 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050913063028.GQ25261@ZenIV.linux.org.uk>
References: <20050911012033.5632152f.sfr@canb.auug.org.au> <20050910161917.GA22113@mars.ravnborg.org> <20050911023203.GH25261@ZenIV.linux.org.uk> <20050911083153.GA24176@mars.ravnborg.org> <20050911154550.GJ25261@ZenIV.linux.org.uk> <20050911170425.GA8049@mars.ravnborg.org> <20050911212942.GK25261@ZenIV.linux.org.uk> <20050911220328.GE2177@mars.ravnborg.org> <20050911231601.GL25261@ZenIV.linux.org.uk> <20050912191525.GA13435@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912191525.GA13435@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 09:15:25PM +0200, Sam Ravnborg wrote:
> o Use symlinks
>   - With all their horror they do the job.
>   - The need special care with make O=
>   - We fail to detect when the point somewhere else, so make mrproper
>     is needed.
>   - They confuse people
>     
> o include_next
>   - gcc extension
>   - Give us correct dependencies
>   - Signal that something fishy is going on
> 
> o Use some magic define trick like:
>   - #include "ARCHDIR##foo.h"
>   - I cannot recall correct syntax but something like this is doable

* Provide a function that would
	take target of form <directory>/.<link>
	create a symlink at <directory>/<link> to argument of function,
doing obvious changes for O=
	touch the target

That would turn e.g. arm/Makefile rule into

include/asm-arm/.arch: $(wildcard include/config/arch/*.h) include/config/MARKER
	$(call symlink, arch-$(incdir-y))

with all the guts handled by the function in question.  For O= build you'd
get
	include/asm-arm created if needed
	include/asm-arm/arch -> $(srctree)/include/asm-arm/arch-....
and for normal one
	include/asm-arm/arch -> arch-....
In either case include/asm-arm/.arch is touched and depends on the right
config options.  Same for include/asm-sh/cpu and include/asm-sh/mach,
etc.

The only case not handled by that scheme is when we create a symlink and
then create files in its target.  Which, AFAICS, is the case only for
include/asm - UML used to need that for arch/um/include/sysdep, but doesn't
anymore (as the matter of fact, arch/um/include2/ is gone in my tree).

The reason why include_next blows is very simple: OK, so make can figure
out what we mean.  But make is not the only thing that has to understand
which file is refered to - people writing and reviewing code need the same
and having to figure out what exactly do we have in search path is asking
for trouble.  With symlinks (or bindings, etc.) you have #include argument
that doesn't need that sort of lookups - <asm/arch/foo.h> is visibly
different from <asm/foo.h> and one can immediately see what it's about.

IOW, playing tricks with search paths becomes wrong as soon as it becomes
something you have to keep in mind while reading kernel code itself.
