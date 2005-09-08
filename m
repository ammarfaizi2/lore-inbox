Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbVIHBdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVIHBdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVIHBcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:32:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47514 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932855AbVIHB3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:29:41 -0400
Message-Id: <20050908012856.927348000@localhost.localdomain>
References: <20050908012842.299637000@localhost.localdomain>
Date: Wed, 07 Sep 2005 18:28:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, herbert@gondor.apana.org.au,
       kaber@trash.net, "David S. Miller" <davem@davemloft.net>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 5/9] [NET]: 2.6.13 breaks libpcap (and tcpdump)
Content-Disposition: inline; filename=fix-socket-filter-regression.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

[NET]: 2.6.13 breaks libpcap (and tcpdump)

Patrick McHardy says:

  Never mind, I got it, we never fall through to the second switch
  statement anymore. I think we could simply break when load_pointer
  returns NULL. The switch statement will fall through to the default
  case and return 0 for all cases but 0 > k >= SKF_AD_OFF.

Here's a patch to do just that.

I left BPF_MSH alone because it's really a hack to calculate the IP
header length, which makes no sense when applied to the special data.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 net/core/filter.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.13.y/net/core/filter.c
===================================================================
--- linux-2.6.13.y.orig/net/core/filter.c
+++ linux-2.6.13.y/net/core/filter.c
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

--
