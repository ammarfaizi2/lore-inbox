Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293154AbSBWQWh>; Sat, 23 Feb 2002 11:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293155AbSBWQW2>; Sat, 23 Feb 2002 11:22:28 -0500
Received: from bitmover.com ([192.132.92.2]:52383 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293154AbSBWQWN>;
	Sat, 23 Feb 2002 11:22:13 -0500
Date: Sat, 23 Feb 2002 08:22:11 -0800
From: Larry McVoy <lm@bitmover.com>
To: Dan Aloni <da-x@gmx.net>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] C exceptions in kernel
Message-ID: <20020223082211.Z11156@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dan Aloni <da-x@gmx.net>, bert hubert <ahu@ds9a.nl>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org> <20020223162100.A1952@outpost.ds9a.nl> <1014480355.1844.16.camel@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1014480355.1844.16.camel@callisto.yi.org>; from da-x@gmx.net on Sat, Feb 23, 2002 at 06:05:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 06:05:48PM +0200, Dan Aloni wrote:
> But, it CAN be used in *local* driver call branches. Writing a new
> driver? have a lot of local nested calls? Hate goto's? You can use
> exceptions.

Is this really anything other than syntactic sugar?  Maybe it's different 
in drivers, but I find myself doing the following in user space all the time

	#define	unless(x)	if (!(x))	/* perl/BCPL corrupted me */

	function(...)
	{
		char	*foo = 0, *bar = 0;
		int	locked = 0;
		int	rc = -1;

		if (bad args or something) {
	out:		if (foo) free(foo);
			if (bar) free(bar);
			if (locked) unlock();
			return (rc);
		}

		unless (locked = get_the_lock()) goto out;
		unless (foo = allocate_foo()) goto out;
		unless (bar = allocate_bar()) goto out;

		more code....

		rc = 0;
		goto out;
	}

It seems ugly at first but it has some nice attributes:

    a) all the cleanup is in one place, for both the error path and the 
       non-error path.  I could put it at the bottom, I like it at the
       top because that's where I tend to have the list of things needed
       to be cleaned.

    b) all the error cases are branches, the normal path is straightline.

    c) it's as dense as I can make it.

So how would you do the same thing with exceptions?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
