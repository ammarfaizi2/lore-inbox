Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVCSUvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVCSUvF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 15:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVCSUvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 15:51:04 -0500
Received: from smtp05.web.de ([217.72.192.209]:63634 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S261354AbVCSUvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 15:51:02 -0500
Message-ID: <423C90B4.8030700@web.de>
Date: Sat, 19 Mar 2005 21:51:00 +0100
From: Jan Kiszka <jan.kiszka@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NULL pointer bug in netpoll.c
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090306020601070603090301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090306020601070603090301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

it seems that there is a gremlin sleeping in 
net/core/netpoll.c:find_skb(). Even if no more buffers are available 
through "skbs", "skb" is dereferenced anyway. The tiny patch should fix it.

Jan

--------------090306020601070603090301
Content-Type: text/plain;
 name="netpoll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netpoll.patch"

--- linux-2.6.11.4/net/core/netpoll.c.orig	2005-03-16 01:09:19.000000000 +0100
+++ linux-2.6.11.4/net/core/netpoll.c	2005-03-19 21:42:41.573018776 +0100
@@ -165,10 +165,11 @@ repeat:
 	if (!skb) {
 		spin_lock_irqsave(&skb_list_lock, flags);
 		skb = skbs;
-		if (skb)
+		if (skb) {
 			skbs = skb->next;
-		skb->next = NULL;
-		nr_skbs--;
+			skb->next = NULL;
+			nr_skbs--;
+		}
 		spin_unlock_irqrestore(&skb_list_lock, flags);
 	}
 

--------------090306020601070603090301--
