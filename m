Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTESMgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 08:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTESMgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 08:36:05 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:52496 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id S262430AbTESMgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 08:36:04 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200305191248.h4JCmti06492@oboe.it.uc3m.es>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <Pine.LNX.4.55.0305181623320.3568@bigblue.dev.mcafeelabs.com> from
 Davide Libenzi at "May 18, 2003 04:26:26 pm"
To: Davide Libenzi <davidel@xmailserver.org>
Date: Mon, 19 May 2003 14:48:55 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Davide Libenzi wrote:"
> On Mon, 19 May 2003, Peter T. Breuer wrote:
> 
> > No. This is not true. Imagine two threads, timed as follows ...
> >
> >     .
> >     .
> >     .
> >     .
> > if ((snl)->uniq == current) {
> > atomic_inc(&(snl)->count); 		.
> > } else { 				.
> > spin_lock(&(snl)->lock);		.
> > atomic_inc(&(snl)->count);		.
> > (snl)->uniq = current; 	  <->	if ((snl)->uniq == current) {
> > 				atomic_inc(&(snl)->count);
> > 				} else {
> > 				spin_lock(&(snl)->lock);
> > 				atomic_inc(&(snl)->count);
> > 				(snl)->uniq = current;
> >
> >
> > There you are. One hits the read exactly at the time the other does a
> > write. Bang.
> 
> So, what's bang for you ? The second task (the one that reads "uniq")
> will either see "uniq" as NULL or as (task1)->current. And it'll go
> acquiring the lock, as expected. Check it again ...

Perhaps I should expand on my earlier answer ...

(1) while, with some luck, writing may be atomic on ia32 (and I'm not
sure it is, I'm only prepared to guarantee it for the lower bits, and I
really don't know about zeroing the carry and so on), I actually doubt
that reading is atomic, or we wouldn't need the atomic_read
construction!

(2) I'm not prepared to bet that one either sees the answer from
before the write was done, or the answer after it is done.  I would
suspect that one can get anything, including an explosion or reading
of the works of tolstoy ...

(3) even if one gets either one or the other answer, one of them would
be the wrong answer, and you clearly intend the atomic_inc of the
counter to be done in the same atomic region as the setting to current,
which would be a programming hypothesis that is broken when the wrong
answer comes up.



Peter
