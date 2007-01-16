Return-Path: <linux-kernel-owner+w=401wt.eu-S1750863AbXAPU0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbXAPU0O (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbXAPU0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:26:13 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:2288 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbXAPU0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:26:13 -0500
X-Greylist: delayed 710 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 15:26:12 EST
Date: Tue, 16 Jan 2007 15:13:32 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.com, torvalds@osdl.com, nhorman@tuxdriver.com
Subject: [PATCH] select: fix sys_select to not leak ERESTARTNOHAND to userspace
Message-ID: <20070116201332.GA28523@hmsreliant.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As it is currently written, sys_select checks its return code to convert
ERESTARTNOHAND to EINTR.  However, the check is within an if (tvp) clause, and
so if select is called from userspace with a NULL timeval, then it is possible
for the ERESTARTNOHAND errno to leak into userspace, which is incorrect.  This
patch moves that check outside of the conditional, and prevents the errno leak.

Thanks & Regards
Neil

Signed-Off-By: Neil Horman <nhorman@tuxdriver.com>


 select.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)


diff --git a/fs/select.c b/fs/select.c
index fe0893a..afcd691 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -415,20 +415,12 @@ asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 		rtv.tv_sec = timeout;
 		if (timeval_compare(&rtv, &tv) >= 0)
 			rtv = tv;
-		if (copy_to_user(tvp, &rtv, sizeof(rtv))) {
-sticky:
-			/*
-			 * If an application puts its timeval in read-only
-			 * memory, we don't want the Linux-specific update to
-			 * the timeval to cause a fault after the select has
-			 * completed successfully. However, because we're not
-			 * updating the timeval, we can't restart the system
-			 * call.
-			 */
-			if (ret == -ERESTARTNOHAND)
-				ret = -EINTR;
-		}
+		if (copy_to_user(tvp, &rtv, sizeof(rtv)))
+			return -EFAULT;
 	}
+sticky:
+	if (ret == -ERESTARTNOHAND)
+		ret = -EINTR;
 
 	return ret;
 }
