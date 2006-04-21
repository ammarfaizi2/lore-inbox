Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWDUGPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWDUGPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 02:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWDUGPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 02:15:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751000AbWDUGPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 02:15:47 -0400
Date: Thu, 20 Apr 2006 23:14:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       kai.germaschewski@gmx.de, kkeil@suse.de, fritz@isdn4linux.de,
       Michael.Hipp@student.uni-tuebingen.de, jesper.juhl@gmail.com,
       tilman@imap.cc
Subject: Re: [PATCH][resend] ISDN: unsafe interaction between isdn_write and
 isdn_writebuf_stub
Message-Id: <20060420231432.6588aaf3.akpm@osdl.org>
In-Reply-To: <200604210006.31653.jesper.juhl@gmail.com>
References: <200604210006.31653.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> --- linux-2.6.17-rc1-git4-orig/drivers/isdn/i4l/isdn_common.c	2006-03-20 06:53:29.000000000 +0100
>  +++ linux-2.6.17-rc1-git4/drivers/isdn/i4l/isdn_common.c	2006-04-11 21:43:26.000000000 +0200
>  @@ -1177,9 +1177,14 @@ isdn_write(struct file *file, const char
>   			goto out;
>   		}
>   		chidx = isdn_minor2chan(minor);
>  -		while (isdn_writebuf_stub(drvidx, chidx, buf, count) != count)
>  + loop:
>  +		retval = isdn_writebuf_stub(drvidx, chidx, buf, count);
>  +		if (retval < 0)
>  +			goto out;
>  +		if (retval != count) {
>   			interruptible_sleep_on(&dev->drv[drvidx]->snd_waitq[chidx]);
>  -		retval = count;
>  +			goto loop;
>  +		}
>   		goto out;
>   	}
>   	if (minor <= ISDN_MINOR_CTRLMAX) {
>  @@ -1951,9 +1956,10 @@ isdn_writebuf_stub(int drvidx, int chan,
>   	struct sk_buff *skb = alloc_skb(hl + len, GFP_ATOMIC);
>   
>   	if (!skb)
>  -		return 0;
>  +		return -ENOMEM;
>   	skb_reserve(skb, hl);
>  -	copy_from_user(skb_put(skb, len), buf, len);
>  +	if (!copy_from_user(skb_put(skb, len), buf, len))
>  +		return -EFAULT;
>   	ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, 1, skb);
>   	if (ret <= 0)
>   		dev_kfree_skb(skb);

It's simpler to code it this way:



From: Jesper Juhl <jesper.juhl@gmail.com>

isdn_writebuf_stub() forgets to detect memory allocation and uaccess errors. 
And when that's fixed, if a error happens the caller will just keep on
looping.

So change the caller to detect the error, and to return it.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Karsten Keil <kkeil@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/isdn/i4l/isdn_common.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff -puN drivers/isdn/i4l/isdn_common.c~isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub drivers/isdn/i4l/isdn_common.c
--- devel/drivers/isdn/i4l/isdn_common.c~isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub	2006-04-20 23:02:53.000000000 -0700
+++ devel-akpm/drivers/isdn/i4l/isdn_common.c	2006-04-20 23:09:18.000000000 -0700
@@ -1177,9 +1177,12 @@ isdn_write(struct file *file, const char
 			goto out;
 		}
 		chidx = isdn_minor2chan(minor);
-		while (isdn_writebuf_stub(drvidx, chidx, buf, count) != count)
+		for ( ; ; ) {
+			retval = isdn_writebuf_stub(drvidx, chidx, buf, count);
+			if (retval < 0 || retval == count)
+				break;
 			interruptible_sleep_on(&dev->drv[drvidx]->snd_waitq[chidx]);
-		retval = count;
+		}
 		goto out;
 	}
 	if (minor <= ISDN_MINOR_CTRLMAX) {
@@ -1951,9 +1954,10 @@ isdn_writebuf_stub(int drvidx, int chan,
 	struct sk_buff *skb = alloc_skb(hl + len, GFP_ATOMIC);
 
 	if (!skb)
-		return 0;
+		return -ENOMEM;
 	skb_reserve(skb, hl);
-	copy_from_user(skb_put(skb, len), buf, len);
+	if (!copy_from_user(skb_put(skb, len), buf, len))
+		return -EFAULT;
 	ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, 1, skb);
 	if (ret <= 0)
 		dev_kfree_skb(skb);
_






But the code still looks wrong.  If isdn_writebuf_stub() does a short write, we'll
just retry the entire write.  And if that returns the same short write, we'll
retry the write again, ad infinitum.

One would expect that if a short write happened, we either bale out with an
error or we advance partway through the buffer and write some more.

But I can't even spell ISDN.

