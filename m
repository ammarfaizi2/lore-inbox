Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVIDRG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVIDRG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbVIDRG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:06:28 -0400
Received: from mail.collax.com ([213.164.67.137]:41435 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932065AbVIDRG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:06:27 -0400
Message-ID: <431B2985.1060502@trash.net>
Date: Sun, 04 Sep 2005 19:06:13 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Andrew Morton <akpm@osdl.org>, jmcgowan@inch.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: Kernel 2.6.13 breaks libpcap (and tcpdump).
References: <E1EBpkT-0001RP-00@gondolin.me.apana.org.au>
In-Reply-To: <E1EBpkT-0001RP-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> We aren't handling the reading of specific fields like the IP protocol
> field correctly.  This patch should make it work again.

I can't spot the problem, could you give me a hint?

> I tried to move this logic into the new load_pointer function but it
> all came out messy so I simply rolled it back.

  		case BPF_LD|BPF_W|BPF_ABS:
  			k = fentry->k;
   load_w:
-			ptr = load_pointer(skb, k, 4, &tmp);
+			if (k >= 0)
+				ptr = skb_header_pointer(skb, k, 4, &tmp);
+			else if (k < SKF_AD_OFF)
+				ptr = load_pointer(skb, k);
+			else
+				break;

The old value of ptr will be used in this case, it should
be explicitly set to NULL to abort.
