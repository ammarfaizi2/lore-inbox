Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUJJCWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUJJCWd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 22:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUJJCWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 22:22:32 -0400
Received: from mail.dif.dk ([193.138.115.101]:8931 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268053AbUJJCWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 22:22:13 -0400
Date: Sun, 10 Oct 2004 04:29:51 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ben Collins <bcollins@debian.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: [PATCH] check copy_to_user return value in raw1394
In-Reply-To: <41687FCA.5010907@osdl.org>
Message-ID: <Pine.LNX.4.61.0410100426110.29333@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410100208270.2973@dragon.hygekrogen.localhost>
 <Pine.LNX.4.61.0410100220580.2973@dragon.hygekrogen.localhost>
 <41687FCA.5010907@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2004, Randy.Dunlap wrote:

> Jesper Juhl wrote:
> > On Sun, 10 Oct 2004, Jesper Juhl wrote:
> > 
> > 
> > > Here's a proposed patch to make sure we check the return value of
> > > copy_to_user in raw1394.c::raw1394_read
> > 
> 
> How about sending it to:
> 
> IEEE 1394 SUBSYSTEM
> P:	Ben Collins
> M:	bcollins@debian.org
> L:	linux1394-devel@lists.sourceforge.net
> W:	http://www.linux1394.org/
> S:	Maintained
> 

Right, I should probably do that... Added as a recipient on this mail...

> and change "if(" to "if (" ...
> 
Done.


Here's a revised patch : 

Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc3-bk9-orig/drivers/ieee1394/raw1394.c linux-2.6.9-rc3-bk9/drivers/ieee1394/raw1394.c
--- linux-2.6.9-rc3-bk9-orig/drivers/ieee1394/raw1394.c	2004-09-30 05:03:45.000000000 +0200
+++ linux-2.6.9-rc3-bk9/drivers/ieee1394/raw1394.c	2004-10-10 04:24:57.000000000 +0200
@@ -411,6 +411,7 @@ static ssize_t raw1394_read(struct file 
         struct file_info *fi = (struct file_info *)file->private_data;
         struct list_head *lh;
         struct pending_request *req;
+	ssize_t ret;
 
         if (count != sizeof(struct raw1394_request)) {
                 return -EINVAL;
@@ -443,10 +444,15 @@ static ssize_t raw1394_read(struct file 
                         req->req.error = RAW1394_ERROR_MEMFAULT;
                 }
         }
-        __copy_to_user(buffer, &req->req, sizeof(req->req));
+        if (copy_to_user(buffer, &req->req, sizeof(req->req))) {
+		ret = -EFAULT;
+		goto out;
+	}
 
+        ret = (ssize_t)sizeof(struct raw1394_request);
+out:
         free_pending_request(req);
-        return sizeof(struct raw1394_request);
+	return ret;
 }
 
 

