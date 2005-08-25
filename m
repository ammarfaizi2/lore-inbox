Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVHYTqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVHYTqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVHYTqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:46:55 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:51605 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751239AbVHYTqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:46:54 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050825193416.GB4070@elte.hu>
References: <1124749192.17515.16.camel@dhcp153.mvista.com>
	 <1124756775.5350.14.camel@localhost.localdomain>
	 <1124758291.9158.17.camel@dhcp153.mvista.com>
	 <1124760725.5350.47.camel@localhost.localdomain>
	 <1124768282.5350.69.camel@localhost.localdomain>
	 <1124908080.5604.22.camel@localhost.localdomain>
	 <1124917003.5711.8.camel@localhost.localdomain>
	 <1124932391.5527.15.camel@localhost.localdomain>
	 <20050825063539.GB27291@elte.hu>
	 <1124986554.5148.1.camel@localhost.localdomain>
	 <20050825193416.GB4070@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 25 Aug 2005 15:46:29 -0400
Message-Id: <1124999189.6264.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 21:34 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > does the system truly lock up, or is this some transitional condition?  
> > > In any case, i agree that this should be debugged independently of the 
> > > pi_lock patch.
> > 
> > Hmm, I forgot that you took out the bit_spin_lock fixes.  I think this 
> > may be caused by them.  I haven't look further into it yet.
> 
> yeah, i took them out because they clashed with upstream changes. Note 
> that i meanwhile also introduced a per-bh lock, which might make it 
> easier to fix the deadlock:
> 
>  --- linux.orig/fs/buffer.c
>  +++ linux/fs/buffer.c
>  @@ -537,8 +537,7 @@ static void end_buffer_async_read(struct
>           * decide that the page is now completely done.
>           */
>          first = page_buffers(page);
>  -       local_irq_save(flags);
>  -       bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
>  +       spin_lock_irqsave(&first->b_uptodate_lock, flags);
>          clear_buffer_async_read(bh);
>          unlock_buffer(bh);
>          tmp = bh;
> 
> could jbd reuse this lock - or would it need another lock?

I think it can.  I'm looking into right now, but first I'm updating my
logdev to the latest release.  I stripped it all out after submitting
that pi_lock patch and now I have to put it back in!   I didn't save the
updates that I added earlier, so I'm reworking things now.  The logging
definitely helps me, since that was a major factor in getting that
pi_lock patch done so quick.

-- Steve


