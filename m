Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVAGVxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVAGVxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVAGVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:52:35 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:56806 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261647AbVAGVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:49:59 -0500
Date: Fri, 7 Jan 2005 16:49:55 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Bryan Fulton <bryan@coverity.com>, linux-kernel@vger.kernel.org,
       jaharkes@cs.cmu.edu
Subject: [PATCH 2.4.29-pre3-bk4] fs/coda Re: [Coverity] Untrusted user data in kernel
Message-ID: <20050107214955.GA14630@delft.aura.cs.cmu.edu>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Bryan Fulton <bryan@coverity.com>, linux-kernel@vger.kernel.org,
	jaharkes@cs.cmu.edu
References: <1103247211.3071.74.camel@localhost.localdomain> <20050105120423.GA13662@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105120423.GA13662@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds bounds checking for tainted scalars.
(reported by Brian Fulton and Ted Unangst, Coverity Inc.)

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>

Index: linux-2.4.29-pre3-bk4/include/linux/coda.h
===================================================================
--- linux-2.4.29-pre3-bk4.orig/include/linux/coda.h	2005-01-06 15:37:01.576583328 -0500
+++ linux-2.4.29-pre3-bk4/include/linux/coda.h	2005-01-06 09:12:40.000000000 -0500
@@ -767,8 +767,8 @@
 #define PIOCPARM_MASK 0x0000ffff
 struct ViceIoctl {
         caddr_t in, out;        /* Data to be transferred in, or out */
-        short in_size;          /* Size of input buffer <= 2K */
-        short out_size;         /* Maximum size of output buffer, <= 2K */
+        u_short in_size;        /* Size of input buffer <= 2K */
+        u_short out_size;       /* Maximum size of output buffer, <= 2K */
 };
 
 struct PioctlData {
Index: linux-2.4.29-pre3-bk4/fs/coda/upcall.c
===================================================================
--- linux-2.4.29-pre3-bk4.orig/fs/coda/upcall.c	2005-01-06 15:37:01.609578312 -0500
+++ linux-2.4.29-pre3-bk4/fs/coda/upcall.c	2005-01-06 15:36:24.849166744 -0500
@@ -543,6 +543,11 @@
 		goto exit;
         }
 
+        if (data->vi.out_size > VC_MAXDATASIZE) {
+		error = -EINVAL;
+		goto exit;
+	}
+
         inp->coda_ioctl.VFid = *fid;
     
         /* the cmd field was mutated by increasing its size field to
@@ -571,26 +576,30 @@
 		       error, coda_f2s(fid));
 		goto exit; 
 	}
-        
-	/* Copy out the OUT buffer. */
+
+	if (outsize < (long)outp->coda_ioctl.data + outp->coda_ioctl.len) {
+                CDEBUG(D_FILE, "reply size %d < reply len %ld\n", outsize,
+		       (long)outp->coda_ioctl.data + outp->coda_ioctl.len);
+		error = -EINVAL;
+		goto exit;
+	}
+
         if (outp->coda_ioctl.len > data->vi.out_size) {
-                CDEBUG(D_FILE, "return len %d <= request len %d\n",
-                      outp->coda_ioctl.len, 
-                      data->vi.out_size);
+                CDEBUG(D_FILE, "return len %d > request len %d\n",
+		       outp->coda_ioctl.len, data->vi.out_size);
 		error = -EINVAL;
-        } else {
-		error = verify_area(VERIFY_WRITE, data->vi.out, 
-                                    data->vi.out_size);
-		if ( error ) goto exit;
-
-		if (copy_to_user(data->vi.out, 
-				 (char *)outp + (long)outp->coda_ioctl.data, 
-				 data->vi.out_size)) {
-			error = -EINVAL;
-			goto exit;
-		}
+		goto exit;
         }
 
+	/* Copy out the OUT buffer. */
+	error = verify_area(VERIFY_WRITE, data->vi.out, outp->coda_ioctl.len);
+	if ( error ) goto exit;
+
+	if (copy_to_user(data->vi.out, 
+			 (char *)outp + (long)outp->coda_ioctl.data, 
+			 outp->coda_ioctl.len)) {
+	    error = -EINVAL;
+	}
  exit:
 	CODA_FREE(inp, insize);
 	return error;
