Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUBTVEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUBTVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:03:19 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:10189 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261414AbUBTVCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:02:33 -0500
Date: Fri, 20 Feb 2004 16:02:21 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, brugolsky@telemetry-investments.com
Subject: [PATCH][2/4] poll()/select() timeout behavior
Message-ID: <20040220210221.GC1912@ti19.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cause select() to return EINVAL when passed an un-normalized
timeval usec, and fixes up the range check in preparation for the patch
that follows.

Please apply.

	Bill Rugolsky

--- linux/fs/select.c	2004-02-20 14:22:53.641191351 -0500
+++ linux/fs/select.c	2004-02-20 14:23:01.891295743 -0500
@@ -291,8 +291,6 @@
  * Update: ERESTARTSYS breaks at least the xview clock binary, so
  * I'm trying ERESTARTNOHAND which restart only when you want to.
  */
-#define MAX_SELECT_SECONDS \
-	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
 asmlinkage long
 sys_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
@@ -312,10 +310,10 @@
 			goto out_nofds;
 
 		ret = -EINVAL;
-		if (sec < 0 || usec < 0)
+		if (sec < 0 || usec < 0 || usec >= 1000000)
 			goto out_nofds;
 
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
+		if ((unsigned long) sec < (MAX_SCHEDULE_TIMEOUT-1) / HZ - 1) {
 			timeout = ROUND_UP(usec, 1000000/HZ);
 			timeout += sec * (unsigned long) HZ;
 		}
