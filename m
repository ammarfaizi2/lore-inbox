Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752362AbWKCMRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbWKCMRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 07:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbWKCMRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 07:17:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27784 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752362AbWKCMRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 07:17:04 -0500
Message-ID: <454B3282.3010308@redhat.com>
Date: Fri, 03 Nov 2006 07:13:54 -0500
From: Larry Woodman <lwoodman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages() failures reported due to fragmentation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have seen a couple of __alloc_pages() failures due to fragmentation, 
there is plenty
of free memory but no large order pages available.  I think the problem 
is in
sock_alloc_send_pskb(), the gfp_mask includes __GFP_REPEAT but its never
used/passed to the page allocator.  Shouldnt the gfp_mask be passed to 
alloc_skb() ?

-------------------------------------------------------------------
struct sk_buff *sock_alloc_send_pskb()
{
       unsigned int gfp_mask;
... 
                                                                          
       gfp_mask = sk->sk_allocation;
       if (gfp_mask & __GFP_WAIT)
               gfp_mask |= __GFP_REPEAT;
...
       skb = alloc_skb(header_len, sk->sk_allocation);
--------------------------------------------------------------------


--- linux-2.6.18.noarch/net/core/sock.c.orig
+++ linux-2.6.18.noarch/net/core/sock.c
@@ -1154,7 +1154,7 @@ static struct sk_buff *sock_alloc_send_p
 			goto failure;
 
 		if (atomic_read(&sk->sk_wmem_alloc) < sk->sk_sndbuf) {
-			skb = alloc_skb(header_len, sk->sk_allocation);
+			skb = alloc_skb(header_len, gfp_mask);
 			if (skb) {
 				int npages;
 				int i;



