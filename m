Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbULWPds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbULWPds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 10:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbULWPds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 10:33:48 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:63244 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S261253AbULWPdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 10:33:43 -0500
Subject: reiserfs bug fix: do not clear MS_ACTIVE mount flag
From: Vladimir Saveliev <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Content-Type: multipart/mixed; boundary="=-fS9+cARK/p7wgIZYaHY1"
Message-Id: <1103816009.3529.130.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 23 Dec 2004 18:33:31 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fS9+cARK/p7wgIZYaHY1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

Andrew, please apply this reiserfs bug fix.

--=-fS9+cARK/p7wgIZYaHY1
Content-Disposition: attachment; filename=reiserfs-do-not-clear-MS_ACTIVE.patch
Content-Type: text/plain; name=reiserfs-do-not-clear-MS_ACTIVE.patch; charset=KOI8-R
Content-Transfer-Encoding: 7bit


When CONFIG_QUOTA is defined reiserfs's finish_unfinished sets and clears
MS_ACTIVE bit in s_flags field of super block. If that bit was set already
it should not be set.


 fs/reiserfs/super.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff -puN fs/reiserfs/super.c~reiserfs-do-not-clear-MS_ACTIVE fs/reiserfs/super.c
--- linux-2.6.10-rc3-mm1/fs/reiserfs/super.c~reiserfs-do-not-clear-MS_ACTIVE	2004-12-23 18:22:06.568755520 +0300
+++ linux-2.6.10-rc3-mm1-vs/fs/reiserfs/super.c	2004-12-23 18:22:06.576756006 +0300
@@ -158,6 +158,7 @@ static int finish_unfinished (struct sup
     int truncate;
 #ifdef CONFIG_QUOTA
     int i;
+    int ms_active_set;
 #endif
  
  
@@ -168,7 +169,12 @@ static int finish_unfinished (struct sup
 
 #ifdef CONFIG_QUOTA
     /* Needed for iput() to work correctly and not trash data */
-    s->s_flags |= MS_ACTIVE;
+    if (s->s_flags & MS_ACTIVE) {
+	    ms_active_set = 0;
+    } else {
+	    ms_active_set = 1;
+	    s->s_flags |= MS_ACTIVE;
+    }
     /* Turn on quotas so that they are updated correctly */
     for (i = 0; i < MAXQUOTAS; i++) {
 	if (REISERFS_SB(s)->s_qf_names[i]) {
@@ -276,8 +282,9 @@ static int finish_unfinished (struct sup
             if (sb_dqopt(s)->files[i])
                     vfs_quota_off_mount(s, i);
     }
-    /* Restore the flag back */
-    s->s_flags &= ~MS_ACTIVE;
+    if (ms_active_set)
+	    /* Restore the flag back */
+	    s->s_flags &= ~MS_ACTIVE;
 #endif
     pathrelse (&path);
     if (done)

_

--=-fS9+cARK/p7wgIZYaHY1--

