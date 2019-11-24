Return-Path: <SRS0=S5qu=ZQ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEC0C432C0
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1284320706
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 15:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=untilfluent.com header.i=mark@untilfluent.com header.b="A96BJ6UN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKXPeM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 10:34:12 -0500
Received: from sender4-op-o19.zoho.com ([136.143.188.19]:17917 "EHLO
        sender4-op-o19.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfKXPeM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Nov 2019 10:34:12 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574609650; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bvsAWab4gRBKiwWp+a3zsZL7kNvf29iWoNB1OYn695xtmyyVHTRXH37Wm576bpIAM9ENH7nyk8EeFJZzoxvici8U+mvVoVgdFfU5l0uFHgv1JmIZGiEp8cgnKQY44iMyF1PcWq+RkLa+jDpnnOVMDrzmhOgqU81r9vt3vE2Yubw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574609650; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=EUmjzs+byYyOyHNsLUPp42FJT0+iSrr2xZ/88M+F1RU=; 
        b=WgRsPT9V6BRQbWWwzYBAofQSu7a7lmHXh9/VmCiqMrpJAN/rKF+QzTI7K1tMDwjOwxUqjm2r66jzRledGzz52opIpogzoLNAEl4fNZbjeuEWTBb6T4pzG1JlW5qYoXHJZP65oD33n3QyDgiO8Su6eW2r8xdSnC2LcXcRA31MN1o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=untilfluent.com;
        spf=pass  smtp.mailfrom=mark@untilfluent.com;
        dmarc=pass header.from=<mark@untilfluent.com> header.from=<mark@untilfluent.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574609650;
        s=uf; d=untilfluent.com; i=mark@untilfluent.com;
        h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=992; bh=EUmjzs+byYyOyHNsLUPp42FJT0+iSrr2xZ/88M+F1RU=;
        b=A96BJ6UN1Q7cIN8s/2gEFUmmJNXOHzyA204I57CTdEUUxr6JRPlHqGQzoj/Zcuxc
        Qnz6Qwnpn1dRil7CRXm5DOlT1umQY7IzFyPIvG8mbUf48/Ph8bUlqgZG8t8opS0ytyy
        XYW7ovwFU+ihab8UtXJLrggjE9Fg5truSRaQXWLw=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1574609649889733.4664246134537; Sun, 24 Nov 2019 07:34:09 -0800 (PST)
Date:   Sun, 24 Nov 2019 07:34:09 -0800
From:   Mark Reed <mark@untilfluent.com>
To:     "io-uring" <io-uring@vger.kernel.org>
Message-ID: <16e9e0c80e0.10e8cb6351147499.7149684061226631446@untilfluent.com>
In-Reply-To: 
Subject: io_uring_prep_writev
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org


Jens et al,

I wrote a C event loop library based on io_uring and a KV store similar to memcached using it.  Mrcache is 4x faster using io_uring vs epoll so thank you guys for the work on this. I'm looking forward to 5.5 and am testing on 5.2.14 right now.

https://github.com/MarkReedZ/mrloop
https://github.com/MarkReedZ/mrcache

I'm currently using write instead of io_uring_prep_writev when writing to the socket and have a couple questions:

1.  If I queue up 50 writevs to a socket will they write in order?

2.  If the client backs up will those writevs return or will they simply wait?  

3.  Would you expect io_uring_prep_writev to be faster than using write on the socket?  My initial benchmarks had a 50 deep GET pipeline which would do a single writev with 50 iovs and that was slower than copying to an output buffer and looping on write when full.  Perhaps I had something wrong with the benchmark at the time - if you think so I'll try again.

Thanks again,

Mark

