Return-Path: <SRS0=2AeR=52=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A657C2BB55
	for <io-uring@archiver.kernel.org>; Fri, 10 Apr 2020 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7B420753
	for <io-uring@archiver.kernel.org>; Fri, 10 Apr 2020 08:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvSvRAdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgDJIrR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 10 Apr 2020 04:47:17 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:46337 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDJIrR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 10 Apr 2020 04:47:17 -0400
Received: by mail-lf1-f54.google.com with SMTP id m19so842854lfq.13
        for <io-uring@vger.kernel.org>; Fri, 10 Apr 2020 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SyVc0AUXFgwZFeXx8oqA8wQEu3GELDRcErh8X4dpjUM=;
        b=dvSvRAdTz8MWF9BViG0MeBAvFMb8iR5ob0OuEZzXnyt9/bCahr0tzDdfle5dZgbH6b
         Nsck8ZQiTGMpSKKX+wf38/50Gc1mlH+FjDa6u7tiMI0bMIS1TzZTazaHHz5/cw5OIgDo
         AWZ88WV7vUS9Pag0RIV/kXpgL3bPXn23Wle/cab+NUVk6mqWzQEqSgTPFM+UL7yykqki
         PLwaDKwGr0vuf0alLFURCS7EhW1h/gL3CqoZbKA9gCwM2FDhq0c5UH4bDhMjo1xs8LDD
         nf3mq1w3lKBCYVke4KXw+V+/HGHzIRtN0hmSyToQ0Rxz/6eYgKApwU+MsMArU8LM78lx
         tELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SyVc0AUXFgwZFeXx8oqA8wQEu3GELDRcErh8X4dpjUM=;
        b=aKSOGr4zE2+P/Z4Og5XrUjOvLoofFq8mzJRkximCCn6L/SrIXjQ7OHndaWKM1r2pY0
         fNqjWKFxY5QJJtjqiF4tMnvYh0pAVN3A13iKJiESB3zsHjKQJjsSXZNycF+FaLIRjig5
         eBYC8YurrcGfkgv3Dh4in+qMkcJIhPAoHIFVK8FQYrFAbND52HDcbfywcs1gds9TKd7A
         Pg1IdNzKm8tJF3Xi7J5QtqlU0cNqwe/wostjSeKE/CHa2mXd9Np5Tyza1Wp7cs1PMPqf
         Nyxc4kL0UUlor3hLiUcjEWYbA3Q3F9crE+l6qTQ5Cbue1aGQ7TxKrnCiw4CzLimanuk2
         2TUg==
X-Gm-Message-State: AGi0Pua0pQka67XGDjTUECiQ0YhJGNIbMt+u88pJOTd6f1CZUHCrIX+L
        7y1y5KEjmdYKB+Oiv6hbcrRJsRg2
X-Google-Smtp-Source: APiQypJtIK03kZ0hLYr7pSmhTw9Rkl2y9jGG/8S9dGiLIWmhXialEDD+QEMFMHsML7XudVpIf/tDaA==
X-Received: by 2002:a05:6512:1c5:: with SMTP id f5mr2039824lfp.138.1586508433466;
        Fri, 10 Apr 2020 01:47:13 -0700 (PDT)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id a28sm886231lfr.4.2020.04.10.01.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 01:47:13 -0700 (PDT)
Subject: Re: [RFC 1/1] io_uring: preserve work->mm since actual work
 processing may need it
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>, axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
References: <1586469817-59280-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1586469817-59280-2-git-send-email-bijan.mottahedeh@oracle.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <f38056cf-b240-7494-d23b-c663867451cf@gmail.com>
Date:   Fri, 10 Apr 2020 11:47:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1586469817-59280-2-git-send-email-bijan.mottahedeh@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 4/10/2020 1:03 AM, Bijan Mottahedeh wrote:
> Do not clear work->mm since io_madvise() passes it to do_madvise()
> when the request is actually processed.

As I see, this down_read() from the trace is
down_read(&current->mm->mmap_sem), where current->mm is set by use_mm()
just several lines above your change. So, what do you mean by passing? I
don't see do_madvise() __explicitly__ accepting mm as an argument.

What tree do you use? Extra patches on top?

> 
> Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
> ---
>  fs/io-wq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index 4023c98..4d20754 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -431,8 +431,6 @@ static void io_wq_switch_mm(struct io_worker *worker, struct io_wq_work *work)
>  		if (!worker->mm)
>  			set_fs(USER_DS);
>  		worker->mm = work->mm;
> -		/* hang on to this mm */
> -		work->mm = NULL;
>  		return;
>  	}
>  
> 

-- 
Pavel Begunkov
