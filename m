Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277135AbRJVRL6>; Mon, 22 Oct 2001 13:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277141AbRJVRLt>; Mon, 22 Oct 2001 13:11:49 -0400
Received: from bitmover.com ([192.132.92.2]:49583 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S277135AbRJVRLi>;
	Mon, 22 Oct 2001 13:11:38 -0400
Date: Mon, 22 Oct 2001 10:12:12 -0700
From: Larry McVoy <lm@bitmover.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org,
        BitKeeper Development Source <dev@bitmover.com>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Message-ID: <20011022101212.B24778@work.bitmover.com>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org,
	BitKeeper Development Source <dev@work.bitmover.com>
In-Reply-To: <9qv1to$ase$1@penguin.transmeta.com> <200110221703.f9MH3Gm15955@deathstar.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200110221703.f9MH3Gm15955@deathstar.prodigy.com>; from davidsen@tmr.com on Mon, Oct 22, 2001 at 01:03:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 01:03:16PM -0400, bill davidsen wrote:
> In article <9qv1to$ase$1@penguin.transmeta.com> torvalds@transmeta.com wrote:
> | If somebody has a good suggestion for what could be used as a reasonably
> | efficient "cookie" for virtual filesystems like tmpfs, speak up.  In the
> | meantime, one way to _mostly_ avoid this should be to give a big buffer
> | to readdir(), so that you end up getting all entries in one go (which
> | will be protected by the semaphore inside the kernel), rather than
> | having to do multiple readdir() calls. 
> 
>   Generally "do it all at one go" solutions don't scale, and sooner of
> later break on a large case. 

OK, here's what we are proposing to do in BitKeeper as a work around:

	replace readdir() with an internal getdir() function

	getdir() returns all directory entries in a sorted list
	getdir() works by doing 

		for (;;) {
			lstat(dir);
			while (e = readdir(..)) save(e->d_name);
			lstat(dir)
			if (dir size && dir mtime have NOT changed) break;
			cleanup the array and go start over
		}
		sort entries
		return sorted list

The basic idea being that we first of all narrow the race window and
second of all detect the race in all cases where the mods to the dir
result in either a changed mtime or a changed size.  So yes, that leaves
us open to cases where the size didn't change but the contents did but
I'll be ding danged if I can see a way around that.

As for the sorting, we want deterministic ordering of the entries for
our own reasons.  It also means that we can do the duplicate suppression
in the list processing.

Anyone see a fixable flaw in this approach?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
