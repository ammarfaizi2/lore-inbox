Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284182AbRL2ASf>; Fri, 28 Dec 2001 19:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284905AbRL2ASY>; Fri, 28 Dec 2001 19:18:24 -0500
Received: from d-dialin-2776.addcom.de ([213.61.81.144]:38126 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S284182AbRL2AST>; Fri, 28 Dec 2001 19:18:19 -0500
Date: Sat, 29 Dec 2001 00:44:06 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Legacy Fishtank <garzik@havoc.gtf.org>, <linux-kernel@vger.kernel.org>,
        Keith Owens <kaos@ocs.com.au>, Larry McVoy <lm@bitmover.com>,
        "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system
In-Reply-To: <Pine.LNX.4.33.0112281416290.23445-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112290005110.2889-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Linus Torvalds wrote:

> On Fri, 28 Dec 2001, Legacy Fishtank wrote:
> >
> > I think one thing to note is that dependencies is that if you are smart
> > about it, dependencies -really- do not even change when your .config
> > changes.
> 
> Absolutely. I detest "gcc -MD", exactly because it doesn't get this part
> right. "mkdep.c" gets this _right_.

Well, -MD gets this right. The dependencies it generates will cause a 
recompile when necessary. Unfortunately, though, it's too good, because 
the dependency on include/linux/autoconf.h will cause lots of unnecessary 
recompiles.

But yes, it seems possible to replace the -MD dependency file, which
depends on a specific config, with a generic dependency file, which knows
about our #ifdef CONFIG_XXX and translates them to the corresponding
ifeq(CONFIG_,) Makefile syntax. It'd make an interesting project, but it
effectively means re-implementing a C preprocessor.

I don't think you can blame gcc -MD for not knowing about the kernel's
CONFIG_ system, though ;-)

From

---
#ifdef CONFIG_XXX
#include <linux/xxx.h>
#endif

#ifdef CONFIG_YYY
const int nr = 10;
#else
const int nr = 100;
#endif
---

you'd have to generate

---
ifeq(CONFIG_XXX,y)
DEPS += include/linux/xxx.h
endif

DEPS += include/config/yyy
---

i.e. the include/config trick has to stay any way.

I don't think the above is necessary, though, the following does work
pretty good (I did it this way, inspired by mec, and I think kbuild-2.5
does it similarly):

Generate dependencies for a .o file when compiling it. 

[ Doing make dep in advance is unnessary. Actually, it's pretty stupid to
generate dependencies for *all* possible object files which you are never
going to compile (think arch/*). If you don't have the object yet, you
don't need to know the dependencies, dependencies only make sense for
recompiles. It's also cheaper to generate dependencies during the compile,
as you need to read the file anyway. Also, dependencies on generated files
cannot be found correctly until these files have been generated. ]

The generated dependencies will always include linux/autoconf.h, which is
correct, but will cause too many recompiles. So, replace linux/autoconf.h
with linux/config/xxx, where xxx are all the config options which appear
in all of the files used to build the object file (which is what -MD gave
you).

The result is still dependencies which are 100% correct. It's that simple. 
The object file gcc generates depends on the command line and all the 
files it reads during the compile. Why make it more complex?

--Kai


