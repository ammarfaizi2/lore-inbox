Return-Path: <SRS0=AtwX=DX=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28148C433E7
	for <io-uring@archiver.kernel.org>; Fri, 16 Oct 2020 13:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6942207DE
	for <io-uring@archiver.kernel.org>; Fri, 16 Oct 2020 13:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JubGlHO3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h57olXuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408060AbgJPNHQ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:07:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44512 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406681AbgJPNHP (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 16 Oct 2020 09:07:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602853634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HEz9VA+Ry8f6KJ6PxVCIFUNP+ITbnXQUT58CgkC8uJQ=;
        b=JubGlHO3g8DwdoYooc1pglbREfYqaAamM4Hx9hRuoInagdD117RqKfkFKgMPnpqan5rUrV
        Fhx5ueOIONbYhARvrMyaGW5UhzgD6pNs1qXOGVRYWjT6U+MbjOCE7C1uJTSkLRjJP4XtAi
        R3f3ohp2++Xgkt225Wek3ggxZZxnxHx97bIKQVPXDOOSFExsl/lQcVCW5JzreItXPshroA
        t10DnOXBJOqnuFPRUkKx5f9NmD8Jl4IVVPVJvyRfT9ssNOr8Pf7axprI2qwQ/05IgCcl8z
        7qAUYdqs344YY8ApOArbeFnX2GbQVt0JcxC0vym7nCA6zd5qt0vF/btSVQKtaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602853634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HEz9VA+Ry8f6KJ6PxVCIFUNP+ITbnXQUT58CgkC8uJQ=;
        b=h57olXuDcrwiP6aHeH5PjiqOv39ZsphnB1BGJhV3NM7/Vf4REa5A5TRZJTGvNHZO5ZGDvO
        Selt/I8hhgCJsPCA==
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 4/5] x86: wire up TIF_NOTIFY_SIGNAL
In-Reply-To: <20201016105415.GA21989@redhat.com>
References: <20201015131701.511523-1-axboe@kernel.dk> <20201015131701.511523-5-axboe@kernel.dk> <87o8l3a8af.fsf@nanos.tec.linutronix.de> <20201015143409.GC24156@redhat.com> <87y2k6trzr.fsf@nanos.tec.linutronix.de> <20201016105415.GA21989@redhat.com>
Date:   Fri, 16 Oct 2020 15:07:14 +0200
Message-ID: <87imbatj3x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Fri, Oct 16 2020 at 12:54, Oleg Nesterov wrote:
> On 10/16, Thomas Gleixner wrote:
>
> But again, I won't argue. And to remind, we do not really need to touch
> arch_do_signal() at all. We can just add
>
> 	if (test_thread_flag(TIF_NOTIFY_SIGNAL))
> 		tracehook_notify_signal();
>
> 	if (!task_sigpending(current))
> 		return 0;
>
> at the start of get_signal() and avoid the code duplication automatically.

That works as well and is smart, but it's completely non obvious while

     if (ti_work & _TIF_NOTIFY_SIGNAL)
            tracehook_notify_signal();

     arch_do_signal_or_restart(ti_work & _TIF_SIGPENDING);

makes it entirely clear to follow the logic and it just operates on
cached ti_work.

You can still do this for the non generic entry architectures:

     if (!IS_ENABLED(CONFIG_GENERIC_ENTRY) &&
     	 (test_thread_flag(TIF_NOTIFY_SIGNAL))
 		tracehook_notify_signal();

to avoid the churn in arch/*.

Thanks,

        tglx
