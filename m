Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266462AbUFQMNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266462AbUFQMNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 08:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUFQMNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 08:13:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48802 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266462AbUFQMMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 08:12:53 -0400
Date: Thu, 17 Jun 2004 14:13:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040617121356.GA24338@elte.hu>
References: <20040527210447.GA2029@elte.hu> <C7C4545F11DFBEindou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7C4545F11DFBEindou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Takao Indoh <indou.takao@soft.fujitsu.com> wrote:

>  int mod_timer(struct timer_list *timer, unsigned long expires)
>  {
>  	BUG_ON(!timer->function);
> 
> +	if (crashdump_mode()) {
> +		return diskdump_mod_timer(timer, expires);
> +	}

looks good. Please use the proper coding style:

 +	if (crashdump_mode())
 +		return diskdump_mod_timer(timer, expires);

but there's another possible method (suggested by Alan Cox) that
requires no changes to the timer API hotpaths: 'clear' all timer lists
upon a crash [once all CPUs have stopped and irqs are disabled] and just
let the drivers use the normal timer APIs. Drive timer execution via a
polling method.

this basically approximates your polling based implementation but uses
the existing kernel timer data structures and timer mechanism so should
be robust and compatible. It doesnt rely on any previous state (because
all currently pending timers are discarded) so it's as crash-safe as
possible.

what do you think?

	Ingo
