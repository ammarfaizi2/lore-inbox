Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264831AbSJPDF7>; Tue, 15 Oct 2002 23:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264834AbSJPDF7>; Tue, 15 Oct 2002 23:05:59 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:2057 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S264831AbSJPDF6>; Tue, 15 Oct 2002 23:05:58 -0400
Date: Tue, 15 Oct 2002 20:11:45 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Better fork() (and possbly others) failure diagnostics
Message-ID: <20021016031145.GD7844@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz> <20021015061610.A986@pegasys.ws> <20021015154621.GA10243@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015154621.GA10243@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 05:46:21PM +0200, Michal Kara wrote:
> > Take a look at the manpages.  It is very clear there that
> > EAGAIN has two meanings: try again because what you request
> > isn't available yet, and request exceeds resource limits (at
> > the moment).  Basically POSIX and SUS direct that EAGAIN is
> > the correct error code for resource limit exceedance.
> 
>   The fork() manpage says:
> 
> EAGAIN fork cannot allocate sufficient memory to copy the
> parent's page tables and allocate a task  structure
> for the child.
> 
>   No word about limits. But that may classify as a manpage problem.

I'd say so.

Also i meant that you should do a survey of manpages that
site EAGAIN and not just fork(2).  The pattern is clear.

> > I agree it would be nice if rlimit caused its own error code
> > but such a change at this time would break far to many things.
> 
>   I can think only of some applications retrying when they get EAGAIN...

It is the application that you can't think of that will bite
someone else.  Further it isn't just whether they try again.
Some poorly written apps may test errno for known values and
behave oddly if they get an errno that isn't listed in the
manpages.  Also it is common to work around limits.  Many
apps are written to economize if it gets EAGAIN when
allocating memory.

> > Your alternative of a klogging an error is not appropriate
> > either.  Hitting an rlimit is not a system, but a user
> > error.
> 
>   On workstation or multi-user server yes. But not on, say, web server.
> There hitting the limit is a problem and administrator should do something
> about it. When your nightly processing job hits limit (and when you run it
> by hand, it doesn't) , "Something wrong" is not to much helpful to solve the
> problem.

Which is why your nightly job or server should be logging
its errors from user space.

>   But WHICH limit. This is what this is all about. If there was only one,
> then it is OK. And you cannot even display the limit/usage for running
> process to give you a hint.

That is unfortunately a deductive process.  You can call
getrlimit and getrusage and try to guess but which one
caused the problem may be, i'll admit, an unknown.
In reality it is seldom that opaque.

Most of the time it is not hard to tell what caused it by
the syscall.  For fork it will be RLIMIT_NPROC.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
