Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74538C5DF65
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 19:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D63C20869
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 19:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MJ1q17dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfKFTkr (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:40:47 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:40751 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfKFTkq (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 14:40:46 -0500
Received: by mail-io1-f54.google.com with SMTP id p6so28268083iod.7
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 11:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WeAdnPwLkVKfjKfS85mq63m4KGYUB+j3SdfSQTZ/5c=;
        b=MJ1q17dtSVxRv9TCZuuqetYE/SzaC4BxnJhYa46r5oZAhNHYbhB3gLJ6if3dihobhS
         qG20fr4+FMm24uPn/OJjWsAwJVijf9du+GpXJX3fIYzgCh6E4eYJYSpFFoo7uJYfizHg
         YftxIb0S9ru39hmVSx3Q6h9JennMxvq++kj6f3glEGR1fMaQh/6YhysmJ2baGC/SXgiH
         sWH3tsQWml5NcfdZ57cntwmjpmfl/H4ofA7LIQCciRvNcOBfjSFmx2mLDLxdOl3aeHgc
         lRYoaVkI/no7DqCv68//qttb1Nq1/1mKNQW0irke4l+t4Wpv685ZigJRigsBvHsTZ66Z
         QPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WeAdnPwLkVKfjKfS85mq63m4KGYUB+j3SdfSQTZ/5c=;
        b=T0CEVDZtq246X1QEx39RrF9OUXJvC82NIMCL9vcfd5Jo8IVeOdaR86x5rtPSYUoMj0
         0VblT8a4rYSzOMJmxQBpMlbbI7bkAvfzQEMkho2h7hvmTO4SAEs3q1WDbjTLLSbD/zQx
         rhk1RbQ+hb8Q1qfhJTKl+gHypHrj5kheh0yhXPmbXcTFD2Zi4Rg71hjSAme92AgAjY1f
         Ek09s/plIi0SOizBAr1XCTuiUGSJojEt9W5Et2TYryzmdM+4bk71IKeoSKz4ogwbgVWl
         zXzS0NXyHP8L8mTyVpSlLM3CbgJ3eD+ZcaXd86zRe9iYdSFpkOBonD/xXykAgVi5uPrB
         a+Pw==
X-Gm-Message-State: APjAAAW6KiRrQKaZKi5IZ9Hy5X+2OdNENhoiLmT8kHfj0roXRGHuS/EK
        Pg2FM6HBSNcKO7cVA/hWepus91+WCnM=
X-Google-Smtp-Source: APXvYqyZimxCKIca76Oa1yx0JDSibimpMSF4IftFJLm6sh3QobxxcrCUtKip4lDiWSr1mhf8BCysWg==
X-Received: by 2002:a02:5103:: with SMTP id s3mr9924680jaa.45.1573069243949;
        Wed, 06 Nov 2019 11:40:43 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k22sm911298iot.34.2019.11.06.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:40:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/2] Add unbounded io_wq for io_uring
Date:   Wed,  6 Nov 2019 12:40:38 -0700
Message-Id: <20191106194040.26723-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Currently we have just the one workqueue for each io_uring ctx, which
supports any kind of IO. This is problematic with requests that have
very different life times. For example, disk IO is always bounded in
time, while networked IO can take a long time. Ditto with POLL commands,
that also have unbounded execution time.

First patch is just a prep patch, patch number two adds support for
determining the io_wq placement based on the request type.

Patches are against my for-5.5/io_uring-test branch.

 fs/io-wq.c    |   8 +--
 fs/io-wq.h    |   2 +-
 fs/io_uring.c | 145 ++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 110 insertions(+), 45 deletions(-)

-- 
 Jens Axboe


