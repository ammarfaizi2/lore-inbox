Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264517AbTKNGKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 01:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbTKNGKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 01:10:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13237 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264513AbTKNGKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 01:10:47 -0500
Date: Fri, 14 Nov 2003 06:10:45 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Daniel Pittman <daniel@rimspace.net>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
Message-ID: <20031114061045.GJ24159@parcelfarce.linux.theplanet.co.uk>
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au> <87smkrecyw.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87smkrecyw.fsf@enki.rimspace.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 04:27:51PM +1100, Daniel Pittman wrote:
> How about assigning the partition space above 
> 
>   9,0 => md0
>   9,1 => md1
>   ...
>   9,257 => md0p1
>   9,258 => md0p2
>   ...
>   9,320 => md1p1
> 
> That should be sensibly backward compatible, I think, and still allow
> all the MD devices to be partitioned.

Kernel should be mostly OK with partitions having device numbers far from
that of entire disk.  However, mostly != entirely and I can't tell right
now what amount of work would that take.  One obvious problem is boot-time
stuff - code parses root= and its ilk does so by digging in sysfs and that
definitely will need changes.  There might be more.  I'm more or less sure
than all common codepaths are clean and will be OK with having probe do
whatever it wants, but I wouldn't bet a dime on the ioctl side/procfs/sysfs/
devfs.

I would *really* expect breakage in userland, though, and that might be a
killer.  Up until now, we had all partitions getting device numbers in a range
that included entire disk and did not include any device numbers of anything
unrelated.

Folks, we are in 2.6.0-test freeze.  Neil's #3 fits entirely in md.c, is small
and has minimal damage potential for userland code.  Playing games with the
scheme above, nice as it might be, is *not* safe for now and it's not even
safe for 2.6.early.
