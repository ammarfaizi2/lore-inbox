Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268435AbUIQGdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268435AbUIQGdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 02:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268446AbUIQGdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 02:33:24 -0400
Received: from ozlabs.org ([203.10.76.45]:52129 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268435AbUIQGdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 02:33:22 -0400
Date: Fri, 17 Sep 2004 16:20:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@redhat.com>, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [TRIVIAL] Fix recent bug in fib_semantics.c
Message-ID: <20040917062042.GE6523@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, David Miller <davem@redhat.com>,
	trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

When fib_create_info() allocates new hash tables, it neglects to
initialize them.  This leads to an oops during boot on at least
machine I use.  This patch addresses the problem.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/net/ipv4/fib_semantics.c
===================================================================
--- working-2.6.orig/net/ipv4/fib_semantics.c	2004-09-17 09:20:04.000000000 +1000
+++ working-2.6/net/ipv4/fib_semantics.c	2004-09-17 16:24:42.634638304 +1000
@@ -604,8 +604,12 @@
 		if (!new_info_hash || !new_laddrhash) {
 			fib_hash_free(new_info_hash, bytes);
 			fib_hash_free(new_laddrhash, bytes);
-		} else
+		} else {
+			memset(new_info_hash, 0, bytes);
+			memset(new_laddrhash, 0, bytes);
+
 			fib_hash_move(new_info_hash, new_laddrhash, new_size);
+		}
 
 		if (!fib_hash_size)
 			goto failure;



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
