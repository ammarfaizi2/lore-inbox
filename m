Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTERRL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 13:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbTERRL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 13:11:29 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:27143 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id S262139AbTERRL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 13:11:27 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <20030518163537.GZ8978@holomorphy.com> from William Lee Irwin III
 at "May 18, 2003 09:35:37 am"
To: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 18 May 2003 19:24:17 +0200 (MET DST)
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, ptb@it.uc3m.es,
       linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago William Lee Irwin III wrote:"
> At some point in the past, Peter Breuer's attribution was removed from:
> >> Here's a before-breakfast implementation of a recursive spinlock. That
> >> is, the same thread can "take" the spinlock repeatedly. 
> 
> On Sun, May 18, 2003 at 09:30:17AM -0700, Martin J. Bligh wrote:
> > Why?
> 
> netconsole.

That's a problem looking for a solution!  No, the reason for wanting a
recursive spinlock is that nonrecursive locks make programming harder.

Though I've got quite good at finding and removing deadlocks in my old
age, there are still two popular ways that the rest of the world's
prgrammers often shoot themselves in the foot with a spinlock:

   a) sleeping while holding the spinlock
   b) taking the spinlock in a subroutine while you already have it

The first method leads to an early death if the spinlock is a popular
one, as the only thread that can release it doesn't seem to be running,
errr..

The second method is used by programmers who aren't aware that some
obscure subroutine takes a spinlock, and who recklessly take a lock
before calling a subroutine (the very thought sends shivers down my
spine ...).  A popular scenario involves not /knowing/ that your routine
is called by the kernel with some obscure lock already held, and then
calling a subroutine that calls the same obscure lock.  The request
function is one example, but that's hardly obscure (and in 2.5 the 
situation has eased there!).

It's the case (b) that a recursive spinlock makes go away.

Hey, that's not bad for a small change! 50% of potential programming
errors sent to the dustbin without ever being encountered.


Peter
