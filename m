Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272278AbTGYTyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272280AbTGYTyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:54:52 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:50694 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272278AbTGYTyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:54:51 -0400
Date: Fri, 25 Jul 2003 22:10:00 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Barton <andrevv@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forkpty with streams
Message-ID: <20030725201000.GB670@win.tue.nl>
References: <1059089316.8596.14.camel@localhost> <20030725152751.GA606@win.tue.nl> <1059130744.13184.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059130744.13184.11.camel@localhost>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 10:59:04AM +0000, Andrew Barton wrote:
> On Fri, 2003-07-25 at 15:27, Andries Brouwer wrote:
> > On Thu, Jul 24, 2003 at 11:28:36PM +0000, Andrew Barton wrote:

> > > the data never seems to get to the child process.
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
> > 
> > Let me see. Your sh gets input from this pseudotty and sends its
> > output there again. But you never read that filedescriptor.
> > No doubt things will improve if you let the parent read from fd.
> > 
> > Andries
> 
> Before I tried using streams, I just used write() to communicate with
> the ptty, but I had the same problem. I found that if I put a read()
> call before and after the write(), it worked. But why? Is this some kind
> of I/O voodoo? How does the reading affect the writing?

You test with bash, which is a complicated program with many
subtleties related to job control and terminal control. Things will be
easier with ash instead of sh.

But to answer your concrete question: bash does
	ioctl(0, TCSETSW, foo);
which is the same as POSIX
	tcsetattr(0, TCSADRAIN, foo);
which does some setting, but first waits for the output buffer to drain.
It will never drain, unless the other side of the pty does some reading.

Andries

