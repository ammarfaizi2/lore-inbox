Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSJCUkZ>; Thu, 3 Oct 2002 16:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbSJCUkZ>; Thu, 3 Oct 2002 16:40:25 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:26131 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261395AbSJCUkX>;
	Thu, 3 Oct 2002 16:40:23 -0400
Date: Thu, 3 Oct 2002 22:44:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003224444.A1411@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20021003220120.B17403@mars.ravnborg.org> <Pine.LNX.4.44.0210031505510.24570-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210031505510.24570-100000@chaos.physics.uiowa.edu>; from kai-germaschewski@uiowa.edu on Thu, Oct 03, 2002 at 03:19:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 03:19:57PM -0500, Kai Germaschewski wrote:
> > Furthermore the construct:
> > obj-y := some.o dot.o .o module.o
> > Seems illogical to me. What does obj-y mean to me??
> > mandatory-objs := some.o dot.o .o module.o
> 
> No, I think once you've understood obj-$(CONFIG_FOO), the meaning
> of obj-y is perfectly clear. Giving multiple names to the samt thing is 
> not good, next thing would be people wondering what the difference
> between obj-y and mandatory-objs is.

I disagree here. To me it looks like obj-y is a misuse of the
obj-$(CONFIG_XXX) rule.
It looks much more intuitive to have a separate rule. But common practice
today differ so it should stay.
Another argument is that we should keep the way to express things down
only one way.

> Initially, it was for built-in targets in addition to the standard 
> O_TARGET, like arch/i386/kernel/head.o.
> I've been abusing it for scripts/, and I shouldn't be doing that.

You used EXTRA_TARGETS to make sure host-progs programs got compiled.
In general the way to use host-progs is not nice.

Typical usage:

host-progs := gentbl
include $(TOPDIR)/Rules.make
%tbl: %data: $(obj)/somefile.data $(obj)/gentbl
	gentbl $< $@

In other words you need to make an explicit prerequisite to the host-progs
to get it build, which is what you did with EXTRA_TARGETS.

I would advocate for another solution:
Let programs listed in host-progs be compiled always.
Then the makefile could assign host-progs conditionally instead.
find -name Makefile | xargs grep host-progs | wc -l
12

A doable task, that I'm ready to do.


We could also define 
force-host-progs :=
or something similar.


> 
> > > -cmd_link_multi = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $($(basename $@)-objs),$^)
> > > +cmd_link_multi = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.o=-objs)))),$^)
> > Keep a variable without obj appended would make this readable I think.
> 
> I agree that it is not particularly readable, but I'm limited to what make 
> offers. What do you suggest?

Untested:
$(notdir $(@:.o=-objs))

	Sam

