Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSJCUOg>; Thu, 3 Oct 2002 16:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSJCUOg>; Thu, 3 Oct 2002 16:14:36 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:50322 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261242AbSJCUOe>; Thu, 3 Oct 2002 16:14:34 -0400
Date: Thu, 3 Oct 2002 15:19:57 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: kbuild-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: RfC: Don't cd into subdirs during kbuild
In-Reply-To: <20021003220120.B17403@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0210031505510.24570-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Sam Ravnborg wrote:

> > -obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
> > +obj-y := dsfield.o   dsmthdat.o  dsopcode.o  dswexec.o  dswscope.o \
> > +	 dsmethod.o  dsobject.o  dsutils.o   dswload.o  dswstate.o
> 
> Should that have been:
> obj-$(CONFIG_ACPI_INTERPRETER) := dsfield.o   dsmthdat.o  dsopcode.o...
> 
> Looks wrong to me that you remove the CONFIG_ dependency.
> Same is true for the rest of this cset.

No, that's fine. We only enter this subdirectory if 
CONFIG_ACPI_INTERPRETER is set, so we do not need to repeat the variable 
here. A lot of places rely on this behavior to persist, so why not use it?

> > +ifdef list-multi
> > +$(warning kbuild: list-multi ($(list-multi)) is obsolete in 2.5. Please fix!)
> > +endif
> Since kbuild no longer support list-multi this should be $(error ....)

Well, since it will still work fine (throwing an additional warning 
later on), I think a warning is okay here. I should have made the O_TARGET
one an error now, though, since that stopped working. Anyway,
I'll make both of them an error in a little bit, so...

> >  SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m)))
> I prefer first assignment to be := not +=
> This is true for several places including several makefiles as well.

Well, really mostly a matter of taste. Using += everywhere has the 
advantage that you can add another line before that line without changing 
out. Kinda the same thing as adding a comma after the last element of a 
struct / enum.

> > -export CPPFLAGS EXPORT_FLAGS NOSTDINC_FLAGS OBJCOPYFLAGS
> > +export CPPFLAGS EXPORT_FLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
> Did not see this change justified.

The export LDFLAGS just moved to a place where it's more logical.

> > -export	NETWORKS DRIVERS LIBS HEAD LDFLAGS MAKEBOOT
> > +$(warning $(SUBDIRS))
> 
> Warning shall be deleted

Right. I overlooked it first, but it's deleted in a later cset.

> >  ifndef O_TARGET
> >  ifndef L_TARGET
> > -O_TARGET := built-in.o
> > +O_TARGET := $(obj)/built-in.o
> > +endif
> >  endif
> This change result in ld being called for directories like:
> $(TOPDIR)/scripts
> $(TOPDIR)/scripts/lxdialog
> $(TOPDIR)/Documentation/DocBook
> If obj-y is empty then do not define O_TARGET?

Well, it's rather that I used EXTRA_TARGETS in those subdirs now. You're 
right that the standard rules do not apply in those dirs, so I'll think
of a way to fix it there. Not defining O_TARGET when obj-y is empty is not 
an option, we rely on that case working elsewhere.

> Another more general comment.
> There seem to no consistency in the variables used in the first section of
> the makefile. There is a mixture of lower and upper case variables:
> O_TARGET, host-progs etc. This is confusing.

Well, the whole thing is moving away from capitalized letters (in 
particular in the per-subdir Makefiles), as it is moving from old-style
to new-style. The only common variables which are capitalized are
CFLAGS, CC and the like, and I think they'll stay since that's standard 
make. kbuild-specific variables should really be basically all lower-case 
by now, I can only think of L_TARGET as an exception.

> Furthermore the construct:
> obj-y := some.o dot.o .o module.o
> Seems illogical to me. What does obj-y mean to me??
> mandatory-objs := some.o dot.o .o module.o

No, I think once you've understood obj-$(CONFIG_FOO), the meaning
of obj-y is perfectly clear. Giving multiple names to the samt thing is 
not good, next thing would be people wondering what the difference
between obj-y and mandatory-objs is.

> >  first_rule: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
> Where comes the requirement that EXTRA_TARGETS needs to be buildin?

Initially, it was for built-in targets in addition to the standard 
O_TARGET, like arch/i386/kernel/head.o.
I've been abusing it for scripts/, and I shouldn't be doing that.

> > -cmd_link_multi = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $($(basename $@)-objs),$^)
> > +cmd_link_multi = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.o=-objs)))),$^)
> Keep a variable without obj appended would make this readable I think.

I agree that it is not particularly readable, but I'm limited to what make 
offers. What do you suggest?

--Kai


