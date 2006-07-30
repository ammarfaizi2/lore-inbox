Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWG3Xbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWG3Xbr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWG3Xbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:31:47 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:37101 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932478AbWG3Xbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:31:47 -0400
Subject: Re: [patch 32/78] fix bad macro param in timer.c
From: Steven Rostedt <rostedt@goodmis.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, oleg@tv-sign.ru, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <200607301003.k6UA3cOP002609@shell0.pdx.osdl.net>
References: <200607301003.k6UA3cOP002609@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 19:31:15 -0400
Message-Id: <1154302275.10074.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 03:03 -0700, akpm@osdl.org wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> We have
> 
> #define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
> 
> and it's used via
> 
> 	list = varray[i + 1]->vec + (INDEX(i + 1));
> 
> So, due to underparenthesisation, this INDEX(i+1) is now a ...  (TVR_BITS + i
> + 1 * TVN_BITS)) ...
> 
> So this bugfix changes behaviour.  Why did it work before?

Shear luck!

Well the outside most parenthesis was OK to be missing because the use
of those where done like this:

	list = base->tv2.vec + (INDEX(0));

Where the user of the INDEX macro put the parenthesis at location of use
and not in the macro (where it belonged).

The broken code was here:


	for (i = 0; i < 4; i++) {
		j = INDEX(i);
		do {
			if (list_empty(varray[i]->vec + j)) {
				j = (j + 1) & TVN_MASK;
				continue;
			}
			list_for_each_entry(nte, varray[i]->vec + j, entry)
				if (time_before(nte->expires, expires))
					expires = nte->expires;
			if (j < (INDEX(i)) && i < 3)
				list = varray[i + 1]->vec + (INDEX(i + 1));
			goto found;
		} while (j != (INDEX(i)));
	}
found:
	if (list) {
		/*
		 * The search wrapped. We need to look at the next list
		 * from next tv element that would cascade into tv element
		 * where we found the timer element.
		 */
		list_for_each_entry(nte, list, entry) {
			if (time_before(nte->expires, expires))
				expires = nte->expires;
		}
	}

Where the INDEX(i+1) was used.  So why did it work?

  Simple answer: It didn't

If i was anything but 0, it was broken.  But this was only used by s390
and arm.  Since it was for the next interrupt, could that next interrupt
be a problem (going into the second cascade)?  But it was probably
seldom wrong. That is, this would fail if the next interrupt was in the
second cascade, and was wrapped. Which may never of happened.  Also if
it did happen, it would have just missed the interrupt.

If an interrupt was missed, and no one was there to miss it, was it
really missed :-)

So, this is a bug fix, that changes behavior, but I believe that the
behavior that was changed, is for the better.

-- Steve


