Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbTH0ETU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 00:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTH0ETU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 00:19:20 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:8077 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263061AbTH0ETO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 00:19:14 -0400
Date: Tue, 26 Aug 2003 21:47:35 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: kuznet@ms2.inr.ac.ru
cc: Werner Almesberger <wa@almesberger.net>, <quade@hsnr.de>,
       "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
In-Reply-To: <200308270147.FAA07024@dub.inr.ac.ru>
Message-ID: <Pine.LNX.4.44.0308262141480.1471-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Aug 2003 kuznet@ms2.inr.ac.ru wrote:

> Hello!
> 
> > Hmm, actually, no. On UP, yes. But on SMP, you might tasklet_kill
> > while the tasklet is running, but before it has had a chance to
> > tasklet_schedule itself. tasklet_schedule will have no effect in
> > this case.
> > 
> > Alexey, if my observation is correct, the property
> > 
> > | * If tasklet_schedule() is called, then tasklet is guaranteed
> > |   to be executed on some cpu at least once after this.
> > 
> > does not hold if using tasklet_kill on SMP.
> 
> It still holds. tasklet_kill just waits for completion of scheduled
> events. Well, it _assumes_ that cpu which calls tasklet_schedule
> does not try to wake the tasklet after death. But it is from area
> of pure scholastics already: waker and killer have to synchronize in
> some
> way anyway. 

I didn't really understand this one. What Werner says seems correct 
though. For recursive tasklets one of the two things are bound to happen. 
Either the tasklet_kill hangs (which will happen on UP) or one (read last)
tasklet_schedule is not honoured (which will happen on SMP). On SMP the 
user context tasklet_kill gets a chance to exit the 
"while (test_bit(TASKLET_STATE_SCHED, &t->state))" loop as it gets a 
chance to run parallely with tasklet_action in the small window (during 
which TASKLET_STATE_SCHED is not set) that I mentioned in one of my 
earlier mails.

So I believe that at least one (to be precise, the last one called before 
tasklet dies) tasklet_schedule is not honoured.

Thanx,

tomar


> 
> Alexey


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

