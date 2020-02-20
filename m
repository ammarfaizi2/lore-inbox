Return-Path: <SRS0=zVSX=4I=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FE8C11D25
	for <io-uring@archiver.kernel.org>; Thu, 20 Feb 2020 21:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61397222C4
	for <io-uring@archiver.kernel.org>; Thu, 20 Feb 2020 21:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lAew+hMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgBTVHg (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:07:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40546 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgBTVHg (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 20 Feb 2020 16:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mel2oFj+LmKqCcaGKFW4vyg69dSgRhCWtttuVTD+sdk=; b=lAew+hMo3HOe3yddCN44L3zFcq
        2EDkwbcJO0AbWD/SU8gorYQVERLNJ1enTky72KTu7FM9sXZSRLuKoRSMO+gzk/2kM41Nd1lXGsx3c
        xPxJ+L6+rZjcSH8RRYPm+ZU4TmMP218dA6CyOuCv24SqJKzyrCsJp/Fo9FJeZAPzdqd3VKCdLO1Gg
        kYdTDG9srE1olTrDUGfY1Wxse0tpLAjzSj0lSy6410hOfAWJ5CwXpEneux+nPjtSRGGYGvhSrZtpY
        ogF9XlqJZoK9febjbJ9A5gumhWuJSPPtKWjPha9RwQqA86yg5Gk7nXPoKyZvPGQqiyB9CyLzPgguu
        Rb36CLqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4t2i-0005L1-Um; Thu, 20 Feb 2020 21:07:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 352AF980E56; Thu, 20 Feb 2020 22:07:31 +0100 (CET)
Date:   Thu, 20 Feb 2020 22:07:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, glauber@scylladb.com,
        asml.silence@gmail.com
Subject: Re: [PATCH 5/9] kernel: abstract out task work helpers
Message-ID: <20200220210731.GM11457@worktop.programming.kicks-ass.net>
References: <20200220203151.18709-1-axboe@kernel.dk>
 <20200220203151.18709-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220203151.18709-6-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Thu, Feb 20, 2020 at 01:31:47PM -0700, Jens Axboe wrote:

> @@ -27,39 +43,25 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
>  int
>  task_work_add(struct task_struct *task, struct callback_head *work, bool notify)
>  {
> -	struct callback_head *head;
> +	int ret;
>  
> -	do {
> -		head = READ_ONCE(task->task_works);
> -		if (unlikely(head == &work_exited))
> -			return -ESRCH;
> -		work->next = head;
> -	} while (cmpxchg(&task->task_works, head, work) != head);
> +	ret = __task_work_add(task, &task->task_works, work);
>  
>  	if (notify)

	if (!ret && notify)

>  		set_notify_resume(task);
> -	return 0;
> +
> +	return ret;
>  }
