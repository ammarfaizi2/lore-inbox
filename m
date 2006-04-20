Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWDTWFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWDTWFs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWDTWFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:05:48 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:6101 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932070AbWDTWFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:05:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TBPhZAPeDgXxKi8Ohr4tII3c018zzmJ6dpEM0p6ymrjWptECpJgGGehbIpLZZLztLliTv1BA60RdF/Fzd5MZ356q6sXbVltnnR3BI6Zo+RvrbfjQuEp8Nf6snYum2o80Btb3n+9kLYN6BYEzj6Rge05MG+2EphegUoAvdzBwTR4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][resend] ISDN: unsafe interaction between isdn_write and isdn_writebuf_stub
Date: Fri, 21 Apr 2006 00:06:31 +0200
User-Agent: KMail/1.9.1
Cc: isdn4linux@listserv.isdn4linux.de, kai.germaschewski@gmx.de, kkeil@suse.de,
       Andrew Morton <akpm@osdl.org>, Fritz Elfert <fritz@isdn4linux.de>,
       Michael.Hipp@student.uni-tuebingen.de,
       Jesper Juhl <jesper.juhl@gmail.com>, Tilman Schmidt <tilman@imap.cc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604210006.31653.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(patch previously send on April 11'th - this is a resend)

isdn_write() and isdn_writebuf_stub() seem to have some unsafe interaction.

I was originally just looking to fix this warning:
  drivers/isdn/i4l/isdn_common.c:1956: warning: ignoring return value of `opy_from_user', declared with attribute warn_unused_result
And indeed, the return value is not checked, and I can't convince myself
that it's 100% certain that it can never fail.

While reading the code I also noticed that the while loop in isdn_write()
only tests for isdn_writebuf_stub() return value != count as termination
condition. This makes it impossible for isdn_writebuf_stub() to tell the 
caller why it failed so the caller can pass that info on.
It also looks unsafe that if isdn_writebuf_stub() fails to allocate an skb,
then it just returns 0 (zero) which is unlikely to cause the != count 
check in the caller to abort the loop, so it looks like it'll just enter 
the function once more and again fail to alloc an skb, repeat ad infinitum.

To fix these things I first made isdn_writebuf_stub() return -ENOMEM if it 
cannot allocate an skb and also return -EFAULT if the user copy fails.
 (this ofcourse also fixes the warning I was originally investigating)

Then I ditched the while loop in isdn_write() and replaced it with a 
hand-coded loop made up of a label and a goto, and inside this hand-made 
loop I then test if isdn_writebuf_stub() returns a value <=0 and if it does
then that value is used as the `retval' from isdn_write() and if not then 
it tests the !=count condition and otherwise behaves like the original 
while loop.


I hope my analysis of the situation and the resulting fix is correct; if 
not, then I'd appreciate feedback pointing out my error(s).

Unfortunately I have no hardware to properly test the patch, so it's 
compile tested only. So please read the patch carefully before applying it.


Tilman Schmidt gave me some feedback : 
"... my development machine has been running with your patch for a
while, with no apparent ill effects. Although this hardly qualifies as
exhaustive testing, it does seem do indicate that the patch is on the
right track."


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/isdn/i4l/isdn_common.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

--- linux-2.6.17-rc1-git4-orig/drivers/isdn/i4l/isdn_common.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc1-git4/drivers/isdn/i4l/isdn_common.c	2006-04-11 21:43:26.000000000 +0200
@@ -1177,9 +1177,14 @@ isdn_write(struct file *file, const char
 			goto out;
 		}
 		chidx = isdn_minor2chan(minor);
-		while (isdn_writebuf_stub(drvidx, chidx, buf, count) != count)
+ loop:
+		retval = isdn_writebuf_stub(drvidx, chidx, buf, count);
+		if (retval < 0)
+			goto out;
+		if (retval != count) {
 			interruptible_sleep_on(&dev->drv[drvidx]->snd_waitq[chidx]);
-		retval = count;
+			goto loop;
+		}
 		goto out;
 	}
 	if (minor <= ISDN_MINOR_CTRLMAX) {
@@ -1951,9 +1956,10 @@ isdn_writebuf_stub(int drvidx, int chan,
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


