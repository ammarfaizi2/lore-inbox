Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D3FC47082
	for <io-uring@archiver.kernel.org>; Sun, 23 May 2021 16:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E77E61175
	for <io-uring@archiver.kernel.org>; Sun, 23 May 2021 16:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhEWQqK (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 23 May 2021 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhEWQqJ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 23 May 2021 12:46:09 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96EAC061574
        for <io-uring@vger.kernel.org>; Sun, 23 May 2021 09:44:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1621788281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v6lC3iUOG2oAgqRzTpk4B/Ko8qBoWV1R/FXI8SIMAPM=;
        b=0BQmUwXFhNWZXm4/2hWrl07+Snb0nsBbveb6FXabPBL4eQfjzlM9N15K61F4fLB22NMhPd
        /GofJo/lI2gqMxcb+IVQsAMTtgqBgQvZfUfsZgKgGDMRngTuIDyifShC53s8MYJTYXayZY
        ABkarqIAKOy1PxAyw96xYU0YVnIc0QLT8RxyQgwuo4MNHwBmNavCA+7kANOTSAIRPoRyhq
        ssF73xB/wZP+H8dIlrHF3fVQs7aNbwMXjnsao8V844lLczA9B/PSol7ycRzh9TSEN5R3Nv
        4ORcmQk6RRXCJOv8T5axKGwus/Emt8wRkA70ul8h9Ert7ULRa3I0LUCjGrl7OQ==
From:   Drew DeVault <sir@cmpwn.com>
To:     io-uring@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Pavel Begunkov" <asml.silence@gmail.com>
Subject: [PATCH v2] io_uring_enter(2): clarify OP_READ and OP_WRITE
Date:   Sun, 23 May 2021 12:44:37 -0400
Message-Id: <20210523164437.22784-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

These do not advance the internal file offset unless the offset is set
to -1, making them behave more like pread/pwrite than read/write.
---
 man/io_uring_enter.2 | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/man/io_uring_enter.2 b/man/io_uring_enter.2
index f898ffd..5b498e5 100644
--- a/man/io_uring_enter.2
+++ b/man/io_uring_enter.2
@@ -576,16 +576,24 @@ for the general description of the related system call. Available since 5.6.
 .TP
 .B IORING_OP_WRITE
 Issue the equivalent of a
-.BR read(2)
+.BR pread(2)
 or
-.BR write(2)
+.BR pwrite(2)
 system call.
 .I fd
 is the file descriptor to be operated on,
 .I addr
-contains the buffer in question, and
+contains the buffer in question,
 .I len
-contains the length of the IO operation. These are non-vectored versions of the
+contains the length of the IO operation, and
+.I offs
+contains the read or write offset. If
+.I offs
+is set to -1, the offset will use (and advance) the file position, like the
+.BR read(2)
+and
+.BR write(2)
+system calls. These are non-vectored versions of the
 .B IORING_OP_READV
 and
 .B IORING_OP_WRITEV
-- 
2.31.1

