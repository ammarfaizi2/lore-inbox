Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E9DC48BE5
	for <io-uring@archiver.kernel.org>; Tue, 15 Jun 2021 22:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA636128B
	for <io-uring@archiver.kernel.org>; Tue, 15 Jun 2021 22:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhFOWLV (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 15 Jun 2021 18:11:21 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50622 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhFOWLT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 15 Jun 2021 18:11:19 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltHFB-00GqjY-1s; Tue, 15 Jun 2021 16:09:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltHFA-00FYjE-0t; Tue, 15 Jun 2021 16:09:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Olivier Langlois <olivier@trillion01.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov\>" <asml.silence@gmail.com>
References: <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
        <198e912402486f66214146d4eabad8cb3f010a8e.camel@trillion01.com>
        <87eeda7nqe.fsf@disp2133>
        <b8434a8987672ab16f9fb755c1fc4d51e0f4004a.camel@trillion01.com>
        <87pmwt6biw.fsf@disp2133> <87czst5yxh.fsf_-_@disp2133>
        <CAHk-=wiax83WoS0p5nWvPhU_O+hcjXwv6q3DXV8Ejb62BfynhQ@mail.gmail.com>
        <87y2bh4jg5.fsf@disp2133>
        <CAHk-=wjPiEaXjUp6PTcLZFjT8RrYX+ExtD-RY3NjFWDN7mKLbw@mail.gmail.com>
        <87sg1p4h0g.fsf_-_@disp2133> <20210614141032.GA13677@redhat.com>
Date:   Tue, 15 Jun 2021 17:08:23 -0500
In-Reply-To: <20210614141032.GA13677@redhat.com> (Oleg Nesterov's message of
        "Mon, 14 Jun 2021 16:10:33 +0200")
Message-ID: <87pmwmn5m0.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltHFA-00FYjE-0t;;;mid=<87pmwmn5m0.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18kVU+BRNg3PW0YZn2DSgz4GvEBbVLZxeI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] coredump: Limit what can interrupt coredumps
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -519,7 +519,7 @@ static bool dump_interrupted(void)
>>  	 * but then we need to teach dump_write() to restart and clear
>>  	 * TIF_SIGPENDING.
>>  	 */
>> -	return signal_pending(current);
>> +	return fatal_signal_pending(current) || freezing(current);
>>  }
>
>
> Well yes, this is what the comment says.
>
> But note that there is another reason why dump_interrupted() returns true
> if signal_pending(), it assumes thagt __dump_emit()->__kernel_write() may
> fail anyway if signal_pending() is true. Say, pipe_write(), or iirc nfs,
> perhaps something else...
>
> That is why zap_threads() clears TIF_SIGPENDING. Perhaps it should clear
> TIF_NOTIFY_SIGNAL as well and we should change io-uring to not abuse the
> dumping threads?
>
> Or perhaps we should change __dump_emit() to clear signal_pending() and
> restart __kernel_write() if it fails or returns a short write.
>
> Otherwise the change above doesn't look like a full fix to me.

Agreed.  The coredump to a pipe will still be short.  That needs
something additional.

The problem Olivier Langlois <olivier@trillion01.com> reported was
core dumps coming up short because TIF_NOTIFY_SIGNAL was being
set during a core dump.

We can see this with pipe_write returning -ERESTARTSYS
on a full pipe if signal_pending which includes TIF_NOTIFY_SIGNAL
is true.

Looking further if the thread that is core dumping initiated
any io_uring work then io_ring_exit_work will use task_work_add
to request that thread clean up it's io_uring state.

Perhaps we can put a big comment in dump_emit and if we
get back -ERESTARTSYS run tracework_notify_signal.  I am not
seeing any locks held at that point in the coredump, so it
should be safe.  The coredump is run inside of file_start_write
which is the only potential complication.



The code flow is complicated but it looks like the entire
point of the exercise is to call io_uring_del_task_file
on the originating thread.  I suppose that keeps the
locking of the xarray in io_uring_task simple.


Hmm.   All of this comes from io_uring_release.
How do we get to io_uring_release?  The coredump should
be catching everything in exit_mm before exit_files?

Confused and hopeful someone can explain to me what is going on,
and perhaps simplify it.

Eric
