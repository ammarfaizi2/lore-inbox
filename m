Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVBPQKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVBPQKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVBPQKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:10:12 -0500
Received: from news.suse.de ([195.135.220.2]:26515 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262068AbVBPQIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:08:49 -0500
Subject: Re: [patch 7/13] Encode and decode arbitrary XDR arrays
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1108495038.10073.102.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203619.570180000@blunzn.suse.de>
	 <1108495038.10073.102.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-12e7tYkjI3RN0a++yPZi"
Organization: SUSE Labs
Message-Id: <1108570128.30082.107.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Feb 2005 17:08:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-12e7tYkjI3RN0a++yPZi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 20:17, Trond Myklebust wrote:
> lau den 22.01.2005 Klokka 21:34 (+0100) skreiv Andreas Gruenbacher:
> > vanlig tekstdokument vedlegg (patches.suse)
> > Add xdr_encode_array2 and xdr_decode_array2 functions for encoding
> > end decoding arrays with arbitrary entries, such as acl entries. The
> > goal here is to do this without allocating a contiguous temporary
> > buffer.
> 
> net/sunrpc/xdr.c:1024:3: warning: mixing declarations and code
> net/sunrpc/xdr.c:967:16: warning: bad constant expression
> 
> Please don't use these gcc extensions in the kernel.

Andrew has anready fixed the "mixing declarations and code" thing. The
attached patch kmallocs the buffer if needed. This uglifies the code
quite a bit though...

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

--=-12e7tYkjI3RN0a++yPZi
Content-Disposition: attachment; filename=nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix2.patch
Content-Type: text/x-patch; name=nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.11-rc3/net/sunrpc/xdr.c
===================================================================
--- linux-2.6.11-rc3.orig/net/sunrpc/xdr.c
+++ linux-2.6.11-rc3/net/sunrpc/xdr.c
@@ -964,10 +964,10 @@ static int
 xdr_xcode_array2(struct xdr_buf *buf, unsigned int base,
 		 struct xdr_array2_desc *desc, int encode)
 {
-	char elem[desc->elem_size], *c;
+	char *elem = NULL, *c;
 	unsigned int copied = 0, todo, avail_here;
 	struct page **ppages = NULL;
-	int err = 0;
+	int err;
 
 	if (encode) {
 		if (xdr_encode_word(buf, base, desc->array_len) != 0)
@@ -1000,6 +1000,12 @@ xdr_xcode_array2(struct xdr_buf *buf, un
 			avail_here -= desc->elem_size;
 		}
 		if (avail_here) {
+			if (!elem) {
+				elem = kmalloc(desc->elem_size, GFP_KERNEL);
+				err = -ENOMEM;
+				if (!elem)
+					goto out;
+			}
 			if (encode) {
 				err = desc->xcode(desc, elem);
 				if (err)
@@ -1032,6 +1038,13 @@ xdr_xcode_array2(struct xdr_buf *buf, un
 			if (copied || avail_page < desc->elem_size) {
 				unsigned int l = min(avail_page,
 					desc->elem_size - copied);
+				if (!elem) {
+					elem = kmalloc(desc->elem_size,
+						       GFP_KERNEL);
+					err = -ENOMEM;
+					if (!elem)
+						goto out;
+				}
 				if (encode) {
 					if (!copied) {
 						err = desc->xcode(desc, elem);
@@ -1065,6 +1078,13 @@ xdr_xcode_array2(struct xdr_buf *buf, un
 			if (avail_page) {
 				unsigned int l = min(avail_page,
 					    desc->elem_size - copied);
+				if (!elem) {
+					elem = kmalloc(desc->elem_size,
+						       GFP_KERNEL);
+					err = -ENOMEM;
+					if (!elem)
+						goto out;
+				}
 				if (encode) {
 					if (!copied) {
 						err = desc->xcode(desc, elem);
@@ -1124,8 +1144,11 @@ xdr_xcode_array2(struct xdr_buf *buf, un
 			todo -= desc->elem_size;
 		}
 	}
+	err = 0;
 
 out:
+	if (elem)
+		kfree(elem);
 	if (ppages)
 		kunmap(*ppages);
 	return err;

--=-12e7tYkjI3RN0a++yPZi--

