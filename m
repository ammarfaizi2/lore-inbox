Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSHIV7j>; Fri, 9 Aug 2002 17:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSHIV7j>; Fri, 9 Aug 2002 17:59:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47888 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316199AbSHIV7i>; Fri, 9 Aug 2002 17:59:38 -0400
Date: Fri, 9 Aug 2002 15:04:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Larson <plars@austin.ibm.com>
cc: Hubertus Franke <frankeh@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       <andrea@suse.de>, Dave Jones <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <1028929600.19435.373.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0208091459010.1283-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Aug 2002, Paul Larson wrote:
> On Fri, 2002-08-09 at 16:42, Linus Torvalds wrote:
> > Hmm.. Giving them a quick glance-over, the /proc issues look like they
> > shouldn't be there in 2.5.x anyway, since the inode number really is
> > largely just a random number in 2.5 and all the real information is
> > squirelled away at path open time.

It looks like the biggest impact on /proc would be that the /proc/<pid> 
inodes wouldn't be 10%% unique any more, which in turn means that an 
old-style /bin/pwd that actually walks the tree backwards and checks the 
inode number would occasionally fail.

That in turn makes me suspect that we'd better off just biting the bullet 
and makign the inode numbers almost completely static, and forcing that 
particular failure mode early rather than hit it randomly due to unlucky 
timing.

Doing a simple strace shows that all the systems I have regular access to
use the "getcwd()" system call anyway, which gets this right on /proc (and
other filesystems that do not guarantee unique inode numbers)

> So for now then, should I dig out my original (minimal) patch that
> *just* fixed the "loop forever even if we're out of pids" problem?  Even
> if we increase PID_MAX to something obscenely high, I think we should
> still be checking for this.

Ehh, considering that especially with a 30-bit pid, there's _no_ way we'd
run out without some other serious problems hitting us long before (out of
memory being the obvious one), I don't think even that is an issue.

With a minimum of 8kB / pid for process overhead, you need to have at 
least 43 bits of physical address space completely populated just to cover 
the memory uses of that many pid's.

		Linus

