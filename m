Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWDDPSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWDDPSS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWDDPSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:18:18 -0400
Received: from o-hand.com ([70.86.75.186]:6607 "EHLO o-hand.com")
	by vger.kernel.org with ESMTP id S1750702AbWDDPSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:18:18 -0400
Subject: [PATCH RFC/testing] Upgrade the zlib_inflate library code to a
	recent version
From: Richard Purdie <richard@openedhand.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Content-Type: text/plain
Date: Tue, 04 Apr 2006 16:18:08 +0100
Message-Id: <1144163888.6441.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrade the zlib_inflate implementation in the kernel from a patched
version 1.1.3 to a patched 1.2.3. 

The code in the kernel is about seven years old and I noticed that the
external zlib library's inflate performance was significantly faster
(~50%) than the code in the kernel on ARM (and faster again on x86_32).

For comparison the newer deflate code is 20% slower on ARM and 50%
slower on x86_32 but gives an approx 1% compression ratio improvement. I
don't consider this to be an improvement for kernel use so have no plans
to change the zlib_deflate code.

Various changes have been made to the zlib code in the kernel, the most
significant being the extra functions/flush option used by ppp_deflate.
This update reimplements the features PPP needs to ensure it continues
to work.

This code has been tested on ARM under both JFFS2 (with zlib compression
enabled) and ppp_deflate and on x86_32. JFFS2 sees an approx. 10% real
world file read speed improvement.

This patch also removes ZLIB_VERSION as it no longer has a correct
value. We don't need version checks anyway as the kernel's module
handling will take care of that for us. This removal is also more in
keeping with the zlib author's wishes
(http://www.zlib.net/zlib_faq.html#faq24) and I've added something to
the zlib.h header to note its a modified version.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
---

 include/linux/zconf.h           |   12
 include/linux/zlib.h            |  209 ++++---
 include/linux/zutil.h           |   12
 lib/zlib_deflate/deflate.c      |   25
 lib/zlib_deflate/deflate_syms.c |    3
 lib/zlib_inflate/Makefile       |    4
 lib/zlib_inflate/infblock.c     |  365 -------------
 lib/zlib_inflate/infblock.h     |   48 -
 lib/zlib_inflate/infcodes.c     |  202 -------
 lib/zlib_inflate/infcodes.h     |   33 -
 lib/zlib_inflate/inffast.c      |  462 ++++++++++------
 lib/zlib_inflate/inffast.h      |   12
 lib/zlib_inflate/inffixed.h     |   94 +++
 lib/zlib_inflate/inflate.c      | 1114 +++++++++++++++++++++++++++++++---------
 lib/zlib_inflate/inflate.h      |  107 +++
 lib/zlib_inflate/inflate_syms.c |    3
 lib/zlib_inflate/inflate_sync.c |  152 -----
 lib/zlib_inflate/inftrees.c     |  677 ++++++++++--------------
 lib/zlib_inflate/inftrees.h     |   99 +--
 lib/zlib_inflate/infutil.c      |   88 ---
 lib/zlib_inflate/infutil.h      |  178 ------
 21 files changed, 1886 insertions(+), 2013 deletions(-)

The patch is ~160kb so I'll link to it:

http://www.o-hand.com/~richard/zlib_inflate-r3.patch



