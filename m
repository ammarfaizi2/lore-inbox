Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUDZKcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUDZKcC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUDZKa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:30:57 -0400
Received: from ns.suse.de ([195.135.220.2]:56533 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264482AbUDZK2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:28:51 -0400
Subject: [PATCH 4/11] sunrpc-xdr-words
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1082975183.3295.74.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 26 Apr 2004 12:28:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Encode 32-bit words in xdr_buf's

  Andreas Gruenbacher <agruen@suse.de>, SUSE Labs

Index: linux-2.6.6-rc2/include/linux/sunrpc/xdr.h
===================================================================
--- linux-2.6.6-rc2.orig/include/linux/sunrpc/xdr.h	2004-04-20 23:30:31.000000000 +0200
+++ linux-2.6.6-rc2/include/linux/sunrpc/xdr.h	2004-04-24 22:07:00.013155968 +0200
@@ -153,6 +153,9 @@
 extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, int, int);
 extern int xdr_buf_read_netobj(struct xdr_buf *, struct xdr_netobj *, int);
 extern int read_bytes_from_xdr_buf(struct xdr_buf *buf, int base, void *obj, int len);
+extern int read_u32_from_xdr_buf(struct xdr_buf *, int, u32 *);
+extern int write_bytes_to_xdr_buf(struct xdr_buf *, int, void *, int);
+extern int write_u32_to_xdr_buf(struct xdr_buf *, int, u32);
 
 /*
  * Helper structure for copying from an sk_buff.
Index: linux-2.6.6-rc2/net/sunrpc/sunrpc_syms.c
===================================================================
--- linux-2.6.6-rc2.orig/net/sunrpc/sunrpc_syms.c	2004-04-20 23:30:00.000000000 +0200
+++ linux-2.6.6-rc2/net/sunrpc/sunrpc_syms.c	2004-04-24 22:07:00.010156424 +0200
@@ -132,6 +132,9 @@
 EXPORT_SYMBOL(xdr_buf_subsegment);
 EXPORT_SYMBOL(xdr_buf_read_netobj);
 EXPORT_SYMBOL(read_bytes_from_xdr_buf);
+EXPORT_SYMBOL(read_u32_from_xdr_buf);
+EXPORT_SYMBOL(write_bytes_to_xdr_buf);
+EXPORT_SYMBOL(write_u32_to_xdr_buf);
 
 /* Debugging symbols */
 #ifdef RPC_DEBUG
Index: linux-2.6.6-rc2/net/sunrpc/xdr.c
===================================================================
--- linux-2.6.6-rc2.orig/net/sunrpc/xdr.c	2004-04-20 23:29:43.000000000 +0200
+++ linux-2.6.6-rc2/net/sunrpc/xdr.c	2004-04-24 22:08:19.476075768 +0200
@@ -990,7 +990,7 @@
 	return status;
 }
 
-static int
+int
 read_u32_from_xdr_buf(struct xdr_buf *buf, int base, u32 *obj)
 {
 	u32	raw;
@@ -1003,6 +1003,41 @@
 	return 0;
 }
 
+/* obj is assumed to point to allocated memory of size at least len: */
+int
+write_bytes_to_xdr_buf(struct xdr_buf *buf, int base, void *obj, int len)
+{
+	struct xdr_buf subbuf;
+	int this_len;
+	int status;
+
+	status = xdr_buf_subsegment(buf, &subbuf, base, len);
+	if (status)
+		goto out;
+	this_len = min(len, (int)subbuf.head[0].iov_len);
+	memcpy(subbuf.head[0].iov_base, obj, this_len);
+	len -= this_len;
+	obj += this_len;
+	this_len = min(len, (int)subbuf.page_len);
+	if (this_len)
+		_copy_to_pages(subbuf.pages, subbuf.page_base, obj, this_len);
+	len -= this_len;
+	obj += this_len;
+	this_len = min(len, (int)subbuf.tail[0].iov_len);
+	memcpy(subbuf.tail[0].iov_base, obj, this_len);
+out:
+	return status;
+}
+
+int
+write_u32_to_xdr_buf(struct xdr_buf *buf, int base, u32 obj)
+{
+	int	status;
+
+	obj = htonl(obj);
+	return write_bytes_to_xdr_buf(buf, base, &obj, sizeof(obj));
+}
+
 /* If the netobj starting offset bytes from the start of xdr_buf is contained
  * entirely in the head or the tail, set object to point to it; otherwise
  * try to find space for it at the end of the tail, copy it there, and


