Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422627AbWJ3UPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422627AbWJ3UPo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422626AbWJ3UPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:15:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:23452 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030591AbWJ3UPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:15:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lmgKDNPYzToYIt79a7BqzuAUD8IuLhE2Y77tIfN7yndXORkxgwf6j6ikTYraVp5yH5jXs+yHYE00fCENQoDQnHJhr7ajTJKCFLoUMvzztmZ0ikhwwJhVkUdTS6e0kAKEqYEDKpAd48vAL0AbgOd33qW3uuTmPmcWtlaTuiGVcSs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ISDN: Avoid a potential NULL ptr deref in ippp
Date: Mon, 30 Oct 2006 21:17:24 +0100
User-Agent: KMail/1.9.4
Cc: Michael Hipp <Michael.Hipp@student.uni-tuebingen.de>,
       Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610302117.24760.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's a potential problem in isdn_ppp.c::isdn_ppp_decompress().
dev_alloc_skb() may fail and return NULL. If it does we will be passing a
NULL skb_out to ipc->decompress() and may also end up
dereferencing a NULL pointer at 
    *proto = isdn_ppp_strip_proto(skb_out);
Correct this by testing 'skb_out' against NULL early and bail out.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/isdn/i4l/isdn_ppp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
index 119412d..5a97ce6 100644
--- a/drivers/isdn/i4l/isdn_ppp.c
+++ b/drivers/isdn/i4l/isdn_ppp.c
@@ -2536,6 +2536,11 @@ static struct sk_buff *isdn_ppp_decompre
   		rsparm.maxdlen = IPPP_RESET_MAXDATABYTES;
   
   		skb_out = dev_alloc_skb(is->mru + PPP_HDRLEN);
+  		if (!skb_out) {
+  			kfree_skb(skb);
+  			printk(KERN_ERR "ippp: decomp memory allocation failure\n");
+			return NULL;
+  		}  		
 		len = ipc->decompress(stat, skb, skb_out, &rsparm);
 		kfree_skb(skb);
 		if (len <= 0) {
