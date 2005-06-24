Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263271AbVFXV6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbVFXV6B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbVFXVzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 17:55:43 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:10652 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S263271AbVFXVyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 17:54:53 -0400
X-IronPort-AV: i="3.93,229,1115017200"; 
   d="scan'208"; a="194148582:sNHT788599162"
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 2/3] IB: Fix pack/unpack when size_bits == 64
In-Reply-To: <20056241454.JSnV6qzt9RST2IRw@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 24 Jun 2005 14:54:42 -0700
Message-Id: <20056241454.C4xXsKbhkkqxG17N@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix handling of fields with size_bits == 64.  Pointed out by Hal Rosenstock.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/packer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)



--- linux-export2.orig/drivers/infiniband/core/packer.c	2005-06-23 13:16:25.000000000 -0700
+++ linux-export2/drivers/infiniband/core/packer.c	2005-06-24 14:49:44.448271407 -0700
@@ -96,7 +96,7 @@
 			else
 				val = 0;
 
-			mask = cpu_to_be64(((1ull << desc[i].size_bits) - 1) << shift);
+			mask = cpu_to_be64((~0ull >> (64 - desc[i].size_bits)) << shift);
 			addr = (__be64 *) ((__be32 *) buf + desc[i].offset_words);
 			*addr = (*addr & ~mask) | (cpu_to_be64(val) & mask);
 		} else {
@@ -176,7 +176,7 @@
 			__be64 *addr;
 
 			shift = 64 - desc[i].offset_bits - desc[i].size_bits;
-			mask = ((1ull << desc[i].size_bits) - 1) << shift;
+			mask = (~0ull >> (64 - desc[i].size_bits)) << shift;
 			addr = (__be64 *) buf + desc[i].offset_words;
 			val = (be64_to_cpup(addr) & mask) >> shift;
 			value_write(desc[i].struct_offset_bytes,
