Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbTCSALl>; Tue, 18 Mar 2003 19:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbTCSALk>; Tue, 18 Mar 2003 19:11:40 -0500
Received: from hera.cwi.nl ([192.16.191.8]:30861 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262776AbTCSALj>;
	Tue, 18 Mar 2003 19:11:39 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 19 Mar 2003 01:22:35 +0100 (MET)
Message-Id: <UTC200303190022.h2J0MZu08990.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, greg@kroah.com
Subject: Re: [PATCH] dev_t [2/3]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    This is nice, thanks.  We don't have to touch the char drivers now.

    Ah, I wish we could change that function to be:
    int register_chrdev_region(major, num_minors, name, fops)
    if it wasn't for the tty drivers wanting to start their minor at 64.

    Hm, wait, why can't we just do it that way and not change the tty core
    to use the register_chrdev_region() call?  It should still all work
    properly, right?  The tty core would ask for 256 minors, and split them
    off the same way it currently does.

# cat /proc/devices | head
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 vc/0
  4 vc/%d
  4 ttyS%d
  5 tty
  5 console
  5 ptmx
#

The routine tty_register_driver() already finds major, minor_start,
nr_of_minors in its struct tty_driver, so this is the natural,
or at least the easiest, interface to use.

"The tty core would ask for 256 minors" - this doesnt work
very well. One of the problems is that ttyS comes from a
serial module, while vc is virtual console stuff, unrelated.
If opening a device must load the module, then at registration time
we have to tell what minors belong to what module.

Andries
