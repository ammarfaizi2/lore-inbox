Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280328AbRKEIJo>; Mon, 5 Nov 2001 03:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280330AbRKEIJe>; Mon, 5 Nov 2001 03:09:34 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:39439 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280328AbRKEIJS>; Mon, 5 Nov 2001 03:09:18 -0500
Message-ID: <3BE647F4.AD576FF2@zip.com.au>
Date: Mon, 05 Nov 2001 00:04:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <20011104193232.A16679@mikef-linux.matchmail.com> from "Mike Fedyk" at Nov 04, 2001 07:32:32 PM <200111050554.fA55swt273156@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> Mike Fedyk writes:
> > On Sun, Nov 04, 2001 at 06:13:19PM -0800, Andrew Morton wrote:
> 
> >> All well and good, and still a WIP.  But by far the most dramatic
> >> speedups come from disabling ext2's policy of placing new directories
> >> in a different blockgroup from the parent:
> > [snip]
> >> A significant thing here is the improvement in read performance as well
> >> as writes.  All of the other speedup changes only affect writes.
> >>
> >> We are paying an extremely heavy price for placing directories in
> >> different block groups from their parent.  Why do we do this, and
> >> is it worth the cost?
> >
> > My God!  I'm no kernel hacker, but I would think the first thing
> > you would want to do is keep similar data (in this case similar
> > because of proximity in the dir tree) as close as possible to
> > reduce seeking...
> 
> By putting directories far apart, you leave room for regular
> files (added at some future time) to be packed close together.

OK, that's one possible reason.  Not sure I buy it though.  If
the files are created a few days after their parent directory
then the chance of their data or metadata being within device
readhead scope of any of the parent dir's blocks seems small?

> I'm sure your benchmark doesn't fill directories with files
> by adding a few files every day over a period of many months.
> Think about projects under your home directory though.

OK.  I'm not really aware of a suitable benchmark for that.
postmark only works in a single directory.  mongo hardly
touches the disk at all, (with 3/4 of a gig of RAM, anyway).

My original make-100,000-4k-files test creates the files
in a tree - each node has 10 leafs.  For a total of 11,110
directories and 100,000 files.  It originally did it 
in-order, so:

mkdir(00)
mkdir(00/00)
mkdir(00/00/00)
mkdir(00/00/00/00)
creat(00/00/00/00/00)
creat(00/00/00/00/01)
...
mkdir(00/00/00/01)

etc.

So I changed it to create the 11,110 directories, and then
to go back and create the 100,000 files.  This will ensure that the
file's data are not contiguous with their parent directory.

With the ialloc.c change, plus the other changes I mentioned
the time to create all these directories and files and then run
/bin/sync fell from 1:53 to 0:28.  Fourfold.

But the time to read the data was remarkable.  This is purely
due to the ialloc.c change.  The command was

	time (find . -type f | xargs cat > /dev/null)

stock 2.4.14-pre8:	6:32
with ialloc.c change:	0:30

And this was on an 8 gig fs.  On a 32 gig fs I'd expect to see
a fifteen-fold difference due to the additional block groups.

Can you suggest a better test?

-
