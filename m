Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267333AbSLKWZM>; Wed, 11 Dec 2002 17:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbSLKWZM>; Wed, 11 Dec 2002 17:25:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:6528 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267333AbSLKWZF>;
	Wed, 11 Dec 2002 17:25:05 -0500
Date: Wed, 11 Dec 2002 14:32:50 -0800
From: Bob Miller <rem@osdl.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.51] Remove compile warnings from ipv4/raw.c and ipv4/arp.c
Message-ID: <20021211223250.GE1067@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recoded a couple of routines (neigh_get_next()/raw_get_next()) to remove
goto's jumping back into the middle of do {} while(); loop.  This removes the 

    warning: deprecated use of label at end of compound statement

from these two files.


diff -Nru a/net/ipv4/arp.c b/net/ipv4/arp.c
--- a/net/ipv4/arp.c	Wed Dec 11 13:41:51 2002
+++ b/net/ipv4/arp.c	Wed Dec 11 13:41:51 2002
@@ -1168,19 +1168,19 @@
 {
 	struct arp_iter_state* state = seq->private;
 
-	do {
-		n = n->next;
+	n = n->next;
+	while (n != NULL) {
 		/* Don't confuse "arp -a" w/ magic entries */
-try_again:
-	} while (n && !(n->nud_state & ~NUD_NOARP));
+		if ((n->nud_state == 0) || (n->nud_state == NUD_NOARP)) {
+			n = n->next;
+		} else {
+			if (++state->bucket > NEIGH_HASHMASK) {
+				break;
+			}
+			n = arp_tbl.hash_buckets[state->bucket];
+		}
+	}
 
-	if (n)
-		goto out;
-	if (++state->bucket > NEIGH_HASHMASK)
-		goto out;
-	n = arp_tbl.hash_buckets[state->bucket];
-	goto try_again;
-out:
 	return n;
 }
 
diff -Nru a/net/ipv4/raw.c b/net/ipv4/raw.c
--- a/net/ipv4/raw.c	Wed Dec 11 13:41:51 2002
+++ b/net/ipv4/raw.c	Wed Dec 11 13:41:51 2002
@@ -712,14 +712,17 @@
 {
 	struct raw_iter_state* state = raw_seq_private(seq);
 
-	do {
-		sk = sk->next;
-try_again:
-	} while (sk && sk->family != PF_INET);
-
-	if (!sk && ++state->bucket < RAWV4_HTABLE_SIZE) {
-		sk = raw_v4_htable[state->bucket];
-		goto try_again;
+	sk = sk->next;
+	while (sk != NULL) {
+		if (sk->family == PF_INET) {
+			if (++state->bucket < RAWV4_HTABLE_SIZE) {
+				sk = raw_v4_htable[state->bucket];
+			} else {
+				break;
+			}
+		} else {
+			sk = sk->next;
+		}
 	}
 	return sk;
 }
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
