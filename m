Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317500AbSHCK0v>; Sat, 3 Aug 2002 06:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSHCK0v>; Sat, 3 Aug 2002 06:26:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22957 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317500AbSHCK0u>;
	Sat, 3 Aug 2002 06:26:50 -0400
Date: Sat, 03 Aug 2002 03:17:40 -0700 (PDT)
Message-Id: <20020803.031740.84726417.davem@redhat.com>
To: trond.myklebust@fys.uio.no
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Fragment flooding in 2.4.x/2.5.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200207011414.50465.trond.myklebust@fys.uio.no>
References: <200206281821.WAA00420@mops.inr.ac.ru>
	<200207011414.50465.trond.myklebust@fys.uio.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Trond Myklebust <trond.myklebust@fys.uio.no>
   Date: Mon, 1 Jul 2002 14:14:50 +0200
   
   I've now got the application and a demonstration of what kind of fix is 
   needed. I hope you and Dave can work out a better patch in for 2.4.20-pre  
   ;-)...

Trond does this patch fix your problem?  It is exactly how Alexey
described the fix and it should work.

I think the memory failure issue is totally moot.  In fact your
"accumulate skb till we have them all, then send the whole bunch"
version of the fix is very bad because it defers the transmit
on the device until the whole set of fragments have been created.

--- net/ipv4/ip_output.c.~1~	Sat Aug  3 03:14:35 2002
+++ net/ipv4/ip_output.c	Sat Aug  3 03:20:49 2002
@@ -520,8 +520,18 @@
 		/*
 		 *	Get the memory we require with some space left for alignment.
 		 */
-
-		skb = sock_alloc_send_skb(sk, fraglen+hh_len+15, flags&MSG_DONTWAIT, &err);
+		if (!(flags & MSG_DONTWAIT) || nfrags == 0) {
+			skb = sock_alloc_send_skb(sk, fraglen + hh_len + 15,
+						  (flags & MSG_DONTWAIT), &err);
+		} else {
+			/* On a non-blocking write, we check for send buffer
+			 * usage on the first fragment only.
+			 */
+			skb = sock_wmalloc(sk, fraglen + hh_len + 15, 1,
+					   sk->allocation);
+			if (!skb)
+				err = -ENOBUFS;
+		}
 		if (skb == NULL)
 			goto error;
 
