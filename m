Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSFWWAK>; Sun, 23 Jun 2002 18:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSFWWAJ>; Sun, 23 Jun 2002 18:00:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:19467 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317148AbSFWWAI>;
	Sun, 23 Jun 2002 18:00:08 -0400
Date: Mon, 24 Jun 2002 00:05:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild fixes and more
Message-ID: <20020624000500.A11471@mars.ravnborg.org>
References: <Pine.LNX.4.44.0206231325280.6241-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206231325280.6241-100000@chaos.physics.uiowa.edu>; from kai-germaschewski@uiowa.edu on Sun, Jun 23, 2002 at 01:39:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2002 at 01:39:51PM -0500, Kai Germaschewski wrote:
> 
> Feedback is very welcome, of course ;)

1) Tried "make clean"
In the end it gave the following result:
make -C arch/i386/lib clean
Cleaning up
/home/sam/src/linux/kernel/bk/local/Rules.make:134: warning: overriding commands for target `clean'
Makefile:168: warning: ignoring old commands for target `clean'

make clean is too verbose now, especially taken KBUILD_VERBOSE= in consideration.

2) While doing a clean build I spotted:
  LD     drivers/char/pcmcia/built-in.o
  LD     drivers/char/built-in.o
rm defkeymap.c
  CC     drivers/ide/device.o
  CC     drivers/ide/ide-taskfile.o
This rm looks wrong to me.
Btw. I did not use -j and on UP.

Second make did the following:
  CP     drivers/char/defkeymap.c
  CC     drivers/char/defkeymap.o
  LD     drivers/char/built-in.o
  LD     drivers/built-in.o
  Generating build number
  ...

Third make completed with success.

3) ChangeSet@1.490.1.62
Within Rules.make in section "Commands useful for boot image"
In the lines
#	target: source(s) FORCE
-#		$(if_changed,ld/objcopy)
+#              $(if_changed,ld/objcopy/gzip)

 
4)  Clean up arch/i386
I miss $(obj) in front of tools/build
zImage: bootsect setup vmlinux.bin tools/build
-	tools/build bootsect setup vmlinux.bin $(ROOT_DEV) > $@
+	$(obj)/tools/build bootsect setup vmlinux.bin $(ROOT_DEV) > $@


bzImage: bbootsect bsetup bvmlinux.bin tools/build
-	tools/build -b bbootsect bsetup bvmlinux.bin $(ROOT_DEV) > $@
+	$(obj)/tools/build -b bbootsect bsetup bvmlinux.bin $(ROOT_DEV) > $@

Reading through the 4 patches I miss $(obj) in many places.
In generally all temporary and final target needs $(obj)

5) jobserver unavailable
I've started too see this when I execute "make -j2":
make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
Dunno if this is my local setup??
It happens even with nothing to do, e.g. a second make without changes in-between.
make -v:
GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.

	Sam

