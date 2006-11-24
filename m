Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757538AbWKXJbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757538AbWKXJbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757545AbWKXJbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:31:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14036 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757538AbWKXJbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:31:08 -0500
Subject: [DLM] res_recover_locks_count not reset when recover_locks is
	aborted [1/9]
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Nov 2006 09:34:01 +0000
Message-Id: <1164360841.3392.136.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 3c3afe3964bf1259e172e5a8a096a0695897af62 Mon Sep 17 00:00:00 2001
From: David Teigland <teigland@redhat.com>
Date: Thu, 2 Nov 2006 09:49:02 -0600
Subject: [PATCH] [DLM] res_recover_locks_count not reset when recover_locks is aborted

Red Hat BZ 213684

If a node sends an lkb to the new master (RCOM_LOCK message) during
recovery and recovery is then aborted on both nodes before it gets a
reply, the res_recover_locks_count needs to be reset to 0 so that when the
subsequent recovery comes along and sends the lkb to the new master again
the assertion doesn't trigger that checks that counter is zero.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/recover.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index a5e6d18..cf9f683 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -252,6 +252,7 @@ static void recover_list_clear(struct dl
 	spin_lock(&ls->ls_recover_list_lock);
 	list_for_each_entry_safe(r, s, &ls->ls_recover_list, res_recover_list) {
 		list_del_init(&r->res_recover_list);
+		r->res_recover_locks_count = 0;
 		dlm_put_rsb(r);
 		ls->ls_recover_list_count--;
 	}
-- 
1.4.1



