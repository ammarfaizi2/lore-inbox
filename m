Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270332AbTGWOB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270334AbTGWOB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:01:59 -0400
Received: from neko.kfib.org ([193.12.253.17]:25514 "EHLO neko.kfib.org")
	by vger.kernel.org with ESMTP id S270332AbTGWOBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:01:46 -0400
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] Bug in initrd-handling still there in 2.4.22-pre7
From: martin@kfib.org (martin@kfib.org)
Date: 23 Jul 2003 16:16:56 +0200
Message-ID: <m37k69s4yv.fsf@neko.kfib.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From original posting (2 weeks ago):

> At work we've encountered a problem when trying to netboot 2.4.21.
> After /linuxrc has been executed and the kernel tries to remount the
> root, it panics with the all too well known message "Unable to mount
> root fs on ...".
> 
> The kernel bugs out in mount_block_root in the file init/do_mounts.c,
> to be more precise in the for-loop. What happens is that it tries to
> mount the file system as type ext2 (which happens to be first in the
> list in our case), but instead of returning -EINVAL it returns -EBUSY,
> the loop exits instead of trying the next (correct) fs-type and the
> kernel panics.

Patch for 2.4.22-pre7:

--- linux-2.4.22-pre7/init/do_mounts.c.orig     Wed Jul 23 16:16:51 2003
+++ linux-2.4.22-pre7/init/do_mounts.c  Wed Jul 23 16:16:54 2003
@@ -360,6 +360,7 @@
                                flags |= MS_RDONLY;
                                goto retry;
                        case -EINVAL:
+                       case -EBUSY:
                                continue;
                }
                /*

It's been broken since 2.4.19, so I definitely think it's about time it
gets fixed. ;>

-- 
Martin Persson           martin@kfib.org
http://martin.kfib.org/  http://ss.kfib.org/

  "esound is junk. The only thing esd has is a good client API for
   going boing at approximately the right time. Anything else is
   beyond it." -- Alan Cox
