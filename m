Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTIVK6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 06:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbTIVK6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 06:58:55 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:19335
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263106AbTIVK6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 06:58:52 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: Make modules_install doesn't create /lib/modules/$version
Date: Mon, 22 Sep 2003 06:55:43 -0400
User-Agent: KMail/1.5
Cc: azarah@gentoo.org, linux-kernel@vger.kernel.org, rddunlap@osdl.org,
       rusty@rustcorp.com.au
References: <200309192139.h8JLdaXf012418@harpo.it.uu.se>
In-Reply-To: <200309192139.h8JLdaXf012418@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309220655.43275.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 September 2003 17:39, Mikael Pettersson wrote:
> On Fri, 19 Sep 2003 15:16:23 -0400, Rob Landley <rob@landley.net> wrote:
> >> > So how come it's never been a problem on my RH boxes?
> >> > (Currently RH9 + module-init-tools but none of Arjan's .rpms)
> >> >
> >> > I basically do
> >> > make bzImage modules |& tee /tmp/log
> >> > grep Warning /tmp/log
> >> > su
> >> > make modules_install
> >> > make install
> >> >
> >> > Creating the /lib/modules/<version> directory is the kernel's
> >> > job, not installkernel (it's never done that before).
> >>
> >> Yes, OK, so I have not checked =)  I just reacted on if
> >> installkernel form non RH misbehave or not.
> >
> >The kernel isn't doing it.  A script called from installkernel (in Red Hat
> > 9) calls depmod, which has to be Rusty's new depmod or it doesn't create
> > the directory.  This means depmod is running against the OLD modules.
>
> You're confusing make install with make modules_install. (And
> your initial report which spoke of modules_install was obviously
> a make install since it ran arch/i386/boot/install.sh)

No, I'm not.  make install calls installkernel.  (If installkernel isn't 
there, it runs lilo, which lobotomizes my laptop's grub boot sector.)

> make modules_install _does_ create and populate the modules directory.
> In the top-level Makefile we find:
>
> ...
> MODLIB	:= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> ...
> modules_install: _modinst_ _modinst_post
>
> .PHONY: _modinst_
> _modinst_:
> 	@if [ -z "`$(DEPMOD) -V | grep module-init-tools`" ]; then \
> 		echo "Warning: you may need to install module-init-tools"; \
> 		echo "See http://www.codemonkey.org.uk/post-halloween-2.5.txt";\
> 		sleep 1; \
> 	fi
> 	@rm -rf $(MODLIB)/kernel
> 	@rm -f $(MODLIB)/build
> 	@mkdir -p $(MODLIB)/kernel
> 	@ln -s $(TOPDIR) $(MODLIB)/build
> 	$(Q)$(MAKE) -rR -f scripts/Makefile.modinst
>
> In particular note the mkdir.

I noted the mkdir.  I put an echo in front of the mkdir, which didn't get 
called before it died unless I made the directory myself.  This is what 
happens with -test5-mm4:

[root@dhcppc4 linux-2.6.0-test5]# make install modules_install
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  SKIPPED include/linux/compile.h
Kernel: arch/i386/boot/bzImage is ready
sh /home/landley/linux/linux-2.6.0-test5/arch/i386/boot/install.sh 
2.6.0-test5-mm4 arch/i386/boot/bzImage System.map ""
/lib/modules/2.6.0-test5-mm4 is not a directory.
mkinitrd failed
make[1]: *** [install] Error 1
make: *** [install] Error 2
[root@dhcppc4 linux-2.6.0-test5]#

> make install does invoke /sbin/installkernel if your
> system has one, and that script may expect the /lib/modules/
> directory to exist, but that's not a kernel bug.

I'm using Red Hat 9, which worked fine installing 2.4 series kernels.

> In any event, make modules_install before make install works
> and has always worked for me on RH systems.

You're right:

make modules_install install works.
make install modules_install does not.

Good to know.

> >I've been bitten by this before, by the way.  I switched from an
> > accidental SMP kernel to a UP kernel on my laptop, and the install
> > complained about
>
> rm -f /lib/modules/$KERNELVERSION; make modules_install

That's what I did after I was bitten, yes.

> >unresolved SMP symbols in the modules.  (This is how I got in the habit of
> >doing make modules_install before make install, which I thought might also
> > be responsible for the directory creation problem, but wasn't.  Neither
> > creates the directory: depmod does).
>
> depmod does not create any directories, 'make modules_install' does.

Although make install dies on a red hat 9 system trying to look at the modules 
directory if modules_install isn't done first.  Maybe it's an RH 9 bug.  I 
was actually kind of surprised that we almost do "./configure;make;make 
install" now, yet make install doesn't install modules.  Is there a reason 
make install does NOT install modules for a modular kernel?

Rob
