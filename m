Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTESTib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTESTib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:38:31 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:21517 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id S263258AbTESTi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:38:29 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200305191951.h4JJpKc14036@oboe.it.uc3m.es>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <Pine.LNX.4.55.0305190957520.4379@bigblue.dev.mcafeelabs.com> from
 Davide Libenzi at "May 19, 2003 10:15:54 am"
To: Davide Libenzi <davidel@xmailserver.org>
Date: Mon, 19 May 2003 21:51:20 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Davide Libenzi wrote:"
> On Mon, 19 May 2003, Peter T. Breuer wrote:
> > > >     .
> > > >     .
> > > >     .
> > > > if ((snl)->uniq == current) {
> > > > atomic_inc(&(snl)->count); 		.
> > > > } else { 				.
> > > > spin_lock(&(snl)->lock);		.
> > > > atomic_inc(&(snl)->count);		.
> > > > (snl)->uniq = current; 	  <->	if ((snl)->uniq == current) {
> > > > 				atomic_inc(&(snl)->count);
> > > > 				} else {
> > > > 				spin_lock(&(snl)->lock);
> > > > 				atomic_inc(&(snl)->count);
> > > > 				(snl)->uniq = current;

> > > So, what's bang for you ? The second task (the one that reads "uniq")
> > > will either see "uniq" as NULL or as (task1)->current. And it'll go
> > > acquiring the lock, as expected. Check it again ...

Let's take that as hypothetically true. 

> > (3) even if one gets either one or the other answer, one of them would
> > be the wrong answer, and you clearly intend the atomic_inc of the
> > counter to be done in the same atomic region as the setting to current,
> > which would be a programming hypothesis that is broken when the wrong
> > answer comes up.

> either 1 or -1. Going back to the (doubtfully useful) code, you still have
> to point out were it does bang ...

The "unexpected" sutuation is when the RH process reads the old value
of uniq, just before the LH process sets it. Let's suppose that it
erroneously reads NULL, since that's what was set last, at the unlock
that lets the LH spinlock open up. That's OK, because it's not equal to
its own task identifier either, and that's the only special thing it's
looking for.

Umm ...  actually, the RH process could read uniq before the LH process
entered the spinlock.  If it were at that time equal to its own task
identifier, then chaos would ensue. But if it were so equal, then
the RH process would have the spinlock, since it's taken before setting
uniq. OK, I agree, there's no problem if the read doesn't blow up.

Peter
