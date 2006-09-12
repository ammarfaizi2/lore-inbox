Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWILOIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWILOIa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWILOIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:08:30 -0400
Received: from hermes.domdv.de ([193.102.202.1]:10506 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S965041AbWILOI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:08:29 -0400
Message-ID: <4506BF56.6000309@domdv.de>
Date: Tue, 12 Sep 2006 16:08:22 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: uswsusp oddity
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried uswsusp 0.2 and there is a strange problem (2.6.17.8, x86_64):

The swap device used for suspend must be the first swap device,
otherwise suspend fails.


Contents of /etc/suspend.conf:

snapshot device = /dev/snapshot
resume device = /dev/hda2
#image size = 350000000
suspend loglevel = 7
#compute checksum = y
#compress = y
#encrypt = y
early writeout = y
#splash = y


Output of /proc/swaps of the failing suspend:

Filename                Type            Size    Used    Priority
/dev/mapper/swap1       partition       1959920 0       2
/dev/mapper/swap2       partition       1959888 0       3
/dev/hda2               partition       1959920 0       1


Relevant portion of strace of suspend utility:

mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
stat("/dev/hda2", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 2), ...}) = 0
open("/dev/hda2", O_RDWR)               = 3
stat("/dev/snapshot", {st_mode=S_IFCHR|0600, st_rdev=makedev(10, 231),
...}) = 0
open("/dev/snapshot", O_RDONLY)         = 4
ioctl(4, 0x4004330a, 0x302)             = -1 ENODEV (No such device)
write(2, "suspend: Could not use the resum"..., 57suspend: Could not use
the res
ume device (try swapon -a)


There seems to be something wrong with the SNAPSHOT_SET_SWAP_FILE ioctl.

If I do the following sequence suspend works:

swapoff -a
swapon -p 1 /dev/hda2
swapon -a
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
