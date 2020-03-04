Return-Path: <SRS0=iUzr=4V=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAF8C3F2D1
	for <io-uring@archiver.kernel.org>; Wed,  4 Mar 2020 13:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB49C20838
	for <io-uring@archiver.kernel.org>; Wed,  4 Mar 2020 13:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1Aislna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbgCDNPN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:15:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45366 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387992AbgCDNPN (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 4 Mar 2020 08:15:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id v2so2321370wrp.12;
        Wed, 04 Mar 2020 05:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRuvXTjD/bPv3Dn/8R1C/YZLNUqFpK4uHKwIIFfjLvE=;
        b=D1AislnaQYm2mm20PGFzfIW/Hz7YC7gS3iGO/8K5V7ZY7Dii2b/iZX/2UwIXkbMrCj
         yLCHKIBsHLGUnMmWXqzScHao8dskVH46wtNjOPD7hN+w6rqajScN+4hyfF/DU1fVH1m7
         kdQxk1+SNjC7D7tlpu9ZJZ5HwFqB3vMY3tqljWkNhohmfT8zhcws+ki2bTzeBNahfDnv
         gUd8Lh4EVoAExg9co7IYIQmW+0z5JV7IxB8du9evvs1mqwV7GwuFR6JY666sr7+4FBpo
         tlLyAhjl7WkFQ/succ8ddIs/SRwo0a6CjvcQcDgv72pn4KRdealOw5O/dT70LCE9SR6Q
         LSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRuvXTjD/bPv3Dn/8R1C/YZLNUqFpK4uHKwIIFfjLvE=;
        b=H3tzicVBBdql3mdeICEkjhgNclGloFEB2ZSRIA07VRiTkyWnwhxUk2qbHpqtiQ8SY7
         pnAYImZX6LU3VB2G558qQR1Q+ujnPunHgbC7yoqV6lMjt5KJedcK1xCEhWxx3G982lx5
         EZVRFuRCUpaEWfg2WU+7FjvbCvFXAwOPy8ZyvXTIB3hw2i7RM3ZP/BDYbBQ0FMkFnQXM
         XsZnpWgqa7Ejcf4GG6FcI5cFIXR/p5TElyn4hNnJCFWzEHXazQVTmuMFNAN8nO+m1aP5
         yrTglKgum49oP8S+sVIZVspPXfNoLUEUI3MVjFEimFykx5t6cuBDFhQqV8UpOBj4GiAx
         XW+g==
X-Gm-Message-State: ANhLgQ37v757jkOzhh6pnW+dk14BJvuyzm1frvgVmfzKRH2ruz4FfuVd
        sVCww9HhiyLjIaCn3JnqmeA=
X-Google-Smtp-Source: ADFU+vufuO491PqFldO6XhiGin1UqHD5LSSt9/l2D8Gc6MfsEewAdg/CMfFVQbqHAzQHnpzzDJaK1g==
X-Received: by 2002:adf:e742:: with SMTP id c2mr4066931wrn.262.1583327711343;
        Wed, 04 Mar 2020 05:15:11 -0800 (PST)
Received: from localhost.localdomain ([109.126.130.242])
        by smtp.gmail.com with ESMTPSA id c14sm24746746wro.36.2020.03.04.05.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 05:15:10 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] io-wq/io_uring locking optimisation
Date:   Wed,  4 Mar 2020 16:14:08 +0300
Message-Id: <cover.1583314087.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

[1-3] are shedding excessive locking of @wqe's and @worker's spinlocks
from io_worker_handle_work().

[4] removes an extra pair of refcount get/put by making former io_put_work()
to own the submission reference. It also changes io-wq get/put API
and renames io_put_work() into io_free_work() to reflect it.

Pavel Begunkov (4):
  io-wq: shuffle io_worker_handle_work() code
  io-wq: optimise locking in io_worker_handle_work()
  io-wq: optimise out *next_work() double lock
  io_uring/io-wq: forward submission ref to async

 fs/io-wq.c    | 148 ++++++++++++++++++++++++++------------------------
 fs/io-wq.h    |   6 +-
 fs/io_uring.c |  31 ++++-------
 3 files changed, 90 insertions(+), 95 deletions(-)

-- 
2.24.0

