Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSFJPeS>; Mon, 10 Jun 2002 11:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSFJPeR>; Mon, 10 Jun 2002 11:34:17 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:42926 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315458AbSFJPeQ>; Mon, 10 Jun 2002 11:34:16 -0400
Date: Mon, 10 Jun 2002 10:34:15 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: John Levon <movement@marcelothewonderpenguin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: External compilation
In-Reply-To: <20020610151246.GA13626@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0206101025081.20438-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, John Levon wrote:

> Doesn't work for 2.2. Hopefully I will be able to specify M_OBJS in
> addition.

I think later 2.2 support obj-[ym], though I maybe wrong. It won't hurt to
specify M_OBJS additionally.

> Also, you don't specify O_TARGET ?
> 
> Given :
> 
> TOPDIR=/usr/src/linux
> THISDIR=/tmp/mod
>  
> O_TARGET=lartmod.o
> obj-m := lart.o blah.o
>  
> include $(TOPDIR)/Rules.make
>  
> all:
>         (cd $(TOPDIR) && $(MAKE) SUBDIRS=/tmp/mod modules)

My example was for a single source module. If you have multiple sources,
you can either

	O_TARGET := lartmod.o
	obj-y	 := lart.o blah.o
	obj-m    := $(O_TARGET)

or

	obj-m    := lartmod.o

	lartmod-objs := lart.o blah.o

where the later in 2.4 additionally needs

	list-multi := lartmod.o

and a link rule like

	lartmod.o: $(lartmod-objs)
        	$(LD) -r -o $@ $(lartmod-objs)


> a) default target for Rules.make doesn't do anything useful

The default target (at least in < current 2.5) only builds built-in code.

> b) lartmod.o is never made (how could I convince it to ?)

See first example above.

> c) is this going to work OK for modversions...

Yup.

> d) the above seems to disallow a lart.c forming only part of a final lart.o target

If you only have one source, see my first mail.

> e) there seems something is going horribly wrong :
> 
> moz mod 317 make all
> make: execvp: /usr/src/linux/scripts/pathdown.sh: Permission denied
> ˆ¶@ˆ¶@re/locale/en_US/LC_MESSAGES/make.mo(cd /usr/src/linux && make SUBDIRS=/tmp/mod modules)
> make[1]: Entering directory `/usr/src/linux-2.4.0'

That I suppose is due to the fact that during the "make all" 
$(CONFIG_SHELL) is not set, thus the

	MOD_DESTDIR := $(shell $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)

in Rules.make fails. Try doing the "cd $(TOPDIR) && ..." by hand, it 
should work then.

--Kai


