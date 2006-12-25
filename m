Return-Path: <linux-kernel-owner+w=401wt.eu-S1752948AbWLYTCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbWLYTCP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 14:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbWLYTCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 14:02:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:4763 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbWLYTCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 14:02:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RhnRKkErqhfH9qFQCOO2ha/sZ9wCNfwwKxTmQ+X9IlBG7HEdCJnqCZvtWjh/fQYI0ithN/0+AuxjCvhKjXqW5UiGIZ2aj4XVSXQRLx9NluUsCCmuNKl7xiNDUOAUwQUnm3KqCPu5hl7aB+6zyxeRVRXHrB2WOxcgTbDaWghCkL0=
Message-ID: <b637ec0b0612251102w2bb4a4c1ifc78df1193879c6f@mail.gmail.com>
Date: Mon, 25 Dec 2006 14:02:12 -0500
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Subject: Re: BUG: scheduling while atomic - Linux 2.6.20-rc2-ga3d89517
Cc: "kernel list" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Pavel Machek" <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <87psa9z0wu.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b637ec0b0612240553n28b252c4p4c1559da794e646c@mail.gmail.com>
	 <87psa9z0wu.fsf@duaron.myhome.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I applied your patch to yesterday's Linus' GIT. I will run it for
some days and will let you know if the problem represents. Please note
that it happened only twice and I don't have any clue on how to
reproduce it.

I added Pavel and Rafael to CC-list because for the first time in at
least six months my laptop failed to resume after suspend-to-disk
(userland tools) with this kernel. Guys, do you think that this
failure could be related to this BUG?

Best regards and Happy Holidays,
Fabio




On 12/24/06, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> "Fabio Comolli" <fabio.comolli@gmail.com> writes:
>
> > Just found this in syslog. It was during normal activity, about 6
> > minutes after resume-from-ram. I never saw this before.
>
> It seems someone missed to check PREEMPT_ACTIVE in __resched_legal().
> Could you please test the following patch?
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
>
>
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> ---
>
>  kernel/sched.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff -puN kernel/sched.c~__resched_legal kernel/sched.c
> --- linux-2.6/kernel/sched.c~__resched_legal    2006-12-24 22:40:19.000000000 +0900
> +++ linux-2.6-hirofumi/kernel/sched.c   2006-12-24 23:54:01.000000000 +0900
> @@ -4619,10 +4619,11 @@ asmlinkage long sys_sched_yield(void)
>
>  static inline int __resched_legal(int expected_preempt_count)
>  {
> -#ifdef CONFIG_PREEMPT
> +#ifndef CONFIG_PREEMPT
> +       expected_preempt_count = 0;
> +#endif
>         if (unlikely(preempt_count() != expected_preempt_count))
>                 return 0;
> -#endif
>         if (unlikely(system_state != SYSTEM_RUNNING))
>                 return 0;
>         return 1;
> _
>
