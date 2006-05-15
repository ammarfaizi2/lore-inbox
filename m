Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWEOSEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWEOSEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEOSEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:04:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:52451 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965030AbWEOSEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:04:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JlhZxJyACudbZjdoa/EPNmp/UejqA0wGS3T/H4xQrNSMtd+Wr8SMfZHBytNtOP13ngjkuhCeq78sCEWYQTTk3vQrXpCe9RhNWKEKTuKxn1IcvxaD57/ZtpZMjRVexocEkLGm57cY9bbxvL8IdYc1jVFrGXDBSuvn5nYa8SLaFnc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Date: Mon, 15 May 2006 20:05:14 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org>
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152005.14519.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 09:56, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/
> 
Hi Andrew,

While going through my patches currently in -mm I noticed a problem.
I have to hang my head i shame and admit to introducing a bug in what should 
have been a bugFIX patch :-(

In the 
isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub.patch 
patch, which is currently in -mm there's a bug.

This bit :
 -       copy_from_user(skb_put(skb, len), buf, len);
 +       if (!copy_from_user(skb_put(skb, len), buf, len))
should really be :
 -       copy_from_user(skb_put(skb, len), buf, len);
 +       if (copy_from_user(skb_put(skb, len), buf, len))
Somehow a stray "!" crept in there.

Sorry about that. Here's a tiny fix-it-up patch to be applied on top : 


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

--- linux-2.6.17-rc4-mm1-orig/drivers/isdn/i4l/isdn_common.c	2006-05-15 19:43:06.000000000 +0200
+++ linux-2.6.17-rc4-mm1/drivers/isdn/i4l/isdn_common.c	2006-05-15 19:58:26.000000000 +0200
@@ -1952,7 +1952,7 @@ isdn_writebuf_stub(int drvidx, int chan,
 	if (!skb)
 		return -ENOMEM;
 	skb_reserve(skb, hl);
-	if (!copy_from_user(skb_put(skb, len), buf, len))
+	if (copy_from_user(skb_put(skb, len), buf, len))
 		return -EFAULT;
 	ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, 1, skb);
 	if (ret <= 0)


