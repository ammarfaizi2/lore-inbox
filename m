Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVAYArS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVAYArS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVAYAnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:43:32 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:12270 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261761AbVAYAlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:41:18 -0500
Date: Tue, 25 Jan 2005 01:41:17 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc2: vmnet breaks; put skb_copy_datagram back in place
Message-ID: <20050125004117.GB610@speedy.student.utwente.nl>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, could you please put skb_copy_datagram back in place? It's not used
anymore in the kernel, but the vmnet module (in vmware) still uses this
interface to skb_copy_datagram_iovec.

Patch for 2.6.11-rc2 follows. It compiles cleanly; I have not tested it yet,
but I assume it's okay. I'll test it right after sending this mail and report
back here if something goes wrong.

    Sytse

diff -ru a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h    2005-01-25 01:27:00.000000000 +0100
+++ b/include/linux/skbuff.h    2005-01-25 01:31:20.000000000 +0100
@@ -1086,6 +1086,8 @@
                                         int noblock, int *err);
 extern unsigned int    datagram_poll(struct file *file, struct socket *sock,
                                     struct poll_table_struct *wait);
+extern int            skb_copy_datagram(const struct sk_buff *from,
+                                        int offset, char __user *to, int size);
 extern int            skb_copy_datagram_iovec(const struct sk_buff *from,
                                               int offset, struct iovec *to,
                                               int size);
diff -ru a/net/core/datagram.c b/net/core/datagram.c
--- a/net/core/datagram.c       2005-01-25 01:27:01.000000000 +0100
+++ b/net/core/datagram.c       2005-01-25 01:31:20.000000000 +0100
@@ -199,6 +199,19 @@
        kfree_skb(skb);
 }
 
+/*
+ *     Copy a datagram to a linear buffer.
+ */
+int skb_copy_datagram(const struct sk_buff *skb, int offset, char __user *to, int size)
+{
+       struct iovec iov = {
+               .iov_base = to,
+               .iov_len =size,
+       };
+
+       return skb_copy_datagram_iovec(skb, offset, &iov, size);
+}
+
 /**
  *     skb_copy_datagram_iovec - Copy a datagram to an iovec.
  *     @skb - buffer to copy
@@ -477,6 +490,7 @@
 
 EXPORT_SYMBOL(datagram_poll);
 EXPORT_SYMBOL(skb_copy_and_csum_datagram_iovec);
+EXPORT_SYMBOL(skb_copy_datagram);
 EXPORT_SYMBOL(skb_copy_datagram_iovec);
 EXPORT_SYMBOL(skb_free_datagram);
 EXPORT_SYMBOL(skb_recv_datagram);
