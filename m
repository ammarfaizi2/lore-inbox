Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263229AbUEGHXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUEGHXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 03:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbUEGHXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 03:23:40 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:60671 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263229AbUEGHXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 03:23:37 -0400
Message-ID: <409B3930.9B0C9659@melbourne.sgi.com>
Date: Fri, 07 May 2004 17:22:24 +1000
From: Greg Banks <gnb@melbourne.sgi.com>
Organization: SGI Australian Software Group
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-6mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Oliver Tennert <tennert@science-computing.de>,
       linux-kernel@vger.kernel.org,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>
Subject: Re: PATCH [NFSd] NFSv3/TCP
References: <Pine.LNX.4.44.0405070834001.4547-100000@picard.science-computing.de> <16539.12572.90447.543633@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> There was once a patch floating around which allowed a larger
> NFSSVC_MAXBLKSIZE on architectures with large page sizes, but it never
> got properly submitted I think.

Then please consider this a resend.  I'll appreciate any guidance
about proper submission.

This patch has been in SGI's ProPack kernel for 6 months and resulted
in a significant improvement in NFS throughput at a number of customer
sites.

--- /usr/tmp/TmpDir.16250-0/linux/linux/include/linux/nfsd/const.h_1.5	Fri May  7
17:20:22 2004
+++ /usr/tmp/TmpDir.16250-0/linux/linux/include/linux/nfsd/const.h	Fri May  7
17:20:22 2004
@@ -12,6 +12,7 @@
 #include <linux/nfs.h>
 #include <linux/nfs2.h>
 #include <linux/nfs3.h>
+#include <asm/page.h>
 
 /*
  * Maximum protocol version supported by knfsd
@@ -19,9 +20,16 @@
 #define NFSSVC_MAXVERS		3
 
 /*
- * Maximum blocksize supported by daemon currently at 8K
+ * Maximum blocksize supported by daemon.  We want the largest
+ * value which 1) fits in a UDP datagram less some headers
+ * 2) is a multiple of page size 3) can be successfully kmalloc()ed
+ * by each nfsd.   
  */
-#define NFSSVC_MAXBLKSIZE	(8*1024)
+#if PAGE_SIZE > (16*1024)
+#define NFSSVC_MAXBLKSIZE	(32*1024)
+#else
+#define NFSSVC_MAXBLKSIZE	(2*PAGE_SIZE)
+#endif
 
 #ifdef __KERNEL__
 


Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
