Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWAFHUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWAFHUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWAFHUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:20:30 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:52558 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932614AbWAFHU3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:20:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mf96MFNjXpbYf2FXvieLNxooeaXvWyqFNzXCv8+cyXQqDNfTQ3q2Tb4zlOx77bCHrNQxvz6TYCExfsh6vu2VzFZyt3J0k06p4Wkv5nT0G3J7y8I71Hp20lSod8DtWEEp7eYMrau2Fv1D+vEXjAj6GhQGXqP2GMLriU5sMkhYXJI=
Message-ID: <f0309ff0601052320g76bea0afg61322551f57c6d38@mail.gmail.com>
Date: Thu, 5 Jan 2006 23:20:29 -0800
From: Nauman Tahir <nauman.tahir@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: makefile for 2.6 kernel
Cc: anil dahiya <ak_ait@yahoo.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
In-Reply-To: <20060104185524.GA8296@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060104182356.14925.qmail@web60217.mail.yahoo.com>
	 <20060104185524.GA8296@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jan 04, 2006 at 10:23:56AM -0800, anil dahiya wrote:
> > hello
> > I want to make kernel module dummy.ko using multiple
> > .c and .h files. In short i am telling .c and .h files
> > with directory structure
> >
> > 1> dummy.ko should made be using module1.ko and
> > module2.o (i.e
> >    module2.o uses module1.ko to make dummy.ko)
>
> You cannot make a module with a module as input.
> It does not make sense.
> Either you create a module or you don't.
>
> So you will create following modules:
> module1.ko + module2.ko
>
> Alternatively you create one module but using the individual .o files as
> input which is more likely what you want - correct?
>
> Then your Kbuild file would look like this:
>
> Kbuild:
> obj-m := dummy.o
> dummy-y := module1/a1/a1.o
> dummy-y += module1/a2/a2.o
> dummy-y += module2/b1/b1.o
>
> # Tell where to find .h files
> EXTRA_CFLAGS := -I$(src)/include
>
> And to compile your module:
> make -C $PATH_TO_KERNEL_SRC M=`pwd`
>
>
> I assume you already read Documentation/kbuild/modules.txt - otherwise
> please do so too.
>
> Please include the source or provide an URL to the src if you need more
> help.
>
>         Sam
>
>
>
> >
> > 2> module1.ko made using a1/a1.c & a2/a2.c and  both
> > .c file
> >    use /home/include/a.h
> > 3> module2.o should made using b/b1.c which use
> >    use /home/module2/include/b.h
> >
> > Suggest me tht should make i make module2.o or
> > module2.ko and then combine it with module1.o to make
> > dummy.ko
> >
> >
> > /home/------
> >              |_ include _
> >              |           |
> >              |           a.h
> >              |
> >              |___module1_
> >              |           |__ a1 ____
> >              |           |          |
> >              |           |         a1.c
> >              |           |
> >                          |__ a2 ____
> >              |           |           |
> >              |           |         a2.c
> >              |
> >              |___ moudule2_
> >              |             |
> >              |             |__include _
> >              |             |           |
> >              |             |           b.h
> >              |             |___b1__
> >              |                     |
> >              |                   b1.c
> >
> >
> > Looking forward for ur reply
> > thanks in advance
> > ---- Anil
> >

hi,
Anil just put the names of your .c  files where I have mentioned. Hope
this will work


#START OF MAKEFILE===========================================


TARGET = [Your Driver Name]
OBJS = [Your Driver Name (same as above)].o
MDIR = drivers/misc

EXTRA_CFLAGS = -DEXPORT_SYMTAB

CURRENT = $(shell uname -r)
KDIR = /lib/modules/$(CURRENT)/build
PWD = $(shell pwd)
DEST = /lib/modules/$(CURRENT)/kernel/$(MDIR)

obj-m := $(TARGET).o

$(TARGET)-objs := [Names of your .c files with .o extension] [for
example file1.o file2.o               ETC]

default:
	make -C $(KDIR) SUBDIRS=$(PWD) modules

$(TARGET).o: $(OBJS)
	$(LD) $(LD_RFLAG) -r -o $@ $(OBJS)

ifneq (,$(findstring 2.4.,$(CURRENT)))
install:
	su -c "cp -v $(TARGET).o $(DEST) && /sbin/depmod -a"
else
install:
	su -c "cp -v $(TARGET).ko $(DEST) && /sbin/depmod -a"
endif

clean:
	-rm -f *.o *.ko .*.cmd .*.flags *.mod.c

-include $(KDIR)/Rules.make


# END OF MAKEFILE========================================





> >
> >
> > __________________________________________
> > Yahoo! DSL ? Something to write home about.
> > Just $16.99/mo. or less.
> > dsl.yahoo.com
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
