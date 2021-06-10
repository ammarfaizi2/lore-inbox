Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F101C48BD1
	for <io-uring@archiver.kernel.org>; Thu, 10 Jun 2021 20:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133786136D
	for <io-uring@archiver.kernel.org>; Thu, 10 Jun 2021 20:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJUNR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 10 Jun 2021 16:13:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:35978 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJUNR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 10 Jun 2021 16:13:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lrR1M-007Xt1-Ak; Thu, 10 Jun 2021 14:11:20 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lrR1J-003Jez-V6; Thu, 10 Jun 2021 14:11:19 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Olivier Langlois <olivier@trillion01.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov\>" <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
        <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
        <87h7i694ij.fsf_-_@disp2133>
        <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
        <198e912402486f66214146d4eabad8cb3f010a8e.camel@trillion01.com>
        <87eeda7nqe.fsf@disp2133>
        <b8434a8987672ab16f9fb755c1fc4d51e0f4004a.camel@trillion01.com>
        <87pmwt6biw.fsf@disp2133> <87czst5yxh.fsf_-_@disp2133>
        <CAHk-=wiax83WoS0p5nWvPhU_O+hcjXwv6q3DXV8Ejb62BfynhQ@mail.gmail.com>
        <87y2bh4jg5.fsf@disp2133>
        <CAHk-=wjPiEaXjUp6PTcLZFjT8RrYX+ExtD-RY3NjFWDN7mKLbw@mail.gmail.com>
Date:   Thu, 10 Jun 2021 15:11:11 -0500
In-Reply-To: <CAHk-=wjPiEaXjUp6PTcLZFjT8RrYX+ExtD-RY3NjFWDN7mKLbw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 10 Jun 2021 12:50:48 -0700")
Message-ID: <87sg1p4h0g.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lrR1J-003Jez-V6;;;mid=<87sg1p4h0g.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18hK16UcC6YSRYFbVnqrU+yXlLACZ2upQQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH] coredump: Limit what can interrupt coredumps
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org


Olivier Langlois has been struggling with coredumps being incompletely written in
processes using io_uring.

Olivier Langlois <olivier@trillion01.com> writes:
> io_uring is a big user of task_work and any event that io_uring made a
> task waiting for that occurs during the core dump generation will
> generate a TIF_NOTIFY_SIGNAL.
>
> Here are the detailed steps of the problem:
> 1. io_uring calls vfs_poll() to install a task to a file wait queue
>    with io_async_wake() as the wakeup function cb from io_arm_poll_handler()
> 2. wakeup function ends up calling task_work_add() with TWA_SIGNAL
> 3. task_work_add() sets the TIF_NOTIFY_SIGNAL bit by calling
>    set_notify_signal()

The coredump code deliberately supports being interrupted by SIGKILL,
and depends upon prepare_signal to filter out all other signals.   Now
that signal_pending includes wake ups for TIF_NOTIFY_SIGNAL this hack
in dump_emitted by the coredump code no longer works.

Make the coredump code more robust by explicitly testing for all of
the wakeup conditions the coredump code supports.  This prevents
new wakeup conditions from breaking the coredump code, as well
as fixing the current issue.

The filesystem code that the coredump code uses already limits
itself to only aborting on fatal_signal_pending.  So it should
not develop surprising wake-up reasons either.

v2: Don't remove the now unnecessary code in prepare_signal.

Cc: stable@vger.kernel.org
Fixes: 12db8b690010 ("entry: Add support for TIF_NOTIFY_SIGNAL")
Reported-by: Olivier Langlois <olivier@trillion01.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 2868e3e171ae..c3d8fc14b993 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -519,7 +519,7 @@ static bool dump_interrupted(void)
 	 * but then we need to teach dump_write() to restart and clear
 	 * TIF_SIGPENDING.
 	 */
-	return signal_pending(current);
+	return fatal_signal_pending(current) || freezing(current);
 }
 
 static void wait_for_dump_helpers(struct file *file)
-- 
2.20.1

