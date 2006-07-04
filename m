Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWGDN0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWGDN0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWGDN0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:26:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:48579 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750775AbWGDN0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:26:14 -0400
Date: Tue, 4 Jul 2006 15:21:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: R/W semaphore changes
Message-ID: <20060704132135.GA7816@elte.hu>
References: <1152017562.3109.48.camel@laptopd505.fenrus.org> <14683.1152017262@warthog.cambridge.redhat.com> <15345.1152018339@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15345.1152018339@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5136]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Howells <dhowells@redhat.com> wrote:

> They still aren't allowed to.  Consider:
> 
> 	CPU 1			CPU 2
> 	=======================	=======================
> 	-->down_read(&A);
> 	<--down_read(&A);
> 				-->down_write(&A);
> 				   --- SLEEPING ---
> 	-->down_read(&A);
> 	   --- DEADLOCKED ---

i think you misunderstood what nested locking means in the lockdep case. 
(and that is my fault, for not adding enough documentation to 
down_write_nested() and down_read_nested().)

nested locking does not mean the same instance is allowed to nest! It 
only allows different-instance nesting, 'nesting within the same lock 
class'. (Lockdep has a very broad notion of 'lock class', to achieve the 
collection of very generic locking rules and to do as generic validation 
as possible. See Documentation/lockdep-design.txt for more details.)

Rw-locks on the other hand have special permission to nest for the same 
instance too. See commit 6c9076ec9cd448f43bbda871352a7067f456ee26:

    lockdep so far only allowed read-recursion for the same lock instance.
    This is enough in the overwhelming majority of cases, but a hostap case
    triggered and reported by Miles Lane relies on same-class
    different-instance recursion.  So we relax the restriction on read-lock
    recursion.

    (This change does not allow rwsem read-recursion, which is still
    forbidden.)

also please see the testcases in lib/locking-selftest.c, we specifically 
test the rwsem scenario you outlined above, to make sure the validator 
immediately flags it:

------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
[...]
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
[...]

	Ingo
