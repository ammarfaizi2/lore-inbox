Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbSJCT4j>; Thu, 3 Oct 2002 15:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSJCT4j>; Thu, 3 Oct 2002 15:56:39 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:44298 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261308AbSJCT4i>;
	Thu, 3 Oct 2002 15:56:38 -0400
Date: Thu, 3 Oct 2002 22:01:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003220120.B17403@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>; from kai-germaschewski@uiowa.edu on Wed, Oct 02, 2002 at 09:59:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 09:59:00PM -0500, Kai Germaschewski wrote:
> 
> Hi,
> 
> I'd appreciate to get comments on the appended patch.

> -obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
> +obj-y := dsfield.o   dsmthdat.o  dsopcode.o  dswexec.o  dswscope.o \
> +	 dsmethod.o  dsobject.o  dsutils.o   dswload.o  dswstate.o

Should that have been:
obj-$(CONFIG_ACPI_INTERPRETER) := dsfield.o   dsmthdat.o  dsopcode.o...

Looks wrong to me that you remove the CONFIG_ dependency.
Same is true for the rest of this cset.

> +ifdef list-multi
> +$(warning kbuild: list-multi ($(list-multi)) is obsolete in 2.5. Please fix!)
> +endif
Since kbuild no longer support list-multi this should be $(error ....)

> -multi-used-y := $(filter-out $(list-multi),$(__multi-used-y))
Here is list-multi removed.


>  SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m)))
I prefer first assignment to be := not +=
This is true for several places including several makefiles as well.


> -export CPPFLAGS EXPORT_FLAGS NOSTDINC_FLAGS OBJCOPYFLAGS
> +export CPPFLAGS EXPORT_FLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
Did not see this change justified.

> -export	NETWORKS DRIVERS LIBS HEAD LDFLAGS MAKEBOOT
> +$(warning $(SUBDIRS))

Warning shall be deleted

>  ifndef O_TARGET
>  ifndef L_TARGET
> -O_TARGET := built-in.o
> +O_TARGET := $(obj)/built-in.o
> +endif
>  endif
This change result in ld being called for directories like:
$(TOPDIR)/scripts
$(TOPDIR)/scripts/lxdialog
$(TOPDIR)/Documentation/DocBook
If obj-y is empty then do not define O_TARGET?

Another more general comment.
There seem to no consistency in the variables used in the first section of
the makefile. There is a mixture of lower and upper case variables:
O_TARGET, host-progs etc. This is confusing.
Furthermore the construct:
obj-y := some.o dot.o .o module.o
Seems illogical to me. What does obj-y mean to me??
mandatory-objs := some.o dot.o .o module.o
It a litte longer, but occur only once (typical) per makefile.
Thats not something I propose for now, more to be seen as a general comment
about striving for consistency in the interface to rules.make.

>  
>  first_rule: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
Where comes the requirement that EXTRA_TARGETS needs to be buildin?

> -cmd_link_multi = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $($(basename $@)-objs),$^)
> +cmd_link_multi = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.o=-objs)))),$^)
Keep a variable without obj appended would make this readable I think.

Now it's testing time..

	Sam
