Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE95C48BCF
	for <io-uring@archiver.kernel.org>; Wed,  9 Jun 2021 20:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F89E613EF
	for <io-uring@archiver.kernel.org>; Wed,  9 Jun 2021 20:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFIUui (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:50:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41652 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFIUuh (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 9 Jun 2021 16:50:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lr57x-0047Td-GP; Wed, 09 Jun 2021 14:48:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lr57w-00GdK0-Er; Wed, 09 Jun 2021 14:48:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Olivier Langlois <olivier@trillion01.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov\>" <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
        <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
        <87h7i694ij.fsf_-_@disp2133>
        <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
Date:   Wed, 09 Jun 2021 15:48:33 -0500
In-Reply-To: <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 9 Jun 2021 13:33:36 -0700")
Message-ID: <8735tq9332.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lr57w-00GdK0-Er;;;mid=<8735tq9332.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/dApkXvfoeT8AzOo9n3ZROV6GlGoBin10=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC] coredump: Do not interrupt dump for TIF_NOTIFY_SIGNAL
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jun 9, 2021 at 1:17 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>
>> In short the coredump code deliberately supports being interrupted by
>> SIGKILL, and depends upon prepare_signal to filter out all other
>> signals.
>
> Hmm.
>
> I have to say, that looks like the core reason for the bug: if you
> want to be interrupted by a fatal signal, you shouldn't use
> signal_pending(), you should use fatal_signal_pending().
>
> Now, the fact that we haven't cleared TIF_NOTIFY_SIGNAL for the first
> signal is clearly the immediate cause of this, but at the same time I
> really get the feeling that that coredump aborting code should always
> had used fatal_signal_pending().
>
> We do want to be able to abort core-dumps (stuck network filesystems
> is the traditional reason), but the fact that it used signal_pending()
> looks buggy.
>
> In fact, the very comment in that dump_interrupted() function seems to
> acknowledge that signal_pending() is all kinds of silly.
>
> So regardless of the fact that io_uring does seem to have messed up
> this part of signals, I think the fix is not to change
> signal_pending() to task_sigpending(), but to just do what the comment
> suggests we should do.

It looks like it would need to be:

static bool dump_interrupted(void)
{
	return fatal_signal_pending() || freezing();
}

As the original implementation of dump_interrupted 528f827ee0bb
("coredump: introduce dump_interrupted()") is deliberately allowing the
freezer to terminate the core dumps to allow for reliable system
suspend.

>
> But also:
>
>> With the io_uring code comes an extra test in signal_pending
>> for TIF_NOTIFY_SIGNAL (which is something about asking a task to run
>> task_work_run).
>
> Jens, is this still relevant? Maybe we can revert that whole series
> now, and make the confusing difference between signal_pending() and
> task_sigpending() go away again?
>
>                Linus
