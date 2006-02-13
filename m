Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWBMOOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWBMOOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWBMOOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:14:34 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:12721 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751785AbWBMOOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:14:33 -0500
Date: Mon, 13 Feb 2006 15:12:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] hrtimer: optimize hrtimer_get_remaining
Message-ID: <20060213141250.GH12923@elte.hu>
References: <Pine.LNX.4.61.0602130211470.23855@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602130211470.23855@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> hrtimer_get_remaining doesn't need to lock the hrtimer_base to read 
> the time. Also use hrtimer_get_remaining at two other places.

nack - it's not only about ->get_time() atomicity:

> -	base = lock_hrtimer_base(timer, &flags);
> -	rem = ktime_sub(timer->expires, timer->base->get_time());
> -	unlock_hrtimer_base(timer, &flags);

timer->expires is a 64-bit value, which might be read nonatomically on 
32-bit platforms. Wherever it's safe, we already open-code this 
ktime_sub() - if you find more places then please do it that way.

definitely not something for v2.6.16.

	Ingo
