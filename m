Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751904AbWIGWI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbWIGWI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWIGWI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:08:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:42605 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751904AbWIGWI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:08:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=P4lEZ0lJZxPBZkR9/8zVcmujnGieynxlFs5MjNfpNf39nbJ75IoViI9Ttdvmbr2pOYmzeLQtGOyIausPYmHSqIGdSUxHUhA6MbfaspoFXrSLWNmItJXvJVZxQHIsUbz5+B+ODEAaNcEX9Upuiv/tcGruyArtDxxthJccsNa0YQk=
Date: Fri, 8 Sep 2006 02:08:53 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, Greg KH <greg@kroah.com>
Subject: Re: Naughty ramdrives
Message-ID: <20060907220852.GA5192@martell.zuzino.mipt.ru>
References: <20060907205927.GA5193@martell.zuzino.mipt.ru> <20060907145412.db920bb5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907145412.db920bb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I assume udev is still madly crunching on its message backlog while
> this is happening?
>
> If so, ug.

OK. I'll let it stabilize, sorry.

> > This was noticed while investigating #4899
> > http://bugme.osdl.org/show_bug.cgi?id=4899
> > where /dev/ram0 when opened, pins module indefinitely. It seems that
> > adding ->release() which undoes
> >
> > 	inode = igrab(bdev->bd_inode);
> >
> > should do the trick. Am I right?

> Looks right.
>
> I'm not sure that igrab() is needed though.  Probably bd_openers is
> sufficient.
>
> I'm also not sure that rd_open() needs to play with bd_openers.
> fs/block_dev.c:do_open() already does that.

Maybe start with closing open/open race?
That's what drivers/char/raw.c does...
------------------------------------------------
[PATCH 1/2] rd: protect rd_bdev[] with mutex

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/block/rd.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/block/rd.c
+++ b/drivers/block/rd.c
@@ -56,6 +56,7 @@ #include <linux/buffer_head.h>		/* for i
 #include <linux/backing-dev.h>
 #include <linux/blkpg.h>
 #include <linux/writeback.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 
@@ -63,6 +64,7 @@ #include <asm/uaccess.h>
  */
 
 static struct gendisk *rd_disks[CONFIG_BLK_DEV_RAM_COUNT];
+static DEFINE_MUTEX(rd_mutex);
 static struct block_device *rd_bdev[CONFIG_BLK_DEV_RAM_COUNT];/* Protected device data */
 static struct request_queue *rd_queue[CONFIG_BLK_DEV_RAM_COUNT];
 
@@ -343,6 +345,7 @@ static int rd_open(struct inode *inode, 
 {
 	unsigned unit = iminor(inode);
 
+	mutex_lock(&rd_mutex);
 	if (rd_bdev[unit] == NULL) {
 		struct block_device *bdev = inode->i_bdev;
 		struct address_space *mapping;
@@ -382,6 +385,7 @@ static int rd_open(struct inode *inode, 
 		gfp_mask |= __GFP_HIGH;
 		mapping_set_gfp_mask(mapping, gfp_mask);
 	}
+	mutex_unlock(&rd_mutex);
 
 	return 0;
 }

