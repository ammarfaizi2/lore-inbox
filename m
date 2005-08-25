Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVHYTdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVHYTdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVHYTdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:33:39 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:27625 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751237AbVHYTdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:33:38 -0400
Date: Thu, 25 Aug 2005 21:34:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
Message-ID: <20050825193416.GB4070@elte.hu>
References: <1124749192.17515.16.camel@dhcp153.mvista.com> <1124756775.5350.14.camel@localhost.localdomain> <1124758291.9158.17.camel@dhcp153.mvista.com> <1124760725.5350.47.camel@localhost.localdomain> <1124768282.5350.69.camel@localhost.localdomain> <1124908080.5604.22.camel@localhost.localdomain> <1124917003.5711.8.camel@localhost.localdomain> <1124932391.5527.15.camel@localhost.localdomain> <20050825063539.GB27291@elte.hu> <1124986554.5148.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124986554.5148.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > does the system truly lock up, or is this some transitional condition?  
> > In any case, i agree that this should be debugged independently of the 
> > pi_lock patch.
> 
> Hmm, I forgot that you took out the bit_spin_lock fixes.  I think this 
> may be caused by them.  I haven't look further into it yet.

yeah, i took them out because they clashed with upstream changes. Note 
that i meanwhile also introduced a per-bh lock, which might make it 
easier to fix the deadlock:

 --- linux.orig/fs/buffer.c
 +++ linux/fs/buffer.c
 @@ -537,8 +537,7 @@ static void end_buffer_async_read(struct
          * decide that the page is now completely done.
          */
         first = page_buffers(page);
 -       local_irq_save(flags);
 -       bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
 +       spin_lock_irqsave(&first->b_uptodate_lock, flags);
         clear_buffer_async_read(bh);
         unlock_buffer(bh);
         tmp = bh;

could jbd reuse this lock - or would it need another lock?

	Ingo
