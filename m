Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWDKBaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWDKBaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 21:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWDKBaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 21:30:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28691 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932182AbWDKBai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 21:30:38 -0400
Date: Tue, 11 Apr 2006 03:30:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: chris@zankel.net
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [BUG] sizeof(struct async_icount) exported to userspace on SH, SH64 and xtensa (fwd)
Message-ID: <20060411013036.GA3190@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

now that the sh people have fixed it on their ports, xtensa is the only 
port with this issue.

Please fix it.

TIA
Adrian


----- Forwarded message from Russell King <rmk+lkml@arm.linux.org.uk> -----

Date:	Sat, 21 Jan 2006 18:57:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: chris@zankel.net, lethal@linux-sh.org
Subject: [BUG] sizeof(struct async_icount) exported to userspace on SH, SH64 and xtensa

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

