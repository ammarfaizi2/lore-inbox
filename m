Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317849AbSGVSUX>; Mon, 22 Jul 2002 14:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317850AbSGVSUW>; Mon, 22 Jul 2002 14:20:22 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:26496 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S317849AbSGVSUO>;
	Mon, 22 Jul 2002 14:20:14 -0400
Date: Mon, 22 Jul 2002 20:23:07 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH] ipx use of cli/sti
Message-ID: <20020722182307.GA5932@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
  patch below removes cli/sti from SPX registration
code in IPX. I decided to use normal rw_semaphore instead
of net_family_{write,read}_{lock,unlock} used in
net/socket.c.

  I left SPX code itself alone: I do not use it and
last time I checked it it was very unreliable reliable
transport.
				Thanks,
					Petr Vandrovec



--- linux-2.5.27-c683/net/ipx/af_ipx.c.orig	2002-07-22 15:32:51.000000000 +0200
+++ linux-2.5.27-c683/net/ipx/af_ipx.c	2002-07-22 20:10:39.000000000 +0200
@@ -145,6 +145,7 @@
 static struct proto_ops ipx_dgram_ops;
 
 static struct net_proto_family *spx_family_ops;
+static DECLARE_RWSEM(spx_family_ops_lock);
 
 static ipx_route *ipx_routes;
 static rwlock_t ipx_routes_lock = RW_LOCK_UNLOCKED;
@@ -1929,10 +1930,13 @@
 			 * From this point on SPX sockets are handled
 			 * by af_spx.c and the methods replaced.
 			 */
+			down_read(&spx_family_ops_lock);
 			if (spx_family_ops) {
 				ret = spx_family_ops->create(sock, protocol);
+				up_read(&spx_family_ops_lock);
 				goto decmod;
 			}
+			up_read(&spx_family_ops_lock);
 			/* Fall through if SPX is not loaded */
 		case SOCK_STREAM:       /* Allow higher levels to piggyback */
 		default:
@@ -2463,20 +2467,27 @@
 
 int ipx_register_spx(struct proto_ops **p, struct net_proto_family *spx)
 {
-        if (spx_family_ops)
-                return -EBUSY;
-        cli();
-        MOD_INC_USE_COUNT;
-        *p = &ipx_dgram_ops;
-        spx_family_ops = spx;
-        sti();
+	int err;
+
+	err = -EBUSY;
+	down_write(&spx_family_ops_lock);
+        if (!spx_family_ops) {
+	        MOD_INC_USE_COUNT;
+        	*p = &ipx_dgram_ops;
+	        spx_family_ops = spx;
+	}
+        up_write(&spx_family_ops_lock);
         return 0;
 }
 
 int ipx_unregister_spx(void)
 {
-        spx_family_ops = NULL;
-        MOD_DEC_USE_COUNT;
+	down_write(&spx_family_ops_lock);
+	if (spx_family_ops) {
+	        spx_family_ops = NULL;
+        	MOD_DEC_USE_COUNT;
+	}
+	up_write(&spx_family_ops_lock);
         return 0;
 }
 
