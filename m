Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTISVjz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 17:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbTISVjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 17:39:54 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:36240 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261724AbTISVjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 17:39:52 -0400
Date: Fri, 19 Sep 2003 23:39:36 +0200 (MEST)
Message-Id: <200309192139.h8JLdaXf012418@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: rob@landley.net
Subject: Re: Make modules_install doesn't create /lib/modules/$version
Cc: azarah@gentoo.org, linux-kernel@vger.kernel.org, rddunlap@osdl.org,
       rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Sep 2003 15:16:23 -0400, Rob Landley <rob@landley.net> wrote:
>> > So how come it's never been a problem on my RH boxes?
>> > (Currently RH9 + module-init-tools but none of Arjan's .rpms)
>> >
>> > I basically do
>> > make bzImage modules |& tee /tmp/log
>> > grep Warning /tmp/log
>> > su
>> > make modules_install
>> > make install
>> >
>> > Creating the /lib/modules/<version> directory is the kernel's
>> > job, not installkernel (it's never done that before).
>>
>> Yes, OK, so I have not checked =)  I just reacted on if
>> installkernel form non RH misbehave or not.
>
>The kernel isn't doing it.  A script called from installkernel (in Red Hat 9) 
>calls depmod, which has to be Rusty's new depmod or it doesn't create the 
>directory.  This means depmod is running against the OLD modules.

You're confusing make install with make modules_install. (And
your initial report which spoke of modules_install was obviously
a make install since it ran arch/i386/boot/install.sh)

make modules_install _does_ create and populate the modules directory.
In the top-level Makefile we find:

...
MODLIB	:= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
...
modules_install: _modinst_ _modinst_post

.PHONY: _modinst_
_modinst_:
	@if [ -z "`$(DEPMOD) -V | grep module-init-tools`" ]; then \
		echo "Warning: you may need to install module-init-tools"; \
		echo "See http://www.codemonkey.org.uk/post-halloween-2.5.txt";\
		sleep 1; \
	fi
	@rm -rf $(MODLIB)/kernel
	@rm -f $(MODLIB)/build
	@mkdir -p $(MODLIB)/kernel
	@ln -s $(TOPDIR) $(MODLIB)/build
	$(Q)$(MAKE) -rR -f scripts/Makefile.modinst

In particular note the mkdir.

make install does invoke /sbin/installkernel if your
system has one, and that script may expect the /lib/modules/
directory to exist, but that's not a kernel bug.

In any event, make modules_install before make install works
and has always worked for me on RH systems.

>I've been bitten by this before, by the way.  I switched from an accidental 
>SMP kernel to a UP kernel on my laptop, and the install complained about 

rm -f /lib/modules/$KERNELVERSION; make modules_install

>unresolved SMP symbols in the modules.  (This is how I got in the habit of 
>doing make modules_install before make install, which I thought might also be 
>responsible for the directory creation problem, but wasn't.  Neither creates 
>the directory: depmod does).

depmod does not create any directories, 'make modules_install' does.
