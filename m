Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135220AbRARN4q>; Thu, 18 Jan 2001 08:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135424AbRARN4h>; Thu, 18 Jan 2001 08:56:37 -0500
Received: from msgrouter2.onetel.net.uk ([212.67.96.141]:21021 "EHLO
	msgrouter2.onetel.net.uk") by vger.kernel.org with ESMTP
	id <S135220AbRARN4c>; Thu, 18 Jan 2001 08:56:32 -0500
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramieleavitt@onetel.net.uk>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Is sendfile all that sexy?
Date: Thu, 18 Jan 2001 14:00:19 -0000
Message-ID: <JKEGJJAJPOLNIFPAEDHLOEDGCEAA.laramieleavitt@onetel.net.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <3A646CBB.3D4355E5@linuxjedi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jakub Jelinek wrote:
>
> > > This makes me wonder...
> > >
> > > If the kernel only kept a queue of the three smallest unused fd's, and
> > > when the queue emptied handed out whatever it liked, how many things
> > > would break?  I suspect this would cover a lot of bases...
> >
> > First it would break Unix98 and other standards:
> [snip]
>
> Yeah, I reallized it would violate at least POSIX.  The discussion was
> just bandying about ways to avoid an expensive 'open()' without breaking
> lots of utilities and glibc stuff.  This might be something that could
> be configured for specific server environments, where performance is
> more imporant than POSIX/Unix98, but you still don't want to completely
> break the system.  Just a thought, brain-damaged as it might be. ;-)
>

Merely following the discussion a thought occurred to me of how
to make fd allocation fairly efficient (and simple) even if it retains
the O(n) structure worst case.  I don't know how it is currently implemented
so this may be how it is done, or I may be way off base.

First, keep a table of FDs in sorted order ( mark deleted entries )
that you can access quickly.  O(1) lookup.

Then, maintain this struct like

struct
{
	int lowest_fd;
	int highest_fd;
}

open:
	if( lowest_fd == highest_fd )
	{
		fd = lowest_fd;
		lowest_fd = ++highest_fd;
	}
	if( flags == IGNORE_UNIX98 )
	{
		fd = highest_fd++;
	}
	else
	{
		fd = lowest_fd
		lowest_fd = linear_search( lowest_fd+1, highest_fd );
	}

close:
	if( fd < lowest_fd )
	{
		lowest_fd = fd;
	}
	else if( fd == highest_fd - 1 )
	{
		if( highest_fd == lowest_fd )
		{
			lowest_fd = --highest_fd;
		}
		else
		{
			highest_fd;
		}
	}

For common cases this would be fairly quick.  It would be very easy to
implement an O(1) allocation if you want it to be fast ( at the expense
of a growing file handle table. )

Just thinking about it.
Laramie.
















-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
