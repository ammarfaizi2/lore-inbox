Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267222AbUBMVl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUBMVl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:41:29 -0500
Received: from intra.cyclades.com ([64.186.161.6]:2253 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S267222AbUBMVlX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:41:23 -0500
Date: Fri, 13 Feb 2004 19:23:56 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: userland starvation with 2.4.25-rc2
In-Reply-To: <1076705542.24165.198.camel@heat>
Message-ID: <Pine.LNX.4.58L.0402131903260.6713@logos.cnet>
References: <1076705542.24165.198.camel@heat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Feb 2004, Jeffrey W. Baker wrote:

> I have this machine with 8GB main memory, two CPUs, two internal IDE
> disks (on AMD 8111), and two external SCSI disks (on AIC79xx).  The
> kernel is 2.4.25-rc2 built for ia32, with no aditional patches.  The
> filesystem on the IDE disk is ext2 and the file system on the SCSI disks
> is XFS.  I am trying to load the SCSI disk by doing in parallel:
>
> 1) bonnie++ -f
> 2) find /scsivol -type f | xargs cat > /dev/null
> 3) untar millions of files from tarball on IDE disk to SCSI disk
> 4) copy postgresql databases (data, xlogs on SCSI) using pg_dump | psql
>
> The odd behavior I am observing is that userland can be virtually
> starved for minutes at a stretch.  I have plotted the I/O and CPU load
> time series here, if you care to see it graphically:
>
> http://saturn5.com/~jwb/prime-starve.png
>
> The upper graph is the CPU load, the lower graph is the I/O load.  As
> you can see, at certain points the kernel will take all available CPU,
> and I/O will slow to nearly a halt.  The longest period seen in this
> graph is 140 seconds, during which certain interactive user processes
> made progress (iostat -k 10, watch df -ha) while others did not (top,
> watch "dmesg | tail").  Obviously very little of the I/O made progress.
>
> I wonder if there is a /proc tweak I can make to avoid this behavior?

Hi Jeffrey,

Boot with profile=2, run your tests, then do:

readprofile -m /path/to/System.map -v | sort -nr +2 | head -50

So we can see what is using the CPU time in the kernel.

I'm not sure if the IDE controller can do highmem IO. If it can't, then
the kernel has to copy data to lower 1GB to do IO, which is nasty.

The SCSI stack has known scalability problems, but those shouldnt be
hurting that much as far as I know. Well, the readprofile will show us.

Try 2.6.3-rc, too.
