Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbTEZRgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTEZRgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:36:32 -0400
Received: from [193.126.240.148] ([193.126.240.148]:466 "EHLO
	mcmmta3.mediacapital.pt") by vger.kernel.org with ESMTP
	id S261846AbTEZRg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:36:27 -0400
Date: Mon, 26 May 2003 18:50:33 +0100
From: "Paulo Andre'" <fscked@iol.pt>
Subject: [PATCH] check copy_*_user return values in remaining WAN drivers
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <20030526185033.27160c6c.fscked@iol.pt>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: multipart/mixed; boundary="Boundary_(ID_anjvUqJFjMYIKqq6WhYVxg)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_anjvUqJFjMYIKqq6WhYVxg)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT

The following patch adds error checking to the copy_*_user() functions
to the remaining WAN drivers which did not have this checking made. I'm
sending a single patch as it's the same change in all files. Affected
files are:

drivers/net/wan/comx-hw-comx.c
drivers/net/wan/comx-hw-locomx.c
drivers/net/wan/comx-hw-mixcom.c
drivers/net/wan/comx-hw-munich.c
drivers/net/wan/comx-proto-fr.c
drivers/net/wan/comx-proto-lapb.c
drivers/net/wan/pc300_drv.c
drivers/net/wan/sbni.c

Applies cleanly on top of latest bk(-19). Please consider applying.

		Paulo

--Boundary_(ID_anjvUqJFjMYIKqq6WhYVxg)
Content-type: text/plain; name=patch-drivers_net_wan.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=patch-drivers_net_wan.diff

diff -urN -X dontdiff linux-2.5-vanilla/drivers/net/wan/comx-hw-comx.c linux/drivers/net/wan/comx-hw-comx.c
--- linux-2.5-vanilla/drivers/net/wan/comx-hw-comx.c	2003-05-26 15:43:32.000000000 +0100
+++ linux/drivers/net/wan/comx-hw-comx.c	2003-05-26 15:49:25.000000000 +0100
@@ -1084,7 +1084,8 @@
 		if (hw->firmware->data) {
 			kfree(hw->firmware->data);
 		}
-		copy_from_user(tmp + file->f_pos, buffer, count);
+		if (copy_from_user(tmp + file->f_pos, buffer, count))
+			return -EFAULT;
 		hw->firmware->len = entry->size = file->f_pos + count;
 		hw->firmware->data = tmp;
 		file->f_pos += count;
diff -urN -X dontdiff linux-2.5-vanilla/drivers/net/wan/comx-hw-locomx.c linux/drivers/net/wan/comx-hw-locomx.c
--- linux-2.5-vanilla/drivers/net/wan/comx-hw-locomx.c	2003-05-26 15:43:32.000000000 +0100
+++ linux/drivers/net/wan/comx-hw-locomx.c	2003-05-26 15:49:25.000000000 +0100
@@ -339,7 +339,10 @@
 		return -ENOMEM;
 	}
 
-	copy_from_user(page, buffer, count = min_t(unsigned long, count, PAGE_SIZE));
+	if (copy_from_user(page, buffer, count = min_t(unsigned long, count, PAGE_SIZE))) {
+		free_page((unsigned long)page);
+		return -EBADF;
+	}
 	if (*(page + count - 1) == '\n') {
 		*(page + count - 1) = 0;
 	}
diff -urN -X dontdiff linux-2.5-vanilla/drivers/net/wan/comx-hw-mixcom.c linux/drivers/net/wan/comx-hw-mixcom.c
--- linux-2.5-vanilla/drivers/net/wan/comx-hw-mixcom.c	2003-05-26 15:43:32.000000000 +0100
+++ linux/drivers/net/wan/comx-hw-mixcom.c	2003-05-26 15:49:25.000000000 +0100
@@ -763,7 +763,10 @@
 		return -ENOMEM;
 	}
 
-	copy_from_user(page, buffer, count = min_t(unsigned long, count, PAGE_SIZE));
+	if (copy_from_user(page, buffer, count = min_t(unsigned long, count, PAGE_SIZE))) {
+		free_page((unsigned long)page);
+		return -EFAULT;
+	}
 	if (*(page + count - 1) == '\n') {
 		*(page + count - 1) = 0;
 	}
diff -urN -X dontdiff linux-2.5-vanilla/drivers/net/wan/comx-hw-munich.c linux/drivers/net/wan/comx-hw-munich.c
--- linux-2.5-vanilla/drivers/net/wan/comx-hw-munich.c	2003-05-26 15:43:32.000000000 +0100
+++ linux/drivers/net/wan/comx-hw-munich.c	2003-05-26 15:49:25.000000000 +0100
@@ -2414,7 +2414,10 @@
 	return -ENOMEM;
 
     /* Copy user data and cut trailing \n */
-    copy_from_user(page, buffer, count = min(count, PAGE_SIZE));
+    if (copy_from_user(page, buffer, count = min(count, PAGE_SIZE))) {
+	    free_page((unsigned long)page);
+	    return -EFAULT;
+    }
     if (*(page + count - 1) == '\n')
 	*(page + count - 1) = 0;
     *(page + PAGE_SIZE - 1) = 0;
diff -urN -X dontdiff linux-2.5-vanilla/drivers/net/wan/comx-proto-fr.c linux/drivers/net/wan/comx-proto-fr.c
--- linux-2.5-vanilla/drivers/net/wan/comx-proto-fr.c	2003-05-26 15:43:32.000000000 +0100
+++ linux/drivers/net/wan/comx-proto-fr.c	2003-05-26 15:49:25.000000000 +0100
@@ -657,7 +657,10 @@
 		return -ENOMEM;
 	}
 
-	copy_from_user(page, buffer, count);
+	if (copy_from_user(page, buffer, count)) {
+		free_page((unsigned long)page);
+		return -EFAULT;
+	}
 	if (*(page + count - 1) == '\n') {
 		*(page + count - 1) = 0;
 	}
diff -urN -X dontdiff linux-2.5-vanilla/drivers/net/wan/comx-proto-lapb.c linux/drivers/net/wan/comx-proto-lapb.c
--- linux-2.5-vanilla/drivers/net/wan/comx-proto-lapb.c	2003-05-26 15:43:32.000000000 +0100
+++ linux/drivers/net/wan/comx-proto-lapb.c	2003-05-26 15:49:25.000000000 +0100
@@ -232,7 +232,10 @@
 		return -ENOMEM;
 	}
 
-	copy_from_user(page, buffer, count);
+	if (copy_from_user(page, buffer, count)) {
+		free_page((unsigned long)page);
+		return -EFAULT;
+	}
 	if (*(page + count - 1) == '\n') {
 		*(page + count - 1) = 0;
 	}
diff -urN -X dontdiff linux-2.5-vanilla/drivers/net/wan/pc300_drv.c linux/drivers/net/wan/pc300_drv.c
--- linux-2.5-vanilla/drivers/net/wan/pc300_drv.c	2003-05-25 15:30:15.000000000 +0100
+++ linux/drivers/net/wan/pc300_drv.c	2003-05-26 15:49:25.000000000 +0100
@@ -2623,7 +2623,8 @@
 					       sizeof(struct net_device_stats));
 					if (card->hw.type == PC300_TE)
 						memcpy(&pc300stats.te_stats,&chan->falc,sizeof(falc_t));
-				    copy_to_user(arg, &pc300stats, sizeof(pc300stats_t));
+				    	if (copy_to_user(arg, &pc300stats, sizeof(pc300stats_t)))
+						return -EFAULT;
 				}
 				return 0;
 			}
diff -urN -X dontdiff linux-2.5-vanilla/drivers/net/wan/sbni.c linux/drivers/net/wan/sbni.c
--- linux-2.5-vanilla/drivers/net/wan/sbni.c	2003-05-25 15:30:15.000000000 +0100
+++ linux/drivers/net/wan/sbni.c	2003-05-26 15:49:25.000000000 +0100
@@ -1290,8 +1290,9 @@
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
@@ -1310,7 +1311,8 @@
 		error = verify_area( VERIFY_WRITE, ifr->ifr_data,
 				     sizeof flags );
 		if( !error )
-			copy_to_user( ifr->ifr_data, &flags, sizeof flags );
+			if (copy_to_user( ifr->ifr_data, &flags, sizeof flags ))
+				return -EFAULT;
 		break;
 
 	case  SIOCDEVSHWSTATE :
@@ -1342,7 +1344,8 @@
 					  sizeof slave_name )) != 0 )
 			return  error;
 
-		copy_from_user( slave_name, ifr->ifr_data, sizeof slave_name );
+		if (copy_from_user( slave_name, ifr->ifr_data, sizeof slave_name ))
+			return -EFAULT;
 		slave_dev = dev_get_by_name( slave_name );
 		if( !slave_dev  ||  !(slave_dev->flags & IFF_UP) ) {
 			printk( KERN_ERR "%s: trying to enslave non-active "

--Boundary_(ID_anjvUqJFjMYIKqq6WhYVxg)--
