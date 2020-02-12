Return-Path: <SRS0=2NQH=4A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EC9C2BA83
	for <io-uring@archiver.kernel.org>; Wed, 12 Feb 2020 04:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693E520842
	for <io-uring@archiver.kernel.org>; Wed, 12 Feb 2020 04:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="gAGJPRTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBLEMg (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:12:36 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35822 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLEMg (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 11 Feb 2020 23:12:36 -0500
Received: by mail-lj1-f180.google.com with SMTP id q8so670802ljb.2
        for <io-uring@vger.kernel.org>; Tue, 11 Feb 2020 20:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ddbc8EZ31/HLaljcB/hWqG7TibOsoBF8nvuzDQ9pkhI=;
        b=gAGJPRTN7fO1KQDib1O1hZkmBgWdkLBAQQdCjWt45d4t1/nuR/rbWdyOu4WfYhJ4YJ
         vITDXX5A7ZB5RrPIKmQAmbbZSN8kNIHuerUpR+ydg+Sm19Oxwmie6CfSmTk8zmIm2KZp
         Xi+rrZk+kXJoCqghM+wf30OWPcxcKZ6Kz0kSU4slQkxJKmDinjGZrm2krPO22heKK7Ol
         9ubN6T4GpB2rC/NQ0VFYI48DsGrPP9NKfwEzxOv2iPSqY4I0zpBL6ezTHB4zXiQzhcaG
         m8cJ9/yVeWtvVg/a9PkL8rzE69TLaC4AjHntgKH3DSbUoHcjcmexIhFojsI4YcjbLxGr
         74ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ddbc8EZ31/HLaljcB/hWqG7TibOsoBF8nvuzDQ9pkhI=;
        b=E9ikNHgaiWwFAd9AHkwGzFjTV2oJlUVajbFMNNkXPC1JomYU7vl+ul2doQNgTuQWbm
         zYWm8dLx24RtJmfdyaN4F8a5C1l+VUT51OOewOWzeeMEA+PMg2cje1tQtOiPmfb3yQ3R
         hq0vJv/FF1Tap83yf4FzP3kvmPED6HbpTFMEvYKdv4+5AvLlEDisWXoUKvHnIMd65fNH
         G8TrhiNwclHzNGEmpKSXZKsaFF+fv9pfKRI2vPir3SB1W+frWUqwiHrYL/US3zPqKVv+
         zY+DrgRsxPJVcXhPFgcM/gZek30PX38KSHNlf7RNPZHk4fsuPv9UOe24ZLbHMc/JgLdF
         W21Q==
X-Gm-Message-State: APjAAAWEG1d4n3QMbtN4zCnDHqb7B46PCXoYyr5clbp75LPweF05AFvQ
        b7DxQSBpUrfOmaHcj8bsWy+qMWrabpfPyVIKvlBwQ5zydv+ojg==
X-Google-Smtp-Source: APXvYqxehAn2yjx3CmM6izrAKavS1EKO7WxqFhfu3IuyVnJd0xx0ORE77q6EcDnmtCORwyc/g6fZxXWpETChwUVmCsY=
X-Received: by 2002:a2e:3514:: with SMTP id z20mr6296204ljz.261.1581480753403;
 Tue, 11 Feb 2020 20:12:33 -0800 (PST)
MIME-Version: 1.0
From:   Glauber Costa <glauber@scylladb.com>
Date:   Tue, 11 Feb 2020 23:12:22 -0500
Message-ID: <CAD-J=zbYp0D5NSV1hqxpU7C-Ki+ffwretuXEYCxX5cbazA5WqQ@mail.gmail.com>
Subject: how is register_(buffer|file) supposed to work?
To:     io-uring@vger.kernel.org, Avi Kivity <avi@scylladb.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi,

I am trying to experiment with the interface for registering files and buffers.

(almost) Every time I call io_uring_register with those opcodes, my
application hangs.

It's easy to see the reason. I am blocking here:

                mutex_unlock(&ctx->uring_lock);
                ret = wait_for_completion_interruptible(&ctx->completions[0]);
                mutex_lock(&ctx->uring_lock);

Am I right in my understanding that this is waiting for everything
that was submitted to complete? Some things in my ring may never
complete: for instance one may be polling for file descriptors that
may never really become ready.

This sounds a bit too restrictive to me. Is this really the intended
use of the interface?
