Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTDUHhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 03:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTDUHhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 03:37:17 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:27877 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263434AbTDUHhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 03:37:16 -0400
Date: Mon, 21 Apr 2003 00:49:13 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
Subject: [CHECKER]  Help Needed!
In-Reply-To: <20030327091058.A22868@figure1.int.wirex.com>
Message-ID: <Pine.GSO.4.44.0304210042170.19252-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We run a checker that warns about derefence of user-pointer errors on
linux-2.5.63 and got the following warning message in
init/do_mounts.c:create_dev, which needs clarifications.

---------------------------------------------------------
/home/junfeng/linux-2.5.63/init/do_mounts.c:437:create_dev: ERROR:TAINTED:442:437:dereferencing tainted ptr 'devfs_name'

	sys_unlink(name);
	if (!do_devfs)
		return sys_mknod(name, S_IFBLK|0600, dev);

Error--->
	if (devfs_name && devfs_name[0]) {
		if (strncmp(devfs_name, "/dev/", 5) == 0)
			devfs_name += 5;
		sprintf(path, "/dev/%s", devfs_name);
		if (sys_access(path, 0) == 0)
Start --->
			return sys_symlink(devfs_name, name);
	}
	if (!dev)
		return -1;


It seems to us that create_dev can only be called at boot time (the
"__init" attribute), so devfs_name must be an untainted kernel pointer.
The warning on line 437 isn't a real error.

However, this pointer is finally passed into strncpy_from_user through the
call chain [ sys_symlink (devfs_name, name) --> getname (oldname) -->
do_getname(filename, _) --> strncpy_from_user (_, filename, _)].  Is it
okay to call *_from_user functions with the second arguements untainted?
What will access_ok(VERIFY_READ, src, 1) return?

As usual, any response will be greatly apppreciated.  Thanks a lot!

-Junfeng

