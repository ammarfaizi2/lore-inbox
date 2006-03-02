Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWCBQnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWCBQnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWCBQnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:43:15 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:19435 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751085AbWCBQnP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:43:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CH78M502Puz1Kc6+z7N2kwuKFkq3vHY/PCKwvgxdYie+mCpSpmp/Y+zNuy9dlmjFJbVb+KLEY4F9lOc/iS+Lx5Jsdix9RftDe0TvV1HQJ5xY4Qzwoks2l4YfRY8ikehDdNQE9FAnVHvL88jzuYPEiLnKQUDwWuhc0PWlhjRJDHA=
Message-ID: <728201270603020843s4feacb1cv3a8acc620e636ffa@mail.gmail.com>
Date: Thu, 2 Mar 2006 10:43:12 -0600
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] fix potential jiffies overflow
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060303.000306.08077845.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060303.000306.08077845.anemo@mba.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I found i386 timer_resume is updating jiffies, not jiffies_64.  It
> looks there is a potential overflow problem.  Is this a correct fix?
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>
> diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> index a14d594..e4ed172 100644
> --- a/arch/i386/kernel/time.c
> +++ b/arch/i386/kernel/time.c
> @@ -413,7 +413,7 @@ static int timer_resume(struct sys_devic
>         xtime.tv_sec = sec;
>         xtime.tv_nsec = 0;
>         write_sequnlock_irqrestore(&xtime_lock, flags);
> -       jiffies += sleep_length;
> +       jiffies_64 += sleep_length;
>         wall_jiffies += sleep_length;
>         if (last_timer->resume)
>                 last_timer->resume();


The 64-bit jiffies value is not atomic. You need to hold xtime_lock to read it.
