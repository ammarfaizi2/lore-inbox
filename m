Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757651AbWKXJdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757651AbWKXJdE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757659AbWKXJc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:32:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52948 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757652AbWKXJbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:31:55 -0500
Subject: [DLM] clear sbflags on lock master [7/9]
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: David Teigland <teigland@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Nov 2006 09:34:43 +0000
Message-Id: <1164360883.3392.144.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 37019bff80ea5e0115fcf992dec7c936dfbe13c9 Mon Sep 17 00:00:00 2001
From: David Teigland <teigland@redhat.com>
Date: Fri, 10 Nov 2006 14:16:27 -0600
Subject: [PATCH] [DLM] clear sbflags on lock master

RH BZ 211622

The ALTMODE flag can be set in the lock master's copy of the lock but
never cleared, so ALTMODE will also be returned in a subsequent conversion
of the lock when it shouldn't be.  This results in lock_dlm incorrectly
switching to the alternate lock mode when returning the result to gfs
which then asserts when it sees the wrong lock state.  The fix is to
propagate the cleared sbflags value to the master node when the lock is
requested.  QA's d_rwrandirectlarge test triggers this bug very quickly.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/lock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6088a16..30878de 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2372,6 +2372,7 @@ static int send_lookup_reply(struct dlm_
 static void receive_flags(struct dlm_lkb *lkb, struct dlm_message *ms)
 {
 	lkb->lkb_exflags = ms->m_exflags;
+	lkb->lkb_sbflags = ms->m_sbflags;
 	lkb->lkb_flags = (lkb->lkb_flags & 0xFFFF0000) |
 		         (ms->m_flags & 0x0000FFFF);
 }
-- 
1.4.1



