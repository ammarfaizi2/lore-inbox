Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVADJdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVADJdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 04:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVADJdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 04:33:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14514 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261586AbVADJdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 04:33:39 -0500
Date: Tue, 4 Jan 2005 10:33:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050104093330.GA13602@elte.hu>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103115120.GB18408@infradead.org> <20050104090408.GA12197@elte.hu> <20050104092612.GA2371@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104092612.GA2371@infradead.org>
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


* Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jan 04, 2005 at 10:04:08AM +0100, Ingo Molnar wrote:
> > or is it the addition of _smp_processor_id() as a way to signal 'this
> > smp_processor_id() call in a preemptible region is fine, trust me'?
> 
> Yes.
> 
> > We
> > could do smp_processor_id_preempt() or some other name - any better
> > suggestions?
> 
> I'd just kill the debug check and rely on the eye of the review to not
> let new users of smp_processor_id slip in.

relying on that is quite futile. E.g. in the block IO code it needed 3-4
iterations even after the first instance was found to get all the cases
right. There are functions that are always called from under a lock then
some unlocked call happens and we've got trouble. Often the bug is some
very rare and obscure corruption of a statistics value, nobody really
notices that.

by today i think we've identified most of the places that can safely do
smp_processor_id() in a preemptible section (in x86 and x64) - it's only
around 3% of the total smp_processor_id() use. I'd rather allow these
exceptions and flag new exceptions as they get added - they are added at
least an order of magnitude more rarely than smp_processor_id() gets
added.

	Ingo
