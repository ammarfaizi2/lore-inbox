Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293156AbSBWRFc>; Sat, 23 Feb 2002 12:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293159AbSBWRFX>; Sat, 23 Feb 2002 12:05:23 -0500
Received: from pop.gmx.de ([213.165.64.20]:47374 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293156AbSBWRFQ>;
	Sat, 23 Feb 2002 12:05:16 -0500
Subject: Re: [RFC] [PATCH] C exceptions in kernel
From: Dan Aloni <da-x@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020223082211.Z11156@work.bitmover.com>
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org>
	<20020223162100.A1952@outpost.ds9a.nl>
	<1014480355.1844.16.camel@callisto.yi.org> 
	<20020223082211.Z11156@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 23 Feb 2002 19:00:16 +0200
Message-Id: <1014483618.3085.37.camel@callisto.yi.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-02-23 at 18:22, Larry McVoy wrote:
> On Sat, Feb 23, 2002 at 06:05:48PM +0200, Dan Aloni wrote:
> > But, it CAN be used in *local* driver call branches. Writing a new
> > driver? have a lot of local nested calls? Hate goto's? You can use
> > exceptions.
> 
> Is this really anything other than syntactic sugar?  Maybe it's 
> different in drivers, but I find myself doing the following in user 
> space all the time
> 
> 	#define	unless(x)	if (!(x))	/* perl/BCPL corrupted me */
> 
> 	function(...)
> 	{
> 		char	*foo = 0, *bar = 0;
> 		int	locked = 0;
> 		int	rc = -1;
> 
> 		if (bad args or something) {
> 	out:		if (foo) free(foo);
> 			if (bar) free(bar);
> 			if (locked) unlock();
> 			return (rc);
> 		}
> 
> 		unless (locked = get_the_lock()) goto out;
> 		unless (foo = allocate_foo()) goto out;
> 		unless (bar = allocate_bar()) goto out;
> 
> 		more code....
> 
> 		rc = 0;
> 		goto out;
> 	}
> 
> It seems ugly at first but it has some nice attributes:
> 
>     a) all the cleanup is in one place, for both the error path and
the 
>        non-error path.  I could put it at the bottom, I like it at the
>        top because that's where I tend to have the list of things
needed
>        to be cleaned.
> 
>     b) all the error cases are branches, the normal path is
straightline.
> 
>     c) it's as dense as I can make it.
> 
> So how would you do the same thing with exceptions?

Like this:

function(...)
{
	char	*foo = 0, *bar = 0;
	int	locked = 0;
	int	rc = -1;
 
	try {
		if (bad args or something) 
			throw;
 
		locked = get_the_lock();
		foo = allocate_foo();
		bar = allocate_bar();

		more code....

		rc = 0;
	}	
	cleanup {
		if (foo) free(foo);
		if (bar) free(bar);
		if (locked) unlock();
	}  
	return rc;
}

Looks much better, IMHO.

The cleanup() block will run after the try block even if an exception 
did not occur, and will run also if the exception occured, passing the
exception to the next catch() or cleanup() block in stack.

