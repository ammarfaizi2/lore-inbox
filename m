Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbTBFSoP>; Thu, 6 Feb 2003 13:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267516AbTBFSoP>; Thu, 6 Feb 2003 13:44:15 -0500
Received: from fmr01.intel.com ([192.55.52.18]:42459 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267513AbTBFSoO>;
	Thu, 6 Feb 2003 13:44:14 -0500
Subject: Re: skb_padto and small fragmented transmits
From: Chris Leech <christopher.leech@intel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F20BA2AAD1@orsmsx118.jf.intel.com>
References: <BD9B60A108C4D511AAA10002A50708F20BA2AAD1@orsmsx118.jf.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044559370.4620.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 06 Feb 2003 11:22:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 03:58, David S. Miller wrote:

> skb_padto() only works on linear skb.

The result is always a linear skb.  Given that skb_padto() takes into
account data_len (incorrectly, but still) and skb_pad() contains a
comment about non-linear skb always having zero tailroom, it certainly
looks like these were written with the attempt to work for non-linear
buffers.

I fail to see how the statement "skb->len + skb->data_len" has any
usable meaning, or how it can be anything other than a bug.

The checksum issue I mentioned is not as clear.  I haven't looked at all
the callers of skb_copy_expand() and copy_skb_header() to see what
effect copying ip_summed in one of those calls might have elsewhere.

> And if you look at all the drivers where it is used, they
> do not enable things like scatter-gather.

So because the problem is not currently exposed, it's acceptable for the
code to be incorrect?

-- Chris


diff -aur a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h	2003-01-13 12:45:20.000000000 -0800
+++ b/include/linux/skbuff.h	2003-02-05 12:25:38.000000000 -0800
@@ -1102,7 +1102,7 @@
  
 static inline struct sk_buff *skb_padto(struct sk_buff *skb, unsigned int len)
 {
-	unsigned int size = skb->len + skb->data_len;
+	unsigned int size = skb->len;
 	if (likely(size >= len))
 		return skb;
 	return skb_pad(skb, len-size);



