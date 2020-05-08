Return-Path: <SRS0=dMkf=6W=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B490C47257
	for <io-uring@archiver.kernel.org>; Fri,  8 May 2020 15:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3FA24953
	for <io-uring@archiver.kernel.org>; Fri,  8 May 2020 15:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nLXivfej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgEHPg6 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 May 2020 11:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHPg5 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 May 2020 11:36:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C4C061A0C;
        Fri,  8 May 2020 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K2Uub0aVlfxersdFoVOaGQEKIhROd5F6Q0lYewfweLc=; b=nLXivfejQ+u34RbuaNX/WRviAP
        4MWtTgrAfbomeTARHGscIxB0QNC16PC97aZYytTP+FF+q7ACvUTThUK9PVdWxAGifmTgZugVLsN4v
        QY1gxUI/EnmI8tEMw9oblbdgBRg6XuLSqvnYIAcnNngOpBkkT+DiC/aonb2qvEMT37abKrQx4gHFs
        7Ds+24tMuJDuoDd7QTAAiDDNyL9wAWVw2hrtUwae9zOHmIFGIc2fBYTSfQC+irX8W7GgXn0m3XJtS
        S1m572ziEHrm1ZsNjB4+YI+dNh4qBo0ef6X8qTK/iM60a+t/A3rmc/Rt2hlF5iujEmK4Gl4sBeDFV
        V4ot9Jkg==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX53Y-0004E0-RB; Fri, 08 May 2020 15:36:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 07/12] eventfd: use __anon_inode_getfd
Date:   Fri,  8 May 2020 17:36:29 +0200
Message-Id: <20200508153634.249933-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508153634.249933-1-hch@lst.de>
References: <20200508153634.249933-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Use __anon_inode_getfd instead of opencoding the logic using
get_unused_fd_flags + anon_inode_getfile.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/eventfd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index df466ef81dddf..9b6d5137679b2 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -423,20 +423,11 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->count = count;
 	ctx->flags = flags;
 	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
-
-	flags &= EFD_SHARED_FCNTL_FLAGS;
-	flags |= O_RDWR;
-	fd = get_unused_fd_flags(flags);
+	fd = __anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
+		(flags & EFD_SHARED_FCNTL_FLAGS) | O_RDWR, &file);
 	if (fd < 0)
 		goto err;
 
-	file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		fd = PTR_ERR(file);
-		goto err;
-	}
-
 	file->f_mode |= FMODE_NOWAIT;
 	fd_install(fd, file);
 	return fd;
-- 
2.26.2

