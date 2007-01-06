Return-Path: <linux-kernel-owner+w=401wt.eu-S1751120AbXAFCa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbXAFCa3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbXAFCaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:30:18 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36521 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbXAFC3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:29:41 -0500
Message-Id: <20070106023314.791884000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:16 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>
Subject: [patch 23/50] UDP: Fix reversed logic in udp_get_port()
Content-Disposition: inline; filename=fix-reversed-logic-in-udp_get_port.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

When this code was converted to use sk_for_each() the
logic for the "best hash chain length" code was reversed,
breaking everything.

The original code was of the form:

			size = 0;
			do {
				if (++size >= best_size_so_far)
					goto next;
			} while ((sk = sk->next) != NULL);
			best_size_so_far = size;
			best = result;
		next:;

and this got converted into:

			sk_for_each(sk2, node, head)
				if (++size < best_size_so_far) {
					best_size_so_far = size;
					best = result;
				}

Which does something very very different from the original.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ipv4/udp.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- linux-2.6.19.1.orig/net/ipv4/udp.c
+++ linux-2.6.19.1/net/ipv4/udp.c
@@ -167,11 +167,14 @@ int udp_get_port(struct sock *sk, unsign
 				goto gotit;
 			}
 			size = 0;
-			sk_for_each(sk2, node, head)
-				if (++size < best_size_so_far) {
-					best_size_so_far = size;
-					best = result;
-				}
+			sk_for_each(sk2, node, head) {
+				if (++size >= best_size_so_far)
+					goto next;
+			}
+			best_size_so_far = size;
+			best = result;
+		next:
+			;
 		}
 		result = best;
 		for(i = 0; i < (1 << 16) / UDP_HTABLE_SIZE; i++, result += UDP_HTABLE_SIZE) {

--
