Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVCNIOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVCNIOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVCNIOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:14:25 -0500
Received: from mx2.elte.hu ([157.181.151.9]:35527 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261333AbVCNIOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:14:11 -0500
Date: Mon, 14 Mar 2005 09:14:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break_lock forever broken
Message-ID: <20050314081402.GA26589@elte.hu>
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com> <20050311203427.052f2b1b.akpm@osdl.org> <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com> <20050314070230.GA24860@elte.hu> <42354562.1080900@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42354562.1080900@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > while writing the ->break_lock feature i intentionally avoided
> > overhead in the spinlock fastpath. A better solution for the bug you
> > noticed is to clear the break_lock flag in places that use
> > need_lock_break() explicitly.
> 
> What happens if break_lock gets set by random contention on the lock
> somewhere (with no need_lock_break or cond_resched_lock)? Next time it
> goes through a lockbreak will (may) be a false positive.

yes, and that's harmless. Lock contention is supposed to be a relatively
rare thing (compared to the frequency of uncontended locking), so all
the overhead is concentrated towards the contention case, not towards
the uncontended case. If the flag lingers then it may be a false
positive and the lock will be dropped once, the flag will be cleared,
and the lock will be reacquired. So we've traded a constant amount of
overhead in the fastpath for a somewhat higher, but still constant
amount of overhead in the slowpath.

> >One robust way for that seems to be to make the need_lock_break() macro
> >clear the flag if it sees it set, and to make all the other (internal)
> >users use __need_lock_break() that doesnt clear the flag. I'll cook up a
> >patch for this.
> >
> 
> If you do this exactly as you describe, then you'll break
> cond_resched_lock (eg. for the copy_page_range path), won't you?

(cond_resched_lock() is an 'internal' user that will use
__need_lock_break().)

	Ingo
