Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272747AbTHKQEB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272745AbTHKQCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:02:47 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:13094 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272747AbTHKP7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:41 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing copy_*_user checks in sbni wan driver
Message-Id: <E19mF4Z-0005FD-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/wan/sbni.c linux-2.5/drivers/net/wan/sbni.c
--- bk-linus/drivers/net/wan/sbni.c	2003-06-11 10:23:01.000000000 +0100
+++ linux-2.5/drivers/net/wan/sbni.c	2003-07-13 06:04:35.000000000 +0100
@@ -1287,8 +1287,9 @@ sbni_ioctl( struct net_device  *dev,  st
 		error = verify_area( VERIFY_WRITE, ifr->ifr_data,
 				     sizeof(struct sbni_in_stats) );
 		if( !error )
-			copy_to_user( ifr->ifr_data, &nl->in_stats,
-				      sizeof(struct sbni_in_stats) );
+			if (copy_to_user( ifr->ifr_data, &nl->in_stats,
+				      sizeof(struct sbni_in_stats) ))
+				return -EFAULT;
 		break;
 
 	case  SIOCDEVRESINSTATS :
@@ -1307,7 +1308,8 @@ sbni_ioctl( struct net_device  *dev,  st
 		error = verify_area( VERIFY_WRITE, ifr->ifr_data,
 				     sizeof flags );
 		if( !error )
-			copy_to_user( ifr->ifr_data, &flags, sizeof flags );
+			if (copy_to_user( ifr->ifr_data, &flags, sizeof flags ))
+				return -EFAULT;
 		break;
 
 	case  SIOCDEVSHWSTATE :
@@ -1339,7 +1341,8 @@ sbni_ioctl( struct net_device  *dev,  st
 					  sizeof slave_name )) != 0 )
 			return  error;
 
-		copy_from_user( slave_name, ifr->ifr_data, sizeof slave_name );
+		if (copy_from_user( slave_name, ifr->ifr_data, sizeof slave_name ))
+			return -EFAULT;
 		slave_dev = dev_get_by_name( slave_name );
 		if( !slave_dev  ||  !(slave_dev->flags & IFF_UP) ) {
 			printk( KERN_ERR "%s: trying to enslave non-active "
