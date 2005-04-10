Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVDJGny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVDJGny (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 02:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVDJGny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 02:43:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11181 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261437AbVDJGnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 02:43:52 -0400
Date: Sun, 10 Apr 2005 08:43:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@davemloft.net>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, tony.luck@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
Message-ID: <20050410064324.GA24596@elte.hu>
References: <3R6Ir-89Y-23@gated-at.bofh.it> <ugoecowjci.fsf@panda.mostang.com> <20050409070738.GA5444@elte.hu> <16983.33049.962002.335198@napali.hpl.hp.com> <20050409155810.593d8f7b.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050409155810.593d8f7b.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.223, required 5.9,
	BAYES_00 -4.90, SUBJ_HAS_UNIQ_ID 2.68
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David S. Miller <davem@davemloft.net> wrote:

> > Yes, of course.  The deadlock was due to context-switching, not
> > switch_mm() per se.  Hopefully someone else beats me to remembering
> > the details before Monday.
> 
> Sparc64 has a deadlock because we hold mm->page_table_lock during 
> switch_mm().  I bet IA64 did something similar, as I remember it had a 
> very similar locking issue in this area.
> 
> So the deadlock was, we held the runqueue locks over switch_mm(), 
> switch_mm() spins on mm->page_table_lock, the cpu which does have 
> mm->page_table_lock tries to do a wakeup on the first cpu's runqueue. 
> Classic AB-BA deadlock.

yeah, i can see that happening - holding the runqueue lock and enabling 
interrupts. (it's basically never safe to enable irqs with the runqueue 
lock held.)

the patch drops both the runqueue lock and enables interrupts, so this 
particular issue should not trigger.

	Ingo
