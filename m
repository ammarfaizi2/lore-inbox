Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVI2HWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVI2HWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVI2HWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:22:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:52708 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932140AbVI2HWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:22:21 -0400
Subject: iMac G5: experimental thermal & cpufreq support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc64-dev@ozlabs.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 17:20:31 +1000
Message-Id: <1127978432.6102.53.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I now have some experimental thermal control and cpufreq support for
iMac G5. I have not _yet_ implemented support for the SMU based single
CPU desktops (PowerMac9,1), those will have to wait a little bit more
(not too much hopefully, but I need potential testers to contact me as I
lack hardware access). At this point, it should work on PowerMac8,1
(iMacG5 rev A) and PowerMac8,2 (iMacG5 rev B).

WARNING: This is really a 'first shot'. There is no overtemp detection,
so be careful. The driver doesn't yet have a sysfs interface for you to
read the temperature, but I left it with verbose debugging enabled in
the kernel log so you can see what's going on with the 2 control loops
(the System one which ticks every 5 seconds and the CPU one which ticks
every second). Please tell me if it appears to behave properly. On my
iMac G5 rev A, the target temperature for the CPU is set by the firmware
at 78 degree C with a max at about 83 degree. If I put load on the CPU,
the CPU appears to properly ramp up slowly to 82 then go down and
stabilize at 78 while the driver slowly ramps the fans up.

The algorithm itself is extracted from darwin. However, it's a rather
complex modified version of the PID algorithm, and thus it could use
some review to make sure I got everything right.

The thermal control is also part of a new infrastructure I have written
called "windfarm" that splits the whole thing into several modules
(though I have only tested with everything built in at this point).
Ultimately, it should be possible to port the existing Desktop G5 and
Xserver thermal driver to the new infrastructure provided that the
appropriate sensor & control modules are written. The old thermal driver
uses pretty much the same 2 kind of PID control loops as provided by the
windfarm_pid helper.

I would encourage people doing thermal control on other machines
(laptops, etc...) to also use the new infrastructure.

Ok, now the patches. You need to appy them in proper order. First of
all, it all is on top of current -git as of yesterday. I won't guarantee
they will apply on anything more ancient.

First, you need a fix that is currently pending in -mm (and should be in
2.6.14 before it's final) :

http://gate.crashing.org/~benh/ppc64-smu-fix.diff

Then, you can apply the patch that adds cpufreq support for the iMac G5
(and possibly the SMU based desktop, though not tested)

http://gate.crashing.org/~benh/ppc64-fx-freq-scaling.diff

Then apply those 2 patches in that order:

http://gate.crashing.org/~benh/ppc64-smu-partitions.diff
http://gate.crashing.org/~benh/ppc64-smu-thermal-control.diff

That's it. Now enable:

  CONFIG_WINDFARM_SMU
 
and

  CONFIG_I2C_PMAC_SMU

If you are using modules, you may have to manually load the whole bunch,
especially the i2c SMU one which isn't requested (yet).

And let me know :)

Regards,
Ben.



