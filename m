Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbVLVNX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbVLVNX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVLVNX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:23:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44699 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965150AbVLVNX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:23:57 -0500
Subject: Re: [patch 0/9] mutex subsystem, -V4
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, bcrl@kvack.org,
       rostedt@goodmis.org, hch@infradead.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20051222050701.41b308f9.akpm@osdl.org>
References: <20051222114147.GA18878@elte.hu>
	 <20051222035443.19a4b24e.akpm@osdl.org> <20051222122011.GA20789@elte.hu>
	 <20051222050701.41b308f9.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 14:23:49 +0100
Message-Id: <1135257829.2940.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >    * - only one task can hold the mutex at a time
> >    * - only the owner can unlock the mutex
> >    * - multiple unlocks are not permitted
> >    * - recursive locking is not permitted
> >    * - a mutex object must be initialized via the API
> >    * - a mutex object must not be initialized via memset or copying
> >    * - task may not exit with mutex held
> >    * - memory areas where held locks reside must not be freed
> 
> Pretty much all of that could be added to semaphores-when-used-as-mutexes. 
> Without introducing a whole new locking mechanism.

this is basically in direct conflict with what Linus has been asking
for.. "leave semaphore semantics alone".

I agree with Linus that if it has very different rules, it should have a
different name. 

> Ingo, there appear to be quite a few straw-man arguments here.  You're
> comparing a subsystem (semaphores) which obviously could do with a lot of
> fixing and enhancing with something new which has had a lot of recent
> feature work out into it.
> 
> I'd prefer to see mutexes compared with semaphores after you've put as much
> work into improving semaphores as you have into developing mutexes.

semaphores have had a lot of work for the last... 10 years. To me that
is a sign that maybe they're close to their limit already.

You keep saying 10 times "so please enhance semaphores to do this".
Semaphores have far more complex rules for the slowpath (mutex semantics
are simple because the number of wakers is always at most one, and if
you hold the lock, you KNOW nobody else can do another release under
you). Adding dual rules or other complexity to it doesn't sound too
compelling to me actually; they're highly tricky things already (just
look at the i386 ones.. that extra wakeup was there to plug a hole (at
least that is my empirical conclusion based on "we remove it it hangs"
behavior).

Having 2 sets of behaviors for the same primitive also sounds not good
to me to be honest, that's bound to explode stuff left and right all the
time.

I realize you're not looking forward to a gradual conversion; yet Linus
says he doesn't want a wholesale change either but wants it gradual.


