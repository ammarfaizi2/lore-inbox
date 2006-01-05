Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWAEPhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWAEPhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWAEPhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:37:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48593 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932085AbWAEPhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:37:09 -0500
Date: Thu, 5 Jan 2006 16:36:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 00/21] mutex subsystem, -V15
Message-ID: <20060105153638.GA31013@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is version 15 of the generic mutex subsystem, against v2.6.15.

The patch-queue consists of 21 patches, which can also be downloaded 
from:

  http://redhat.com/~mingo/generic-mutex-subsystem/

Changes since -V14:

 5 files changed, 164 insertions(+), 191 deletions(-)

 - micro-optimization #1: changed waiter->ti to be waiter->task, this
   shaved off 2 more instructions from the slowpath. Suggested by David
   Howells.

 - micro-optimization #2: beware, this is evil black magic: i've enabled
   architectures to do tail-merging of the slowpath if they want to, and 
   implemented this on x86. This shaves off another 3 instructions
   from the slowpath, which can now directly branch into the slowpath 
   function, and the ret from there will bring us back to the call site.
   The cost is that no other code but the fastpath must be put into
   mutex_lock()/_unlock(). I have added big warnings to the affected
   places. The non-assembly generic includes, nor the debugging code is
   affected by this.

 - reordered the API functions to be in likelyhood-of-use order:
   mutex_lock()-fastpath, mutex_unlock()-fastpath, 
   mutex_lock()-slowpath, mutex_unlock()-slowpath, 
   mutex_lock_interruptible() fastpath/slowpath, mutex_trylock().

 - cleanup: got rid of the intermediate __mutex_lock()/__mutex_unlock() 
   wrappers, they were unnecessary. Renamed the _noinline functions to 
   _slowpath - this is more descriptive.

	Ingo
