Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTCVAXF>; Fri, 21 Mar 2003 19:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261610AbTCVAXF>; Fri, 21 Mar 2003 19:23:05 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:4862 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261463AbTCVAXD>; Fri, 21 Mar 2003 19:23:03 -0500
Date: Fri, 21 Mar 2003 16:32:54 -0800
From: Chris Wright <chris@wirex.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030321163254.E646@figure1.int.wirex.com>
Mail-Followup-To: Junfeng Yang <yjf@stanford.edu>,
	linux-kernel@vger.kernel.org, mc@cs.stanford.edu
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>; from yjf@stanford.edu on Thu, Mar 20, 2003 at 10:33:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Junfeng Yang (yjf@stanford.edu) wrote:
> 
> [UNKNOWN] sys_quotaoctl is a real system call. The entry point is at
> entry.S. But this file is under subdir fs. So there must be something we
> are missing
> 
> /home/junfeng/linux-2.5.63/fs/block_dev.c:817:lookup_bdev: ERROR:TAINTED
> deferencing "path" tainted by [dist=1][called by
> /home/junfeng/linux-2.5.63/fs/quota.c:sys_quotactl:parm1]

Yup, this is a bug, should have a getname() in there.  Patch below.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== fs/quota.c 1.12 vs edited =====
--- 1.12/fs/quota.c	Sun Feb  2 13:40:31 2003
+++ edited/fs/quota.c	Fri Mar 21 16:25:46 2003
@@ -221,12 +221,17 @@
 	uint cmds, type;
 	struct super_block *sb = NULL;
 	struct block_device *bdev;
+	char *tmp;
 	int ret = -ENODEV;
 
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
-	bdev = lookup_bdev(special);
+	tmp = getname(special);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	bdev = lookup_bdev(tmp);
+	putname(tmp);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 	sb = get_super(bdev);
