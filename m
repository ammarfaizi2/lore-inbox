Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270212AbTHBTIJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270214AbTHBTII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:08:08 -0400
Received: from mail15.speakeasy.net ([216.254.0.215]:42882 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S270212AbTHBTIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:08:05 -0400
Date: Sat, 2 Aug 2003 12:08:02 -0700
Message-Id: <200308021908.h72J82x10422@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
X-Fcc: ~/Mail/linus
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] bug in setpgid()? process groups and thread groups
In-Reply-To: Jeremy Fitzhardinge's message of  , 2 August 2003 01:50:58 -0700 <1059814257.18860.38.camel@ixodes.goop.org>
Emacs: a compelling argument for pencil and paper.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem exists with uids/gids as well, in the sense that they are
changed per-thread but POSIX semantics are that setuid et al affect the
whole process (i.e. all threads in a thread group).  I emphatically agree
that this should be changed, and I hope we can get it done in 2.6.  It's a
significant divergence from POSIX semantics, and not something that can be
worked around very robustly at user level.  (In the case of pgrp, you can
ignore SIGTTIN/SIGTTOU and progress to some degree at user level.  In the
case of uids/gids, you can change every thread individually.)

Changing each thread in the group seems clunky to me.  It also might have
atomicity issues, as there is no synchronization with the reading of these
values.  For job control changes, it probably doesn't matter--each thread
went into its read/write/ioctl or whatever call "before" the setpgid call
if you didn't get to it yet in the loop when it checks current->pgrp; I
can't off hand think of a scenario where two threads can perceivably be on
the opposite sides of the setpgid transition at the same time so as to call
the process-wide transition not atomic.  In the case of uid et al, there is
certainly a problem with the nonatomicity of one thread touching the fields
of another thread that might be running.  The set*id calls change multiple
fields at once, and the intermediate states in between these several word
stores could perhaps be combinations of ids that the user wasn't supposed
to be able to produce.  I am hesitant to hunt down all the permutations and
ways they can be used by another racing thread that might be exploited for
something or other.

It seems obvious to me that these fields should live in a separate data
structure that is shared, like signal_struct and other pieces of
"process-wide" state shared by the threads in a thread group.  This means a
one time swell foop of changing ->{pgrp,uid,euid,...} into ->ids->... or
perhaps task_...(current) macros in case the implementation might change
again.  That's trivial enough to do by just compiling everything and fixing
errors (given ability to compile on a reasonably wide set of platforms).
Making access appear atomic with respect to updates takes a bit more work,
but certainly less than if these fields are not shared among threads.



Thanks,
Roland
