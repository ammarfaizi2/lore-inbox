Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272242AbTGYSb3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272250AbTGYSb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:31:29 -0400
Received: from mail.zmailer.org ([62.240.94.4]:3200 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S272242AbTGYSb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:31:26 -0400
Date: Fri, 25 Jul 2003 21:46:35 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andrew Barton <andrevv@users.sourceforge.net>
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: forkpty with streams
Message-ID: <20030725184635.GC6898@mea-ext.zmailer.org>
References: <1059089316.8596.14.camel@localhost> <20030725152751.GA606@win.tue.nl> <1059130744.13184.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059130744.13184.11.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 10:59:04AM +0000, Andrew Barton wrote:
...
> > > with the standard I/O stream functions. The calls to forkpty() and
> > > fdopen() and fprintf() all return successfully, but the data never seems
> > > to get to the child process.
> > 
> > > 	pid = forkpty (&fd, 0, 0, 0);
> > > 	if (pid == 0) {
> > > 		execlp ("sh", "sh", (void *)0);
> > > 	} else {
> > > 		F = fdopen (fd, "w");
> > > 		fprintf (F, "exit\n");
> > > 		fflush (F);
> > > 		wait (0);
> > > 	}
...
> Before I tried using streams, I just used write() to communicate with
> the ptty, but I had the same problem. I found that if I put a read()
> call before and after the write(), it worked. But why? Is this some kind
> of I/O voodoo? How does the reading affect the writing?

PTY file-handle is full-duplex bi-directional thing, and sometimes
it may need reading, or you get unwanted deadlocks.

> You mentioned that things would improve if I let the parent read from
> fd. Will this work using streams? I have tried opening fd in "r+" mode,
> but in that case I end up reading my own data. Do I need to lay an
> fflush() somewhere inbetween? What is it exactly that causes the data to
> be sent to the parent?

dup() helps you to have two fd:s,  fdopen() for both, one with "w",
other "r".   Things should not need that dup() actually.
Also fcntl() the fd's to be non-blocking.

Actually I am always nervous with stdio streams in places
where I want to use non-blocking file handles, and carefull
read()ing and write()ng along with select()s to handle
non-stagnation of this type of communications.

> I appreciate the help.

/Matti Aarnio
