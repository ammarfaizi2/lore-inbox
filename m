Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317826AbSGVV0I>; Mon, 22 Jul 2002 17:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317818AbSGVV0I>; Mon, 22 Jul 2002 17:26:08 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:2944 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S317791AbSGVV0H>;
	Mon, 22 Jul 2002 17:26:07 -0400
Date: Mon, 22 Jul 2002 23:28:47 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: davem@redhat.com
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH] Unloading of psnap
Message-ID: <20020722212847.GA1391@vana.vc.cvut.cz>
References: <20020722194814.GA1668@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020722194814.GA1668@vana.vc.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
  during my work on removing cli/sti from these two files I found that
removing psnap causes kernel to crash because of it does not unregister
from 802.2 layer.

  While I was on it, I also added MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT
into both 802.2 and SNAP. It is not strictly required as all callers
should have reference by name to register_*_client function, but I do not 
think that MOD_*_USE_COUNT will slow code down, and now it is directly 
visible how many snap and 802.2 clients live on system. And I'm sure
that somebody could through inter_module_get arrange some call path
so that we could unload p8022/psnap while still having some clients
registered.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

diff linux-2.5.27-c683/net/802/p8022.c.orig linux-2.5.27-c683/net/802/p8022.c
--- linux-2.5.27-c683/net/802/p8022.c.orig	2002-07-22 21:32:20.000000000 +0200
+++ linux-2.5.27-c683/net/802/p8022.c	2002-07-22 23:12:43.000000000 +0200
@@ -95,6 +95,7 @@
 		goto out;
 	proto = kmalloc(sizeof(*proto), GFP_ATOMIC);
 	if (proto) {
+		MOD_INC_USE_COUNT;
 		proto->type[0]		= type;
 		proto->type_len		= 1;
 		proto->rcvfunc		= rcvfunc;
@@ -121,6 +122,7 @@
 			*clients = tmp->next;
 			kfree(tmp);
 			llc_unregister_sap(type);
+			MOD_DEC_USE_COUNT;
 			break;
 		}
 		clients = &tmp->next;
diff linux-2.5.27-c683/net/802/psnap.c.orig linux-2.5.27-c683/net/802/psnap.c
--- linux-2.5.27-c683/net/802/psnap.c.orig	2002-07-22 21:52:11.000000000 +0200
+++ linux-2.5.27-c683/net/802/psnap.c	2002-07-22 23:14:34.000000000 +0200
@@ -103,7 +103,14 @@
 		printk("SNAP - unable to register with 802.2\n");
 	return 0;
 }
+
+static void __exit snap_exit(void)
+{
+	unregister_8022_client(0xAA);
+}
+
 module_init(snap_init);
+module_exit(snap_exit);
 
 /*
  *	Register SNAP clients. We don't yet use this for IP.
@@ -121,6 +128,7 @@
 	proto = (struct datalink_proto *) kmalloc(sizeof(*proto), GFP_ATOMIC);
 	if (proto != NULL)
 	{
+		MOD_INC_USE_COUNT;
 		memcpy(proto->type, desc,5);
 		proto->type_len = 5;
 		proto->rcvfunc = rcvfunc;
@@ -152,6 +160,7 @@
 		{
 			*clients = tmp->next;
 			kfree(tmp);
+			MOD_DEC_USE_COUNT;
 			break;
 		}
 		else
