Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316431AbSE3Gc7>; Thu, 30 May 2002 02:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316444AbSE3Gc6>; Thu, 30 May 2002 02:32:58 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:39872 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S316431AbSE3Gc6>; Thu, 30 May 2002 02:32:58 -0400
Message-ID: <11a801c207a3$d5449320$8f320c80@adar>
From: "Adar Dembo" <adar@stanford.edu>
To: <mac@melware.de>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/isdn/eicon/eicon_idi.c: (2.5.17) dev_kfree_skb on wrong variable
Date: Wed, 29 May 2002 23:32:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

        The patch below changes one of the dev_kfree_skb() calls, which
incorrectly frees the wrong variable, and leaves some memory orphaned.
Specifically, in idi_send_data(), two skb's, "xmit_skb" and "skb2" are
allocated with alloc_skb. A check is made to see if either allocation
failed; if one did, whichever one (if at all) succeeded is
dev_kfree_skb()'d, and the function returns an error message. One of
these dev_kfree_skb() calls was freeing "skb" instead of "xmit_skb".

        Looking at the other calls to idi_send_data() and the rest of
the function, I believe "skb" should still be dev_kfree_skb()'d prior to
the return, but I am not 100% sure. The maintainer should look into this
and fix it if necessary.

-Adar Dembo

--- drivers/isdn/eicon/eicon_idi.c.orig 2002-05-20
22:07:28.000000000 -0700
+++ drivers/isdn/eicon/eicon_idi.c      2002-05-27
01:42:04.000000000 -0700
@@ -2972,7 +2972,7 @@
                        spin_unlock_irqrestore(&eicon_lock, flags);
                        eicon_log(card, 1, "idi_err: Ch%d: alloc_skb
failed in s
end_data()\n", chan->No);
                        if (xmit_skb)
-                               dev_kfree_skb(skb);
+                               dev_kfree_skb(xmit_skb);
                        if (skb2)
                                dev_kfree_skb(skb2);
                        return -ENOMEM;


