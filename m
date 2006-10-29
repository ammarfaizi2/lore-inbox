Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWJ2X2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWJ2X2s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 18:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWJ2X2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 18:28:48 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:17564 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030441AbWJ2X2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 18:28:47 -0500
Date: Mon, 30 Oct 2006 00:28:19 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: [patch] sys_pselect7 vs compat_sys_pselect7 uaccess error handling
Message-ID: <20061029232819.GA11687@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

758333458aa719bfc26ec16eafd4ad3a9e96014d fixes the not checked copy_to_user
return value of compat_sys_pselect7. I ran into this too because of an old
source tree, but my fix would look quite a bit different to Andi's fix.

The reason is that the compat function IMHO should behave the very same as
the non-compat function if possible. Since sys_pselect7 does not return
-EFAULT in this specific case, change the compat code so it behaves like
sys_pselect7.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 fs/compat.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/compat.c b/fs/compat.c
index 50624d4..8d0a001 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -1835,9 +1835,12 @@ asmlinkage long compat_sys_pselect7(int 
 
 	} while (!ret && !timeout && tsp && (ts.tv_sec || ts.tv_nsec));
 
-	if (ret == 0 && tsp && !(current->personality & STICKY_TIMEOUTS)) {
+	if (tsp) {
 		struct compat_timespec rts;
 
+		if (current->personality & STICKY_TIMEOUTS)
+			goto sticky;
+
 		rts.tv_sec = timeout / HZ;
 		rts.tv_nsec = (timeout % HZ) * (NSEC_PER_SEC/HZ);
 		if (rts.tv_nsec >= NSEC_PER_SEC) {
@@ -1846,8 +1849,19 @@ asmlinkage long compat_sys_pselect7(int 
 		}
 		if (compat_timespec_compare(&rts, &ts) >= 0)
 			rts = ts;
-		if (copy_to_user(tsp, &rts, sizeof(rts)))
-			ret = -EFAULT;
+		if (copy_to_user(tsp, &rts, sizeof(rts))) {
+sticky:
+			/*
+			 * If an application puts its timeval in read-only
+			 * memory, we don't want the Linux-specific update to
+			 * the timeval to cause a fault after the select has
+			 * completed successfully. However, because we're not
+			 * updating the timeval, we can't restart the system
+			 * call.
+			 */
+			if (ret == -ERESTARTNOHAND)
+				ret = -EINTR;
+		}
 	}
 
 	if (ret == -ERESTARTNOHAND) {
