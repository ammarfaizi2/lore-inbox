Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWDQLE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWDQLE7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 07:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWDQLE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 07:04:59 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:39539 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750760AbWDQLE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 07:04:58 -0400
Message-ID: <4443780B.1040108@openvz.org>
Date: Mon, 17 Apr 2006 15:12:11 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       devel@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mishin Dmitry <dim@openvz.org>
Subject: [PATCH] unaligned access in sk_run_filter()
Content-Type: multipart/mixed;
 boundary="------------040804020606030206020804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040804020606030206020804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH] unaligned access in sk_run_filter()

This patch fixes unaligned access warnings noticed on IA64
in sk_run_filter(). 'ptr' can be unaligned.

Signed-Off-By: Dmitry Mishin <dim@openvz.org>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>


--------------040804020606030206020804
Content-Type: text/plain;
 name="diff-ms-ia64-unalign-skrunfilter"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-ia64-unalign-skrunfilter"

--- ./net/core/filter.c.ve125	2006-04-05 15:11:24.000000000 +0400
+++ ./net/core/filter.c	2006-04-05 15:55:33.000000000 +0400
@@ -34,6 +34,7 @@
 #include <linux/timer.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/unaligned.h>
 #include <linux/filter.h>
 
 /* No hurry in this branch */
@@ -177,7 +178,7 @@ unsigned int sk_run_filter(struct sk_buf
 load_w:
 			ptr = load_pointer(skb, k, 4, &tmp);
 			if (ptr != NULL) {
-				A = ntohl(*(u32 *)ptr);
+				A = ntohl(get_unaligned((u32 *)ptr));
 				continue;
 			}
 			break;
@@ -186,7 +187,7 @@ load_w:
 load_h:
 			ptr = load_pointer(skb, k, 2, &tmp);
 			if (ptr != NULL) {
-				A = ntohs(*(u16 *)ptr);
+				A = ntohs(get_unaligned((u16 *)ptr));
 				continue;
 			}
 			break;

--------------040804020606030206020804--

