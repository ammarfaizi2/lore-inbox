Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261332AbSKGRnN>; Thu, 7 Nov 2002 12:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSKGRnN>; Thu, 7 Nov 2002 12:43:13 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:37273 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261332AbSKGRnM>;
	Thu, 7 Nov 2002 12:43:12 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200211071749.UAA10171@sex.inr.ac.ru>
Subject: Re: IPSEC FIRST LIGHT! (by non-kernel developer :-))
To: davem@redhat.com (David S. Miller)
Date: Thu, 7 Nov 2002 20:49:37 +0300 (MSK)
Cc: ahu@ds9a.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20021107.071808.43409100.davem@redhat.com> from "David S. Miller" at Nov 7, 2 07:18:08 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Alexey, any ideas?

Yes, rules with prefixlen!=32 do not work, gem forgot htonl() on netmask.

Also, forwarding is still sick, as I told you before going to sleep,
so expect a patch soon. Unfortunately, despite of all the precautions
I sleeped all the day, so I am again at the point when cannot test
anything but loopback. :-)

Alexey


===== net/key/af_key.c 1.6 vs edited =====
--- 1.6/net/key/af_key.c	Thu Nov  7 04:52:11 2002
+++ edited/net/key/af_key.c	Thu Nov  7 20:44:51 2002
@@ -488,7 +491,8 @@
 	case AF_INET:
 		xaddr->xfrm4_addr = 
 			((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr;
-		xaddr->xfrm4_mask = ~0 << (32 - addr->sadb_address_prefixlen);
+		if (addr->sadb_address_prefixlen)
+			xaddr->xfrm4_mask = htonl(~0 << (32 - addr->sadb_address_prefixlen));
 		break;
 	case AF_INET6:
 		memcpy(xaddr->a6, 
