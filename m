Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbSJCTWG>; Thu, 3 Oct 2002 15:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSJCTWG>; Thu, 3 Oct 2002 15:22:06 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:30219 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261283AbSJCTWF>;
	Thu, 3 Oct 2002 15:22:05 -0400
Date: Thu, 3 Oct 2002 21:26:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003212618.A17403@mars.ravnborg.org>
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
> I'd appreciate to get comments on the appended patch. It's mostly cleanups 
> and the like, but the interesting part is the last cset, which is actually
> fairly small:

Tried out what I pulled from linux-2.5.make

1) warning present in Makefile
2) Annoying /././ when doing make dep
3) Did a ld built-in.o in scripts, despite obj-y is empty
   - When i changed "=" to ":=" to fix next error ar failed.

ifdef O_TARGET replaced with ifdef obj-y to make it work

4) Could not link, no *.o file were used as parameters to ld

cmd_link_o_target := $(if $(strip $(obj-y)),\
                      $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(obj-y), $^),\
                      rm -f $@; $(AR) rcs $@)

$(O_TARGET): $(obj-y) FORCE
        @echo XXXXX $^
        @echo $(obj-y) - $@


Result:
make[1]: Entering directory `/home/sam/src/linux/kernel/bk/kai-make/init'
  Generating /home/sam/src/linux/kernel/bk/kai-make/include/linux/compile.h (unchanged)
XXXXX main.o version.o do_mounts.o FORCE
./main.o ./version.o ./do_mounts.o - built-in.o
   ld -m elf_i386  -r -o  
ld: unrecognized option '-o'
ld: use the --help option for usage information

It seems that make strips "./" in front of all .o files listed in obj-y
Utilising $(filter-out FORCE,$(obj-y) did the trick for me.

[sam@mars kai-make]$ make -v
GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.


Hmmm, was the stuff present at bkbits incomplete?

	Sam
