Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVLOPiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVLOPiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 10:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVLOPiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 10:38:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10154 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750771AbVLOPiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 10:38:23 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051214155432.320f2950.akpm@osdl.org> 
References: <20051214155432.320f2950.akpm@osdl.org>  <1134559121.25663.14.camel@localhost.localdomain> <13820.1134558138@warthog.cambridge.redhat.com> <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com> <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu> <20051213100015.GA32194@elte.hu> <6281.1134498864@warthog.cambridge.redhat.com> <14242.1134558772@warthog.cambridge.redhat.com> <16315.1134563707@warthog.cambridge.redhat.com> <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca> 
To: Andrew Morton <akpm@osdl.org>
Cc: Mark Lord <lkml@rtr.ca>, tglx@linutronix.de, dhowells@redhat.com,
       alan@lxorguk.ukuu.org.uk, pj@sgi.com, mingo@elte.hu, hch@infradead.org,
       torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 15 Dec 2005 15:37:33 +0000
Message-ID: <4336.1134661053@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> I must say that my interest in this stuff is down in
> needs-an-electron-microscope-to-locate territory.  down() and up() work
> just fine and they're small, efficient, well-debugged and well-understood. 
> We need a damn good reason for taking on tree-wide churn or incompatible
> renames or addition of risk.  What's the damn good reason here?

Well...

 (1) On some platforms counting semaphores _can't_ be implemented all that
     efficiently because the only atomic op you've got is something very
     simple that can only unconditionally exchange one state for another
     (XCHG/TAS/SWAP). In such cases counting semaphores have to be be
     implemented by disabling interrupts and taking spinlocks.

     Okay, spinlocks are null ops when CONFIG_SMP and CONFIG_DEBUG_SPINLOCK
     are both disabled, but you still have to disable interrupts, and that
     slows things down, sometimes quite appreciably. It is, for example,
     something I really want to avoid doing on FRV as it takes a *lot* of
     cycles.

 (2) I think Ingo has some RT requirements, but he's probably better to speak
     about them.

 (3) As a slight aside, in a number of cases counting semaphores and their
     operators are being misused: there are, for example, places where
     completions should be used instead and places where *_MUTEX_LOCKED are
     used to initialise counting semaphores. There are also cases in there
     that seem unsure as to whether they're using counting semaphores or
     mutexes.

     Whilst this is not an argument for a galaxy wide churn, in and of itself,
     it does show that a good review is needed and at the very least these
     cases need to be fixed.

 (4) Various people want a mutex for which the semantics are tighter: in
     particular requiring that mutexes must be released in their owner's
     context. This makes debugging easier.

 (5) Mutexes can catch a double-release, which counting semaphores by their
     very nature can't.

So... Would you then object to an implementation of a mutex appearing in the
tree which semaphores that are being used as strict mutexes can be migrated
over to as the opportunity arises?

David
