Return-Path: <SRS0=dMkf=6W=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE609C47247
	for <io-uring@archiver.kernel.org>; Fri,  8 May 2020 15:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EEA24955
	for <io-uring@archiver.kernel.org>; Fri,  8 May 2020 15:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GEun4DGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgEHPhf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 May 2020 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbgEHPhF (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 May 2020 11:37:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D447C061A0C;
        Fri,  8 May 2020 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o2cUHvSZE2EbFXmmDO+7qFHMKjG62hLvo4GWWJeNlEI=; b=GEun4DGRcmfYQBOvAkSWSKBi8k
        hyxwpEVsIDW42KAYGD2IG0DBW+naURQPn+t9000Tcky8+RFVAtsEdZQX53snjhIgZGF1c63t/IYif
        RvEWHwHOScnhB1KsKDEJS554BZrnYNEgfwKy8iUVdPkSRAHRXakiHI2Hm9rO+gNqibOnH05EqkW4U
        QbC29MaYTQ8PfMqDDc+fnAEXz4DIo1+rtG6TFmnP7+0r0O5H3HP9m74GFinmTv/XezxrDk4NZk9q+
        xjD/XRPYCLfIpl8OCBt3vIyiGgdyGXi2kJrYnLXrIhyv6HxtF6+9PEkeWLESGyC4ENeK7Kl9FUULM
        yItqzyPQ==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX53h-0004R3-4P; Fri, 08 May 2020 15:37:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 10/12] drm_syncobj: use __anon_inode_getfd
Date:   Fri,  8 May 2020 17:36:32 +0200
Message-Id: <20200508153634.249933-11-hch@lst.de>
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
 drivers/gpu/drm/drm_syncobj.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 42d46414f7679..b69a7be34e8c7 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -581,18 +581,11 @@ int drm_syncobj_get_fd(struct drm_syncobj *syncobj, int *p_fd)
 	struct file *file;
 	int fd;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
+	fd = __anon_inode_getfd("syncobj_file", &drm_syncobj_file_fops,
+			syncobj, O_CLOEXEC, &file);
 	if (fd < 0)
 		return fd;
 
-	file = anon_inode_getfile("syncobj_file",
-				  &drm_syncobj_file_fops,
-				  syncobj, 0);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
-	}
-
 	drm_syncobj_get(syncobj);
 	fd_install(fd, file);
 
-- 
2.26.2

