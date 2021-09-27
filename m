Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D776C433F5
	for <io-uring@archiver.kernel.org>; Mon, 27 Sep 2021 13:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F8760F44
	for <io-uring@archiver.kernel.org>; Mon, 27 Sep 2021 13:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbhI0Nxl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:53:41 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57116 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhI0Nxl (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 27 Sep 2021 09:53:41 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:45182)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mUr33-00HJEH-LZ; Mon, 27 Sep 2021 07:52:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:53126 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mUr32-003njm-Gz; Mon, 27 Sep 2021 07:52:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        io-uring <io-uring@vger.kernel.org>
References: <fb81a0f6-0a9d-6651-88bc-d22e589de0ee@kernel.dk>
        <CAHk-=whi3UxvY1C1LQNCO9d2xzX5A69qfzNGbBVGpRE_6gv=9Q@mail.gmail.com>
        <0eeefd32-f322-1470-9bcf-0f415be517bd@kernel.dk>
Date:   Mon, 27 Sep 2021 08:51:37 -0500
In-Reply-To: <0eeefd32-f322-1470-9bcf-0f415be517bd@kernel.dk> (Jens Axboe's
        message of "Sat, 25 Sep 2021 19:20:52 -0600")
Message-ID: <87lf3iazyu.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mUr32-003njm-Gz;;;mid=<87lf3iazyu.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18DcecB42oMyQcRqO5QuJrJGzTZHwZBVak=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] io_uring fixes for 5.15-rc3
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 9/25/21 5:05 PM, Linus Torvalds wrote:
>> On Sat, Sep 25, 2021 at 1:32 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> - io-wq core dump exit fix (me)
>> 
>> Hmm.
>> 
>> That one strikes me as odd.
>> 
>> I get the feeling that if the io_uring thread needs to have that
>> signal_group_exit() test, something is wrong in signal-land.
>> 
>> It's basically a "fatal signal has been sent to another thread", and I
>> really get the feeling that "fatal_signal_pending()" should just be
>> modified to handle that case too.
>
> It did surprise me as well, which is why that previous change ended up
> being broken for the coredump case... You could argue that the io-wq
> thread should just exit on signal_pending(), which is what we did
> before, but that really ends up sucking for workloads that do use
> signals for communication purposes. postgres was the reporter here.

The primary function get_signal is to make signals not pending.  So I
don't understand any use of testing signal_pending after a call to
get_signal.

My confusion doubles when I consider the fact io_uring threads should
only be dequeuing SIGSTOP and SIGKILL.

I am concerned that an io_uring thread that dequeues SIGKILL won't call
signal_group_exit and thus kill the other threads in the thread group.

What motivated removing the break and adding the fatal_signal_pending
test?

Eric

