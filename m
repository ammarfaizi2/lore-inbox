Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVAGV50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVAGV50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVAGV4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:56:20 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:59622 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261647AbVAGVyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:54:07 -0500
Date: Fri, 7 Jan 2005 16:54:00 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Bryan Fulton <bryan@coverity.com>, linux-kernel@vger.kernel.org,
       jaharkes@cs.cmu.edu
Subject: [PATCH 2.6.10-mm2] fs/coda Re: [Coverity] Untrusted user data in kernel
Message-ID: <20050107215400.GB14630@delft.aura.cs.cmu.edu>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
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


This patch adds bounds checks for tainted scalars
(reported by Brian Fulton and Ted Unangst, Coverity Inc.).

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>

Index: linux-2.6.10-mm2/include/linux/coda.h
===================================================================
--- linux-2.6.10-mm2.orig/include/linux/coda.h	2005-01-07 16:36:03.000000000 -0500
+++ linux-2.6.10-mm2/include/linux/coda.h	2005-01-07 16:42:20.000000000 -0500
@@ -761,8 +761,8 @@
 struct ViceIoctl {
         void __user *in;        /* Data to be transferred in */
         void __user *out;       /* Data to be transferred out */
-        short in_size;          /* Size of input buffer <= 2K */
-        short out_size;         /* Maximum size of output buffer, <= 2K */
+        u_short in_size;        /* Size of input buffer <= 2K */
+        u_short out_size;       /* Maximum size of output buffer, <= 2K */
 };
 
 struct PioctlData {
Index: linux-2.6.10-mm2/fs/coda/upcall.c
===================================================================
--- linux-2.6.10-mm2.orig/fs/coda/upcall.c	2005-01-07 16:36:03.000000000 -0500
+++ linux-2.6.10-mm2/fs/coda/upcall.c	2005-01-07 16:53:03.074276720 -0500
@@ -555,6 +555,11 @@
 		goto exit;
         }
 
+        if (data->vi.out_size > VC_MAXDATASIZE) {
+		error = -EINVAL;
+		goto exit;
+	}
+
         inp->coda_ioctl.VFid = *fid;
     
         /* the cmd field was mutated by increasing its size field to
@@ -583,19 +588,26 @@
 		       error, coda_f2s(fid));
 		goto exit; 
 	}
+
+	if (outsize < (long)outp->coda_ioctl.data + outp->coda_ioctl.len) {
+		error = -EINVAL;
+		goto exit;
+	}
         
 	/* Copy out the OUT buffer. */
         if (outp->coda_ioctl.len > data->vi.out_size) {
 		error = -EINVAL;
-        } else {
-		if (copy_to_user(data->vi.out, 
-				 (char *)outp + (long)outp->coda_ioctl.data, 
-				 data->vi.out_size)) {
-			error = -EFAULT;
-			goto exit;
-		}
+		goto exit;
         }
 
+	/* Copy out the OUT buffer. */
+	if (copy_to_user(data->vi.out, 
+			 (char *)outp + (long)outp->coda_ioctl.data, 
+			 outp->coda_ioctl.len)) {
+		error = -EFAULT;
+		goto exit;
+	}
+
  exit:
 	CODA_FREE(inp, insize);
 	return error;
