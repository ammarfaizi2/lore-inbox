Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWHXRFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWHXRFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWHXRFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:05:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22428 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030389AbWHXRFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:05:12 -0400
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433068.3012.115.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 18:05:10 +0100
Message-Id: <1156439110.3012.147.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 18:48 +0200, Jan Engelhardt wrote:
> >     If you are compiling multiple source files, this option tells the
> >     driver to pass all the source files to the compiler at once (for
> >     those languages for which the compiler can handle this).  This
> >     will allow intermodule analysis (IMA) to be performed by the
> >     compiler.  Currently the only language for which this is supported
> >     is C.  If you pass source files for multiple languages to the
> >     driver, using this option, the driver will invoke the compiler(s)
> >     that support IMA once each, passing each compiler all the source
> >     files appropriate for it. 
> 
> Compiling files on their own (`make drivers/foo/bar.o`) seems to make 
> the optimization void. Sure, most people don't stop compiling in 
> between. Just a note

Yeah, that's largely because my support for this in the makefiles is an
evil hack. I'm sure Sam can come up with something better :)

Actually I'm not entirely sure what you write is true. It'll _build_
fs/jffs2/read.o, for example, but it still won't then use it when I make
the kernel -- it'll just use fs/jffs2/jffs2.o which is built from all
the C files with --combine. So the optimisation isn't lost.

> There should be an option (in the kernel's makefile system) to disable 
> its use, just in case `gcc *.c` gobbles up a little more RAM 
> than is present.

Maybe, yeah. If you look in my 'hacks' patch you'll see I actually did
this for drivers/net/e1000.ko because of a known compiler bug. In an
ideal world it shouldn't be necessary though -- and there is always the
option of just turning off CONFIG_COMBINED_COMPILE if your compiler is
buggy or your system doesn't have the balls.

> >Using a combination of these two compiler options for building kernel
> >code leads to some useful optimisation -- especially with modules which
> >are made up of a bunch of incestuous C files, where none of the global
> >symbols actually _need_ to be visible outside the directory they reside
> >in.
> 
> For modules, we have EXPORT_SYMBOL() and any other symbols that are 
> 'extern' but not exported are not visible to other modules.

Indeed.

> >The same benefits can be extended to the vmlinux too, although there are
> >caveats with making _everything_ static. However, it's relatively simple
> >to make EXPORT_SYMBOL() automatically set the 'externally_visible'
> >attribute on the symbol in question, and to introduce a new '__global'
> >tag which does the same for those symbols which aren't exported to
> >modules but which _are_ needed as a global symbol in vmlinux.
> 
> Does the kernel (at least for modules) really use ELF symbol visibility 
> (read: __attribute__((visibility(xyz))) or -fvisibility=xyz) for 
> lookups? 

No, I think that's something entirely different. This is just about
whether something is static or not.

The -fwhole-program option makes _everything_ static -- not visible
outside the object file it's compiled into. For modules that's fine,
since they really don't need to provide _any_ global symbols.

For stuff compiled into the kernel, however, this can be a problem,
since sometimes we _need_ a symbol to actually be global, and accessible
from somewhere outside the directory it's provided by.

So to overcome this, we use GCC's __attribute__((externally_visible))
which, as documented, just makes it global again -- undoing the effect
of -fwhole-program just for this _one_ symbol.

For anything which is exported by EXPORT_SYMBOL or marked ASMLINKAGE, we
put the externally_visible attribute on it automatically, by modifying
the EXPORT_SYMBOL* and ASMLINKAGE macros to do so. That covers a large
number of the symbols which actually need to be global within vmlinux.
The new '__global' tag covers the rest.

-- 
dwmw2

