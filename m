Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTDRT5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 15:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbTDRT5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 15:57:11 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9161 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263230AbTDRT5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 15:57:10 -0400
Date: Fri, 18 Apr 2003 15:17:04 -0500
From: latten@austin.ibm.com
Message-Id: <200304182017.h3IKH4ng019821@faith.austin.ibm.com>
To: davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com
Subject: IPsecv6 integrity failures not dropped
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running IPSecv6 on 2.5.67 with patch-2.5.67-bk8.

If AH authentication or ESP encryption integrity check for an 
incoming packet fails, result is an ICMPv6 Parameter problem 
of Unknown-Next-Header, instead of just dropping packet. This 
is because xfrm6_rcv() expects an unsigned-8-bit return value 
from the input handler, i.e. ah6_input() or esp6_input(). But handler 
returns a signed int (-EINVAL) that seems to be getting converted into 
a "u8" via 2's complement, because ah6_input() says it is returning
-EINVAL/-22, but xfrm6_rcv() says it got a return value of 234,
which it believes to be valid and passes to ip6_input() who thinks it is 
the next header.  

I modified ah6_input() and esp6_input() to return zero instead of -EINVAL
in the fix below. I tested it and it works.

Please let me know if this is ok. 

Joy
-------------------------------------------------------------------------

--- ah6.c.orig	2003-04-17 16:04:07.000000000 -0500
+++ ah6.c	2003-04-18 14:15:37.000000000 -0500
@@ -212,7 +212,7 @@
 free_out:
 	kfree(tmp_hdr);
 out:
-	return -EINVAL;
+	return 0;
 }
 
 void ah6_err(struct sk_buff *skb, struct inet6_skb_parm *opt, 
--- esp6.c.orig	2003-04-17 17:07:25.000000000 -0500
+++ esp6.c	2003-04-17 17:08:17.000000000 -0500
@@ -346,7 +346,7 @@
 	return ret_nexthdr;
 
 out:
-	return -EINVAL;
+	return 0;
 }
 
 static u32 esp6_get_max_size(struct xfrm_state *x, int mtu)
