Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbUCQTTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 14:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUCQTTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 14:19:24 -0500
Received: from 217-162-71-11.dclient.hispeed.ch ([217.162.71.11]:58038 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S261998AbUCQTTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 14:19:05 -0500
Message-ID: <4058A49A.5070608@steudten.com>
Date: Wed, 17 Mar 2004 20:18:50 +0100
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-admin@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems module autoload in 2.6.x
References: <4051DA6E.6070809@steudten.com> <1079490472.3400.114.camel@bach>
In-Reply-To: <1079490472.3400.114.camel@bach>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: Mailer
X-Check: 2c1783c72b2809387bfafaa1e08e3128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

2.6.4 on alpha:

  zgrep -i mod /proc/config.gz
# Loadable module support
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_IDEDISK_MULTI_MODE=y

grep -i floppy /etc/modprobe.conf
alias block-major-2-* floppy

strace -estat,open /sbin/modprobe -v floppy
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
open("/lib/libc.so.6.1", O_RDONLY)      = 3
open("/etc/modprobe.conf", O_RDONLY)    = 3
open("/lib/modules/2.6.4/modules.dep", O_RDONLY) = 3
open("/proc/modules", O_RDONLY)         = 3
open("/lib/modules/2.6.4/kernel/drivers/block/floppy.ko", O_RDONLY) = 3
insmod /lib/modules/2.6.4/kernel/drivers/block/floppy.ko

=> OK
without module floppy loaded:
mdir a:
Can't open /dev/fd0: No such device or address
No msg in KRB (dmesg) and log from  /tmp/modprobe.log
=> FAILED
modprobe -v floppy
insmod /lib/modules/2.6.4/kernel/drivers/block/floppy.ko
=> OK
mdir a:
=> OK

My questions are:
1. What process name has the "new" kmod? There´s no such process in the
table.
2. What triggers to run the prog given in /proc/sys/kernel/modprobe (
for a missing device)?

Strange: Looks like there is no kmod build or loaded or ..
I should look in detail about this..


>>Kernel 2.6.4:
>>Some modules (floppy, lp, loop..) won´t be autoloaded any more since
>>2.4.21. There´s no block-major aso. request in the kernel-ring buffer.
>>I have /etc/modules.conf and /etc/modprobe.conf with modutils-2.4.21-23.1
>>and depmod -V: module-init-tools 3.0-pre5. How can I track this down?
>>Shouldn't be there a kmod process/ thread in the process list?
> 
> 
> Check you have CONFIG_KMOD=y.  If so, the correct way of debugging
> module problems is something like this:
> 
> echo '#! /bin/sh' > /tmp/modprobe
> echo 'echo "$@" >> /tmp/modprobe.log' >> /tmp/modprobe
> echo 'exec /sbin/modprobe "$@"' >> /tmp/modprobe
> chmod a+x /tmp/modprobe
> echo /tmp/modprobe > /proc/sys/kernel/modprobe
> 
> Then do something that should cause the module to load: you'll see the
> command which gets called in /tmp/modprobe.log.  Then you can add "-v"
> and run it manually, hopefully providing enlightenment.


