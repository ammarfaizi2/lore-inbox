Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVHCG5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVHCG5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVHCGzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:55:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262126AbVHCGyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:54:15 -0400
Date: Tue, 2 Aug 2005 23:53:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Patrick McHardy <kaber@trash.net>
Subject: [05/13] [NET]: Fix signedness issues in net/core/filter.c
Message-ID: <20050803065348.GT7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

This is the code to load packet data into a register:

                        k = fentry->k;
                        if (k < 0) {
...
                        } else {
                                u32 _tmp, *p;
                                p = skb_header_pointer(skb, k, 4, &_tmp);
                                if (p != NULL) {
                                        A = ntohl(*p);
                                        continue;
                                }
                        }

skb_header_pointer checks if the requested data is within the
linear area:

        int hlen = skb_headlen(skb);

        if (offset + len <= hlen)
                return skb->data + offset;

When offset is within [INT_MAX-len+1..INT_MAX] the addition will
result in a negative number which is <= hlen.

I couldn't trigger a crash on my AMD64 with 2GB of memory, but a
coworker tried on his x86 machine and it crashed immediately.

This patch fixes the check in skb_header_pointer to handle large
positive offsets similar to skb_copy_bits. Invalid data can still
be accessed using negative offsets (also similar to skb_copy_bits),
anyone using negative offsets needs to verify them himself.

Thanks to Thomas Vögtle <thomas.voegtle@coreworks.de> for verifying the
problem by crashing his machine and providing me with an Oops.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/skbuff.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12.3.orig/include/linux/skbuff.h	2005-07-28 11:17:01.000000000 -0700
+++ linux-2.6.12.3/include/linux/skbuff.h	2005-07-28 11:17:12.000000000 -0700
@@ -1192,7 +1192,7 @@
 {
 	int hlen = skb_headlen(skb);
 
-	if (offset + len <= hlen)
+	if (hlen - offset >= len)
 		return skb->data + offset;
 
 	if (skb_copy_bits(skb, offset, buffer, len) < 0)
