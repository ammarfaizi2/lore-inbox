Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269445AbUJFV2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269445AbUJFV2p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269439AbUJFU2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:28:02 -0400
Received: from mail.dif.dk ([193.138.115.101]:7134 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269415AbUJFUSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:18:08 -0400
Date: Wed, 6 Oct 2004 22:25:36 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "David A. Hinds" <dahinds@users.sourceforge.net>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: Re: [PATCH] check the return value of __copy_to_user in
 drivers/pcmcia/ds.c::ds_ioctl and return -EFAULT if it fails
In-Reply-To: <20041006114342.B29243@infradead.org>
Message-ID: <Pine.LNX.4.61.0410062221420.2975@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410060012590.2913@dragon.hygekrogen.localhost>
 <20041006114342.B29243@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Christoph Hellwig wrote:

> On Wed, Oct 06, 2004 at 12:21:58AM +0200, Jesper Juhl wrote:
> > 
> >   CC      drivers/pcmcia/ds.o
> > include/asm/uaccess.h: In function `ds_ioctl':
> > drivers/pcmcia/ds.c:1049: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
> > 
> > Patch adds a check of the return value and returns -EFAULT if 
> > __copy_to_user fails.
> 
> I think this function should use the non-__ prefix version 

Sounds resonable to me.


>and remove access_ok
> again
> 
Actually I see no access_ok there, there's not one single call to that 
function in this file (2.6.9-rc3-bk5).

How about the following patch instead? 

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc3-bk5-orig/drivers/pcmcia/ds.c linux-2.6.9-rc3-bk5/drivers/pcmcia/ds.c
--- linux-2.6.9-rc3-bk5-orig/drivers/pcmcia/ds.c	2004-10-05 22:07:27.000000000 +0200
+++ linux-2.6.9-rc3-bk5/drivers/pcmcia/ds.c	2004-10-06 22:20:27.000000000 +0200
@@ -1046,7 +1046,11 @@ static int ds_ioctl(struct inode * inode
 	}
     }
 
-    if (cmd & IOC_OUT) __copy_to_user(uarg, (char *)&buf, size);
+    if (cmd & IOC_OUT) {
+        if (copy_to_user(uarg, (char *)&buf, size))
+            err = -EFAULT;
+    }
+
 
     return err;
 } /* ds_ioctl */


