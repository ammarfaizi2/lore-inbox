Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVINS4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVINS4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVINS4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:56:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20888
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932496AbVINS4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:56:21 -0400
Date: Wed, 14 Sep 2005 11:56:16 -0700 (PDT)
Message-Id: <20050914.115616.06815109.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH]: Missing acct/mm calls in compat_do_execve()
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As I do periodically, I checked to see how far out of sync
compat_do_execve() has gotten from do_execve().  And as usual there
was some missing stuff in the former.  Perhaps we need some tighter
consolidation of these two routines to make this less likely to happen
in the future.

Anyways, on the success path of compat_do_execve() we forget
to call acct_update_integrals() and update_mem_hiwater(), as
is done in do_execve().

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/fs/compat.c b/fs/compat.c
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -44,6 +44,8 @@
 #include <linux/nfsd/syscall.h>
 #include <linux/personality.h>
 #include <linux/rwsem.h>
+#include <linux/acct.h>
+#include <linux/mm.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
@@ -1487,6 +1489,8 @@ int compat_do_execve(char * filename,
 
 		/* execve success */
 		security_bprm_free(bprm);
+		acct_update_integrals(current);
+		update_mem_hiwater(current);
 		kfree(bprm);
 		return retval;
 	}
