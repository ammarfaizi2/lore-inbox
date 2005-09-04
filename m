Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVIDWJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVIDWJq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVIDWJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:09:46 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:23512 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S932090AbVIDWJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:09:45 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kaber@trash.net (Patrick McHardy)
Subject: Re: Kernel 2.6.13 breaks libpcap (and tcpdump).
Cc: herbert@gondor.apana.org.au, akpm@osdl.org, jmcgowan@inch.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net
Organization: Core
In-Reply-To: <431B2F6E.9070401@trash.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EC2gG-0006hm-00@gondolin.me.apana.org.au>
Date: Mon, 05 Sep 2005 08:09:40 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy <kaber@trash.net> wrote:
> 
> Never mind, I got it, we never fall through to the second switch
> statement anymore. I think we could simply break when load_pointer
> returns NULL. The switch statement will fall through to the default
> case and return 0 for all cases but 0 > k >= SKF_AD_OFF.

Thanks Patrick, that's a much better idea.  Here's a patch to do just
that.

I left BPF_MSH alone because it's really a hack to calculate the IP
header length, which makes no sense when applied to the special data.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

BTW, you should be able to send me mail now.  Sorry about that.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/net/core/filter.c b/net/core/filter.c
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -182,7 +182,7 @@ int sk_run_filter(struct sk_buff *skb, s
 				A = ntohl(*(u32 *)ptr);
 				continue;
 			}
-			return 0;
+			break;
 		case BPF_LD|BPF_H|BPF_ABS:
 			k = fentry->k;
  load_h:
@@ -191,7 +191,7 @@ int sk_run_filter(struct sk_buff *skb, s
 				A = ntohs(*(u16 *)ptr);
 				continue;
 			}
-			return 0;
+			break;
 		case BPF_LD|BPF_B|BPF_ABS:
 			k = fentry->k;
 load_b:
@@ -200,7 +200,7 @@ load_b:
 				A = *(u8 *)ptr;
 				continue;
 			}
-			return 0;
+			break;
 		case BPF_LD|BPF_W|BPF_LEN:
 			A = skb->len;
 			continue;
