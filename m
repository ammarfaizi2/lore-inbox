Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTH2Xe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 19:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTH2Xe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 19:34:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:3123 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S262198AbTH2Xe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 19:34:56 -0400
Date: Sat, 30 Aug 2003 00:36:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 4G/4G preempt on vstack
In-Reply-To: <3F4FCCC6.4020501@kolumbus.fi>
Message-ID: <Pine.LNX.4.44.0308300034050.1197-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Aug 2003, Mika Penttila wrote:
> hmm. you make the window smaller, but can't the preempt happen even
> inside repeat_if_esp_changed, after xorl? Disabling interrupts seems the
> only solution.

Your conclusion may very well be right.

Certainly the preempt can happen anywhere there, and I was going
to argue that it doesn't matter.  All we need is to be looking up
TI_real_stack(%ebp) at a time when %ebp is sure to be pointing at
our task's virtual stack.  That real stack will be valid whatever
cpu we're on, but we need to be sure we were looking through the
right window at the moment when we looked it up.

But my error is to say "the preempt": there could be more than one.
Then you can imagine that cpu and %esp at the end are the same as
cpu and %esp at the beginning; but in between, when looking up
TI_real_stack(%ebp), it was actually on another cpu and %ebp was
the wrong pointer.  Very unlikely, but possible.

I was trying to avoid pushfl, cli, popfl, being ignorant of how
much overhead they add (into what I'm sure Ingo would like to keep
as fast a path as possible).  Perhaps there's still a neat way they
can be avoided, perhaps I'm just being silly to try to avoid them.

Sorry, I'm sleepy, perhaps someone else will fix this up now?

Hugh

