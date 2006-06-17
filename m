Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWFQSVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWFQSVw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWFQSVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:21:52 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:16736 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750765AbWFQSVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:21:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=LVEMnVzNp91kKSEGK4oHdDp0KU63mvJoXmWzvtetvfoNpCYk70N/Y5omPb5QS+tcBLtdfUJcWuJGF2quQ++23y8kO5Et2IfeCgOXGdoG1u43Qq3Xfxd4A/c0gaS+vsjx85wsTRGtSoif+jGLDrLiOfRLz6nZDE2XJaPiKuadbqQ=
Message-ID: <4494483C.4020205@gmail.com>
Date: Sat, 17 Jun 2006 12:21:48 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 00/20] chardev: GPIO for SCx200 & PC8736x: Intro
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO SUPPORT FOR SCx200 & PC8736x

The patch-set reworks the 2.4 vintage scx200_gpio driver for modern
2.6, and refactors GPIO support to reuse it in a new driver for the
GPIO on PC-8736x chips.  Its handy for the Soekris.com net-4801, which
has both chips.

These patches have been seen recently on Kernel-Mentors, and then
Kernel-Newbies ML, where Jesper Juhl kindly reviewed it.  His feedback
has been incorporated.  Thanks Jesper !

Its also gone to soekris-tech@soekris.com for possible testing by
linux folks, Ive gotten 1 promise so far.  Theyre mostly BSD folk over 
there,
but we'll see..


Device-file & Sysfs

The driver preserves the existing device-file interface, including the
write/cmd set, but adds v to 'view' the pin-settings & configs by
inducing, via gpio_dump(), a dev_info() call.  Its a fairly crappy way
to get status, but it sticks to the syslog approach, conservatively.

Allowing users to voluntarily trigger logging is good, it gives them a
familiar way to confirm their app's control & use of the pins, and Ive
thus reduced the pin-mode-updates from dev_info to dev_dbg.

Ive recently bolted on a proto sysfs interface for both new drivers.
Im not including those patches here; they (the patch + doc-pre-patch) are
still quite raw (and unreviewed on KNML), and since they 'invent' a
convention for GPIO, a proper vetting is needed.  Since this patchset
is much bigger than my previous ones, Id like to keep things simpler,
and address it 1st, before bolting on more stuff.

(Um. dumbass cant count, so to prevent 'missing patch' feedback,
is just sending the sysfs-gpio patch as 20th patch :-/, please be gentle)


The driver-split

The Geode CPU and the PC-87366 Super-IO chip have GPIO units which
share a common pin-architecture (same pin features, with same bits
controlling), but with different addressing mechanics and port
organizations.

The vintage driver expresses the pin capabilities with pin-mode
commands [OoPpTt],etc that change the pin configurations, and since
the 2 chips share pin-arch, we can reuse the read(), write() commands,
once the implementation is suitably adjusted.


The patchset adds a vtable: struct nsc_gpio_ops, to abstract the
existing gpio operations, then adjusts fileops.write() code to invoke
operations via that vtable.  Driver specific open()s set private_data
to the vtable so its available for use by write().

The vtable gets the gpio_dump() too, since its user-friendly, and
(could be construed as) part of the current device-file interface.  To
support use of dev_dbg() in write() & _dump(), the vtable gets a dev
ptr too, set by both scx200 & pc8736x _gpio drivers.

heres how the pins are presented in syslog:

[ 1890.176223]  scx200_gpio.0: io00: 0x0044 TS OD PUE  EDGE LO DEBOUNCE
[ 1890.287223]  scx200_gpio.0: io01: 0x0003 OE PP PUD  EDGE LO

nsc_gpio.c: new file is new home of several file-ops methods, which
are modified to get their vtable from filp->private_data, and use it
where needed.

scx200_gpio.c: keeps some of its existing gpio routines, but now wires
them up via the vtable (they're invoked by nsc_gpio.c:nsc_gpio_write()
thru this vtable).  A driver-spcific open() initializes
filp->private_data with the vtable.

Once the split is clean, and the scx200_gpio driver is working, we
copy and modify the function and variable names, and rework the
access-method bodies for the different addressing scheme.



Heres a working overview of the patchset:

# series file for GPIO

# Spring Cleaning
gpio-scx/patch.preclean        # scripts/Lindent fixes, editor-ctrl comments

# API Modernization

gpio-scx/patch.api26        # what I learned from LDD3
gpio-scx/patch.platform-dev-2    # get pdev, support for dev_dbg()
gpio-scx/patch.unsigned-minor    # fix to match std practice

# Debuggability

gpio-scx/patch.dump-diet    # shrink gpio_dump()
gpio-scx/patch.viewpins        # add new 'command' to call dump()
gpio-scx/patch.init-refactor    # pull shadow-register init to sub

# Access-Abstraction (add vtable)

gpio-scx/patch.access-vtable    # introduce nsg_gpio_ops vtable, w dump
gpio-scx/patch.vtable-calls    # add & use the vtable in scx200_gpio
gpio-scx/patch.nscgpio-shell    # add empty driver for common-fops

# move code under abstraction
gpio-scx/patch.migrate-fops    # move file-ops methods from scx200_gpio
gpio-scx/patch.common-dump    # mv scx200.c:scx200_gpio_dump() to nsc_gpio.c
gpio-scx/patch.add-pc8736x-gpio    # add new driver, like old, w chip adapt
# gpio-scx/patch.add-DEBUG    # enable all dev_dbg()s

# Cleanups

# finish printk -> dev_dbg() etc
gpio-scx/patch.pdev-pc8736x    # new drvr needs pdev too,
gpio-scx/patch.devdbg-nscgpio    # add device to 'vtable', use in dev_dbg()

# gpio-scx/patch.pin-config-view    # another 'c' 'command'
# gpio-scx/quiet-getset        # take out excess dbg stuff (pretty quiet 
now)
gpio-scx/patch.shadow-current    # imitate scx200_gpio's shadow regs in 
pc87*

# post KMentors-post patches ..

gpio-scx/patch.mutexes        # use mutexes for config-locks
gpio-scx/patch.viewpins-values    # extend dump to obsolete separate 'c' cmd

gpio-scx/patch.kconfig        # add stuff for kbuild

# TBC
# combine api26 with pdev, which is just one step.
# merge c&v commands to single do-all-fn
# delay viewpins, dump-diet should also un-ifdef it too.

diff.sys-gpio-rollup-1



Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

