Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSLQTBd>; Tue, 17 Dec 2002 14:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbSLQTBd>; Tue, 17 Dec 2002 14:01:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40452 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265373AbSLQTBc>; Tue, 17 Dec 2002 14:01:32 -0500
Date: Tue, 17 Dec 2002 11:10:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFF7399.40708@redhat.com>
Message-ID: <Pine.LNX.4.44.0212171106210.1095-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Ulrich Drepper wrote:
>
> But this is exactly what I expect to happen.  If you want to implement
> gettimeofday() at user-level you need to modify the page.

Note that I really don't think we ever want to do the user-level
gettimeofday(). The complexity just argues against it, it's better to try
to make system calls be cheap enough that you really don't care.

sysenter helps a bit there.

If we'd need to modify the page, we couldn't share one page between all
processes, and we couldn't make it global in the TLB. So modifying the
info page is something we should avoid at all cost - it's not totally
unlikely that the overheads implied by per-thread pages would drown out
the wins from trying to be clever.

The advantage of the current static fixmap is that it's _extremely_
streamlined. The only overhead is literally the system entry itself, which
while a bit too high on a P4 is not that bad in general (and hopefully
Intel will fix the stupidities that cause the P4 to be slow at kernel
entry. Somebody already mentioned that apparently the newer P4 cores are
actually faster at system calls than mine is).

			Linus

