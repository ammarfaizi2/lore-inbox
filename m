Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVF1IbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVF1IbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVF1I2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:28:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13546 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261946AbVF1I07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:26:59 -0400
Date: Tue, 28 Jun 2005 10:26:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: eliminate unneccessary sighand locking
Message-ID: <20050628082645.GB16455@elte.hu>
References: <20050628071624.GA2302@elte.hu> <200506280726.j5S7QgZU027472@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506280726.j5S7QgZU027472@magilla.sf.frob.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roland McGrath <roland@redhat.com> wrote:

> > the amount of potentially affected code (assuming all the locking is 
> > done in a single .[ch] file)
> 
> I'm not sure what that means.  I'm not confident that all relevant 
> locking code is always in one file.  If you mean that you did as I 
> said, checked every use of siglock and confirmed that tasklist_lock is 
> held before examining ->sighand, then we are good.

no, i didnt check all of that. I only checked the obvious places where 
all 3 methods are used in a single module.

> > this reminds me about the patch below: it gets rid of tasklist_lock use 
> > in the POSIX timer signal delivery critical path.
> 
> I don't see how that works at all.  The thought that it would seems to 
> contradict what we've just been discussing.  Holding tasklist_lock is 
> what protects against ->sighand and ->signal changing and the old 
> pointers becoming stale, not task_lock.  What am I missing here?

yeah, it's a bad patch. Offtopic, but it's a real problem: the signal 
code is inevitably holding the tasklist_lock for long times when sending 
group signals, which is interfering with the signal-sending ability of 
upcoming features like high-resolution timers (which uses 
send_sigqueue()).

Could we get rid of tasklist_lock and do a careful lock-step walking of 
the thread hierarchy (locking the next thread, unlocking the previous 
thread in every step), or are there signal semantics reasons for doing 
it all in one atomic step?

	Ingo
