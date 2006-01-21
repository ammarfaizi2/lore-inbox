Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWAUS53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWAUS53 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 13:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWAUS53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 13:57:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54280 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750861AbWAUS52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 13:57:28 -0500
Date: Sat, 21 Jan 2006 18:57:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: chris@zankel.net, lethal@linux-sh.org
Subject: [BUG] sizeof(struct async_icount) exported to userspace on SH, SH64 and xtensa
Message-ID: <20060121185712.GA25185@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	chris@zankel.net, lethal@linux-sh.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just been looking through the remaining cruft in the serial
drivers, and have come across this silly thing:

TIOCGICOUNT exports a structure to userspace called
struct serial_icounter_struct.

However, sh, sh64 and xtensa do this:

include/asm-sh/ioctls.h:#define TIOCGICOUNT     _IOR('T', 93, struct async_icount) /* 0x545D */ /* read serial port inline interrupt counts */
include/asm-sh64/ioctls.h:#define TIOCGICOUNT   0x802c545d      /* _IOR('T', 93, struct async_icount) 0x545D */ /* read serial port inline interrupt counts */
include/asm-xtensa/ioctls.h:#define TIOCGICOUNT _IOR('T', 93, struct async_icount) /* read serial port inline interrupt counts */

What's more is that no driver actually exports async_icount, and
async_icount is a kernel internal structure which does _not_ form
part of the public API, and modifications to this will result in
unexpected breakage on these platforms.

100% for trying to clean up the tty ioctl definitions.  0% for
using the wrong structures.  As such, these _require_ fixing.

Please document that your TIOCGICOUNT is broken and remove the
dependence on the async_icount structure.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
