Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUE0MJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUE0MJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUE0MJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:09:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:36818 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261991AbUE0MJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:09:36 -0400
Date: Thu, 27 May 2004 14:06:16 +0200
From: Olaf Kirch <okir@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux@horizon.com, akpm@osdl.org, kerndev@sc-software.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 is crashing repeatedly
Message-ID: <20040527120616.GK12225@suse.de>
References: <20040520060805.1620.qmail@science.horizon.com> <20040527112508.24292.qmail@science.horizon.com> <16565.53893.357718.79@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <16565.53893.357718.79@cse.unsw.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > This is not true. The dirent offset is a 64bit quantity, so it's quite
> > possible it will be split across the page boundary. I'm working on a
> > patch...

Here's a patch that hopefully fixes this problem. Please give it
a try and let me know.

Neil, does this look okay to you?

Cheers,
Olaf
-- 
Olaf Kirch     |  The Hardware Gods hate me.
okir@suse.de   |
---------------+ 

--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=nfsd-encode-dirent3

Index: linux-2.6.5/fs/nfsd/nfs3proc.c
===================================================================
--- linux-2.6.5.orig/fs/nfsd/nfs3proc.c	2004-05-27 12:22:43.000000000 +0200
+++ linux-2.6.5/fs/nfsd/nfs3proc.c	2004-05-27 12:34:40.000000000 +0200
@@ -437,7 +437,6 @@
 	resp->buflen = count;
 	resp->common.err = nfs_ok;
 	resp->buffer = argp->buffer;
-	resp->offset = NULL;
 	resp->rqstp = rqstp;
 	nfserr = nfsd_readdir(rqstp, &resp->fh, (loff_t*) &argp->cookie, 
 					&resp->common, nfs3svc_encode_entry);
Index: linux-2.6.5/fs/nfsd/nfs3xdr.c
===================================================================
--- linux-2.6.5.orig/fs/nfsd/nfs3xdr.c	2004-05-27 12:22:43.000000000 +0200
+++ linux-2.6.5/fs/nfsd/nfs3xdr.c	2004-05-27 12:39:09.000000000 +0200
@@ -887,8 +887,18 @@
 	int		elen;		/* estimated entry length in words */
 	int		num_entry_words = 0;	/* actual number of words */
 
-	if (cd->offset)
-		xdr_encode_hyper(cd->offset, (u64) offset);
+	if (cd->offset) {
+		u64 offset64 = offset;
+
+		if (unlikely(cd->offset1)) {
+			/* we ended up with offset on a page boundary */
+			*cd->offset = htonl(offset64 >> 32);
+			*cd->offset1 = htonl(offset64 & 0xffffffff);
+			cd->offset1 = NULL;
+		} else {
+			xdr_encode_hyper(cd->offset, (u64) offset);
+		}
+	}
 
 	/*
 	dprintk("encode_entry(%.*s @%ld%s)\n",
@@ -969,17 +979,32 @@
 			/* update offset */
 			cd->offset = cd->buffer + (cd->offset - tmp);
 		} else {
+			unsigned int offset_r = (cd->offset - tmp) << 2;
+
+			/* update pointer to offset location.
+			 * This is a 64bit quantity, so we need to
+			 * deal with 3 cases:
+			 *  -	entirely in first page
+			 *  -	entirely in second page
+			 *  -	4 bytes in each page
+			 */
+			if (offset_r + 8 <= len1) {
+				cd->offset = p + (cd->offset - tmp);
+			} else if (offset_r >= len1) {
+				cd->offset -= len1 >> 2;
+			} else {
+				/* sitting on the fence */
+				BUG_ON(offset_r != len1 - 4);
+				cd->offset = p + (cd->offset - tmp);
+				cd->offset1 = tmp;
+			}
+
 			len2 = (num_entry_words << 2) - len1;
 
 			/* move from temp page to current and next pages */
 			memmove(p, tmp, len1);
 			memmove(tmp, (caddr_t)tmp+len1, len2);
 
-			/* update offset */
-			if (((cd->offset - tmp) << 2) <= len1)
-				cd->offset = p + (cd->offset - tmp);
-			else
-				cd->offset -= len1 >> 2;
 			p = tmp + (len2 >> 2);
 		}
 	}
Index: linux-2.6.5/include/linux/nfsd/xdr3.h
===================================================================
--- linux-2.6.5.orig/include/linux/nfsd/xdr3.h	2004-05-27 12:22:43.000000000 +0200
+++ linux-2.6.5/include/linux/nfsd/xdr3.h	2004-05-27 12:28:20.000000000 +0200
@@ -183,6 +183,7 @@
 	u32 *			buffer;
 	int			buflen;
 	u32 *			offset;
+	u32 *			offset1;
 	struct svc_rqst *	rqstp;
 
 };

--4bRzO86E/ozDv8r1--
