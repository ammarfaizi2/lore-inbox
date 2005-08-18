Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVHRMNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVHRMNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 08:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVHRMNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 08:13:41 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:28806 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932210AbVHRMNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 08:13:40 -0400
Message-ID: <43047DF6.3E74B6EF@tv-sign.ru>
Date: Thu, 18 Aug 2005 16:24:22 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com> <4301D455.AC721EB7@tv-sign.ru> <20050816170714.GA1319@us.ibm.com> <20050817014857.GA3192@us.ibm.com> <43034B17.3DEE0884@tv-sign.ru> <20050817211957.GN1300@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Replying to wrong message, sorry).

Thomas Gleixner wrote:
>
> --- linux-2.6.13-rc6-rt8/kernel/fork.c	2005-08-17 12:57:08.000000000 +0200
> +++ linux-2.6.13-rc6-rt/kernel/fork.c	2005-08-17 11:17:46.000000000 +0200
> @@ -1198,7 +1198,8 @@ bad_fork_cleanup_mm:
>  bad_fork_cleanup_signal:
>  	exit_signal(p);
>  bad_fork_cleanup_sighand:
> -	exit_sighand(p);
> +	if (p->sighand) /* exit_signal() could have freed p->sighand */
> +		exit_sighand(p);


Looks like now it is the only user of exit_signal(), and I think
we can kill this function and just do:

bad_fork_cleanup_sighand:

	if (p->sighand) {

		// p->sighand can't change here, we don't need tasklist lock

		if (atomic_dec_and_test(p->sighand->count))

			// If we get here we are not sharing ->sighand with anybody else.
			// It means, in particular, that p had no CLONE_THREAD flag.
			// Nobody can see this process yet, we didn't call attach_pid(),
			// otherwise ->sighand was freed from __exit_signal. Thus nobody
			// can see this sighand.

			sighand_free(p->sighand);
	}

It is not an optimization, this path is rare, just to make things
more clear and to reduce "false positives" from grep tasklist_lock.

And I think it makes sense to

#define	put_sighand(sig)	\
	do if atomic_dec_and_test(sig->count) sighand_free(sig); while (0)

Oleg.
