Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRDFMoM>; Fri, 6 Apr 2001 08:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRDFMoC>; Fri, 6 Apr 2001 08:44:02 -0400
Received: from mail.axisinc.com ([193.13.178.2]:37897 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S131579AbRDFMnr>;
	Fri, 6 Apr 2001 08:43:47 -0400
Message-ID: <1b5601c0be96$bf159b50$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: <cate@debian.org>, "Johan Adolfsson" <johan.adolfsson@axis.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.ggqkpgv.9g0c0b@ifi.uio.no> <fa.k6fq96v.nhaq06@ifi.uio.no> <3ACD68FF.637D8958@math.ethz.ch> <018001c0be69$90dcb200$9db270d5@homeip.net> <3ACD73E0.2B1DFF6F@math.ethz.ch> <19da01c0be78$f9106c90$0a070d0a@axis.se> <3ACD8ECC.F2518B90@math.ethz.c <3ACDA9CB.583241B6@math.ethz.ch>
Subject: Re: Arch specific/multiple Configure.help files? [PATCH included]
Date: Fri, 6 Apr 2001 14:40:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: Giacomo Catenazzi <cate@math.ethz.ch>
To: Johan Adolfsson <johana@axis.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, April 06, 2001 13:34
Subject: Re: Arch specific/multiple Configure.help files? [PATCH included]


> Johan Adolfsson wrote:
> >
> > > This change is too big for 2.4 kernel.
> >
> > It doesnt look that big to mee, so here it is for everyones
consideration
> > (the mailprogram probably screws up tabs etc. but you get the idea,
> > I apologise if posting patches like this is the wrong way)
> >
> > The normal user/developer shouldn't even notice the difference,
> > the patch shouldn't break anything, just make it possible to
> > use multiple help files.
> >
> > linux/Makefile: (linenumber probably a bit off)
> > @@ -40,6 +44,10 @@ MODFLAGS = -DMODULE
> >  CFLAGS_KERNEL =
> >  PERL = perl
> >
> > +# Helpfiles used in the config system
> > +# (merged to Documentation/Configure.help.generated)
> > +HELPFILES       = arch/$(ARCH)/Configure.help
Documentation/Configure.help
> > +
> >  export VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
> >   CONFIG_SHELL TOPDIR HPATH HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
> >   CPP AR NM STRIP OBJCOPY OBJDUMP MAKE MAKEFILES GENKSYMS MODFLAGS PERL
> > @@ -260,19 +270,22 @@ symlinks:
> >   @if [ ! -d include/linux/modules ]; then \
> >   mkdir include/linux/modules; \
> >   fi
> > +
> > +helpfiles:
> > + -cat $(HELPFILES) >Documentation/Configure.help.generated 2>/dev/null
> >
> > -oldconfig: symlinks
> > +oldconfig: symlinks helpfiles
>
> No!
> Documentation/Configure.help.generated: $(HELPFILES)
> -cat $(HELPFILES) >Documentation/Configure.help.generated
> 2>/dev/null
>
> oldconfig: symlinks Documentation/Configure.help.generated
> ...
>
> Really you should include the ARCH/COnfigure.help in
> $(HELPFILES) only
> if it exists (else make will complain)

That's why I had the -cat and the 2>/dev/null
and not dependencies to them :-)

I'm not a Makefile wizard but the following seems to work,
but it might skip the generation of Configure.help.generated
if you change ARCH and happen to have an old help file
in the arch directory, so I'm not so sure it really is a good idea.
It's safer to generate the file everytime, it doesn't cost much
in time compared to the gerenetion of the configure scripts.


+ # Helpfiles used in the config system
+ # (merged to Documentation/Configure.help.generated)
+ # Add arch specific help if it exists:
+ ifeq (arch/${ARCH}/Configure.help,$(wildcard arch/${ARCH}/Configure.help))
+ HELPFILES       = arch/$(ARCH)/Configure.help
+ else
+ HELPFILES       =
+ endif
+ # Always use good old Documentation/Configure.help:
+ HELPFILES       += Documentation/Configure.help


+ Documentation/Configure.help.generated: $(HELPFILES)
+  cat $(HELPFILES) >Documentation/Configure.help.generated



> >   $(CONFIG_SHELL) scripts/Configure -d arch/$(ARCH)/config.in
> >
> > -xconfig: symlinks
> > +xconfig: symlinks helpfiles
> >   $(MAKE) -C scripts kconfig.tk
> >   wish -f scripts/kconfig.tk
> >
> > -menuconfig: include/linux/version.h symlinks
> > +menuconfig: include/linux/version.h symlinks helpfiles
> >   $(MAKE) -C scripts/lxdialog all
> >   $(CONFIG_SHELL) scripts/Menuconfig arch/$(ARCH)/config.in
> >
> > -config: symlinks
> > +config: symlinks helpfiles
> >   $(CONFIG_SHELL) scripts/Configure arch/$(ARCH)/config.in
> >
>
> ditto.
>
> >  include/config/MARKER: scripts/split-include include/linux/autoconf.h
> >
> > RCS file: /n/cvsroot/os/linux/scripts/Configure,v
> > retrieving revision 1.1.1.2
> > diff -u -p -r1.1.1.2 Configure
> > --- scripts/Configure 2001/01/10 13:28:58 1.1.1.2
> > +++ scripts/Configure 2001/04/06 09:57:44
>
> OK!

Does this meen you think this suggestion is ok?

/Johan


