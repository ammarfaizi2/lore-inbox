Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUEKUgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUEKUgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUEKUgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:36:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65507 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263609AbUEKUgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:36:07 -0400
Date: Tue, 11 May 2004 22:38:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, geoff@linux.jf.intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-ID: <20040511203813.GA6552@elte.hu>
References: <20040511131137.2390ffa8.akpm@osdl.org> <200405112027.i4BKR5F18656@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405112027.i4BKR5F18656@unix-os.sc.intel.com>
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


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> > +int del_single_shot_timer(struct timer_struct *timer)
> > +{
> > +	if (del_timer(timer))
> > +		del_timer_sync(timer);
> > +}
> >  #endif
> 
> I'm confused, isn't the polarity of del_timer() need to be reversed?
> Also propagate the return value of del_timer_sync()?

indeed. If the removal didnt succeed then we must make sure there's no
timer fn pending. Btw., in that case del_timer_sync() must not succeed -
it would mean the timer fn re-added the timer, which by definition must
not happen here. So i'd go for:

int del_single_shot_timer(struct timer_struct *timer)
{
	int ret = del_timer(timer);

	if (!ret) {
		ret = del_timer_sync(timer);
		BUG_ON(ret);
	}

	return ret;
}

this should catch illegal uses of del_single_shot_timer().

	Ingo
