Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271082AbUJUXRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271082AbUJUXRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271113AbUJUXPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:15:52 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36586 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S271056AbUJUXCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:02:24 -0400
Date: Fri, 22 Oct 2004 00:58:25 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 - e1000 - page allocation failed
Message-ID: <20041021225825.GA10844@electric-eye.fr.zoreil.com>
References: <20041021221622.GA11607@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021221622.GA11607@mail.muni.cz>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@mail.muni.cz> :
[page allocation failure with e1000]

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

