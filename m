Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbSI2KqN>; Sun, 29 Sep 2002 06:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262444AbSI2KqN>; Sun, 29 Sep 2002 06:46:13 -0400
Received: from adsl-64-160-54-138.dsl.snfc21.pacbell.net ([64.160.54.138]:1021
	"EHLO gateway.sf.frob.com") by vger.kernel.org with ESMTP
	id <S261638AbSI2KqM>; Sun, 29 Sep 2002 06:46:12 -0400
Date: Sun, 29 Sep 2002 03:47:37 -0700
Message-Id: <200209291047.g8TAlbp03653@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: phil-list@redhat.com
Cc: Axel <Axel.Zeuner@gmx.de>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: 2.5.39: Signal delivery to thread groups: Bug or feature
In-Reply-To: Ingo Molnar's message of  Sunday, 29 September 2002 12:27:11 +0200 <Pine.LNX.4.44.0209291222500.18396-100000@localhost.localdomain>
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> we still have one more problem left in the signal handling area: atomicity
> of signal delivery. Eg. right now it's possible to have a signal 'in
> flight' for one specific thread, which manages to block it before handling
> the signal. What should the behavior be in that case? Does POSIX say
> anything about this?

Assuming you are talking about a process-global signal (not pthread_kill),
then POSIX does not permit this race condition.  If there is any thread
that can take the signal (i.e. not blocking it, or is sigwait'ing for it),
then one such thread must take the signal.  The selection of the thread and
it beginning its action (i.e. choosing a signal handler, and saving the
signal mask the signal handler will restore on its return; or process death)
must be atomic with respect to that thread blocking the signal.

