Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313041AbSDHDyR>; Sun, 7 Apr 2002 23:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313548AbSDHDyQ>; Sun, 7 Apr 2002 23:54:16 -0400
Received: from rj.SGI.COM ([204.94.215.100]:47550 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313041AbSDHDyO>;
	Sun, 7 Apr 2002 23:54:14 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile 
In-Reply-To: Your message of "Sun, 07 Apr 2002 20:51:03 CST."
             <200204080251.g382p3997627@aslan.scsiguy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Apr 2002 13:54:02 +1000
Message-ID: <32231.1018238042@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Apr 2002 20:51:03 -0600, 
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>My complaint is that kbuild mixes module naming convention with source
>file names when they should be separate.  For instance, if RedHat want
>to ship my driver as "aic7xxx_experimental.o", they have to rename files
>instead of make a single line change to the Makefile.

That is a deliberate design decision, the installed module under
/lib/modules has the same name and relative path as the object that is
built in the kernel tree.  Keeping them the same makes it much easier
to debug kernel problems, a module called aic7xxx_experimental.o could
come from anywhere.  If somebody wants to create a new version of an
existing driver while keeping the original name, they have to set up
the new files and the rules accordingly.

>I'm complaining about the install target, not the link or compile targets.
>The user doesn't really care what the latter are so long as they can find
>the module if they build it.

See above.

>>For u320, ensure that the source is u320_core.c (not u320.c) and the
>>conglomerate is u320.o and there will be no problems with the module
>>name.
>
>That convention is already being followed.
>
>The only problem I have now is how to map your changes to aic7xxx/Makefile
>when it has two targets.  What I'd done prior to your mail was:
>
>1) Build each driver independently using AIC7XXX_OBJS and AIC79XX_OBJS and
>   a final LD step.
>2) Add each driver .o to obj-$(CONFIG_SCSI_AIC7XXX) and
>   obj-$(CONFIG_SCSI_AIC79XX) respectively.
>3) Set O_TARGET to aic7xxx_drv.o to handle the case of one or more being
>   configured for static linkage.
>4) Have scsi/Makefile pull in aic7xxx_drv.o as appropriate.
>
>The version of the Makefile you changed is just an edited down copy of
>the above.  Perhaps that explains partially why it was the way it was.
>I'd be more than happy to fix this up some other way, but I don't think
>I can use the obj-y stuff directly as you have proposed in your patch
>once I add the second driver (as soon as we hit Beta which should be
>~two weeks away).

Agreed, this is one of the limitations of kbuild 2.4.  It is relatively
easy to build everything in a directory into a single conglomerate,
that requirement is so common that it is the default case for
Rules.make.

Having multiple conglomerates gets messy, especially if you allow a
mixture of built in and modular selection and if it is possible for
everything to be a module with no built in stubs.  The generic case
looks like this

drivers/scsi/yourdir/Makefile

O_TARGET := dummy.o	# needed to trigger some Rules.make processing
list-multi := module1.o module2.o
module1-objs := obj1a.o obj1b.o ...
module2-objs := obj2a.o obj2b.o ...
obj-$(CONFIG_module1) += module1.o
obj-$(CONFIG_module2) += module2.o
include Rules.make
module1.o: $(module1-objs)
        $(LD) -r -o $@ $<
module2.o: $(module2-objs)
        $(LD) -r -o $@ $<

and in drivers/scsi/Makefile

subdir-y += yourdir
subdir-m += yourdir
ifeq ($(CONFIG_module1),y)
  obj-y += yourdir/module1.o
endif
ifeq ($(CONFIG_module2),y)
  obj-y += yourdir/module2.o
endif

That should handle all combinations of CONFIG_module1=[ymn] and
CONFIG_module2=[ymn].  As long as module1.o and module2.o have no
common sub-objects, i.e. the module1-objs and module2-objs lists have
no duplicates.  If there are common sub-objects then it gets even more
complicated.

Because the above processing for multiple conglomerates is so messy, a
lot of developers use multiple directories, each containing one
conglomerate.  Then you can fall back on the default Rules.make
processing in each directory.

<blatant plug>

BTW, this is _so_ much simpler in kbuild 2.5.  Unlike kbuild 2.4 which
makes one case easy and everything else messy, kbuild 2.5 makes
everything easy.  Single and multiple conglomerates are all handled the
same, even the single case is easier to code in 2.5.

  objlink(module1.o obj1a.o obj1b.o ...)
  objlink(module2.o obj2a.o obj2b.o ...)
  select(CONFIG_module1 module1.o)
  select(CONFIG_module2 module2.o)

and in drivers/scsi/Makefile.in

  link_subdirs(yourdir)

That is it!

</blatant plug>

