Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUJKSP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUJKSP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269170AbUJKSP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:15:27 -0400
Received: from mail.aknet.ru ([217.67.122.194]:25092 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S267504AbUJKSNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:13:38 -0400
Message-ID: <416AC048.6040805@aknet.ru>
Date: Mon, 11 Oct 2004 21:18:00 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: linux-net@vger.kernel.org
Subject: [patch] allow write() on SOCK_PACKET sockets
Content-Type: multipart/mixed;
 boundary="------------070101080404040007020604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070101080404040007020604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Unless I am really missing something, there
seem to be no reason why the SOCK_PACKET code
does not allow to use write() or send() when
the socket was bound, and insists on using
sendto(). SOCK_RAW code, in comparison, allows
write() after bind().
Attached patch allows write() for the SOCK_PACKET
sockets when they are bound.
Can this be applied, or am I missing the point?

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------070101080404040007020604
Content-Type: text/x-patch;
 name="pkt_send.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pkt_send.diff"

--- linux/net/packet/af_packet.c	2004-06-26 15:20:54.000000000 +0400
+++ linux/net/packet/af_packet.c	2004-10-10 02:25:41.000000000 +0400
@@ -322,16 +322,23 @@
 			return(-EINVAL);
 		if (msg->msg_namelen==sizeof(struct sockaddr_pkt))
 			proto=saddr->spkt_protocol;
+		/*
+		 *	Find the device first to size check it 
+		 */
+
+		saddr->spkt_device[13] = 0;
+		dev = dev_get_by_name(saddr->spkt_device);
 	}
 	else
-		return(-ENOTCONN);	/* SOCK_PACKET must be sent giving an address */
-
-	/*
-	 *	Find the device first to size check it 
-	 */
+	{
+		struct packet_opt *po = pkt_sk(sk);
+		if (!po->running || !po->prot_hook.dev)
+			return -ENOTCONN;	/* SOCK_PACKET must be sent giving an address */
+		proto = po->prot_hook.type;
+		dev = po->prot_hook.dev;
+		dev_hold(dev);
+	}
 
-	saddr->spkt_device[13] = 0;
-	dev = dev_get_by_name(saddr->spkt_device);
 	err = -ENODEV;
 	if (dev == NULL)
 		goto out_unlock;

--------------070101080404040007020604--
