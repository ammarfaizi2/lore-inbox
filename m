Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVCPCzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVCPCzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 21:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVCPCzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 21:55:24 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:57002 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262472AbVCPCzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 21:55:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16951.40964.44130.990674@wombat.chubb.wattle.id.au>
Date: Wed, 16 Mar 2005 13:55:00 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
       davidm@davemloft.net
Subject: Can no longer build ipv6 built-in (2.6.11, today's BK head)
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Changeset 
  herbert@gondor.apana.org.au|ChangeSet|20050310043957|06845
added cleanup to ipv6_init(), which calls ip6_route_cleanup()

ip6_route_cleanup() is marked __exit so cannot be called from an
__init section -- it's discarded by the linker from the image
(although it'll be retained in a module).

You get errors like this:
ip6_route_cleanup: discarded in section `.exit.text' from
net/built-in.o 
xfrm6_fini: discarded in section `.exit.text' from net/built-in.o
fib6_gc_cleanup: discarded in section `.exit.text' from net/built-in.o
ipv6_packet_cleanup: discarded in section `.exit.text' from
net/built-in.o


A simple fix is to delete the __exit from the various functions now that
they're called other than at module_exit.

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

Index: linux-2.5-import/net/ipv6/route.c
===================================================================
--- linux-2.5-import.orig/net/ipv6/route.c	2005-03-16 10:12:44.742595387 +1100
+++ linux-2.5-import/net/ipv6/route.c	2005-03-16 13:01:50.246678866 +1100
@@ -2116,7 +2116,7 @@
 #endif
 }
 
-void __exit ip6_route_cleanup(void)
+void ip6_route_cleanup(void)
 {
 #ifdef CONFIG_PROC_FS
 	proc_net_remove("ipv6_route");
Index: linux-2.5-import/net/ipv6/ipv6_sockglue.c
===================================================================
--- linux-2.5-import.orig/net/ipv6/ipv6_sockglue.c	2005-03-16 10:12:44.736736056 +1100
+++ linux-2.5-import/net/ipv6/ipv6_sockglue.c	2005-03-16 13:24:19.095793200 +1100
@@ -698,7 +698,7 @@
 	dev_add_pack(&ipv6_packet_type);
 }
 
-void __exit ipv6_packet_cleanup(void)
+void ipv6_packet_cleanup(void)
 {
 	dev_remove_pack(&ipv6_packet_type);
 }
Index: linux-2.5-import/net/ipv6/ip6_fib.c
===================================================================
--- linux-2.5-import.orig/net/ipv6/ip6_fib.c	2005-03-15 12:28:44.819748921 +1100
+++ linux-2.5-import/net/ipv6/ip6_fib.c	2005-03-16 13:27:46.423351526 +1100
@@ -1218,7 +1218,7 @@
 		panic("cannot create fib6_nodes cache");
 }
 
-void __exit fib6_gc_cleanup(void)
+void fib6_gc_cleanup(void)
 {
 	del_timer(&ip6_fib_timer);
 	kmem_cache_destroy(fib6_node_kmem);
Index: linux-2.5-import/net/ipv6/xfrm6_policy.c
===================================================================
--- linux-2.5-import.orig/net/ipv6/xfrm6_policy.c	2005-03-15 12:28:44.853928319 +1100
+++ linux-2.5-import/net/ipv6/xfrm6_policy.c	2005-03-16 13:53:28.890552848 +1100
@@ -276,7 +276,7 @@
 	xfrm_policy_register_afinfo(&xfrm6_policy_afinfo);
 }
 
-static void __exit xfrm6_policy_fini(void)
+static void xfrm6_policy_fini(void)
 {
 	xfrm_policy_unregister_afinfo(&xfrm6_policy_afinfo);
 }
@@ -287,7 +287,7 @@
 	xfrm6_state_init();
 }
 
-void __exit xfrm6_fini(void)
+void xfrm6_fini(void)
 {
 	//xfrm6_input_fini();
 	xfrm6_policy_fini();
Index: linux-2.5-import/net/ipv6/xfrm6_state.c
===================================================================
--- linux-2.5-import.orig/net/ipv6/xfrm6_state.c	2005-03-15 12:28:44.854904874 +1100
+++ linux-2.5-import/net/ipv6/xfrm6_state.c	2005-03-16 13:29:30.183337361 +1100
@@ -129,7 +129,7 @@
 	xfrm_state_register_afinfo(&xfrm6_state_afinfo);
 }
 
-void __exit xfrm6_state_fini(void)
+void xfrm6_state_fini(void)
 {
 	xfrm_state_unregister_afinfo(&xfrm6_state_afinfo);
 }



-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
