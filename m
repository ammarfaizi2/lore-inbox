Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270523AbUJVHkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270523AbUJVHkp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270020AbUJVHb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 03:31:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40866 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269987AbUJVH2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 03:28:08 -0400
Date: Fri, 22 Oct 2004 09:29:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Thomas Gleixner <tglx@linutronix.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041022072908.GC10908@elte.hu>
References: <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <20041022061901.GM32465@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022061901.GM32465@suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <axboe@suse.de> wrote:

> It has to go, why? Because your deadlock detection breaks? Doesn't
> seem a very strong reason to me at all, sorry.

no, this is no reason at all. I'm really sorry this issue came up in
this context because now people appear to be arguing this as some sort
of policy issue, implying that is somehow improper to use mutexes
instead of completions, which it clearly is _not_. I very much wanted to
avoid this particular type of flamewar :-)

Using mutexes for completion purposes is perfectly fine kernel code. 
Full stop.

Using completions instead of mutexes in certain cases has some minor
advantages for two simple reasons: it's slighly faster and it's also
more readable.

here's an example: initially i made the scheduler's migration logic use
semaphores in that fashion and Linus made me change it to completions,
because, and i quote Linus here:

 [...]
 Btw, should you not use completions here?

 Completions are optimized for the sleep (ie contention) case, while
 semaphores are optimized for the non-contention case. It also makes 
 more "sense" from a conceptual angle (you're waiting for something to
 complete, not asking for an exclusive thing).
 [...]

and i have to say the migration code did become cleaner. To signal some
sort of event it's a more intuitive _symbol_ _name_ to use 'complete()'
and 'wait_for_completion()' than to use 'up()' and 'down()'.

[ If you truly do not agree with this contention then please just look
at one simple conversion we did and check out the previous and the new
logic, by reading the full previous code and the full resulting code. I
do believe that if anyone at that point still thinks that the
semaphore-based code is just as readable (in that context!) as the
completion-based code that then his brains are not made of neurons but
silicon :) ]

but it has never been kernel policy to not allow the use of mutexes that
way! In some cases it's somewhat cleaner to use completions (and if
something is cleaner in Linux then in most cases it's faster as well),
but it's a judgement thing just like it's judgement thing whether to use
kmalloc() or get_free_pages(). Both are correct for the generic problem
of 'allocate some kernel RAM', but optimized for two different types of
uses.

	Ingo
