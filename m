Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbUKGXOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUKGXOc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 18:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUKGXOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 18:14:32 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:33961 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261705AbUKGXO0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 18:14:26 -0500
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200411072314.iA7NEM119415@inv.it.uc3m.es>
Subject: kernel analyser to detect sleep under spinlock
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Mon, 8 Nov 2004 00:14:20 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 ftp://øboe.it.uc3m.es/pub/Programs/c-1.2.tgz

To use the application, compile and then use "c" in place of
"gcc" on a typical kernel compile line.

This is currently tested only on kernel 2.4 and probably will need some
slight mods to the parser for kernel 2.6 code, as it has to
inverse engineer some of the assembler produced by macros in kernel
headers.

Here's some typical output ...
 
 % ./c -D__KERNEL__ -DMODULE \
   -I/usr/local/src/linux-2.4.25-xfs/include ../dbr/1/sbull.c 
 *************** sleepy functions *******************************
 *       function                line    calls
 *
 * - /usr/local/src/linux-2.4.25-xfs/include/linux/smb_fs_sb.h
 *       smb_lock_server         63      down
 *
 * - /usr/local/src/linux-2.4.25-xfs/include/linux/fs.h
 *       lock_parent             1624    down
 *       double_down             1647    down
 *       triple_down             1668    down
 *       double_lock             1718    double_down
 *
 * - /usr/local/src/linux-2.4.25-xfs/include/linux/locks.h
 *       lock_super              38      down
 *
 * - ../dbr/1/sbull.c
 *       sbull_ioctl             171     interruptible_sleep_on
 *
 * - /usr/local/src/linux-2.4.25-xfs/include/linux/blk.h
 *       sbull_request           358     interruptible_sleep_on
 *
 * - ../dbr/1/sbull.c
 *       sbull_init              431     kmalloc
 *       sbull_init              431     kfree
 *       sbull_cleanup           542     kfree
 *
 ****************************************************************
 *************** sleep_under_spinlock ****************************
 *       function                line    calls
 *
 * - ../dbr/1/sbull.c
 *       sbull_request           420     interruptible_sleep_on
 *
 *
 * *** found 1 instances of sleep under spinlock ***
 *
 ***********************************************

It's GPL/LGPL.

Peter (ptb@inv.it.uc3m.es)
