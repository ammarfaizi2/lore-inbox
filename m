Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbTDMIq6 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 04:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTDMIq6 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 04:46:58 -0400
Received: from phobos.aros.net ([66.219.192.20]:526 "EHLO phobos.aros.net")
	by vger.kernel.org with ESMTP id S263401AbTDMIq5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 04:46:57 -0400
Message-ID: <3E992EAD.6050102@aros.net>
Date: Sun, 13 Apr 2003 03:32:29 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com, marcelo@conectiva.com.br
Subject: [PATCH] network block device driver, kernel 2.4
Content-Type: multipart/mixed;
 boundary="------------090901090703070208090509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090901090703070208090509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's a simple patch to nbd.c to fix some of the potential for oopses 
(and possible corruption) should the nbd-client that handed off a socket 
exit (implicitly closing the socket), while the driver is still sending 
requests onto that socket. The oops can easily be seen when root runs 
"nbd-client -d /dev/nbX" after /dev/nbX has been setup and still has a 
bunch of I/O buffered up (and is sending requests to the socket to 
handle the queue). This patch doesn't change functionality.

Louis D. Langholtz

--------------090901090703070208090509
Content-Type: text/plain;
 name="nbd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd.diff"

--- linux-2.4.20/drivers/block/nbd.c	2002-08-02 18:39:43.000000000 -0600
+++ linux/drivers/block/nbd.c	2003-04-13 02:24:26.000000000 -0600
@@ -26,6 +26,8 @@
  *   reduce number of partial TCP segments sent. <steve@chygwyn.com>
  * 01-12-6 Fix deadlock condition by making queue locks independant of
  *   the transmit lock. <steve@chygwyn.com>
+ * 03-04-12 Fix some possible ways to oops from the nbd-client closing the
+ *   socket it gave us while we're still using that socket. <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -153,7 +155,7 @@
 	int result;
 	struct nbd_request request;
 	unsigned long size = req->nr_sectors << 9;
-	struct socket *sock = lo->sock;
+	struct socket *sock;
 
 	DEBUG("NBD: sending control, ");
 	request.magic = htonl(NBD_REQUEST_MAGIC);
@@ -163,6 +165,8 @@
 	memcpy(request.handle, &req, sizeof(req));
 
 	down(&lo->tx_lock);
+	sock = lo->sock;
+	if (!sock) goto error_out; /* we got cleared */
 
 	result = nbd_xmit(1, sock, (char *) &request, sizeof(request), req->cmd == WRITE ? MSG_MORE : 0);
 	if (result <= 0)
@@ -402,7 +406,10 @@
 		if (!file)
 			return -EINVAL;
 		lo->file = NULL;
+		/* ensure we're not in critical section of nbd_send_req() */
+		down(&lo->tx_lock);
 		lo->sock = NULL;
+		up(&lo->tx_lock);
 		fput(file);
 		return 0;
 	case NBD_SET_SOCK:

--------------090901090703070208090509--

