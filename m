Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261566AbSJCOtl>; Thu, 3 Oct 2002 10:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSJCOtl>; Thu, 3 Oct 2002 10:49:41 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:14225 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263287AbSJCOsh>; Thu, 3 Oct 2002 10:48:37 -0400
Date: Thu, 3 Oct 2002 09:54:00 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Peter Samuelson <peter@cadcamlab.org>
cc: kbuild-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] RfC: Don't cd into subdirs during kbuild
In-Reply-To: <20021003051833.GN1536@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0210030929440.24570-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Peter Samuelson wrote:

> Which top dir, src or obj?  Most end users will expect obj topdir.
> More on that below.

Yes, I think obj topdir is the way to go - and you're right, it can be 
made work mostly with vpath and does not need much more.

> > So gcc/ld/.. are now called from the topdir, allowing to
> > closer resemble a non-recursive build.
> 
> I still think it's more intuitive to have $(obj) == '.', but you do
> make some good arguments in the cset comment.

The most important argument is that a none-recursive make of course cannot 
change dirs, so there it is definitely needed to have the right paths 
relative to the top dir. However, that's not really relevant, since we're 
not doing a none-recursive make (though it's a step into that direction).

> > -	@$(MAKE) -C $(patsubst _sfdep_%, %, $@) fastdep
> > +	@$(call descend,$(patsubst _sfdep_%,%,$@),fastdep)
> >  
> >  else # !CONFIG_MODVERSIONS
> >  
> > @@ -533,7 +526,7 @@
> >  
> >  .PHONY: $(patsubst %, _modinst_%, $(SUBDIRS))
> >  $(patsubst %, _modinst_%, $(SUBDIRS)) :
> > -	@$(MAKE) -C $(patsubst _modinst_%, %, $@) modules_install
> > +	$(descend,$(patsubst _modinst_%,%,$@),modules_install)
> 
> 	$(call descend,
> for consistency.

Duh, I found that during testing. - Looks like I forgot checking in my 
last cset.

> 
> > -fastdep: sub_dirs
> > -	@echo -n
> > +fastdep: $(subdir-ym)
> > +	@/bin/true
> 
> 	@:
> Seriously.  You can assume ':' is built in to your /bin/sh.  If not,
> you've got bigger problems, like perhaps a /bin/sh -> csh link.

Alright, if you're sure about this, send me a patch (later).

> Yeah, I always felt this was "too clever for its own good".  Same
> category as fs/smbfs/proto.h...
> 
> >  $(obj)/devlist.h: $(src)/pci.ids $(obj)/gen-devlist
> > -	$(obj)/gen-devlist < $<
> > +	( cd $(obj); ./gen-devlist ) < $<
> 
> 	cd $(obj); ./gen-devlist < $<
> 
> No need for parentheses - $(src) is an absolute path.

No, $(src) is a relative path - I really don't want to use an absolute 
path anywhere anymore.

> Really gen-devlist should output to stdout instead of a fixed file.

That's what I was thinking, but actually it generates two files at a time, 
so that wouldn't quite work.

> >  lxdialog:
> > -	$(MAKE) -C lxdialog all
> > +	$(call descend,lxdialog,)
> 
> 	$(call descend,scripts/lxdialog,)
> I didn't actually test this but isn't $(descend) relative to
> $(TOPDIR)?  At least in your later changeset.

You're right. Fixed.

> > diff -Nru a/drivers/isdn/i4l/isdn_ppp.h b/drivers/isdn/i4l/isdn_ppp.h
> > --- a/drivers/isdn/i4l/isdn_ppp.h	Wed Oct  2 21:52:06 2002
> > +++ b/drivers/isdn/i4l/isdn_ppp.h	Wed Oct  2 21:52:06 2002
> > @@ -27,7 +27,7 @@
> >  #else
> >  
> >  static inline int
> > -isdn_ppp_xmit(struct sk_buff *, struct net_device *);
> > +isdn_ppp_xmit(struct sk_buff *, struct net_device *)
> 
> Obviously correct, but was that supposed to be part of your changeset?
> I suppose it relates to "kbuild" in that "I can't compile my
> kernel". (:

Grrh. That happens to me all the time...

> > +# Add subdir path
> > +
> > +EXTRA_TARGETS	:= $(addprefix $(obj)/,$(EXTRA_TARGETS))
> > +obj-y		:= $(addprefix $(obj)/,$(obj-y))
> > +obj-m		:= $(addprefix $(obj)/,$(obj-m))
> > +export-objs	:= $(addprefix $(obj)/,$(export-objs))
> > +subdir-obj-y	:= $(addprefix $(obj)/,$(subdir-obj-y))
> > +real-objs-y	:= $(addprefix $(obj)/,$(real-objs-y))
> > +real-objs-m	:= $(addprefix $(obj)/,$(real-objs-m))
> > +multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
> > +multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
> > +multi-objs-y	:= $(addprefix $(obj)/,$(multi-objs-y))
> > +multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
> > +subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
> 
> add_obj_prefix = $1 := $(addprefix $(obj)/,$($1))
> $(call add_obj_prefix EXTRA_TARGETS)

I don't think that works - make is not always pretty, that's life.

> Hey, why not make life exciting.  Don't ifndef the O_TARGET.  Just
> break the existing O_TARGET users.

I added a $(warning ) for this case somewhere above. I'll break it 
eventually ;)

>    ACPI_CFLAGS	:= -D_LINUX -I$(src)/include
> 
> or do you require '.' to be source TOPDIR?  If so, this is the
> opposite of what most projects do.  Normally the user expects to build
> from the top of $(obj).  Why not do the same here, even if it's a bit
> more work?

I'm planning on doing the same. I think for $(src) != $(obj), I'll do
a $(patsubst -I%,-I% -I$(src)/%) on the [AC]FLAGS. (BTW, in this case, of
course $(src) would probably be an absolute path). We also have generated 
files which need to be included, so we basically need both $(src) and 
$(obj) in the include path.

> > -EXTRA_CFLAGS += -I. ${MPT_CFLAGS}
> > +EXTRA_CFLAGS += ${MPT_CFLAGS}
> 
> So can we assume -I$(src) is always part of the cflags?

I think (need to check), gcc automatically seaches the path of the source 
for includes. If not we'll have to add it.

Anyway, the case above worked fine without the -I.

> > +++ b/drivers/net/sk98lin/Makefile	Wed Oct  2 21:52:10 2002
> > @@ -55,7 +55,7 @@
> >  # SK_DBGCAT_DRV_INT_SRC         0x04000000      interrupts sources
> >  # SK_DBGCAT_DRV_EVENT           0x08000000      driver events
> >  
> > -EXTRA_CFLAGS += -I. -DSK_USE_CSUM $(DBGDEF)
> > +EXTRA_CFLAGS += -Idrivers/net/sk98lin -DSK_USE_CSUM $(DBGDEF)
> 
> ...because if so, this isn't needed.

In this case someones including "h/header.h", and this did not work 
without the -I.

Well, you see, some issues still need tackling for $(src) != $(obj), but
that's not what I was aiming for with this patch, anyway.

--Kai

