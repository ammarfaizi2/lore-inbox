Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BEDC433C1
	for <io-uring@archiver.kernel.org>; Thu, 25 Mar 2021 20:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1286261A31
	for <io-uring@archiver.kernel.org>; Thu, 25 Mar 2021 20:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCYU4r (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:56:47 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55486 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCYU4Y (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 25 Mar 2021 16:56:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPX1j-00GGQT-Ij; Thu, 25 Mar 2021 14:56:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPX1h-0003qr-PN; Thu, 25 Mar 2021 14:56:23 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Metzmacher <metze@samba.org>
References: <20210325164343.807498-1-axboe@kernel.dk>
        <m1ft0j3u5k.fsf@fess.ebiederm.org>
        <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
        <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
        <CAHk-=wgUcVeaKhtBgJO3TfE69miJq-krtL8r_Wf_=LBTJw6WSg@mail.gmail.com>
        <20210325204430.GE28349@redhat.com>
Date:   Thu, 25 Mar 2021 15:55:21 -0500
In-Reply-To: <20210325204430.GE28349@redhat.com> (Oleg Nesterov's message of
        "Thu, 25 Mar 2021 21:44:30 +0100")
Message-ID: <m1im5fymva.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPX1h-0003qr-PN;;;mid=<m1im5fymva.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/JsbrhQ4IeD1xkDz3HU8Jinx2474vuSMo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 03/25, Linus Torvalds wrote:
>>
>> The whole "signals are very special for IO threads" thing has caused
>> so many problems, that maybe the solution is simply to _not_ make them
>> special?
>
> Or may be IO threads should not abuse CLONE_THREAD?
>
> Why does create_io_thread() abuse CLONE_THREAD ?
>
> One reason (I think) is that this implies SIGKILL when the process exits/execs,
> anything else?

A lot.

The io workers perform work on behave of the ordinary userspace threads.
Some of that work is opening files.  For things like rlimits to work
properly you need to share the signal_struct.  But odds are if you find
anything in signal_struct (not counting signals) there will be an
io_uring code path that can exercise it as io_uring can traverse the
filesystem, open files and read/write files.  So io_uring can exercise
all of proc.

Using create_io_thread with CLONE_THREAD is the least problematic way
(including all of the signal and ptrace problems we are looking at right
now) to implement the io worker threads.

They _really_ are threads of the process that just never execute any
code in userspace.

Eric

