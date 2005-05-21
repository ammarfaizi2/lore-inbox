Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVEUK7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVEUK7r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 06:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVEUK7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 06:59:47 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:60728 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261730AbVEUK7f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 06:59:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jFZowtC0Q1n/UIFPJcJ4zZq7G3PfL8HTa6bsLyfVVOl1U4hdIjtqDKwtPx/NWkJtdStyUvyWFyRr7KwH7cW2LzUmmXCm05mgZea5AJdUTcftOpeBjgeqlYMSlYtFDH1Yya8jNREzBrwrFmm38U2J3GnilzTz9Qtah9oWQHK0qUs=
Message-ID: <5edf7fc905052103593ea75abf@mail.gmail.com>
Date: Sat, 21 May 2005 16:29:35 +0530
From: Kedar Sovani <kedars@gmail.com>
Reply-To: Kedar Sovani <kedars@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Kbuild trick
In-Reply-To: <20050520193706.GA8225@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <428A661C.1030100@ammasso.com>
	 <20050517201148.GA12997@64m.dyndns.org> <428B4C67.5090307@ammasso.com>
	 <20050518123854.GA13452@64m.dyndns.org> <428B646C.3030501@ammasso.com>
	 <20050518132417.GA14488@64m.dyndns.org> <428B7143.4090607@ammasso.com>
	 <20050518182250.GB8130@mars.ravnborg.org>
	 <428B8809.8060406@ammasso.com>
	 <20050520193706.GA8225@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the question that I haven't yet managed to solve properly is
how do we manage kernel modules which have its C files in multiple
underlying directories.

say :
/src/Makefile
/src/main.c
/src/module1/Makefile
/src/module1/module1.c
/src/module1/module_stuff.c

And the 3 C files should be built into a single module at the top level.
I tried something like this in the top level Makefile, but it does not work.

obj-m += mymodule.o
main-objs=main.o module1/

I could use,
main-objs=main.o module1/module1.o module1/module_stuff.o

But I don't think that is a good idea. I looked at
Documentation/kbuild/, but no luck.

Any suggestions?

Thanks,
Kedar.

On 5/21/05, Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> Hi Timur.
> Some tricks/hints.
> 
> For both kernel 2.4 and 2.6 you can split up your makefile like this:
> makefile <= all the external modules specific part
> Makefile <= the kbuild specific part
> 
> Recent 2.6 kernels looks for a fine named Kbuild before Makefile
> so you can use the file Kbuild for a 2.6 compatible kbuild file, and
> Makefile for a 2.4 compatible kbuild file.
> 
> 
> > # Only if the Config.mk file exists will the next line include it.
> > # (Inside Ammasso, the needed information is derived differently.)
> > ifneq (${wildcard ${SOFTWARE}/../Config.mk},)
> >     include ${SOFTWARE}/../Config.mk
> > endif
> -include does the same
> 
> 
> > # Determine the kernel version.  We only really care about 2.4 vs 2.6, so
> > this
> > # simple code will work with version.h files that have multiple
> > UTS_RELEASEs.
> 
> In the kbuild part of the file you can check for KERNELRELEASE.
> And a lot of what is below ought to be in the kbuild part of the file.
> 
> 
> > # If O= is specified on the make command line, then you must have write
> > # access to KERNEL_SOURCE, otherwise the build will fail.  So we only pass
> > # O= if it is specified in Config.mk.
> O= does not require write access to KERNEL_SOURCE. Thats one one the
> main concpets. KERNEL_SOURCE may be owned by whoever.
> 
> 
> > # Define DO_MUNMAP_API_CHANGE if this kernel uses the version of do_unmap()
> > # that has four parameters instead of just three.
> >
> > ifneq (${shell grep -c -m 1 do_munmap.*acct
> > ${KERNEL_SOURCE}/include/linux/mm.h}, 0)
> >     EXTRA_CFLAGS += -DDO_MUNMAP_API_CHANGE
> > endif
> 
> A macro can simplify this:
> 
> feature = $(if $(shell grep -m 1 $(1) $(srctree)/include/$(2)), $(3))
> 
> Usage:
> EXTRA_CFLAGS += $(call feature, do_munmap.*acct, linux/mm.h, -DDO_MUNMAP_API_CHANGE)
> EXTRA_CFLAGS += $(call feature, remap_page_range.*vm_area_struct, \
>                   linux/mm.h, -DREMAP_API_CHANGE)
> 
> etc..
> 
> >
> >     ifneq (${wildcard /proc/ksyms},)
> >         SYMFILE = /proc/ksyms
> >     else
> >         ifneq (${wildcard /proc/kallsyms},)
> >             SYMFILE = /proc/kallsyms
> >         endif
> >     endif
> This looks wrong. Either you shall check kernel source or running
> kernel.
> But mixing it like this is to call for troubles.
> 
> 
> 
> > # Source files
> >
> > CFILES = \
> >         devnet.c \
> >         ccilnet.c \
> >         devccil.c \
> >         devccil_adapter.c \
> >         devccil_rnic.c \
> >         devccil_mem.c \
> >         devccil_vq.c \
> >         devccil_eh.c \
> >         devccil_cq.c \
> >         devccil_mq.c \
> >         devccil_pd.c \
> >         devccil_srq.c \
> >         devccil_qp.c \
> >         devccil_mm.c \
> >         devccil_ep.c \
> >         devccil_wrappers.c \
> >         devccil_ae.c \
> >         devccil_logging.c
> >
> > COMMON_CFILES   = \
> >               cc_cq_common.c \
> >                 cc_mq_common.c \
> >                 cc_qp_common.c
> >
> In kbuild files the usual pattern is to specify the .o files not the
> source files. So for anyone familiar with kbuild files this looks wrong.
> And be explicit. No reason to hide directories behind the addprefix
> macro below. This is not an obscufating contest.
> > # Fix the paths for the common .c files
> > CFILES += $(addprefix ../../common/, ${COMMON_CFILES})
> 
> > # Generate an assembly listing for each file
> >
> > EXTRA_CFLAGS += -Wa,-aldh=$*.lst
> If needed you can use: make cc_mp_common.lst to let kbuild generate
> them. Dunno if it works for external modules btw.
> 
> >
> >
> > # Linker parameters
> >
> > obj-m := ccil.o
> >
> > ccil-objs := ${CFILES:.c=.o}
> >
> > syscall:
> >       @echo ${SYSCALL_METHOD}
> 
> As you have noticed in another mail - this does not work.
> An untested approch would be to use:
> .PHONY: syscall
> $(obj)/ccil.o: syscall
> 
>         Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
