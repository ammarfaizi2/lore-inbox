Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVCHW6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVCHW6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVCHW6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:58:50 -0500
Received: from mta206-rme.xtra.co.nz ([210.86.15.58]:13202 "EHLO
	mta206-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S262160AbVCHW6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:58:30 -0500
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C330360F8E3@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: linux-kernel@vger.kernel.org
Subject: Bug: ll_rw_blk.c, elevator.c and displaying "default" IO Schedule
	r at boot-time (Cosmetic only)
Date: Wed, 9 Mar 2005 11:58:13 +1300 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to investigate an IO performance issue on my machine, as
part of this I've noticed what is (presumably only a cosmetic) issue with
the messages displayed at kernel boot-time.

In the "good old days" (i.e. older 2.6.x kernel versions), one of the many
messages displayed at kernel boot-time was "elevator: using XXX as default
io scheduler", where XXX was one of the IO schedulers (cfq, anticipatory,
deadline, etc) depending on kernel .config at compile time.

I noticed in 2.6.11, this message has vanished (although this may have
happened in an earlier kernel), and I now get some messages "io scheduler
XXX registered".  Unfortunately, the "default" scheduler is no longer
tagged.

The Bug, however, is that code to tag the default clearly exists in
elevator.c, thus:

In function "elv_register":

        printk(KERN_INFO "io scheduler %s registered", e->elevator_name);
        if (!strcmp(e->elevator_name, chosen_elevator))
                printk(" (default)");
        printk("\n");

Some investigation has shown that when this code is called at kernel boot
time with no "elevator=xxx" kernel argument, chosen_elevator is undefined.
The code that defines chosen_elevator (elevator_setup_default) is only
called for the first time AFTER all the compiled in schedulers call
"elv_register".

However, if "elevator=xxx" is passed as a kernel argument, the code in
elv_register works.

Presumably, this code causes that behaviour:

static int __init elevator_setup(char *str)
{
        strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
        return 0;
}

__setup("elevator=", elevator_setup);

I imagine the fix for the bug is to have "elevator_setup_default" called
before any of the compiled in schedulers call "elv_register"; but I lack
sufficient knowledge of how the kernel hangs together to be able to patch
anything to do this.  Presumably, ll_rw_blk.c is responsible for the calling
order - somehow.

For completeness, the appropriate section from my .config:

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

If anyone can come up with a patch, I'm happy to test and report back....

Thanks,

James Roberts-Thomson
----------
Hardware:  The parts of a computer system that can be kicked.

LKML Readers:  Please ignore the following disclaimer - this email is
explicitly declared to be non confidential and does not contain privileged
information.

This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.
