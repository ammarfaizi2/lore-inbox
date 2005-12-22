Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVLVNpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVLVNpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVLVNpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:45:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932437AbVLVNp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:45:29 -0500
Date: Thu, 22 Dec 2005 05:44:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       arjanv@infradead.org, nico@cam.org, jes@trained-monkey.org,
       zwane@arm.linux.org.uk, oleg@tv-sign.ru, dhowells@redhat.com,
       alan@lxorguk.ukuu.org.uk, bcrl@kvack.org, rostedt@goodmis.org,
       hch@infradead.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-Id: <20051222054413.c1789c43.akpm@osdl.org>
In-Reply-To: <1135257829.2940.19.camel@laptopd505.fenrus.org>
References: <20051222114147.GA18878@elte.hu>
	<20051222035443.19a4b24e.akpm@osdl.org>
	<20051222122011.GA20789@elte.hu>
	<20051222050701.41b308f9.akpm@osdl.org>
	<1135257829.2940.19.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> 
> > >    * - only one task can hold the mutex at a time
> > >    * - only the owner can unlock the mutex
> > >    * - multiple unlocks are not permitted
> > >    * - recursive locking is not permitted
> > >    * - a mutex object must be initialized via the API
> > >    * - a mutex object must not be initialized via memset or copying
> > >    * - task may not exit with mutex held
> > >    * - memory areas where held locks reside must not be freed
> > 
> > Pretty much all of that could be added to semaphores-when-used-as-mutexes. 
> > Without introducing a whole new locking mechanism.
> 
> this is basically in direct conflict with what Linus has been asking
> for.. "leave semaphore semantics alone".

No, it's mostly just adding new debug stuff.  And we'd need to add
additional anotations to those few semaphores which are used as non-mutexes
to support that new debug stuff.

That's if the new debugging stuff is actually useful.  I'm not sure it is,
really - I can't think of any kernel bugs which these features would have
exposed.  Although I think Ingo found some, but I don't recall what they
were.

> 
> > Ingo, there appear to be quite a few straw-man arguments here.  You're
> > comparing a subsystem (semaphores) which obviously could do with a lot of
> > fixing and enhancing with something new which has had a lot of recent
> > feature work out into it.
> > 
> > I'd prefer to see mutexes compared with semaphores after you've put as much
> > work into improving semaphores as you have into developing mutexes.
> 
> semaphores have had a lot of work for the last... 10 years. To me that
> is a sign that maybe they're close to their limit already.

No they haven't - they're basically unchanged from four years ago (at
least).

> You keep saying 10 times "so please enhance semaphores to do this".

Well I think diligence requires that we be able to demonstrate why it's not
possible.

It's plain dumb for us to justify a fancy-pants new system based on
features which we could have added to the old one, no?

> Semaphores have far more complex rules for the slowpath (mutex semantics
> are simple because the number of wakers is always at most one, and if
> you hold the lock, you KNOW nobody else can do another release under
> you). Adding dual rules or other complexity to it doesn't sound too
> compelling to me actually; they're highly tricky things already (just
> look at the i386 ones.. that extra wakeup was there to plug a hole (at
> least that is my empirical conclusion based on "we remove it it hangs"
> behavior).
> 
> Having 2 sets of behaviors for the same primitive also sounds not good
> to me to be honest, that's bound to explode stuff left and right all the
> time.

There's no need for two sets of behaviour.  What I'm saying is that we
could add similar debugging features to semaphores (if useful).  Yes, we
would have to tell the kernel at the source level to defeat that debugging
if a particular lock isn't being used as a mutex.  That's rather less
intrusive than adding a whole new type of lock.  But I'd question the value
even of doing that, given the general historical non-bugginess of existing
semaphore users.

