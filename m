Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVEREcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVEREcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVEREcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:32:14 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:28173 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262085AbVEREal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:30:41 -0400
Message-Id: <200505180420.j4I4KMMS017317@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/9] UML - multicast driver cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 May 2005 00:20:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byte-swapping of the port and IP address passed in to the multicast driver
by the user used to happen in different places, which was a bug in itself.  
The port also was swapped before being printk-ed, which led to a misleading
message.  This patch moves the port swapping to the same place as the IP 
address swapping.
It also cleans up the error paths of mcast_open.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/drivers/mcast_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/mcast_kern.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/mcast_kern.c	2005-05-17 18:07:03.000000000 -0400
@@ -73,7 +73,6 @@ int mcast_setup(char *str, char **mac_ou
 	struct mcast_init *init = data;
 	char *port_str = NULL, *ttl_str = NULL, *remain;
 	char *last;
-	int n;
 
 	*init = ((struct mcast_init)
 		{ .addr 	= "239.192.168.1",
@@ -89,13 +88,12 @@ int mcast_setup(char *str, char **mac_ou
 	}
 	
 	if(port_str != NULL){
-		n = simple_strtoul(port_str, &last, 10);
+		init->port = simple_strtoul(port_str, &last, 10);
 		if((*last != '\0') || (last == port_str)){
 			printk(KERN_ERR "mcast_setup - Bad port : '%s'\n", 
 			       port_str);
 			return(0);
 		}
-		init->port = htons(n);
 	}
 
 	if(ttl_str != NULL){
Index: linux-2.6.12-rc/arch/um/drivers/mcast_user.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/mcast_user.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/mcast_user.c	2005-05-17 18:07:10.000000000 -0400
@@ -38,7 +38,7 @@ static struct sockaddr_in *new_addr(char
 	}
 	sin->sin_family = AF_INET;
 	sin->sin_addr.s_addr = in_aton(addr);
-	sin->sin_port = port;
+	sin->sin_port = htons(port);
 	return(sin);
 }
 
@@ -55,28 +55,25 @@ static int mcast_open(void *data)
 	struct mcast_data *pri = data;
 	struct sockaddr_in *sin = pri->mcast_addr;
 	struct ip_mreq mreq;
-	int fd, yes = 1;
+	int fd = -EINVAL, yes = 1, err = -EINVAL;;
 
 
-	if ((sin->sin_addr.s_addr == 0) || (sin->sin_port == 0)) {
-		fd = -EINVAL;
+	if ((sin->sin_addr.s_addr == 0) || (sin->sin_port == 0))
 		goto out;
-	}
 
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
+
 	if (fd < 0){
 		printk("mcast_open : data socket failed, errno = %d\n", 
 		       errno);
-		fd = -ENOMEM;
+		fd = -errno;
 		goto out;
 	}
 
 	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0) {
 		printk("mcast_open: SO_REUSEADDR failed, errno = %d\n",
 			errno);
-		os_close_file(fd);
-		fd = -EINVAL;
-		goto out;
+		goto out_close;
 	}
 
 	/* set ttl according to config */
@@ -84,26 +81,20 @@ static int mcast_open(void *data)
 		       sizeof(pri->ttl)) < 0) {
 		printk("mcast_open: IP_MULTICAST_TTL failed, error = %d\n",
 			errno);
-		os_close_file(fd);
-		fd = -EINVAL;
-		goto out;
+		goto out_close;
 	}
 
 	/* set LOOP, so data does get fed back to local sockets */
 	if (setsockopt(fd, SOL_IP, IP_MULTICAST_LOOP, &yes, sizeof(yes)) < 0) {
 		printk("mcast_open: IP_MULTICAST_LOOP failed, error = %d\n",
 			errno);
-		os_close_file(fd);
-		fd = -EINVAL;
-		goto out;
+		goto out_close;
 	}
 
 	/* bind socket to mcast address */
 	if (bind(fd, (struct sockaddr *) sin, sizeof(*sin)) < 0) {
 		printk("mcast_open : data bind failed, errno = %d\n", errno);
-		os_close_file(fd);
-		fd = -EINVAL;
-		goto out;
+		goto out_close;
 	}		
 	
 	/* subscribe to the multicast group */
@@ -117,12 +108,15 @@ static int mcast_open(void *data)
 		       "interface on the host.\n");
 		printk("eth0 should be configured in order to use the "
 		       "multicast transport.\n");
-		os_close_file(fd);
-		fd = -EINVAL;
+                goto out_close;
 	}
 
  out:
-	return(fd);
+	return fd;
+
+ out_close:
+        os_close_file(fd);
+        return err;
 }
 
 static void mcast_close(int fd, void *data)
@@ -164,14 +158,3 @@ struct net_user_info mcast_user_info = {
 	.delete_address = NULL,
 	.max_packet	= MAX_PACKET - ETH_HEADER_OTHER
 };
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

