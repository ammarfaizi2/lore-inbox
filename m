Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWCUTvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWCUTvR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWCUTvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:51:17 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:47574 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965097AbWCUTvP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:51:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oD9dj56UaOfe8wK/Mml2EvVT8THW++Bcow6Jrvb+1r8PfukCKGu7FBG0LtN9yNzyQXoRd4yWf83uKgsutKyx2LzY4iDTPVD/cotfyUMKdQnQiZkjwCSFYDMxdmxZ7Z0N6FLywR6Fe++jx44e9spo7nLRJYt11L9PGo1k96Q6GJ4=
Message-ID: <2c0942db0603211151l5db29201p181aac20bb0cf523@mail.gmail.com>
Date: Tue, 21 Mar 2006 11:51:14 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Subject: Re: ring buffer indices: way too much modulo (division!) fiddling
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060321182806.GA2691@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060321182806.GA2691@rhlx01.fht-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> "Just One" shocking example (2.6.16 arch/i386/kernel/apm.c):
>
> static apm_event_t get_queued_event(struct apm_user *as)
> {
>         as->event_tail = (as->event_tail + 1) % APM_MAX_EVENTS;
>         return as->events[as->event_tail];
> }
[...]
>      7d7:       83 f9 14                cmp    $0x14,%ecx

APM_MAX_EVENTS appears to be 20, not a power of 2. GCC does the
obvious transform of modulo to an ANDL when the modulus is a sane
value. Rewrite the above as a four line function and run it through
gcc -S to see to difference bewteen APM_MAX_EVENTS=20 and =32.

> Any problems with such a change that I'm missing here?

<shrug> It's probably not a wide-spread problem. How many places in
the kernel use ringbuffers that aren't sized to a power of 2?

> ringbuf_advance_idx(my_idx_var, MY_BUF_SIZE)
> (any more generic name? It's not always about ring buffers...)

modulo_add? But it's probably unneccessary, unless this really is
widespread. Even then, just correcting those already in place would be
better than adding yet another abstraction of a simple operation to
the kernel.

> This kind of unnecessary modulo operation happens in lots of places (mostly
> network drivers).

Check to see if those are power of 2 sized buffers. gcc really will do
those correctly.

Ray
