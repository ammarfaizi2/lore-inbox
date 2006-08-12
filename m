Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWHLQjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWHLQjA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 12:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWHLQjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 12:39:00 -0400
Received: from thunk.org ([69.25.196.29]:931 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964883AbWHLQit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 12:38:49 -0400
Date: Sat, 12 Aug 2006 12:38:34 -0400
From: Theodore Tso <tytso@mit.edu>
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: Duane Griffin <duaneg@dghda.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
Message-ID: <20060812163834.GA11497@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Molle Bestefich <molle.bestefich@gmail.com>,
	Duane Griffin <duaneg@dghda.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com> <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com> <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com> <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com> <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com> <62b0912f0608091347u8b86d40q3679991e9e16526f@mail.gmail.com> <e9e943910608091527t3b88da7eo837f6adc1e1e6f98@mail.gmail.com> <62b0912f0608091609q6b3c6c4ev2d287060fa209@mail.gmail.com> <e9e943910608091708p4914930ct1ee031a1201bfd2f@mail.gmail.com> <62b0912f0608101400t607cf9b7t5c2324f39cc2eed@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b0912f0608101400t607cf9b7t5c2324f39cc2eed@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 11:00:07PM +0200, Molle Bestefich wrote:
> Duane Griffin wrote:
> >> If it doesn't take into account own changes, then the -n command is
> >> unable to produce even a slightly accurate resemblence of what would
> >> happen if I did a real run.
> >
> >It takes into account some of them (such as reading data from the
> >backup superblock if it detects corruption). Others will be irrelevent
> >for further operations. Many reports will be accurate, especially
> >fatal ones. I consider that useful, YMMV.
> 
> I've attached the output of a -n run, let's get some facts on the table.
> 
> I would be very happy if someone knowledgeable would tell me something
> useful about it.
> 
> I'm especially worried about the "70058 files, 39754 blocks used (0%)"
> message at the end of the e2fsck run.

OK, so it looks like the primary block group descriptors got trashed,
and so e2fsck had to fall back to using the backup block group
descriptors.  The summary information in the backup block group
descriptors is not backed up, for speed/performance reasons.  This is
not a problem, since that information can always be regenerated
trivially from the pass 5 information.  That's what all of "free
inodes/blocks/directories count wrong" messages in your log were all
about.

The 39754 block used (0%) is just because you were using -n and the
summary information is calculated from the filesystem summary data,
not from the pass5 count information (which was thrown away since you
were running -n and thus declined to fix the results).

I can imagine accepting a patch which sets a flag if any discrepancies
found in pass 5 are not fixed, and then if the summary information is
requested, to print a warning message indicating that the summary
information may not be correct.  But no, it's not worth it to take
into account changes that -n might make if the user had said "yes".
The complexities that would entail would be huge, and in fact as it is
e2fsck -n does give a fairly accurate report of what what is wrong
with the filesystem.  Is it 100% accurate?  No, but that was never the
goal of e2fsck -n.  If you want that, then use a dm-snapshot, and run
e2fsck on the snapshot....

						- Ted
