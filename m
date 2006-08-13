Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWHMAuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWHMAuP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 20:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWHMAuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 20:50:14 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:18558 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932635AbWHMAuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 20:50:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=S1kTtT/GClKi10Jnai8T8wfTbCiROCX9X/KfTo5R5TNMcv3Xlkzsf/q1/+YojQLiAJEwuzdFVvA3+BAVN6JyBkPqEY8IvzKP2HsxsOk8o5Ci+yUmUrPbWQ/CJsNoFm1iWD+Yb9KnXEEB5k7EZWjvh92UDjBG3tUSebjyTDw/5gE=
Message-ID: <44DE779D.8060609@gmail.com>
Date: Sat, 12 Aug 2006 17:51:41 -0700
From: Jeff Carr <basilarchia@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take8 1/2] kevent: Core files.
References: <11552856103972@2ka.mipt.ru>
In-Reply-To: <11552856103972@2ka.mipt.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/06 01:40, Evgeniy Polyakov wrote:

> +/*
> + * Inode events.
> + */
> +#define	KEVENT_INODE_CREATE	0x1
> +#define	KEVENT_INODE_REMOVE	0x2

It would be useful to have gnome/kde notification when hard drives start
failing. There was some talk in the past about how to implement that
with kobjects. Perhaps you could add for this purpose:

#define	KEVENT_BLOCK_CREATE	0x1
#define	KEVENT_BLOCK_REMOVE	0x2
#define	KEVENT_BLOCK_ERROR	0x4

AFAICT:
The conversation concluded this is the best way to handle ioerrors:

--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -108,6 +108,8 @@ static void buffer_io_error(struct buffe
 	printk(KERN_ERR "Buffer I/O error on device %s, logical block %Lu\n",
 			bdevname(bh->b_bdev, b),
 			(unsigned long long)bh->b_blocknr);
+
+	kevent_block_error(&bh->b_bdev->bd_disk->kobj);
 }

 /*
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -252,8 +252,11 @@ static void finished_one_bio(struct dio
 				transferred = dio->i_size - offset;

 			/* check for error in completion path */
-			if (dio->io_error)
+			if (dio->io_error) {
 				transferred = dio->io_error;
+				kevent_block_error(
+				&dio->bio->bi_bdev->bd_disk->kobj);
+			}

 			dio_complete(dio, offset, transferred);

