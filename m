Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWGYRFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWGYRFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 13:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWGYRFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 13:05:13 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:61401 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S932365AbWGYRFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 13:05:11 -0400
Date: Wed, 26 Jul 2006 02:04:52 +0900 (JST)
Message-Id: <20060726.020452.132264896.jet@gyve.org>
To: linux-kernel@vger.kernel.org, marcel@holtmann.org
Subject: [PATCH] guarding bt_proto with rwlock
From: Masatake YAMATO <jet@gyve.org>
X-Mailer: Mew version 4.2.53 on Emacs 22.0.51 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found that bt_proto manipulated in bt_sock_register is not guarded
from race condition. 

Look at net/bluetooth/af_bluetooth.c:

    static struct net_proto_family *bt_proto[BT_MAX_PROTO];

    int bt_sock_register(int proto, struct net_proto_family *ops)
    {
	    if (proto < 0 || proto >= BT_MAX_PROTO)
		    return -EINVAL;

	    if (bt_proto[proto])
		    return -EEXIST;

	    bt_proto[proto] = ops;
	    return 0;
    }

Here bt_proto[proto] is set.

In other hand,

    static int bt_sock_create(struct socket *sock, int proto)
    {
	    int err = 0;

	    if (proto < 0 || proto >= BT_MAX_PROTO)
		    return -EINVAL;

    #if defined(CONFIG_KMOD)
	    if (!bt_proto[proto]) {
		    request_module("bt-proto-%d", proto);
	    }
    #endif
	    err = -EPROTONOSUPPORT;
	    if (bt_proto[proto] && try_module_get(bt_proto[proto]->owner)) {
		    err = bt_proto[proto]->create(sock, proto);
		    module_put(bt_proto[proto]->owner);
	    }
	    return err; 
    }

bt_proto[proto] is referred.

So I wrote a patch which guards bt_proto with rwlock.

Signed-off-by: Masatake YAMATO <jet@gyve.org>

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 469eda0..dff4514 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -27,6 +27,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/errno.h>
@@ -54,30 +55,44 @@
 /* Bluetooth sockets */
 #define BT_MAX_PROTO	8
 static struct net_proto_family *bt_proto[BT_MAX_PROTO];
+static DEFINE_RWLOCK(bt_proto_rwlock);
 
 int bt_sock_register(int proto, struct net_proto_family *ops)
 {
+	int err;
+
 	if (proto < 0 || proto >= BT_MAX_PROTO)
 		return -EINVAL;
 
-	if (bt_proto[proto])
-		return -EEXIST;
-
-	bt_proto[proto] = ops;
-	return 0;
+	err = -EEXIST;
+	
+	write_lock(&bt_proto_rwlock);
+	if (bt_proto[proto] == NULL) {
+		err = 0;
+		bt_proto[proto] = ops;
+	}
+	write_unlock(&bt_proto_rwlock);
+	
+	return err;
 }
 EXPORT_SYMBOL(bt_sock_register);
 
 int bt_sock_unregister(int proto)
 {
+	int err;
+
 	if (proto < 0 || proto >= BT_MAX_PROTO)
 		return -EINVAL;
-
-	if (!bt_proto[proto])
-		return -ENOENT;
-
-	bt_proto[proto] = NULL;
-	return 0;
+	
+	err = -ENOENT;
+	write_lock(&bt_proto_rwlock);
+	if (bt_proto[proto]) {
+		err = 0;
+		bt_proto[proto] = NULL;
+	}
+	write_unlock(&bt_proto_rwlock);
+	
+	return err;
 }
 EXPORT_SYMBOL(bt_sock_unregister);
 
@@ -94,10 +109,12 @@ static int bt_sock_create(struct socket 
 	}
 #endif
 	err = -EPROTONOSUPPORT;
+	read_lock(&bt_proto_rwlock);
 	if (bt_proto[proto] && try_module_get(bt_proto[proto]->owner)) {
 		err = bt_proto[proto]->create(sock, proto);
 		module_put(bt_proto[proto]->owner);
 	}
+	read_unlock(&bt_proto_rwlock);
 	return err; 
 }
 

