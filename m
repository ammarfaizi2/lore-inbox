Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbTHSW7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbTHSW7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:59:49 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:42897 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261295AbTHSW7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:59:48 -0400
Date: Wed, 20 Aug 2003 00:59:46 +0200 (MEST)
Message-Id: <200308192259.h7JMxkpK011406@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [2.4.22-rc2] x86-64 register_ioctl32_conversion() breakage
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-x86_64/ioctl32.h states:

/* 
 * Register an 32bit ioctl translation handler for ioctl cmd.
 *
 * handler == NULL: use 64bit ioctl handler.
 * arguments to handler:  fd: file descriptor
 *                        cmd: ioctl command.
 *                        arg: ioctl argument
 *                        struct file *file: file descriptor pointer.
 */ 

extern int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *));

The "handler == NULL" comment is true in 2.6 kernels (sys_ioctl()
get called, which is what we want for compatible ioctls), but not
in 2.4.22-rc2, where instead sys32_ioctl() oopses because it calls
a NULL function pointer. (I found that out when testing ia32
compatibility in the latest version of the perfctr driver.)

Either ia32_ioctl.c or the comment in ioctl32.h is wrong and should
be fixed. I'd prefer the code to work as in 2.6 since that avoids
#if LINUX_VERSION_CODE crap and dummy ioctl handlers.

/Mikael
