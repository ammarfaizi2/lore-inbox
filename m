Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263058AbREWMGv>; Wed, 23 May 2001 08:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263063AbREWMGm>; Wed, 23 May 2001 08:06:42 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:1891 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263058AbREWMG3>; Wed, 23 May 2001 08:06:29 -0400
Date: Wed, 23 May 2001 12:36:16 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Getting FS access events
Message-ID: <20010523123616.F27177@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0105142130480.23663-100000@penguin.transmeta.com> <200105180755.JAA23039@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105180755.JAA23039@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Fri, May 18, 2001 at 09:55:14AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 18, 2001 at 09:55:14AM +0200, Rogier Wolff wrote:

> The "boot quickly" was an example. "Load netscape quickly" on some
> systems is done by dd-ing the binary to /dev/null. 

This is one of the reasons why some filesystems use extent maps
instead of inode indirection trees.  The problem of caching the
metadata basically just goes away if your mapping information is a few
bytes saying "this file is an extent of a hundred block at offset FOO
followed by fifty blocks at offset BAR."

If the mapping metadata is _that_ compact, then your binaries are
almost guaranteed to be either mapped in the inode or in a single
mapping block, so the problem of seeking between indirect blocks
basically just goes away.  You still have to do things like prime the
inode/indirect cache before the first data access if you want
directory scans to go fast, and you still have to preload data pages
for readahead, of course.  

If the objective is "start netscape faster", then the cost of having
to do one synchronous IO to pull in a single indirect extent map block
is going to be negligible next to the other costs.

(Extent maps have their own problems, especially when it comes to
dealing with holes, but that's a different story...)

--Stephen
