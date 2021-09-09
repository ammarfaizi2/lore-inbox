Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC82CC4332F
	for <io-uring@archiver.kernel.org>; Thu,  9 Sep 2021 12:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA02961100
	for <io-uring@archiver.kernel.org>; Thu,  9 Sep 2021 12:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353451AbhIIMlO (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 9 Sep 2021 08:41:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38024 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354495AbhIIMfS (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 9 Sep 2021 08:35:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 40B0A21B13;
        Thu,  9 Sep 2021 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631190848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=otlEKKTKaxtvvMLg6ergurTGZ0izRkiNu8lIiQOoJG8=;
        b=pafa6rOLfy8b6s0LOtgRFEyJrgMHk2KL8oMKsBNZqMIZBfwqiSjy0lZ7HvQn9lCFIa0Def
        3I/YVOWFpRHNDb+lcKi49HsIXhj7fESeGM/4jkVBGp0o6almfudRW5jGBLok/fvcJn3Fx1
        m+3/6IVrYh3limVU1shkb/0FMRtdzdA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D69CC13C53;
        Thu,  9 Sep 2021 12:34:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gv1XMT//OWF8eQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 09 Sep 2021 12:34:07 +0000
Date:   Thu, 9 Sep 2021 14:34:05 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jens Axboe <axboe@kernel.dk>, Hao Xu <haoxu@linux.alibaba.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, cgroups@vger.kernel.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v4 0/2] refactor sqthread cpu binding logic
Message-ID: <20210909123405.GA7872@blackbody.suse.cz>
References: <20210901124322.164238-1-haoxu@linux.alibaba.com>
 <20210902164808.GA10014@blackbody.suse.cz>
 <efd3c387-9c7c-c0d8-1306-f722da2a9ba1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd3c387-9c7c-c0d8-1306-f722da2a9ba1@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Thanks for the answer and the context explanations.

On Thu, Sep 02, 2021 at 12:00:33PM -0600, Jens Axboe <axboe@kernel.dk> wrote:
> We already have this API to set the affinity based on when these were
> regular kernel threads, so it needs to work with that too. As such they
> are marked PF_NO_SETAFFINITY.

I see the current implementation "allows" at most one binding (by the
passed sq_cpu arg) to a CPU and then "locks" it by setting
PF_NO_SETAFFINITY subsequently (after set_cpus_allowed_ptr).
And actually doesn't check whether it succeeded or not (Hao suggests in
another subthread sq_cpu is a mere hint).

Nevertheless, you likely don't want to "trespass" the boundary of a
cpuset and I think that it'll end up with a loop checking against
hotplug races. That is already implemented in __sched_affinity, it'd be
IMO good to have it in one place only.

> > [1] Not only spending their life in kernel but providing some
> > delocalized kernel service.
> 
> That's what they do...

(I assume that answer to "life in kernel" and the IO threads serve only
the originating cpuset (container) i.e. are (co)localized to it (not
delocalized as some kernel workers).)

Cheers,
Michal
