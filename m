Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752061AbWCNKCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbWCNKCa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbWCNKCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:02:30 -0500
Received: from mail-gate.ait.ac.th ([202.183.214.47]:59619 "EHLO
	mail-gate.ait.ac.th") by vger.kernel.org with ESMTP
	id S1752061AbWCNKC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:02:29 -0500
Date: Tue, 14 Mar 2006 17:02:17 +0700
From: Alain Fauconnet <alain@ait.ac.th>
To: linux-kernel@vger.kernel.org
Subject: raidautorun gets ENODEV when called from initrd in 2.6.15.4
Message-ID: <20060314100217.GF7987@ait.ac.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello readers,

Would someone please hint me on why a box using SATA (sata_sil -
wouldn't think it's relevant) and software RAID-1 can't boot with RAID
support as modules? (using an initrd image).

I get "raidautorun: RAID_AUTORUN failed: 19" when nash runs
"raidautorun /dev/md0" at boot, therefore the root filesystem fails to
mount and the system panics. At this point I have confirmed that the
physical member devices/partitions have been detected OK and that the
md-mod.ko and raid1.ko modules load without error.

The same box boots OK with RAID support compiled static, but well,
I like the dynamic way and I'd love to understand what's going on.

>From what I can see (confirmed by adding a "printk" there),
that part of md.c is hit:

        /* if we are not initialised yet, only ADD_NEW_DISK, STOP_ARRAY,
         * RUN_ARRAY, and SET_BITMAP_FILE are allowed */
        if (!mddev->raid_disks && cmd != ADD_NEW_DISK && cmd != STOP_ARRAY
                        && cmd != RUN_ARRAY && cmd != SET_BITMAP_FILE) {
                printk(KERN_ALERT "md: cmd = %d\n", cmd); /* added by me */
                err = -ENODEV; 
                goto abort_unlock;

The IOCTL command received is 0x914 (RAID_AUTORUN) which makes sense
to me. So the issue is that mddev->raid_disks is NULL, I guess.

Trustix Linux 2.2
Kernel 2.6.15.4 compiled from source
Mkinitrd 4.1.18-2 RPM from FC3 installed in place
of the original one that comes with Trustix because it can't
manage .ko modules.
The same setup works on a Dell Poweredge 750 in an almost
exacty similar configuration (2 SATA disks - Intel chipset in this case,
with software RAID, kernel 2.6.13).

I'm stuck. I'd be very grateful to receive any hint.

Greets,
_Alain_
