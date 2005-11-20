Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVKTSj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVKTSj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 13:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVKTSj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 13:39:26 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:45319 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1750896AbVKTSjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 13:39:25 -0500
From: James Cloos <cloos@jhcloos.com>
To: linux-kernel@vger.kernel.org
Subject: make kernelrelease ignoring LOCALVERSION_AUTO
Copyright: Copyright 2005 James Cloos
X-Hashcash: 1:23:051120:linux-kernel@vger.kernel.org::opWt3RSlc1Wnu4xT:000000000000000000000000000000001DP+g
Date: Sun, 20 Nov 2005 13:39:00 -0500
Message-ID: <m3acfz88qj.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use $(make kernelrelease) in my kernel install script to get the
version string for the filenames in /boot and the grub menu items.

The partial hash string CONFIG_LOCALVERSION_AUTO=y adds is no longer
showing up in the version kernelrelease echos, although it does show
up in the version string used by $(make modules_install).

I even added an @echo $MODLIB to the kernelrelease rule and got only:

,----
| :; make kernelrelease
| 2.6.15-rc2-lug2
| /lib/modules/2.6.15-rc2-lug2
`----

whereas modules_install shows this:

,----
| :; make -n modules_install
| if [ -z "`/sbin/depmod -V 2>/dev/null | grep module-init-tools`" ]; then \
|         echo "Warning: you may need to install module-init-tools"; \
|         echo "See http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt";\
|         sleep 1; \
| fi
| rm -rf /lib/modules/2.6.15-rc2-lug2-g3bedff1d/kernel
| rm -f /lib/modules/2.6.15-rc2-lug2-g3bedff1d/source
| mkdir -p /lib/modules/2.6.15-rc2-lug2-g3bedff1d/kernel
| ln -s /usr/src/linux-2.6-git /lib/modules/2.6.15-rc2-lug2-g3bedff1d/source
| if [ ! /usr/src/linux-2.6-git -ef  /lib/modules/2.6.15-rc2-lug2-g3bedff1d/build ]; then \
|         rm -f /lib/modules/2.6.15-rc2-lug2-g3bedff1d/build ; \
|         ln -s /usr/src/linux-2.6-git /lib/modules/2.6.15-rc2-lug2-g3bedff1d/build ; \
| fi
| : etc, usw, and so on
`----

So I added the lines:

	@echo kernelreleae is $(KERNELRELEASE)
	@echo modlib is $(MODLIB)

to _modinst_: and got this:

,----
| :; make -n modules_install 2>&1 |head
| echo kernelreleae is 2.6.15-rc2-lug2-g3bedff1d
| echo modlib is /lib/modules/2.6.15-rc2-lug2-g3bedff1d
| if [ -z "`/sbin/depmod -V 2>/dev/null | grep module-init-tools`" ]; then \
|         echo "Warning: you may need to install module-init-tools"; \
|         echo "See http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt";\
|         sleep 1; \
| fi
| rm -rf /lib/modules/2.6.15-rc2-lug2-g3bedff1d/kernel
| rm -f /lib/modules/2.6.15-rc2-lug2-g3bedff1d/source
| mkdir -p /lib/modules/2.6.15-rc2-lug2-g3bedff1d/kernel
`----

So $KERNELRELEASE is /different/ depending on which target is being made.

My laptop is quite slow doing anything disk-intensive, such as git, so
it'll take some time before I can bisect down to a single commit --
especially if a full compile will be required to confirm whether it
works correctly -- but I do know that it is between g9f75e1ef... and
gee90f62b... if anyone with faster hardware cares to try.

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
