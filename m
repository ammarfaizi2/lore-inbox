Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbSJONKS>; Tue, 15 Oct 2002 09:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbSJONKS>; Tue, 15 Oct 2002 09:10:18 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:43783 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262650AbSJONKQ>; Tue, 15 Oct 2002 09:10:16 -0400
Date: Tue, 15 Oct 2002 06:16:10 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Better fork() (and possbly others) failure diagnostics
Message-ID: <20021015061610.A986@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz>; from lemming@atrey.karlin.mff.cuni.cz on Tue, Oct 15, 2002 at 01:55:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 01:55:17PM +0200, Michal Kara wrote:
>   Several times I had real problems with batch jobs failing with EAGAIN,
> printed as "Resource temporarily unavailable". Not with the failure, but to
> determine the real cause is really a pain. Usually, the problem is in
> resource limits (rlimit, set by ulimit), but the returned error code is
> misleading.
> 
>   There are two ways. One is to print something to syslog, when some rlimit
> is reached. This is already done when limit of open files in system is
> reached.
> 
>   The second is more subtle - define error code for reaching the rlimit
> (possibly one errorcode for each rlimit) and slightly change the code to
> return correct error code.
> 
>   What do you think about this subject?

Bad idea at this time.  In 1980 it might have been ok.

Take a look at the manpages.  It is very clear there that
EAGAIN has two meanings: try again because what you request
isn't available yet, and request exceeds resource limits (at
the moment).  Basically POSIX and SUS direct that EAGAIN is
the correct error code for resource limit exceedance.

I agree it would be nice if rlimit caused its own error code
but such a change at this time would break far to many things.

Your alternative of a klogging an error is not appropriate
either.  Hitting an rlimit is not a system, but a user
error.  There is nothing for the admin to do, the message
really needs to go to the user and when an rlimit is hit you
would be likely to get a flurry of messages.  It is better
for the user to be notified by the application.

Optimally whatever hit the rlimit should have reported a
more useful message.  That many applications don't have
special processing for EAGAIN isn't surprising as it doesn't
occur that often.  I suppose a change to the error message
to read "Resource temporarily unavailable or user limits
exceeded" might help newer users but that is a property of
libc.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
