Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288153AbSA3DLs>; Tue, 29 Jan 2002 22:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSA3DLj>; Tue, 29 Jan 2002 22:11:39 -0500
Received: from bitmover.com ([192.132.92.2]:65182 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S288153AbSA3DL3>;
	Tue, 29 Jan 2002 22:11:29 -0500
Date: Tue, 29 Jan 2002 19:11:28 -0800
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: master.kernel.org situation update
Message-ID: <20020129191128.B23269@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <a37lu4$q5a$1@tazenda.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a37lu4$q5a$1@tazenda.transmeta.com>; from hpa@transmeta.com on Tue, Jan 29, 2002 at 06:31:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 06:31:32PM -0800, H. Peter Anvin wrote:
> The situation on master.kernel.org is looking pretty grim.  We were
> trying to add disk capacity (the host uses a DAC960PRL RAID
> controller) and the end result seems to be that a Mylex utility called
> "ezsetup" has completely trashed the RAID configuration information.
> What makes matters worse is that an MIS screwup here means no backups
> have been running for a month or so.

This doesn't help you now, but what you just hit is why we take a 
different approach to backups.  For any data we care about, we 
stick in a 3ware 6410 controller, run it in JBOD mode, and have
4 drives mounted as 
	/home
	/nightly
	/weekly
	/monthly
and we copy all the data once a day to the appropriate spot.  On top
of that, we run the gzip checksum over all the data and save a database
of 
	pathname, size, mtime, chksum

tuples and for all where path, size, mtime match we compare the chksum
which had better be the same, otherwise the disk, filesystem, or memory
has corrupted your data.  That way we get warned before all the backups
are gone.

Using a RAID is a losing proposition - it means you still have exactly 
one copy of the data and no way to verify that it is correct.  The RAID
just does what the fs/block layer tells it to do and if the upper layers
are handing down bad data, the RAID will faithfully store that bad data.
And you never know until you need it.

The other nice thing about the 4 way mirror is that you can do stuff like

	diff foo.c /nightly/$PWD

and try and figure out what you were smoking when you made that change 
before the coffee started working.

I know this doesn't help right now and is probably unwelcome advice, but
I'd encourage you to consider this approach in the future.  It's brute
force but has huge advantages over tapes, RAID, etc.  You'd be back on 
line right now, albeit with maybe 12 hour old data, if you had this.
We have all our scripts in a BitKeeper repository and I'll happily give
them to you if you want them.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
