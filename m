Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUFGXsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUFGXsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbUFGXsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:48:51 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:6109 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S265134AbUFGXsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:48:47 -0400
Subject: Finding user/kernel pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Al Viro <viro@math.psu.edu>, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Jun 2004 16:48:44 -0700
Message-Id: <1086652124.14180.5.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that recently Linus, Al Viro, and others have put a huge
effort into annotating the kernel to find user/kernel pointer bugs
with sparse.  Despite this work, fewer than 1000 of the almost 13000
source files in Linux 2.6.7-rc3 contain any annotations at all.
Because of this, I think you might be interested in our tool for
finding user/kernel pointer bugs, CQual.  CQual could save 
months of work annotating the rest of the kernel.

Like sparse, cqual uses annotations to find bugs in software.  I
don't intend for cqual to replace sparse, but for the specific problem
of user/kernel pointer bugs, I believe that cqual provides better
results with less work from programmers.  The main features of cqual
are:

- cqual requires _very few_ annotations.  

  CQual infers most annotations from a few base annotations provided
  by programmers.  In theory, it's possible to check the entire kernel
  with fewer than 300 annotations.  In practice, cqual only requires
  header files to be annotated.

- cqual requires _zero_ annotations in device drivers.

  Once the generic driver interfaces have been annotated, all device
  drivers can be checked against these annotations without any further
  effort.  This is critical, since annotating the thousands of device
  drivers in linux will be extremely difficult and take months.

- cqual can verify more code than sparse.

  CQual allows some struct instances to have user pointer fields and
  some to have kernel pointer fields, and it automatically figures out
  which are which.  This means some code that sparse erroneously
  reports as buggy will pass through cqual without warning.  The only
  way to get this sort of code to check with sparse is to have two
  redundant structure definitions: one holding user pointers and the
  other holding kernel pointers.  This sort of code duplication will
  lead to its own host of code maintainence problems.  Thus, the
  ability to check more code not only reduces the false positive rate,
  it results in more maintainable code.

  CQual supports other features, such as polymorphism, that also allow
  it to verify more code.

- cqual doesn't require numerous casts.

  Casts are extra annotations that pose yet another annotation burden
  on the programmer.  Even worse, they can silently suppress
  legitimate warning messages.  CQual requires far fewer casts than
  sparse, so it's easier to use and less error prone.

- cqual doesn't miss any bugs.

  If cqual says code is free of user/kernel pointer bugs, then it is.

- cqual works with the kernel build system

  CQual ships with a script, "kqual", that makes it behave like a
  drop-in replacement for sparse in the kernel build system.

- cqual is open source (GPL).

  It's hosted on sourceforge and available from 
  http://www.cs.umd.edu/~jfoster/cqual/

I've already used cqual to find numerous real user/kernel pointer
bugs in the Linux kernel.  You can read about these results in the
paper: http://www.cs.berkeley.edu/~rtjohnso/papers/cquk.ps

I look forward to receiving feedback from kernel developers on cqual.
In the long run, I hope to see cqual become the default tool for
finding user/kernel pointer bugs in Linux.  Again, cqual cannot
replace sparse, because sparse performs many checks that cqual does
not, but for user/kernel pointer bugs, cqual gives better results with 
far, far fewer annotations.  Thanks for your feedback.

Best,
Rob Johnson

P.S. As an example, cqual has already found bugs in

drivers/char/drm/gamma_dma.c
drivers/scsi/cpqfcTSinit.c
drivers/usb/vicam.c
drivers/usb/w9968cf.c
drivers/pcmcia/{[dc]s,bulkmem}.c
drivers/i2c/i2c-dev.c
fs/ncpfs/ioctl.c
drivers/net/wan/cosa.c
drivers/net/wan/sbni.c
drivers/net/bonding.c
drivers/video/fbcon.c
drivers/i2c/i2c-dev.c
drivers/message/i2o/i2o_config.c
drivers/char/joystick.c

and probably a few others that I've forgotten.


