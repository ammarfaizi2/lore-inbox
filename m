Return-Path: <SRS0=yVW0=AT=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5376AC433DF
	for <io-uring@archiver.kernel.org>; Wed,  8 Jul 2020 22:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2369520772
	for <io-uring@archiver.kernel.org>; Wed,  8 Jul 2020 22:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g6TPeBkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgGHW0q (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:26:46 -0400
Received: from casper.infradead.org ([90.155.50.34]:45746 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHW0q (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 8 Jul 2020 18:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8AeY0VPt+1o51Qec2dxI2CAeMYSAsJ315806BrJZGyw=; b=g6TPeBkKcn1ohlx9tgjKe4hJ54
        s2YXPrXUVnBDauWTRDpBfKhjeO29SJ3UwfZVyBg3DmY+0PQo56yGuziIUidiDExZhOlqGhYIFzdTo
        Dk43NT3mlud505xWoQcAqad/v4M8WsTS4LhY//pEsMjE3ZwmAIWImFbhlkFliFgK6mB2W0i/UhRY9
        O2PaJUGzBvycUhg8WOndVaBj+ohvUzxT2g82aocVFb/COPZcxQh7X/h2B1A+d3okPK2GAsNpA0+ZX
        lG7fTF3wWG6UN474gRWySueK3xvz9Konu1vKwBq27SBPLHvl3WUSgsuPQUSSFqIbOfn6l+0mW0gCu
        kUfgMOAA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtIWU-00060X-Kz; Wed, 08 Jul 2020 22:26:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: [PATCH 0/2] Remove kiocb ki_complete
Date:   Wed,  8 Jul 2020 23:26:34 +0100
Message-Id: <20200708222637.23046-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Save a pointer in the kiocb by using a few bits in ki_flags to index
a table of completion functions.

Matthew Wilcox (Oracle) (2):
  fs: Abstract calling the kiocb completion function
  fs: Remove kiocb->ki_complete

 crypto/af_alg.c                    |  2 +-
 drivers/block/loop.c               | 14 +++++++--
 drivers/nvme/target/core.c         | 10 +++++-
 drivers/nvme/target/io-cmd-file.c  | 10 +++---
 drivers/nvme/target/nvmet.h        |  2 ++
 drivers/target/target_core_file.c  | 20 ++++++++++--
 drivers/usb/gadget/function/f_fs.c |  2 +-
 drivers/usb/gadget/legacy/inode.c  |  4 +--
 fs/aio.c                           | 50 ++++++++++++++++--------------
 fs/block_dev.c                     |  2 +-
 fs/ceph/file.c                     |  2 +-
 fs/cifs/file.c                     |  8 ++---
 fs/direct-io.c                     |  2 +-
 fs/fuse/file.c                     |  2 +-
 fs/io_uring.c                      | 14 ++++++---
 fs/iomap/direct-io.c               |  3 +-
 fs/nfs/direct.c                    |  2 +-
 fs/ocfs2/file.c                    |  7 +++--
 fs/overlayfs/file.c                | 17 +++++++---
 fs/read_write.c                    | 36 +++++++++++++++++++++
 include/linux/fs.h                 | 23 ++++++++++++--
 21 files changed, 168 insertions(+), 64 deletions(-)

-- 
2.27.0

