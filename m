Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752246AbWAEWoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbWAEWoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbWAEWoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:44:16 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:16870 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752250AbWAEWoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:44:15 -0500
Date: Thu, 5 Jan 2006 23:43:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nicolas Pitre <nico@cam.org>, Joel Schopp <jschopp@austin.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
Message-ID: <20060105224357.GA30298@elte.hu>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <Pine.LNX.4.64.0601042133230.27409@localhost.localdomain> <Pine.LNX.4.64.0601041847330.3279@g5.osdl.org> <20060105144016.GB16816@elte.hu> <Pine.LNX.4.64.0601050810240.3169@g5.osdl.org> <20060105220305.GA8372@elte.hu> <Pine.LNX.4.64.0601051411570.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601051411570.3169@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> I _think_ your patch is the right approach, because most architectures 
> are likely to do their own fast-paths for mutexes, and as such the 
> generic ones are more of a template for how to do it, and hopefilly 
> aren't that performance critical.

yeah, i think so too. We've got 3 architectures done in assembly so far, 
and it seems people like optimizing such code. Also, since the generic 
code does all the boring slowpath stuff, the architecture can 
concentrate on the fun part alone: to make the fastpath really fast.  
The generic code is still in full control of all the mutex semantics, 
and can ignore asm/mutex.h when it wants/needs to. So i'm quite happy 
with the current design and i'm not against more per-arch assembly fun, 
at all.

there's one exception i think: atomic-xchg.h was pretty optimal on ARM, 
and i'd expect it to be pretty optimal on the other atomic-swap 
platforms too. So maybe we should specify atomic_xchg() to _not_ imply a 
full barrier - it's a new API anyway. We cannot embedd the barrier 
within atomic_xchg(), because the barrier is needed at different ends 
for lock and for unlock, and adding two barriers would be unnecessary.

asm-generic/mutex-dec.h is less optimal (and thus less critical), and i 
can see no easy way to modify it, because i think it would be quite 
confusing to enforce 'lock' ordering for atomic_dec_return(), and 
'unlock' ordering for atomic_inc_return(). We cannot remove the existing 
barriers either (and add them explicitly), because there are existing 
users of these primitives. (although we could add explicit barriers to 
those too - but probably not worth the trouble)

	Ingo
