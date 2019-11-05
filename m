Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA69C5DF60
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E60F206BA
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFY3O5el"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfKEXFb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:05:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35883 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfKEXFb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 18:05:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id w18so23497631wrt.3;
        Tue, 05 Nov 2019 15:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWYBvnUUDziJAopo8EHpOgtw7mIlGcVj+hqQcKwyCf0=;
        b=NFY3O5elCqv2ayAPto2Qh9weg316TYEQ+1e/z9FYJNxkurqbrgCw9o/RkK11xxS6fA
         NHjGXosO6rtXpgbGdtN3m3rPY0iyWkDRZlrSvsqedgNZCns/LGzeFba5ZYZV/z426AzH
         paUw53nsN3husRPXCTU0sRjreWIIOPHMlbQGVzAGkYxzcpF+xs0ebseqLfjZ9znRKU44
         KedftkEZTYaX4UElf731fUBapDtTPhkHhpURvk2sINW7+xbFLB3AKlhA27hBRdR+sczN
         1YzVucJNvlvGZxZDv+7er7yMuJTsntE5eGIa30usZkfzzizMUdvgU4azINtnZqonCux1
         ZS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWYBvnUUDziJAopo8EHpOgtw7mIlGcVj+hqQcKwyCf0=;
        b=D/woQPlVIvNAq9i23+MS9u/8gle7LfjeMBElfQUJMGm6y0CG7mawYH+7y1BFXDAyqH
         Qwn94WXXLv/H3X0t2sYDeJQOvSoB7soETAbaDSArgU3gt4rOw4EHSeIAXCVWV6syDKRt
         pTICzK8eeKUbkLU7Ut8ww53GZcYtpC50OGHSYdQybGKDdjTlGdHQWoZ1FJ18M56RAh/Y
         teJcLlUH3lJXfB17/kHeNz2wqm4H/zjtvJiwXbwQcajeqti4VDEFcsuWy1ZVY2GmQ/wi
         bwEX9fbEQhUABlJdXmuPWIKsvZ4yrq84Omrg7v/SqYAdH2vCopzPCo/YpEj+5GX8KaWJ
         PVhQ==
X-Gm-Message-State: APjAAAXpgKlMezrLGi1sI8PSgDk5eo3JwKn3PWLqipGO7JLcVDKRFWql
        CeiLwZzhMjiyovY6GaHyCC0=
X-Google-Smtp-Source: APXvYqyTVlY8rqU8ZqzPhu6Mddow2+Cqd0jR+lbSKlWENgcYjU3E815ebC9uu4TbRBPM0Hi7ZR7BoQ==
X-Received: by 2002:a05:6000:1051:: with SMTP id c17mr29062215wrx.124.1572995127411;
        Tue, 05 Nov 2019 15:05:27 -0800 (PST)
Received: from localhost.localdomain ([109.126.129.81])
        by smtp.gmail.com with ESMTPSA id x8sm15579658wrm.7.2019.11.05.15.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 15:05:26 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [RFC 0/3] Inline sqe_submit
Date:   Wed,  6 Nov 2019 02:04:42 +0300
Message-Id: <cover.1572993994.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The proposal is to not pass struct sqe_submit as a separate entity,
but always use req->submit instead, so there will be less stuff to
care about. The reasoning begind is code simplification.

Also, I've got steady +1% throughput improvement for nop tests.
Though, it's highly system-dependent, and I wouldn't count on it.

P.S. I'll double check the patches, if the idea is accepted.


Pavel Begunkov (3):
  io_uring: allocate io_kiocb upfront
  io_uring: Use submit info inlined into req
  io_uring: use inlined struct sqe_submit

 fs/io_uring.c | 127 ++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 66 deletions(-)

-- 
2.23.0

