Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUFKFKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUFKFKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 01:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUFKFKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 01:10:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17615 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261763AbUFKFKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 01:10:15 -0400
Date: Thu, 10 Jun 2004 22:04:45 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Unaligned accesses in net/ipv4/netfilter/arp_tables.c:184
Message-Id: <20040610220445.2116457b.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004 11:09:42 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

>         /* Look for ifname matches; this should unroll nicely. */
>         for (i = 0, ret = 0; i < IFNAMSIZ/sizeof(unsigned long); i++) {
>                 ret |= (((const unsigned long *)indev)[i]
>                         ^ ((const unsigned long *)arpinfo->iniface)[i])
>                         & ((const unsigned long *)arpinfo->iniface_mask)[i];
>         }

This is far from a critical code path, so this is how I'm
going to fix this.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/10 22:05:19-07:00 davem@nuts.davemloft.net 
#   [IPV4]: Fix unaligned accesses in arp_tables.c
# 
# net/ipv4/netfilter/arp_tables.c
#   2004/06/10 22:05:03-07:00 davem@nuts.davemloft.net +3 -4
#   [IPV4]: Fix unaligned accesses in arp_tables.c
# 
diff -Nru a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
--- a/net/ipv4/netfilter/arp_tables.c	2004-06-10 22:05:40 -07:00
+++ b/net/ipv4/netfilter/arp_tables.c	2004-06-10 22:05:40 -07:00
@@ -179,11 +179,10 @@
 		return 0;
 	}
 
-	/* Look for ifname matches; this should unroll nicely. */
+	/* Look for ifname matches.  */
 	for (i = 0, ret = 0; i < IFNAMSIZ/sizeof(unsigned long); i++) {
-		ret |= (((const unsigned long *)indev)[i]
-			^ ((const unsigned long *)arpinfo->iniface)[i])
-			& ((const unsigned long *)arpinfo->iniface_mask)[i];
+		ret |= (indev[i] ^ arpinfo->iniface[i])
+			& arpinfo->iniface_mask[i];
 	}
 
 	if (FWINV(ret != 0, ARPT_INV_VIA_IN)) {
