Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266563AbRGLU1K>; Thu, 12 Jul 2001 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266565AbRGLU1A>; Thu, 12 Jul 2001 16:27:00 -0400
Received: from dhcp-10-139.townisp.com ([216.195.10.139]:11769 "EHLO
	cactus.desert.cx") by vger.kernel.org with ESMTP id <S266563AbRGLU0z>;
	Thu, 12 Jul 2001 16:26:55 -0400
Date: Thu, 12 Jul 2001 16:27:52 -0400
From: Mark Aikens <marka@wpi.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SO_BINDTODEVICE parameter checking in 2.2.19
Message-ID: <20010712162752.A690@cactus.desert.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There's a slight problem with the parameter checking in kernel version 2.2.19.
As it is now, if the parameter is less than 4 bytes long, it returns EINVAL.
That means that passing in ("lo", 3) to bind a socket to the loopback device
will never succeed.

There is also another bug where passing NULL as the parameter would unbind
the socket but still return EINVAL. That doesn't seem to be sensible behavior.

I don't know if these two bugs are in 2.4 but I've attached a patch which
fixes these bugs in 2.2.19. If you have any comments, please CC me because
I'm not on the list.

-Mark Aikens


diff -u --new-file --recursive linux-2.2.19.orig/net/core/sock.c linux-2.2.19/net/core/sock.c
--- linux-2.2.19.orig/net/core/sock.c	Sun Mar 25 11:37:41 2001
+++ linux-2.2.19/net/core/sock.c	Wed Jul 11 22:43:29 2001
@@ -174,16 +174,21 @@
 			return 0;
 	}
 #endif	
-		
-  	if(optlen<sizeof(int))
-  		return(-EINVAL);
-  	
-	err = get_user(val, (int *)optval);
-	if (err)
-		return err;
-	
-  	valbool = val?1:0;
-  	
+
+#ifdef CONFIG_NETDEVICES
+	if(optname != SO_BINDTODEVICE)
+#endif
+	{
+ 		if(optlen<sizeof(int))
+ 			return(-EINVAL);
+ 
+		err = get_user(val, (int *)optval);
+		if (err)
+			return err;
+
+		valbool = val?1:0;
+	}
+
   	switch(optname) 
   	{
 		case SO_DEBUG:	
@@ -305,7 +310,7 @@
 			 * is not bound. 
 			 */ 
 
-			if (!valbool) {
+			if (optval == NULL) {
 				sk->bound_dev_if = 0;
 			} else {
 				if (optlen > IFNAMSIZ) 
@@ -326,8 +331,8 @@
 						return -EINVAL;
 					sk->bound_dev_if = dev->ifindex;
 				}
-				return 0;
 			}
+			return 0;
 		}
 #endif
 
