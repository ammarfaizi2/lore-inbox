Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUEFTkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUEFTkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUEFTkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 15:40:41 -0400
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:33286 "EHLO
	rtp-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S262065AbUEFTki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 15:40:38 -0400
X-BrightmailFiltered: true
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto/crc32c.c (was Re: CRC32c warning on sparc64)
References: <Pine.GSO.4.44.0405061921290.21792-100000@math.ut.ee>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Thu, 06 May 2004 14:40:32 -0500
In-Reply-To: <Pine.GSO.4.44.0405061921290.21792-100000@math.ut.ee> (Meelis
 Roos's message of "Thu, 6 May 2004 20:38:52 +0300 (EEST)")
Message-ID: <yqujr7tx1gzz.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2004, Meelis Roos uttered the following:
> This is 2.6.6-rc3+BK as of today on a sparc64 (gcc 3.3.3 on Debian):
> 
>   CC [M] crypto/crc32c.o crypto/crc32c.c:89: warning: initialization
>   from incompatible pointer type
> 
> This is because chksum_update uses size_t (64-bit unsigned long on
> sparc64) length argument but dia_update seems to want unsigned int
> as the type of length.
> 
> What is the right fix - change the length in chksum_update() and
> crc32c() to unsigned int?

Well, it's my opinion that using "size_t" is correct usage of type in
this case.  So here's my thinking:

* we leave lib/crc32c() as it is with size_t, as it is meant to be
derived from crc32() and that uses size_t.

* crypto/crc32c is a wrapper for lib/crc32c.  The interface it
presents to the rest of the crypto routines should agree.  My bad.
So, let us let it translate with a cast, as in the patch below.
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
  "Oh, *that* Physics Prize.  Well, I just substituted 'stupidity' for
      'dark matter' in the equations, and it all came together."

--- linux-2.6.6-rc3-bk.orig/crypto/crc32c.c	2004-05-06 14:11:54.000000000 -0500
+++ linux-2.6.6-rc3-bk/crypto/crc32c.c	2004-05-06 14:12:56.000000000 -0500
@@ -56,12 +56,12 @@
 	return 0;
 }
 
-static void chksum_update(void *ctx, const u8 *data, size_t length)
+static void chksum_update(void *ctx, const u8 *data, unsigned int length)
 {
 	struct chksum_ctx *mctx = ctx;
 	u32 mcrc;
 
-	mcrc = crc32c(mctx->crc, data, length);
+	mcrc = crc32c(mctx->crc, data, (size_t)length);
 
 	mctx->crc = mcrc;
 }
