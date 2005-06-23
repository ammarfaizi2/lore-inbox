Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVFWKDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVFWKDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVFWJ7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 05:59:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:6878 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262449AbVFWJxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:53:49 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE LINUX Products GMBH
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: Potential xdr_xcode_array2 security issue (was: Re: [PATCH] RPC: Encode and decode arbitrary XDR arrays)
Date: Thu, 23 Jun 2005 11:53:41 +0200
User-Agent: KMail/1.8
Cc: Florian Weimer <fw@deneb.enyo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olaf Kirch <okir@suse.de>
References: <200506230502.j5N52PWP007955@hera.kernel.org> <87y8911v46.fsf@deneb.enyo.de>
In-Reply-To: <87y8911v46.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_laouCOffTQ+vw9y"
Message-Id: <200506231153.41318.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_laouCOffTQ+vw9y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 23 June 2005 07:48, Florian Weimer wrote:
> This looks suspiciously like CVE-2002-0391.

Thanks, Florian. How about the attached patch?

Cheers,
Andreas.

--Boundary-00=_laouCOffTQ+vw9y
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="xdr-input-validation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xdr-input-validation.diff"

From: Andreas Gruenbacher <agruen@suse.de>
Subject: Overflow in xdr input validation

The bounds check in xdr_xcode_array2 can overflow. Reported by
Florian Weimer <fw@deneb.enyo.de>.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.5/net/sunrpc/xdr.c
===================================================================
--- linux-2.6.5.orig/net/sunrpc/xdr.c
+++ linux-2.6.5/net/sunrpc/xdr.c
@@ -989,8 +989,7 @@ xdr_xcode_array2(struct xdr_buf *buf, un
 			return -EINVAL;
 	} else {
 		if (xdr_decode_word(buf, base, &desc->array_len) != 0 ||
-		    (unsigned long) base + 4 + desc->array_len *
-				    desc->elem_size > buf->len)
+		    desc->array_len > (buf->len - base - 4) / desc->elem_size)
 			return -EINVAL;
 	}
 	base += 4;
@@ -1158,8 +1157,8 @@ int
 xdr_encode_array2(struct xdr_buf *buf, unsigned int base,
 		  struct xdr_array2_desc *desc)
 {
-	if ((unsigned long) base + 4 + desc->array_len * desc->elem_size >
-	    buf->head->iov_len + buf->page_len + buf->tail->iov_len)
+	if (buf->head->iov_len + buf->page_len + buf->tail->iov_len -
+	    base < desc->array_len * desc->elem_size + 4)
 		return -EINVAL;
 
 	return xdr_xcode_array2(buf, base, desc, 1);

--Boundary-00=_laouCOffTQ+vw9y--
