Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWJWH1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWJWH1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWJWH1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:27:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32898 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751684AbWJWH1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:27:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jakub Jelinek <jakub@redhat.com>, Mike Galbraith <efault@gmx.de>,
       "Albert Cahalan" <acahalan@gmail.com>,
       Bill Nottingham <notting@redhat.com>,
       Marco Roeland <marco.roeland@xs4all.nl>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [RFD][PATCH 2/2] sysctl:  Implement CTL_UNNUMBERED
References: <m13b9fxzs0.fsf@ebiederm.dsl.xmission.com>
Date: Mon, 23 Oct 2006 01:25:13 -0600
In-Reply-To: <m13b9fxzs0.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Mon, 23 Oct 2006 01:22:07 -0600")
Message-ID: <m1y7r7wl2e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch takes the CTL_UNNUMBERD concept from NFS and makes
it available to all new sysctl users.

At the same time the sysctl binary interface maintenance documentation
is updated to mention and to describe what is needed to successfully
maintain the sysctl binary interface.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/lockd/svc.c         |    3 ---
 fs/nfs/sysctl.c        |    5 -----
 include/linux/sysctl.h |   14 +++++++++++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 6341392..8ca1808 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -353,9 +353,6 @@ EXPORT_SYMBOL(lockd_down);
  * Sysctl parameters (same as module parameters, different interface).
  */
 
-/* Something that isn't CTL_ANY, CTL_NONE or a value that may clash. */
-#define CTL_UNNUMBERED		-2
-
 static ctl_table nlm_sysctls[] = {
 	{
 		.ctl_name	= CTL_UNNUMBERED,
diff --git a/fs/nfs/sysctl.c b/fs/nfs/sysctl.c
index 2fe3403..3ea50ac 100644
--- a/fs/nfs/sysctl.c
+++ b/fs/nfs/sysctl.c
@@ -18,11 +18,6 @@ #include "callback.h"
 static const int nfs_set_port_min = 0;
 static const int nfs_set_port_max = 65535;
 static struct ctl_table_header *nfs_callback_sysctl_table;
-/*
- * Something that isn't CTL_ANY, CTL_NONE or a value that may clash.
- * Use the same values as fs/lockd/svc.c
- */
-#define CTL_UNNUMBERED -2
 
 static ctl_table nfs_cb_sysctls[] = {
 #ifdef CONFIG_NFS_V4
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index c184732..91e0bf0 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -6,10 +6,17 @@
  ****************************************************************
  ****************************************************************
  **
+ **  WARNING:
  **  The values in this file are exported to user space via 
- **  the sysctl() binary interface.  However this interface
- **  is unstable and deprecated and will be removed in the future. 
- **  For a stable interface use /proc/sys.
+ **  the sysctl() binary interface.  Do *NOT* change the 
+ **  numbering of any existing values here, and do not change
+ **  any numbers within any one set of values.  If you have to
+ **  have to redefine an existing interface, use a new number for it.
+ **  The kernel will then return -ENOTDIR to any application using
+ **  the old binary interface.
+ **
+ **  For new interfaces unless you really need a binary number 
+ **  please use CTL_UNNUMBERED.
  **
  ****************************************************************
  ****************************************************************
@@ -48,6 +55,7 @@ struct __sysctl_args {
 #ifdef __KERNEL__
 #define CTL_ANY		-1	/* Matches any name */
 #define CTL_NONE	0
+#define CTL_UNNUMBERED	CTL_NONE	/* sysctl without a binary number */
 #endif
 
 enum
-- 
1.4.2.rc3.g7e18e-dirty

