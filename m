Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbSLLFno>; Thu, 12 Dec 2002 00:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267423AbSLLFno>; Thu, 12 Dec 2002 00:43:44 -0500
Received: from h-64-105-35-2.SNVACAID.covad.net ([64.105.35.2]:46247 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267421AbSLLFnn>; Thu, 12 Dec 2002 00:43:43 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 11 Dec 2002 21:41:17 -0800
Message-Id: <200212120541.VAA14863@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au, viro@math.psu.edu
Subject: 2.5.51 + devfs root + SMP = lockup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linux 2.5.51 with SMP and devfs hangs at boot time when trying
to find the initial root device (/dev/ram0 in my case).  2.5.50 does
not have this problem.  That hang occurs when find_in_devfs in
init/do_mounts.c descends into the /dev/shm directory, eventually
resulting to a call to devfs_lookup (in fs/devfs/base.c), which hangs
at line 2685, waiting for a lock, at least on my single processor
running an SMP kernel:

out:
    dentry->d_op = &devfs_dops;
    dentry->d_fsdata = NULL;
    write_lock (&parent->u.dir.lock);    <----------- Hangs here
    wake_up (&lookup_info.wait_queue);
    write_unlock (&parent->u.dir.lock);
    devfs_put (de);
    return retval;
}   /*  End Function devfs_lookup  */


	Actually, I am running slightly modified versions of both
files, although I believe that my modificatiosn are not the cause.
In init/do_mounts.c, I am running the patch that I posted back in ~2.5.48
so that reading /dev under devfs works at all (I think the patch
has fallen through the cracks and I plan to resubmit it, but I want
to get 2.5.51 working first, in case the patch really is the culprit).

	The other difference in my system is the removable device
"support" in devfs (having the kernel reread the partition table when
you didn't ask it to, unlike a non-devfs system).  I removed it.

	Anyhow, I haven't exhausted my debugging efforts, but it has
been a little slow going, so I'm reporting what I know now, in case
anyone recognizes the problem.  If nobody beats me to it, I expect to
track down the problem in the next day or so and post a patch then.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


