Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWAGIrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWAGIrY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 03:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWAGIrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 03:47:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:37136 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030364AbWAGIrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 03:47:23 -0500
Date: Sat, 7 Jan 2006 09:47:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
Message-ID: <20060107084704.GA10557@mars.ravnborg.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136543914.2940.11.camel@laptopd505.fenrus.org> <43BEA672.4010309@pobox.com> <20060106184841.GA13917@mars.ravnborg.org> <p73k6dcykar.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73k6dcykar.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 01:05:16AM +0100, Andi Kleen wrote:
> 
> The feature also has some drawbacks - last time I checked it
> was still quite green (as in bananas). First it causes gcc 
> to eat a lot more memory because it has to hold completely directories
> worth of source in memory. This might slow things down if setups
> that didn't swap before start doing this now.
kbuild rely on the gcc feature that generates a dependency file
using: -Wp,-MD,<file>
This is broken when adding several .c files.
It looks like gcc generate a new dependency file for each and every
input file overwriting the old one. Obviously caused by gcc being
invoked once for each input file in my version of gcc.

gcc --version:
gcc (GCC) 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)
Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Anyone that knows how I can enable gcc 4.x for kernel builds on a gentoo
box without changing gcc for everything else?
I could install a vanilla gcc but too bored to do so.

> I suspect it'll also run slower with this because it has some algorithms
> that scale with the size of the input source and some of the
> directories in the kernel can be quite big (e.g. i'm not 
> sure letting a optimizer lose on all of xfs at the same 
> time is a good idea)
The most noticeable difference will be when it has to compile all files
for a module when a single file changes. And cccache will not save us in
this case.

> And gcc is really picky about type compatibility between source files
> with program-at-a-time.  If any types of the same symbols are
> incompatible even in minor ways you get an ICE. That's technically
> illegal, but tends to happen often in practice (e.g. when people
> use extern) It might end up being quite a lot of work to clean this up.

Even with an ICE it may be wortwhile to do a allmodconfig build just to
get an overview of type inconsistencies - no?
A quick grep shows that we have 3300 extern functions in .c files in the
kernel :-(

	Sam
