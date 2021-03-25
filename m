Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380FCC433DB
	for <io-uring@archiver.kernel.org>; Thu, 25 Mar 2021 19:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF09861A32
	for <io-uring@archiver.kernel.org>; Thu, 25 Mar 2021 19:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhCYTeu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 25 Mar 2021 15:34:50 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52784 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCYTep (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 25 Mar 2021 15:34:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPVki-008Fxh-5l; Thu, 25 Mar 2021 13:34:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPVkh-0000za-GY; Thu, 25 Mar 2021 13:34:43 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com, metze@samba.org
References: <20210325164343.807498-1-axboe@kernel.dk>
Date:   Thu, 25 Mar 2021 14:33:43 -0500
In-Reply-To: <20210325164343.807498-1-axboe@kernel.dk> (Jens Axboe's message
        of "Thu, 25 Mar 2021 10:43:41 -0600")
Message-ID: <m1ft0j3u5k.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPVkh-0000za-GY;;;mid=<m1ft0j3u5k.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18mfvkY8hIovTxtqn4/JaJ6qC3aJXoeS3A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> Hi,
>
> Stefan reports that attaching to a task with io_uring will leave gdb
> very confused and just repeatedly attempting to attach to the IO threads,
> even though it receives an -EPERM every time. This patchset proposes to
> skip PF_IO_WORKER threads as same_thread_group(), except for accounting
> purposes which we still desire.
>
> We also skip listing the IO threads in /proc/<pid>/task/ so that gdb
> doesn't think it should stop and attach to them. This makes us consistent
> with earlier kernels, where these async threads were not related to the
> ring owning task, and hence gdb (and others) ignored them anyway.
>
> Seems to me that this is the right approach, but open to comments on if
> others agree with this. Oleg, I did see your messages as well on SIGSTOP,
> and as was discussed with Eric as well, this is something we most
> certainly can revisit. I do think that the visibility of these threads
> is a separate issue. Even with SIGSTOP implemented (which I did try as
> well), we're never going to allow ptrace attach and hence gdb would still
> be broken. Hence I'd rather treat them as separate issues to attack.

A quick skim shows that these threads are not showing up anywhere in
proc which appears to be a problem, as it hides them from top.

Sysadmins need the ability to dig into a system and find out where all
their cpu usage or io's have gone when there is a problem.  I general I
think this argues that these threads should show up as threads of the
process so I am not even certain this is the right fix to deal with gdb.

Eric
