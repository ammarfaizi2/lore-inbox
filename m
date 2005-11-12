Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVKLSCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVKLSCK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVKLSCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:02:09 -0500
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]:48864 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932457AbVKLSCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:02:08 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 5/9] uml: fix mcast network driver error handling
Date: Sat, 12 Nov 2005 19:07:36 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051112180732.20133.15230.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

printk clears the host errno (I verified this in debugging and it's reasonable
enough, given that it ends via a write call on some fd, especially since
printk() goes on /dev/tty0 which is often the host stdout).
So save errno earlier. There's no reason to change the printk calls to use -err
rather than errno - the assignment can't clear errno.

And in the first failure path, we used to return 0 too (and this time more
clearly), which is totally wrong. 0 is a success fd, which is then registered
and gives a "registering fd twice" warning.

Finally, fix up some whitespace.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/mcast_user.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/mcast_user.c b/arch/um/drivers/mcast_user.c
index 5db136e..afe85bf 100644
--- a/arch/um/drivers/mcast_user.c
+++ b/arch/um/drivers/mcast_user.c
@@ -54,7 +54,7 @@ static int mcast_open(void *data)
 	struct mcast_data *pri = data;
 	struct sockaddr_in *sin = pri->mcast_addr;
 	struct ip_mreq mreq;
-	int fd, yes = 1, err = 0;
+	int fd, yes = 1, err = -EINVAL;
 
 
 	if ((sin->sin_addr.s_addr == 0) || (sin->sin_port == 0))
@@ -63,40 +63,40 @@ static int mcast_open(void *data)
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
 
 	if (fd < 0){
+		err = -errno;
 		printk("mcast_open : data socket failed, errno = %d\n", 
 		       errno);
-		err = -errno;
 		goto out;
 	}
 
 	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0) {
+		err = -errno;
 		printk("mcast_open: SO_REUSEADDR failed, errno = %d\n",
 			errno);
-		err = -errno;
 		goto out_close;
 	}
 
 	/* set ttl according to config */
 	if (setsockopt(fd, SOL_IP, IP_MULTICAST_TTL, &pri->ttl,
 		       sizeof(pri->ttl)) < 0) {
+		err = -errno;
 		printk("mcast_open: IP_MULTICAST_TTL failed, error = %d\n",
 			errno);
-		err = -errno;
 		goto out_close;
 	}
 
 	/* set LOOP, so data does get fed back to local sockets */
 	if (setsockopt(fd, SOL_IP, IP_MULTICAST_LOOP, &yes, sizeof(yes)) < 0) {
+		err = -errno;
 		printk("mcast_open: IP_MULTICAST_LOOP failed, error = %d\n",
 			errno);
-		err = -errno;
 		goto out_close;
 	}
 
 	/* bind socket to mcast address */
 	if (bind(fd, (struct sockaddr *) sin, sizeof(*sin)) < 0) {
-		printk("mcast_open : data bind failed, errno = %d\n", errno);
 		err = -errno;
+		printk("mcast_open : data bind failed, errno = %d\n", errno);
 		goto out_close;
 	}		
 	
@@ -105,22 +105,22 @@ static int mcast_open(void *data)
 	mreq.imr_interface.s_addr = 0;
 	if (setsockopt(fd, SOL_IP, IP_ADD_MEMBERSHIP, 
 		       &mreq, sizeof(mreq)) < 0) {
+		err = -errno;
 		printk("mcast_open: IP_ADD_MEMBERSHIP failed, error = %d\n",
 			errno);
 		printk("There appears not to be a multicast-capable network "
 		       "interface on the host.\n");
 		printk("eth0 should be configured in order to use the "
 		       "multicast transport.\n");
-		err = -errno;
-                goto out_close;
+		goto out_close;
 	}
 
 	return fd;
 
  out_close:
-        os_close_file(fd);
+	os_close_file(fd);
  out:
-        return err;
+	return err;
 }
 
 static void mcast_close(int fd, void *data)

