Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVG2JFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVG2JFd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVG2JFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:05:33 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:27875 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262521AbVG2JFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:05:17 -0400
Message-ID: <42E9F145.7040302@cosmosbay.com>
Date: Fri, 29 Jul 2005 11:05:09 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slab.c : prefetchw the start of new allocated objects
References: <42E6C8DB.4090608@earthlink.net>	<s5hr7dklko4.wl%tiwai@suse.de>	<42E7A8D8.1030809@earthlink.net> <20050729014150.6e97dfd2.akpm@osdl.org>
In-Reply-To: <20050729014150.6e97dfd2.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040401010805070800010300"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 29 Jul 2005 11:05:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040401010805070800010300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[MM] slab.c : prefetchw the start of new allocated objects

Most of objects returned by __cache_alloc() will be written by the caller,
(but not all callers want to write all the object, but just at the begining)
prefetchw() tells the modern CPU to think about the future writes, ie start
some memory transactions in advance.

Some CPU lacks a prefetchw() and currently do nothing, so I ask this question :
Should'nt make prefetchw() do at least a prefetch() ? A read hint is better than nothing.


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------040401010805070800010300
Content-Type: text/plain;
 name="slab.prefetchw"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab.prefetchw"

diff -Nru linux-2.6.13-rc4/mm/slab.c linux-2.6.13-rc4-ed/mm/slab.c
--- linux-2.6.13-rc4/mm/slab.c	2005-07-29 00:44:44.000000000 +0200
+++ linux-2.6.13-rc4-ed/mm/slab.c	2005-07-29 10:48:45.000000000 +0200
@@ -2166,6 +2166,7 @@
 	}
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, __builtin_return_address(0));
+	prefetchw(objp);
 	return objp;
 }
 

--------------040401010805070800010300--
