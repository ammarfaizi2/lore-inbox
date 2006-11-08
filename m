Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754492AbWKHJy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbWKHJy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754499AbWKHJy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:54:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8871 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754492AbWKHJy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:54:56 -0500
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sandeen <sandeen@redhat.com>, Alasdair G Kergon <agk@redhat.com>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Ingo Molnar <mingo@elte.hu>, Srinivasa DS <srinivasa@in.ibm.com>
In-Reply-To: <20061107150017.fb78a327.akpm@osdl.org>
References: <20061107183459.GG6993@agk.surrey.redhat.com>
	 <20061107122837.54828e24.akpm@osdl.org> <45510C73.7060408@redhat.com>
	 <20061107150017.fb78a327.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 10:54:45 +0100
Message-Id: <1162979690.3138.273.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> You're asking me? ;)
> 
> Guys, I'm going to park this patch pending a full description of what it
> does, a description of what the above hunk is doing and pending an
> examination of whether we'd be better off changing the mutex-debugging code
> rather than switching to semaphores.

It's not used as a mutex. Sad but true. It's not so easy to say "just
shut up the debug code", because it's just not that easy: The interface
allows double "unlock", which is fine for semaphores for example. There
fundamentally is no "owner" for this case, and all the mutex concepts
assume that there is an owner. If the owner goes away, pointers to their
task struct for example are no longer valid (used by lockdep and the
other debugging parts). It's what makes the difference between a mutex
and a semaphore: a mutex has an owner and several semantics follow from
that. These semantics allow a more efficient implementation (no multiple
"owners" possible) but once you go away from that fundamental property,
soon we'll see "oh and it needs <this extra code> to cover the wider
semantics correctly.. and soon you have a semaphore again.

Let true semaphores be semaphores, and make all real mutexes mutexes.
But lets not make actual semaphores use mutex code...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

