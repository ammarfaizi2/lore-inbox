Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVLMPkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVLMPkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVLMPkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:40:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8868 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932185AbVLMPkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:40:10 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <439EDC3D.5040808@nortel.com> 
References: <439EDC3D.5040808@nortel.com>  <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> 
To: "Christopher Friesen" <cfriesen@nortel.com>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 13 Dec 2005 15:39:33 +0000
Message-ID: <15167.1134488373@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen <cfriesen@nortel.com> wrote:

> > Which would be a _lot_ more work. It would involve about ten times as many
> > changes, I think, and thus be more prone to errors.
> 
> "lots of work" has never been a valid reason for not doing a kernel change...

There are a number of considerations:

 (1) If _I_ am going to be doing the work, then I'm quite happy to reduce the
     load by 90%. And I think it'd be at least that, probably more. Finding
     struct semaphore with grep is much easier than finding up/down with grep
     because of:

	(a) comments

	(b) other instances of up/down names, including rw_semaphores

     There are a lot fewer instances of struct semaphore than up and down.

 (2) It makes it easier for other people. In most cases, all they need do is
     change "struct semaphore" to "struct mutex". If they've used
     DECLARE_MUTEX() then they need do nothing at all, and if they've used
     init_MUTEX(), then they don't need to convert sema_init() either.

 (3) It forces people to reconsider how they want to use their semaphores.

I have no objection to making life easier for other people. I suspect most
other people don't care that their semaphores are now mutexes, and think of
them that way anyway.

I admit that there are downsides:

 (1) up and down now do something effectively different (though in most cases
     it's also exactly the same).

 (2) Users of counting semaphores have to change, but they're in the minority
     by quite a way.

 (3) Some people want mutexes to be:

     (a) only releasable in the same context as they were taken

     (b) not accessible in interrupt context, or that (a) applies here also

     (c) not initialisable to the locked state

     But this means that the current usages all have to be carefully audited,
     and sometimes that unobvious.

David
