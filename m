Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbUATN2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUATN2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:28:12 -0500
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:22144 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S265504AbUATN2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:28:09 -0500
From: jlnance@unity.ncsu.edu
Date: Tue, 20 Jan 2004 08:28:03 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org, cmp@synopsys.com
Subject: Re: Awful NFS performance with attached test program
Message-ID: <20040120132803.GA2830@ncsu.edu>
References: <20040119211649.GA20200@ncsu.edu> <1074549226.1560.59.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074549226.1560.59.camel@nidelv.trondhjem.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 04:53:46PM -0500, Trond Myklebust wrote:

> So you are surprised that writing the same dataset by putting one
> integer onto each kernel page takes much more time than placing the
> entire dataset onto just a few kernel pages? 'cos I'm not...

I must admit that I am.  I could see that it would take somewhat longer
because a logicial way for the kernel to implement this would be as a
read-modify-write operation.  So a 2X slowdown would not supprise me.
But the slowdown is more than 10X, and that does.

Also, for what its worth, Solaris performs like this:

    flame> ./a.out 
    Creating file: 3.886 seconds
    Updating file: 1.259 seconds

While Linux performs like this:

    jesse> ./a.out
    Creating file: 43.042 seconds
    Updating file: 555.796 seconds


Both machines are writing to the same directory (not at the same time) on
an x86_64 Linux server running a kernel which identifies itself as
2.4.21-4.ELsmp.  The network connection between the Solaris machine and
the NFS server actually seems to be slightly slower than that between
the Linux machine and the NFS server:

sledge> ping flame
PING flame.synopsys.com (10.48.2.191) 56(84) bytes of data.
64 bytes from flame.synopsys.com (10.48.2.191): icmp_seq=0 ttl=255 time=0.174 ms
64 bytes from flame.synopsys.com (10.48.2.191): icmp_seq=1 ttl=255 time=0.171 ms
64 bytes from flame.synopsys.com (10.48.2.191): icmp_seq=2 ttl=255 time=0.168 ms

sledge> ping jesse
PING jesse.synopsys.com (10.48.2.120) 56(84) bytes of data.
64 bytes from jesse.synopsys.com (10.48.2.120): icmp_seq=0 ttl=64 time=0.115 ms
64 bytes from jesse.synopsys.com (10.48.2.120): icmp_seq=1 ttl=64 time=0.113 ms
64 bytes from jesse.synopsys.com (10.48.2.120): icmp_seq=2 ttl=64 time=0.104 ms

so I dont think the descrepency is due to network problems.

I should note that Solaris takes 135 seconds to close the file while Linux
takes almost no time.  This probably means that Solaris has postponed some
of the work it needs to do until close time.  However, even with the 135
seconds factored in, Solaris is still killing us.

I would like to try this with a 2.6 kernel, but that is difficult.  Ill
see what I can put together though.

> Have a look at the nfsstat output and you'll see what I mean. Doing the
> former will necessarily end up generating *a lot* more NFS write
> requests.

Thanks for the info.  I didnt know about nfsstat.  It looks like a useful
utility.

Thanks,

Jim
