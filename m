Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269473AbUJST2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269473AbUJST2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269596AbUJST01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 15:26:27 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:8392 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S269788AbUJSTWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 15:22:09 -0400
Date: Tue, 19 Oct 2004 21:18:17 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 page allocation failures?
Message-ID: <20041019191817.GA13208@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.61.0410191207000.10356@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410191207000.10356@p500>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz <jpiszcz@lucidpixels.com> :
[...]
> lftp: page allocation failure. order:0, mode:0x20
>  [<c01391a7>] __alloc_pages+0x247/0x3b0
>  [<c0139328>] __get_free_pages+0x18/0x40
>  [<c013c9af>] kmem_getpages+0x1f/0xc0
>  [<c013d6f0>] cache_grow+0xc0/0x1a0
>  [<c013d99b>] cache_alloc_refill+0x1cb/0x210
>  [<c013de01>] __kmalloc+0x71/0x80
>  [<c036f463>] alloc_skb+0x53/0x100
>  [<c031f9f8>] e1000_alloc_rx_buffers+0x48/0xf0
>  [<c031f6fe>] e1000_clean_rx_irq+0x18e/0x440

If you are using TSO, try patch below by Herbert Xu (available
from http://marc.theaimsgroup.com/?l=linux-netdev&m=109799935603132&w=3)

--- 1.67/net/ipv4/tcp_output.c	2004-10-01 13:56:45 +10:00
+++ edited/net/ipv4/tcp_output.c	2004-10-17 18:58:47 +10:00
@@ -455,8 +455,12 @@
 {
 	struct tcp_opt *tp = tcp_sk(sk);
 	struct sk_buff *buff;
-	int nsize = skb->len - len;
+	int nsize;
 	u16 flags;
+
+	nsize = skb_headlen(skb) - len;
+	if (nsize < 0)
+		nsize = 0;
 
 	if (skb_cloned(skb) &&
 	    skb_is_nonlinear(skb) &&

