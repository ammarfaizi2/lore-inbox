Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTESRDw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTESRDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:03:52 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:58505 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262493AbTESRDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:03:49 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 19 May 2003 10:15:54 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <200305191248.h4JCmti06492@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.55.0305190957520.4379@bigblue.dev.mcafeelabs.com>
References: <200305191248.h4JCmti06492@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Peter T. Breuer wrote:

> "A month of sundays ago Davide Libenzi wrote:"
> > On Mon, 19 May 2003, Peter T. Breuer wrote:
> >
> > > No. This is not true. Imagine two threads, timed as follows ...
> > >
> > >     .
> > >     .
> > >     .
> > >     .
> > > if ((snl)->uniq == current) {
> > > atomic_inc(&(snl)->count); 		.
> > > } else { 				.
> > > spin_lock(&(snl)->lock);		.
> > > atomic_inc(&(snl)->count);		.
> > > (snl)->uniq = current; 	  <->	if ((snl)->uniq == current) {
> > > 				atomic_inc(&(snl)->count);
> > > 				} else {
> > > 				spin_lock(&(snl)->lock);
> > > 				atomic_inc(&(snl)->count);
> > > 				(snl)->uniq = current;
> > >
> > >
> > > There you are. One hits the read exactly at the time the other does a
> > > write. Bang.
> >
> > So, what's bang for you ? The second task (the one that reads "uniq")
> > will either see "uniq" as NULL or as (task1)->current. And it'll go
> > acquiring the lock, as expected. Check it again ...
>
> Perhaps I should expand on my earlier answer ...
>
> (1) while, with some luck, writing may be atomic on ia32 (and I'm not
> sure it is, I'm only prepared to guarantee it for the lower bits, and I
> really don't know about zeroing the carry and so on), I actually doubt
> that reading is atomic, or we wouldn't need the atomic_read
> construction!

Look at atomic read :

$ emacs `find /usr/src/linux/include -name atomic.h | xargs`


> (3) even if one gets either one or the other answer, one of them would
> be the wrong answer, and you clearly intend the atomic_inc of the
> counter to be done in the same atomic region as the setting to current,
> which would be a programming hypothesis that is broken when the wrong
> answer comes up.

Atomic inc/dec/add/sub are different to read/write an aligned sizeof(int)
memory location. An aligned sizeof(int) read/write must be atomic for the
bare bone CPU memory coherency. While add/sub/add/inc are (or at least can
be) split in MEMOP(load)->ALUOP(?)->MEMOP(store) whose full cycle is not
guaranteed to be atomic, load/store of sizeof(int) aligned memory location
are not split is every CPU whose designer was not drunk during the
architectural phase. Or better, if they are split due some sort of HW
limitation, the HW itself has to guarentee the atomicity of the operation.
Intel tries also to guarantee the atomicity of non aligned load/store by
doing split locks on the memory bus. If you have :

int a;

thread1:
	for (;;)
		a = 1;

thread2:
	for (;;)
		a = -1;

being "a" an aligned memory location, a third thread reading "a" reads
either 1 or -1. Going back to the (doubtfully useful) code, you still have
to point out were it does bang ...



- Davide

