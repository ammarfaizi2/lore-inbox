Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSLXW0H>; Tue, 24 Dec 2002 17:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbSLXW0H>; Tue, 24 Dec 2002 17:26:07 -0500
Received: from h-64-105-35-71.SNVACAID.covad.net ([64.105.35.71]:173 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265909AbSLXW0G>; Tue, 24 Dec 2002 17:26:06 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 24 Dec 2002 14:33:56 -0800
Message-Id: <200212242233.OAA17934@adam.yggdrasil.com>
To: rgooch@atnf.csiro.au
Subject: Module unload race with devfs + char devices
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

	This is pretty obscure, but I thought I should mention this
bug to you.

	I think there is a module unload race for character devices in
devfs whereby devfs retains a file_operations pointer that is no longer
valid after a character device driver module has been unloaded.

	I was able to trip the problem by adding a 10 second
sleep near the beginning of dentry_open (in fs/open.c) whenever a
parallel port was opened.  Then I was able to produce a kernel paging
error by doing the following:

modprobe parport_pc
modprobe lp
cat /dev/printers/0 &
rmmod lp

	Ten seconds later, I'd get a bad pointer reference on the
address previously occupied by lp_fops.  dentry_open would call
devfs_open; devfs_open would try to read lp_fops presumably because
some pointer to it had not been cleared.

	The problem does not occur without devfs because the regular
chrdev_open calls get_chrfops which fetches the appropriate takes a
semaphore that is used by {,un}register_chrdev, and, with that
semaphore held, fetches the appropriate f_ops and increments the
module's reference count before releasing the semaphore.  I had
previously thought that this was a more general problem, but now I now
think it's limited to devfs, so I thought I ought to let you know.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
