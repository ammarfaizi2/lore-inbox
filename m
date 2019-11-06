Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5258FC5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2DF2173E
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDLKGil+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKFWBB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:01:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35982 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfKFWBB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:01:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so441906wrx.3;
        Wed, 06 Nov 2019 14:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4oCSGTDObsSnQ/5bTWCvLq62upftzujdvTtAQ1nYF8=;
        b=ZDLKGil+Ci6h53w56KDWVTugM88AJ5026Rwmnz0QjNBbmNIwPapBjj91mFi3H5n0Sn
         y/HDGFD9la2N8GviZ282ImckgA+j7sbixUwsS1Eh6yeg043p0Cnv2i0h94PPd4AnGuLu
         mpjzRTI1kx3hCj0SuexzltVxY070v1pugD8ZX3fklTZNwxkHYxuTypvuT8/muudffhmP
         jsF3m50SmTkeiM5uOFBhdsOuYh2EEqaA7ZWag9U/K2qVaXQ65oWwy4WHknQQ6NzH7kzN
         DZJevBTXe03A1JpOMpODGYsBTTNCTd3aATGsEAV1KWyNaPMj9mPNFlci2ik3WaqxPRHj
         mMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4oCSGTDObsSnQ/5bTWCvLq62upftzujdvTtAQ1nYF8=;
        b=XjNYzqkdOsCDoX2biJ8Wtb64x8D4vauJPmZ/mB3EPOOO0S87AwQJzAH7UGRZoDQ3Kc
         ScDVnunf6NrRzYWg7w/RcIPYHi9AMAFn7Q0OuDgoXF3O6s08bMjG1mO7mvkkmQvMX18K
         PO7EIecoxHyuoNutmUk7gE4L/KT34B8g9QtbHa+gMMgsKFiiaOsrccoZxBhI+Eq/hbv2
         uErL0xrlKNYVOMrIeS09k/D0lIcN4JXXkkNcCgySWOtixs26dKmHMgBUHH5QtgQlkGlg
         o08KR045zgeSN1rdzWAjTjIToLmpY4BaH5lAN9iQxQz8kNcDCv6v7cc+Y7F9y7rQMhh5
         N/Gg==
X-Gm-Message-State: APjAAAUFhZV1hPj2/+/kza/nBiWW+Iez38G8D0+YMcVf0l6OdF1AZ/bo
        sInIp6Ps8al9EEw+JhUnTIot7ESWOXw=
X-Google-Smtp-Source: APXvYqxbPo1B7ihW4e9ZOaIEVZpXuAhOkXqiI0YYeXL1uWqpSDhlDT+ProltUid/NZeAqSqxa85prQ==
X-Received: by 2002:adf:eccb:: with SMTP id s11mr2539877wro.293.1573077659421;
        Wed, 06 Nov 2019 14:00:59 -0800 (PST)
Received: from localhost.localdomain ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id c24sm62159wrb.27.2019.11.06.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:00:58 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v2 0/3] Inline sqe_submit
Date:   Thu,  7 Nov 2019 01:00:29 +0300
Message-Id: <cover.1573077364.git.asml.silence@gmail.com>
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


Pavel Begunkov (3):
  io_uring: allocate io_kiocb upfront
  io_uring: Use submit info inlined into req
  io_uring: use inlined struct sqe_submit

 fs/io_uring.c | 132 +++++++++++++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 67 deletions(-)

-- 
2.23.0

