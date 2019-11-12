Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C07C43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECAC206BB
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 15:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Jfj5e7ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKLPCM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:02:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39607 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfKLPCM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 10:02:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so13528801pfo.6
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 07:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=b48GZ/0HuV2J4lHOwTkPOO1/vOYAZ8rREhrCmolY9Nw=;
        b=Jfj5e7ugJfix6K1OHVYX4xhYHO/PHuJ2qjQ29Vdpghv3akaH17WvZTuPizkqaomxkU
         K5E1PjQcZpar5GN+Jg95siean4p3CFcEvj1KfhxThBamfcpIgqVR8evGphQfffDRbgBz
         Vku8EAe+LO7DseN5jFSQSCJDeu8g9jMydTieZNORh2IJ5c3CIA8YcHfsdYeVuZfLy3Ak
         Y4rmsn3f3IDBSaB4n9njGeGh0g80aL4A5sCswiOW1jTs2CADq6Q2Knwgx3IPj4SFSS+q
         LgnTlyLHgSqddV5HYt8d9YQ7w7VGkL3rrVmGy6zmd5Y6dhji82g4yctFFsX4NoO8oWCf
         0t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b48GZ/0HuV2J4lHOwTkPOO1/vOYAZ8rREhrCmolY9Nw=;
        b=WSkSN2cSlABtLX7iuP9jVxFIeeaL29JVPyeDczV6CCYoREHFSRKs1yegNZZcRatsa5
         v2dZN3fhEP/y34eFh+x5LwK/T9HS993gyW97OknsjMI6Zswc+6L+qgJ8ftPi81lu3h32
         Ih3m7tCE3gb9/2+oEnfUwhugBS7tsL7WJa1xPnMyKRC9FAoqtEAWWAREJVbQUj8BfeK/
         VBl5gj0VezVgDLWyE5cWOtttpWP+3sdlcZZOfzMPJON8HeFU3K6qqAcE/o3lUJbVr6/b
         E/QP+4XkD6p0Uf/2stxiZdrGYpplfLqchniVByAnyaaqCvpfne5TW5ykFrdvMq+FGoNP
         YIIw==
X-Gm-Message-State: APjAAAXYfNFHdZXIj2LJiq94z3cqal12klupu6jHG82CBrBl9LstxfLs
        aSZk3IBBlYT4CI6C+pZH1XZwWavXgD0=
X-Google-Smtp-Source: APXvYqxl4/nZL40UyhcyftA3ivbv7Lzzd0PTUo1Dx8Vi9b48OzmZqYOzojRZJDkkh/hbgcdjLMMIow==
X-Received: by 2002:aa7:918e:: with SMTP id x14mr27508893pfa.12.1573570929684;
        Tue, 12 Nov 2019 07:02:09 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id j5sm3780367pfe.100.2019.11.12.07.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 07:02:08 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix leaking double_put()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <44a6c4ded7492f9a4d06d09fd9ff94e609b1ecad.1573546632.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <787eebde-a668-ff97-fd6b-86aa6fd04c79@kernel.dk>
Date:   Tue, 12 Nov 2019 07:02:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <44a6c4ded7492f9a4d06d09fd9ff94e609b1ecad.1573546632.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/12/19 12:17 AM, Pavel Begunkov wrote:
> io_double_put_req() may be called for a request with a link (see
> io_req_defer(req)), and so can leak it in case of an error, as
> __io_free_req() doesn't handle links.
> 
> Fixes: 78e19bbef38362ceb ("io_uring: pass in io_kiocb to fill/add CQ
> handlers")

This blows up the 'link' test from the liburing regression suite:

[   20.007180] refcount_t: underflow; use-after-free.
[   20.008562] WARNING: CPU: 0 PID: 278 at lib/refcount.c:190 refcount_sub_and_test_checked+0xf3/0x100
[   20.010784] Modules linked in:
[   20.011565] CPU: 0 PID: 278 Comm: link Not tainted 5.4.0-rc5+ #3490
[   20.013112] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
[   20.015540] RIP: 0010:refcount_sub_and_test_checked+0xf3/0x100
[   20.017312] Code: 5d 41 5c 41 5d 41 5e c3 eb db 44 0f b6 35 cb a3 3a 01 45 84 f6 75 cb 48 c7 c7 e0 55 1a 82 c6 05 b8 a3 3a 01 01 e8 30 92 99 ff <0f> 0b eb b7 66 0f 1f 84 00 00 00 00 00 48 89 fe bf 01 00 00 00 e9
[   20.021244] RSP: 0018:ffff8881005f7af8 EFLAGS: 00010086
[   20.022159] RAX: 0000000000000000 RBX: 00000000fffffffe RCX: 0000000000000000
[   20.023419] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffed10200bef55
[   20.024775] RBP: ffff8881003f2e54 R08: 0000000000000001 R09: ffffed10218c3ee1
[   20.025743] R10: ffffed10218c3ee0 R11: ffff88810c61f707 R12: 0000000000000002
[   20.026645] R13: 1ffff110200bef60 R14: 0000000000000000 R15: ffff8881003f2e40
[   20.027546] FS:  00007f5f0be74540(0000) GS:ffff88810c600000(0000) knlGS:0000000000000000
[   20.028700] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.029726] CR2: 00007f5f0bceabd0 CR3: 00000001072ab001 CR4: 00000000001606f0
[   20.030880] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.032127] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   20.033457] Call Trace:
[   20.033999]  ? refcount_dec_if_one+0x90/0x90
[   20.034861]  ? debug_lockdep_rcu_enabled.part.0+0x16/0x30
[   20.035583]  ? io_cqring_fill_event+0x11d/0x330
[   20.036035]  io_free_req_find_next+0x20c/0x350
[   20.036631]  __io_queue_sqe+0x2db/0x9c0
[   20.037219]  ? io_wq_submit_work+0x220/0x220
[   20.037795]  ? io_req_defer+0x6c/0x3d0
[   20.038404]  ? rcu_read_lock_sched_held+0x81/0xb0
[   20.039045]  io_submit_sqes+0x69e/0xee0
[   20.039521]  ? io_queue_link_head+0x2c0/0x2c0
[   20.040109]  ? mutex_lock_io_nested+0xbd0/0xbd0
[   20.040730]  ? find_held_lock+0x85/0xa0
[   20.041238]  ? __x64_sys_io_uring_enter+0x1be/0x660
[   20.041611]  ? lock_downgrade+0x310/0x310
[   20.041911]  ? lock_acquire+0xc9/0x200
[   20.042194]  ? __x64_sys_io_uring_enter+0x140/0x660
[   20.042583]  __x64_sys_io_uring_enter+0x47f/0x660
[   20.042949]  ? io_sq_thread+0x4f0/0x4f0
[   20.043250]  ? trace_hardirqs_on_thunk+0x1a/0x20
[   20.043605]  ? mark_held_locks+0x24/0x90
[   20.043927]  ? do_syscall_64+0x14/0x260
[   20.044231]  do_syscall_64+0x62/0x260
[   20.044638]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   20.045182] RIP: 0033:0x7f5f0bda5e9d
[   20.045425] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 5f 0c 00 f7 d8 64 89 01 48

-- 
Jens Axboe

