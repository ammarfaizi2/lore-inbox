Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154907AbPIAUrL>; Wed, 1 Sep 1999 16:47:11 -0400
Received: by vger.rutgers.edu id <S154815AbPIAUpa>; Wed, 1 Sep 1999 16:45:30 -0400
Received: from adsl-216-101-162-242.dsl.snfc21.pacbell.net ([216.101.162.242]:33858 "EHLO pizda.davem.net") by vger.rutgers.edu with ESMTP id <S154914AbPIAUlx>; Wed, 1 Sep 1999 16:41:53 -0400
Date: Wed, 1 Sep 1999 13:41:22 -0700
Message-Id: <199909012041.NAA02138@pizda.davem.net>
From: "David S. Miller" <davem@redhat.com>
To: tytso@mit.edu
CC: torvalds@transmeta.com, linux-kernel@vger.rutgers.edu
In-reply-to: <199909012017.QAA18692@tsx-prime.MIT.EDU> (tytso@mit.edu)
Subject: Re: set_current_state
References: <199909012017.QAA18692@tsx-prime.MIT.EDU>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date:   Wed, 1 Sep 1999 16:17:07 -0400
   From: "Theodore Y. Ts'o" <tytso@mit.edu>

   Are there any circumstances where we should keep the old usage?

Fundamentally it only matters when you are going into a "sleep until
condition" polling loop such that:

	add_wait_queue(...);
	for(;;) {
		set_current_state(...);
		if (some asynchronous state)
			break;
		schedule();
	}
	remove_wait_queue(...);

The idea being that you wish the task state to propagate into the view
of all cpus in the system before other cpus can potentially cause the
asynronous event to occur _and_ check your task state while performing
the wake_up(...)

What we're trying to prevent here is the asynchronous state test load
not bypassing the store of the new task state.  If the cpu reorders
these, the wakeup event can be missed.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
