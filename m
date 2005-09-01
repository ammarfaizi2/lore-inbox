Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbVIAOXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbVIAOXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVIAOXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:23:04 -0400
Received: from dvhart.com ([64.146.134.43]:29319 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965136AbVIAOXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:23:03 -0400
Date: Thu, 01 Sep 2005 07:22:53 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: Re: 2.6.13-mm1
Message-ID: <6970000.1125584568@[10.10.2.4]>
In-Reply-To: <20050901035542.1c621af6.akpm@osdl.org>
References: <20050901035542.1c621af6.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Breaks build on PPC64

Lots of this:

In file included from fs/xfs/linux-2.6/xfs_linux.h:57,
                 from fs/xfs/xfs.h:35,
                 from fs/xfs/xfs_rtalloc.c:37:
fs/xfs/xfs_arch.h:55:21: warning: "__LITTLE_ENDIAN" is not defined
In file included from fs/xfs/xfs_rtalloc.c:50:
fs/xfs/xfs_bmap_btree.h:65:21: warning: "__LITTLE_ENDIAN" is not defined
  CC      fs/xfs/xfs_acl.o
In file included from fs/xfs/linux-2.6/xfs_linux.h:57,
                 from fs/xfs/xfs.h:35,
                 from fs/xfs/xfs_acl.c:33:
fs/xfs/xfs_arch.h:55:21: warning: "__LITTLE_ENDIAN" is not defined

Can't see anything obvious to cause that.
Then this:

CC      drivers/char/hvc_console.o
drivers/char/hvc_console.c: In function `hvc_poll':
drivers/char/hvc_console.c:600: error: `count' undeclared (first use in this function)
drivers/char/hvc_console.c:600: error: (Each undeclared identifier is reported only once
drivers/char/hvc_console.c:600: error: for each function it appears in.)
drivers/char/hvc_console.c:636: error: structure has no member named `flip'
make[2]: *** [drivers/char/hvc_console.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

Presumably this:

diff -puN drivers/char/hvc_console.c~tty-layer-buffering-revamp drivers/char/hvc
_console.c
--- 25/drivers/char/hvc_console.c~tty-layer-buffering-revamp    Wed Aug 31 12:50
:55 2005
+++ 25-akpm/drivers/char/hvc_console.c  Wed Aug 31 12:50:56 2005
@@ -597,10 +597,8 @@ static int hvc_poll(struct hvc_struct *h
 
        /* Read data if any */
        for (;;) {
-               int count = N_INBUF;
-               if (count > (TTY_FLIPBUF_SIZE - tty->flip.count))
-                       count = TTY_FLIPBUF_SIZE - tty->flip.count;
-
+               count = tty_buffer_request_room(tty, N_INBUF);
+               
                /* If flip is full, just reschedule a later read */
                if (count == 0) {
                        poll_mask |= HVC_POLL_READ;

shouldn't be deleting the declaration of count. 

and possibly the "flip removal" was incomplete (line 636) ???

