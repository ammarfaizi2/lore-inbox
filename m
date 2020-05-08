Return-Path: <SRS0=dMkf=6W=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B19C47257
	for <io-uring@archiver.kernel.org>; Fri,  8 May 2020 15:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9B42496A
	for <io-uring@archiver.kernel.org>; Fri,  8 May 2020 15:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QaziO0NS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgEHPhK (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 May 2020 11:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgEHPhI (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 May 2020 11:37:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570CBC061A0C;
        Fri,  8 May 2020 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NUGZNNRYFM0r6kvrHWtMu9/AVBHfp8IFXSz0BKnUiVc=; b=QaziO0NSeQwoBUsoW2UkQtna/5
        NGR+c8JIXGOc/mERbPJ/qE6LMl1yRyZBdONWcRQxh2qN+Rk/qihtN73flB3sHOwJF72lSyQj02odD
        tRz1FUuNgGFRL/cQ8TnpfPM5h5Cp1GcTIBamE9zY4bwV4OvEgkOaL+zUguxEmbvpSuUMR1MxJzv8+
        vEWhImZDiwF5ZZ6jdFCkj2PmwdYN4Nsf7H6j0MBRkCAKtQhrPY8M7ps9NjGjWNJmItph2EXtAXF+u
        6pUJHGpwiV3rE/TKreks53fL62TXAD3rNPY8PafEfyIqPvSP+y90xG3LSslfGPcOAJa2l3FCXL0ip
        KwSFPwBQ==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX53j-0004SG-Pl; Fri, 08 May 2020 15:37:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 11/12] gpiolib: use __anon_inode_getfd
Date:   Fri,  8 May 2020 17:36:33 +0200
Message-Id: <20200508153634.249933-12-hch@lst.de>
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
 drivers/gpio/gpiolib.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 40f2d7f69be26..cbcf47b1e6a40 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -736,21 +736,13 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 	i--;
 	lh->numdescs = handlereq.lines;
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
+	fd = __anon_inode_getfd("gpio-linehandle", &linehandle_fileops, lh,
+			O_RDONLY | O_CLOEXEC, &file);
 	if (fd < 0) {
 		ret = fd;
 		goto out_free_descs;
 	}
 
-	file = anon_inode_getfile("gpio-linehandle",
-				  &linehandle_fileops,
-				  lh,
-				  O_RDONLY | O_CLOEXEC);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto out_put_unused_fd;
-	}
-
 	handlereq.fd = fd;
 	if (copy_to_user(ip, &handlereq, sizeof(handlereq))) {
 		/*
@@ -769,8 +761,6 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 
 	return 0;
 
-out_put_unused_fd:
-	put_unused_fd(fd);
 out_free_descs:
 	for (i = 0; i < count; i++)
 		gpiod_free(lh->descs[i]);
@@ -1110,21 +1100,13 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	if (ret)
 		goto out_free_desc;
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
+	fd = __anon_inode_getfd("gpio-event", &lineevent_fileops, le,
+			O_RDONLY | O_CLOEXEC, &file);
 	if (fd < 0) {
 		ret = fd;
 		goto out_free_irq;
 	}
 
-	file = anon_inode_getfile("gpio-event",
-				  &lineevent_fileops,
-				  le,
-				  O_RDONLY | O_CLOEXEC);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto out_put_unused_fd;
-	}
-
 	eventreq.fd = fd;
 	if (copy_to_user(ip, &eventreq, sizeof(eventreq))) {
 		/*
@@ -1140,8 +1122,6 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 
 	return 0;
 
-out_put_unused_fd:
-	put_unused_fd(fd);
 out_free_irq:
 	free_irq(le->irq, le);
 out_free_desc:
-- 
2.26.2

