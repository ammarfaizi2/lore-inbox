Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273925AbRIXOq1>; Mon, 24 Sep 2001 10:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273927AbRIXOqR>; Mon, 24 Sep 2001 10:46:17 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:59856
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S273925AbRIXOqA>; Mon, 24 Sep 2001 10:46:00 -0400
Date: Mon, 24 Sep 2001 10:46:09 -0400
From: Chris Mason <mason@suse.com>
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>, linux-kernel@vger.kernel.org
cc: reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] [PATCH] 2.4.10 improved reiserfs a lot, but
 could still be better
Message-ID: <2315740000.1001342769@tiny>
In-Reply-To: <B0005839269@gollum.logi.net.au>
In-Reply-To: <B0005839269@gollum.logi.net.au>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, September 24, 2001 10:09:59 PM +0800 Beau Kuiper
<kuib-kl@ljbc.wa.edu.au> wrote:

> Hi all again,
> 
> I have updated my last set of patches for reiserfs to run on the 2.4.10 
> kernel.
> 
> The new set of patches create a new method to do kupdated syncs. On 
> filesystems that do no support this new method, the regular write_super 
> method is used. Then reiserfs on kupdated super_sync, simply calls the 
> flush_old_commits code with immediate mode off. 
> 

Ok, I think the patch is missing ;-)

What we need to do now is look more closely at why the performance
increases.  There are a few possibilities:

1) larger transactions due to less frequent commits.  

2) More efficient metadata writes due to less frequent calls to
reiserfs_journal_kupdate

3) Less time spent flushing direct->indirect targets due to less frequent
commits.

The good news is we can easily separate these.  Start by running
debugreiserfs -j /dev/xxx > /tmp/foo

This prints out the transactions still in the log.  You are looking for
j_len, which is the length of each transaction.  The closer this is to ~900
or so, the more efficient the log is.

Q1) Does your patch increase the average length of the transactions?

Q2) Run the tests again with -o notail (including on pure 2.4.10).  Does
the performance gain go down relative to pure 2.4.10?

If Q1 is true, we might be able to tune /proc/sys/vm/bdflush to have
similar benefits.

If Q2 is true, we need to tune the way direct->indirect targets get flushed
(this probably neesd to be tuned regardless).

If neither is true, it is probably the less frequent calls to
reiserfs_journal_kupdate, also tunable through the bdflush params.

I'm not saying we don't need your patch, but I'd like to find out for sure
why it is helping.

Thanks,
Chris

