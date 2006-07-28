Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWG1Qd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWG1Qd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWG1Qd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:33:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:42046 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750875AbWG1Qdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:33:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=fxpU3pTDY/w88MSyRy04yjFVFyw31BlZwqXmp5GH0A3ZyRu2VEEhIlAhCeShOCvh2DMdswLnzR0CaAObOtfi35yNq4zZ3hvZdNb7jJM01DObjkvtE6FBYfapJfjG/uqbuQTJYJXE19LqYJE4crBxusJ/hEN0kNKUtmdvGMx56ZQ=
Date: Fri, 28 Jul 2006 18:33:48 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, acme@mandriva.com, marcel@holtmann.org, jet@gyve.org
Subject: [04/04 mm-patch, rfc] Add lightweight rwlock to net/bluetooth/af_bluetooth.c (was Re: [mm-patch] bluetooth: use GFP_ATOMIC in *_sock_create's sk_alloc)
Message-ID: <20060728163347.GD1227@slug>
References: <20060728083532.GA311@slug> <20060728.181756.135980869.jet@gyve.org> <20060728123246.GB311@slug> <20060728.221252.265353941.jet@gyve.org> <20060728161515.GA1227@slug> <20060728162320.GB1227@slug> <20060728162815.GC1227@slug>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <20060728162815.GC1227@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch is part of the lw_rwlock patchset, it removes the
bt_proto_rwlock lock from af_bluetooth.c and uses the newly available
linux/lw_rwlock.h

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="net_bluetooth_af_bluetooth.c-use-lw_rwlocks.patch"

--- v2.6.18-rc2-mm1~ori/net/bluetooth/af_bluetooth.c	2006-07-27 11:46:12.000000000 +0200
+++ v2.6.18-rc2-mm1/net/bluetooth/af_bluetooth.c	2006-07-28 16:22:50.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 
 #include <linux/spinlock.h>
+#include <linux/lw_rwlock.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/errno.h>
@@ -54,7 +55,7 @@
 /* Bluetooth sockets */
 #define BT_MAX_PROTO	8
 static struct net_proto_family *bt_proto[BT_MAX_PROTO];
-static DEFINE_RWLOCK(bt_proto_rwlock);
+static DEFINE_LW_RWLOCK(bt_proto_rwlock);
 
 int bt_sock_register(int proto, struct net_proto_family *ops)
 {
@@ -65,12 +66,12 @@ int bt_sock_register(int proto, struct n
 
 	err = -EEXIST;
 
-	write_lock(&bt_proto_rwlock);
+	lw_write_lock(&bt_proto_rwlock);
 	if (bt_proto[proto] == NULL) {
 		err = 0;
 		bt_proto[proto] = ops;
 	}
-	write_unlock(&bt_proto_rwlock);
+	lw_write_unlock(&bt_proto_rwlock);
 
 	return err;
 }
@@ -84,12 +85,12 @@ int bt_sock_unregister(int proto)
 		return -EINVAL;
 
 	err = -ENOENT;
-	write_lock(&bt_proto_rwlock);
+	lw_write_lock(&bt_proto_rwlock);
 	if (bt_proto[proto]) {
 		err = 0;
 		bt_proto[proto] = NULL;
 	}
-	write_unlock(&bt_proto_rwlock);
+	lw_write_unlock(&bt_proto_rwlock);
 
 	return err;
 }
@@ -108,12 +109,12 @@ static int bt_sock_create(struct socket 
 	}
 #endif
 	err = -EPROTONOSUPPORT;
-	read_lock(&bt_proto_rwlock);
+	lw_read_lock(&bt_proto_rwlock);
 	if (bt_proto[proto] && try_module_get(bt_proto[proto]->owner)) {
 		err = bt_proto[proto]->create(sock, proto);
 		module_put(bt_proto[proto]->owner);
 	}
-	read_unlock(&bt_proto_rwlock);
+	lw_read_unlock(&bt_proto_rwlock);
 	return err; 
 }
 

--pY3vCvL1qV+PayAL--
