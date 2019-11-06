Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0844BC43331
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED3C217F4
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+pPst7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbfKFWlo (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:41:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38003 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFWlo (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:41:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id j15so558837wrw.5;
        Wed, 06 Nov 2019 14:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UI4fYGUL1773gueb8p996BEQZjx4e09Q4dXOd8/ZlzU=;
        b=g+pPst7bPMww++SpTd/5/TxXFp2D5x81VzdT1Z/k1onLZifP7hUUSvdH7aThK1KXYv
         ihLy6qxxCy5yGSPQaqwEsmvD6Pp8yc97VpjT301EFWTns7WQioOSr+8QJ+GtskSEU/vy
         +XWPoQjtB1NPTZsPunFZHehk9vxKm5E4RNeJhCAy1aUDsTfr7gDMQS38kBnadAp4gA0f
         QIY/cMG+pNwAhOobvH0lEEqeok1JMxMJBeBlUo0koEZ5mj8n/TuqQND3kJ/RADrVrMF8
         1JScuNNXvYbF3lS/YskYAGCqW+kVwXdPQsJni18NBZ/+kOYHgW19FJnsS965OuwYDsrg
         HVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UI4fYGUL1773gueb8p996BEQZjx4e09Q4dXOd8/ZlzU=;
        b=VKQTf1O6lA36WeYEURldHcYvATrIWiC4Edn6Rj13vTP3171fwoHhxt1kYPRY0U54NA
         NqM7Y2QhF85VYPeby5yKVAj6IspLHSQJ3pHlmSbLEtkI834J1twxwgRbaWFUx+nIuW5n
         AJp2+N5uoiUWfhMT6F/CLSU98laIoakiFZrRFIIecCbjRYd8cDvX0L3iZLQOv9l8pu+w
         fFNhYSR4/7fK/fe8okZYqXN2mcWvIFwnFon/7hyiuZICTUP8qRHAMfA3h+CRhKS4qn/z
         QoN1X5bbT62QYZHsYpUpDQXqMA6KE8MEMcWnSSkkqmEzWPMMcNPhJSWciuNuEOWw3fhR
         ztXg==
X-Gm-Message-State: APjAAAVn2Q66jr539u520GVx+5P8jDX/84zmRlxEhxJDsF/9+9UJyBDx
        yvv+uWDMxiWxvvXWdSelcnLyyZxS820=
X-Google-Smtp-Source: APXvYqzQ4jlVJr9eZnfv/EwxL1khOUMsIX94jf4qyOuu05++1gWv2hbVglLxitMI6oTfB8VaTg2udw==
X-Received: by 2002:adf:8b09:: with SMTP id n9mr4582411wra.95.1573080102125;
        Wed, 06 Nov 2019 14:41:42 -0800 (PST)
Received: from localhost.localdomain ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id h140sm23469wme.22.2019.11.06.14.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:41:41 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 0/3] Inline sqe_submit
Date:   Thu,  7 Nov 2019 01:41:05 +0300
Message-Id: <cover.1573079844.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The idea is to not pass struct sqe_submit as a separate entity,
but always use req->submit instead, so there will be less stuff to
care about.

Also, I've got steady +1% throughput improvement for nop tests.
Though, it's highly system-dependent, and I wouldn't count on it.

v2: fix use-after-free catched by Jens

v3: -EAGAIN, in case submission failed

Pavel Begunkov (3):
  io_uring: allocate io_kiocb upfront
  io_uring: Use submit info inlined into req
  io_uring: use inlined struct sqe_submit

 fs/io_uring.c | 134 +++++++++++++++++++++++++-------------------------
 1 file changed, 67 insertions(+), 67 deletions(-)

-- 
2.23.0

