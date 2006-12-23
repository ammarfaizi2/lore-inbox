Return-Path: <linux-kernel-owner+w=401wt.eu-S1753446AbWLWCHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbWLWCHU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 21:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbWLWCHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 21:07:20 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:61533 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbWLWCHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 21:07:18 -0500
Subject: Re: [patch] change WARN_ON back to "BUG: at ..."
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061222120422.eb28953b.akpm@osdl.org>
References: <20061221124327.GA17190@elte.hu> <458AD71D.2060508@goop.org>
	 <20061221235732.GA32637@elte.hu>  <20061222120422.eb28953b.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 21:06:50 -0500
Message-Id: <1166839610.1573.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-22 at 12:04 -0800, Andrew Morton wrote:
> I've always felt that it is wrong (or at least misleading) that WARN_ON
> prints "BUG".  It would have been better if it had said "WARNING", and only
> BUG_ON says "BUG".
> 
> But lots of people have now written downstream log-parsing tools which
> might break due to this change, so I'm inclined to go with Ingo's patch,
> and restore the old (il)logic.

>From hearing what Ingo has to say about this, it seems that calling it
WARING was wrong in the first place.

BUG (and BUG_ON) are really fatal bugs.  Meaning that if you continue,
you will corrupt the system.

WARN_ON is still a BUG, but we know enough about it that we can just
cripple the system so that it doesn't break anything.  But keeps the
system running so that someone can either read the logs, and perhaps, if
it happens to a developer, be able to do some more diagnostics.

But really, the WARN_ON should only be used when the system did
something that is as bad as a BUG, but you don't need to crash the
system since you can prevent data from being corrupted.  But you want to
flag this so that it can be fixed. Since it really is a BUG!  Calling
BUG_ON while the user is in X is really hopeless, since they may never
know why their system just crashed.

The kernel already prints out "warning" for other things that are not
bugs. Usually a warning means that something might not be compatible.
Or something might degrade performance.  Or you have buggy hardware.
But a "warning" doesn't usually mean a kernel BUG.  WARN_ON on the other
hand should only be used where the cause of the WARN_ON was due to a bug
in the kernel, hence, the word "BUG" should be used.

At least with the -rt patch, we get reports of a BUG happening where it
was from a WARN_ON, and this is a Good Thing(TM).  I can foresee users
ignoring a warning message if that's all they see, and they don't
realize that something has been crippled, and the system is unstable.

Sometimes a WARN_ON can be a cause of a later BUG.  And since the BUG
output has a "cut here" we may not get the output of the true bug.
Users are much more apt to report messages of BUG than WARNING.  So, I
totally agree with Ingo, we need people to see these as BUGs, and report
them whenever they happen. Because when it comes down to it, the warning
is about a bug.

-- Steve

