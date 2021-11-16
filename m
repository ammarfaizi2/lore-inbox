Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836A1C433F5
	for <io-uring@archiver.kernel.org>; Tue, 16 Nov 2021 22:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626C861A52
	for <io-uring@archiver.kernel.org>; Tue, 16 Nov 2021 22:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhKPW4a (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 16 Nov 2021 17:56:30 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43686 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhKPW43 (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Tue, 16 Nov 2021 17:56:29 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 17:56:29 EST
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C7DE61FA10;
        Tue, 16 Nov 2021 22:44:56 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     io-uring@vger.kernel.org
Cc:     Liu Changcheng <changcheng.liu@aliyun.com>,
        Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 4/4] debian/rules: support parallel build
Date:   Tue, 16 Nov 2021 22:44:56 +0000
Message-Id: <20211116224456.244746-5-e@80x24.org>
In-Reply-To: <20211116224456.244746-1-e@80x24.org>
References: <20211116224456.244746-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This bit stolen from the debian/rules file of `git'
speeds up builds from ~35s to ~10s for me.

Signed-off-by: Eric Wong <e@80x24.org>
---
 debian/rules | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/debian/rules b/debian/rules
index 2a0d563..4b58d90 100755
--- a/debian/rules
+++ b/debian/rules
@@ -9,6 +9,16 @@ DEB_CFLAGS_MAINT_PREPEND = -Wall
 include /usr/share/dpkg/default.mk
 include /usr/share/dpkg/buildtools.mk
 
+# taken from the debian/rules of src:git
+ifneq (,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
+  NUMJOBS = $(patsubst parallel=%,%,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
+  MAKEFLAGS += -j$(NUMJOBS)
+  # Setting this with a pattern-specific rule prevents -O from
+  # affecting the top-level make, which would break realtime build
+  # output (unless dh is run as +dh, which causes other problems).
+  %: MAKEFLAGS += -O
+endif
+
 export CC
 
 lib := liburing1
