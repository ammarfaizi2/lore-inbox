Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVKPJlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVKPJlB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbVKPJlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:41:01 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:61650 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030261AbVKPJlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:41:00 -0500
Subject: Re: [PATCH -rt] race condition in fs/compat.c with compat_sys_ioctl
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark Knecht <markknecht@gmail.com>, pavel@suse.cz,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20051116083214.GA14829@elte.hu>
References: <1131821278.5047.8.camel@localhost.localdomain>
	 <5bdc1c8b0511121725u6df7ad9csb9cb56777fa6fe64@mail.gmail.com>
	 <Pine.LNX.4.58.0511122149020.25152@localhost.localdomain>
	 <5bdc1c8b0511121914v12dc4402u424fbaf416bf3710@mail.gmail.com>
	 <1131853456.5047.14.camel@localhost.localdomain>
	 <5bdc1c8b0511130634h501fb565v58906bdfae788814@mail.gmail.com>
	 <1131994030.5047.17.camel@localhost.localdomain>
	 <5bdc1c8b0511141057l60a2e778x89155cd5484d532f@mail.gmail.com>
	 <1132115386.5047.61.camel@localhost.localdomain>
	 <20051116083214.GA14829@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 16 Nov 2005 04:40:46 -0500
Message-Id: <1132134046.5047.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 09:32 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> >  	down_read(&ioctl32_sem);
> >  	for (t = ioctl32_hash_table[ioctl32_hash(cmd)]; t; t = t->next) {
> > -		if (t->cmd == cmd)
> > +		if (t->cmd == cmd) {
> > +			handler = t->handler;
> > +			up_read(&ioctl32_sem);
> >  			goto found_handler;
> > +		}
> >  	}
> >  	up_read(&ioctl32_sem);
> 
> i think this problem only triggers on RT kernels, because the RT kernel 
> only allows a single reader within a read-semaphore. This works well in 
> 99.9% of the cases. You just found the remaining 0.1% :-| The better 
> solution within -rt would be to change ioctl32_sem to a compat 
> semaphore, via the patch below. Can you confirm that this solves the 
> bootup problem too?
> 

ACK:

Well duh!  OK, I blame lack of sleep on missing the obvious (and getting
up at 4am to go to the bathroom, and then responding to this doesn't
help ;)

I just applied this patch and it works.  I didn't even notice the word
"read" in down_read and up_read, otherwise I would have sent you this
patch.  I was just so frustrated at getting this to work that I just
assumed that this was a normal down and up. Oh well. At least now I
don't have to see why this works in the non-rt case.

Thanks Ingo, yes go ahead and apply your patch. That is definitely a
better solution.

-- Steve


