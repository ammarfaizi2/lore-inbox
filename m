Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbUBHXtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 18:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUBHXtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 18:49:16 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:59132 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S264410AbUBHXtO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 18:49:14 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "Hefty, Sean" <sean.hefty@intel.com>
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Mon, 9 Feb 2004 00:43:57 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, infiniband-general@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200402090044.14247.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 6 Feb 2004, Hefty, Sean wrote:

> We want to continue to discuss specific details about what's needed to
> add the code into the kernel.  Here's a list of modifications that I
> think are needed so far:
>
> * Update the code to make direct calls for atomic operations.
> * Verify the use of spinlock calls.
> * Reformat the code for tab spacing and curly brace usage.
> * Elimination of typedefs.

Some more hints:
* Understand how to use ioctls: Your current code can't possibly
  work in 32 bit emulation mode, e.g. when running i386 libs on ia64.
  You are also completely ignoring the ioctl 'command' argument.
* Try to reduce the number of necessary ioctls: 90 different commands
  for a single device is just overkill.
* Don't try to hide system calls behind a character device (/dev/cl_dev).
  Someone will find it sooner or later.
* Don't reimplement devfs (poorly), what your are trying to achieve is
  far easier done with a misc device and udev. call_user_mode_helper
  should only be used for running hotplug.
* Get rid of IN and OUT in declarations. If a pointer is const, it's an
  input.
* Declare functions static when they are only used in the file they are
  defined in. Put extern declarations into headers.
* put EXPORT_SYMBOL statements right next to the symbol, not in a seperate
  file.
* Information about drivers/devices should go to sysfs instead of procfs.
* Don't use vmalloc. 
* aside from spinlocks and atomics, there are some more files in complib
  that can easily be removed by using linux primitives directly (e.g.
  kmalloc, list_head, semaphore, work_queue)
* Use C99 named struct initializers instead of their deprecated gcc 
  counterparts.

> And, yes, knowing some of these issues up front will save the trouble of
> submitting code that will be immediately rejected.

Right, but that should not stop you from providing a BK tree or a diff
file that lets you build ibal in a linux tree. As a starting point, just
drop all of ibal and complib into some tree so people can look at it
without having to figure out how you are building stuff.

	Arnd <><
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAJsm/5t5GS2LDRf4RArCIAJ9JEkinmx1yeSZQGS7X6rMaDYjuZwCgl9us
+7w/ZNbFl1ZAiLaIrp/rsso=
=repY
-----END PGP SIGNATURE-----

