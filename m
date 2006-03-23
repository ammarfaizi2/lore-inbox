Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWCWCGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWCWCGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 21:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWCWCGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 21:06:13 -0500
Received: from lemon.ken.nicta.com.au ([203.143.174.44]:40141 "EHLO
	lemon.gelato.unsw.edu.au") by vger.kernel.org with ESMTP
	id S932376AbWCWCGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 21:06:12 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
Message-ID: <17442.650.874609.271109@berry.ken.nicta.com.au>
Date: Thu, 23 Mar 2006 13:06:02 +1100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y4keh+U5fs"
Content-Transfer-Encoding: 7bit
To: shemminger@osdl.org
CC: linux-kernel@vger.kernel.org
X-Mailer: VM 7.19 under 21.4 (patch 19) "Constant Variable" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
X-SA-Exim-Connect-IP: 203.143.160.117
X-SA-Exim-Mail-From: peterc@gelato.unsw.edu.au
Subject: [PATCH] Unaligned accesses in the ethernet bridge
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:39:27 +0000)
X-SA-Exim-Scanned: Yes (on lemon.gelato.unsw.edu.au)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see lots of
	kernel unaligned access to 0xa0000001009dbb6f, ip=0xa000000100811591
	kernel unaligned access to 0xa0000001009dbb6b, ip=0xa0000001008115c1
	kernel unaligned access to 0xa0000001009dbb6d, ip=0xa0000001008115f1
messages in my logs on IA64 when using the ethernet bridge with 2.6.16.


Appended is a patch to fix them.

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>


 net/bridge/br_stp_bpdu.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6-import/net/bridge/br_stp_bpdu.c
===================================================================
--- linux-2.6-import.orig/net/bridge/br_stp_bpdu.c	2006-03-22 09:11:01.349886375 +1100
+++ linux-2.6-import/net/bridge/br_stp_bpdu.c	2006-03-23 12:52:13.719239205 +1100
@@ -19,6 +19,7 @@
 #include <linux/llc.h>
 #include <net/llc.h>
 #include <net/llc_pdu.h>
+#include <asm/unaligned.h>
 
 #include "br_private.h"
 #include "br_private_stp.h"
@@ -59,12 +60,12 @@ static inline void br_set_ticks(unsigned
 {
 	unsigned long ticks = (STP_HZ * j)/ HZ;
 
-	*((__be16 *) dest) = htons(ticks);
+	put_unaligned(htons(ticks), (__be16 *)dest);
 }
 
 static inline int br_get_ticks(const unsigned char *src)
 {
-	unsigned long ticks = ntohs(*(__be16 *)src);
+	unsigned long ticks = ntohs(get_unaligned((__be16 *)src));
 
 	return (ticks * HZ + STP_HZ - 1) / STP_HZ;
 }
