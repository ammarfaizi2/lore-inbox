Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRAEKd4>; Fri, 5 Jan 2001 05:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130003AbRAEKdq>; Fri, 5 Jan 2001 05:33:46 -0500
Received: from zeus.kernel.org ([209.10.41.242]:47626 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129811AbRAEKda>;
	Fri, 5 Jan 2001 05:33:30 -0500
Date: Fri, 5 Jan 2001 10:31:09 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@innominate.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010105103109.O1290@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com> <3A5515D0.7F21E668@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A5515D0.7F21E668@innominate.de>; from phillips@innominate.de on Fri, Jan 05, 2001 at 01:31:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 05, 2001 at 01:31:12AM +0100, Daniel Phillips wrote:
> "Stephen C. Tweedie" wrote:
> > 
> Yes, and so long as your journal is not on another partition/disk things
> will eventually be set right.  The combination of a partially updated
> filesystem and its journal is in some sense a complete, consistent
> filesystem.

Right.

> I'm curious - how does ext3 handle the possibility of a crash during
> journal recovery?

Recovery comes in two parts: replay of the log, and deletion of
orphaned inodes.

The log replay is fully idempotent: it just consists of writing the
appropriate log blocks to their home locations on disk.  It doesn't
matter if you do those writes once, twice or a hundred times, you
still get the same result, so crashing mid-recovery and starting again
from scratch is perfectly safe.

Once that recovery is done, the filesystem is marked, atomically, to
be clean.

Secondly, we do the deletion of orphaned inodes.  By this time, the
journal itself has been recovered so we are journaling our operations,
so each orphaned inode delete is being logged.  A crash will recover
to a consistent state via the normal journaling transaction methods,
and will restart orphan recovery from where it left off.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
