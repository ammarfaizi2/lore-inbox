Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVAVQBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVAVQBh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 11:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVAVQBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 11:01:37 -0500
Received: from perlsupport.com ([66.220.6.226]:12943 "EHLO
	mail.perlsupport.com") by vger.kernel.org with ESMTP
	id S262361AbVAVQBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 11:01:32 -0500
Date: Sat, 22 Jan 2005 11:01:29 -0500
From: Chip Salzenberg <chip@pobox.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] restore skb_copy_datagram, removed from 2.6.11-rc2, breaking VMWare
Message-ID: <20050122160129.GA4693@perlsupport.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Those of you who are using VMWare 4.5 will find that 2.6.11-rc2
removes the public function "skb_copy_datagram", breaking VMWare
(and any other module using that interface *sigh*).

The attached patch restores the (little harmless wrapper) function.
-- 
Chip Salzenberg            - a.k.a. -            <chip@pobox.com>
 "What I cannot create, I do not understand." - Richard Feynman

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="skb.diff"


--- x/include/linux/skbuff.h.old	2005-01-22 10:03:55.000000000 -0500
+++ y/include/linux/skbuff.h	2005-01-22 10:42:33.000000000 -0500
@@ -1087,4 +1087,6 @@
 extern unsigned int    datagram_poll(struct file *file, struct socket *sock,
 				     struct poll_table_struct *wait);
+extern int	       skb_copy_datagram(const struct sk_buff *from,
+					 int offset, char __user *to, int size);
 extern int	       skb_copy_datagram_iovec(const struct sk_buff *from,
 					       int offset, struct iovec *to,

--- x/net/core/datagram.c.old	2005-01-22 10:03:56.000000000 -0500
+++ y/net/core/datagram.c	2005-01-22 10:43:40.000000000 -0500
@@ -200,4 +200,17 @@
 }
 
+/*
+ *	Copy a datagram to a linear buffer.
+ */
+int skb_copy_datagram(const struct sk_buff *skb, int offset, char __user *to, int size)
+{
+	struct iovec iov = {
+		.iov_base = to,
+		.iov_len =size,
+	};
+
+	return skb_copy_datagram_iovec(skb, offset, &iov, size);
+}
+
 /**
  *	skb_copy_datagram_iovec - Copy a datagram to an iovec.
@@ -478,4 +491,5 @@
 EXPORT_SYMBOL(datagram_poll);
 EXPORT_SYMBOL(skb_copy_and_csum_datagram_iovec);
+EXPORT_SYMBOL(skb_copy_datagram);
 EXPORT_SYMBOL(skb_copy_datagram_iovec);
 EXPORT_SYMBOL(skb_free_datagram);

--mYCpIKhGyMATD0i+--
