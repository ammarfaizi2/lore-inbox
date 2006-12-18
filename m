Return-Path: <linux-kernel-owner+w=401wt.eu-S1754707AbWLRWgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbWLRWgt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbWLRWgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:36:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36023 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754707AbWLRWgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:36:48 -0500
Date: Tue, 19 Dec 2006 09:36:37 +1100
From: David Chinner <dgc@sgi.com>
To: Haar =?iso-8859-1?Q?J=E1nos?= <djani22@netcenter.hu>
Cc: David Chinner <dgc@sgi.com>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: xfslogd-spinlock bug?
Message-ID: <20061218223637.GP44411608@melbourne.sgi.com>
References: <003701c71d78$33ed28d0$0400a8c0@dcccs> <Pine.LNX.4.64.0612120932220.19050@p34.internal.lan> <00ab01c71e53$942af2f0$0400a8c0@dcccs> <000d01c72127$3d7509b0$0400a8c0@dcccs> <20061217224457.GN33919298@melbourne.sgi.com> <026501c72237$0464f7a0$0400a8c0@dcccs> <20061218062444.GH44411608@melbourne.sgi.com> <027b01c7227d$0e26d1f0$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <027b01c7227d$0e26d1f0$0400a8c0@dcccs>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 09:17:50AM +0100, Haar János wrote:
> From: "David Chinner" <dgc@sgi.com>
> > > The NBD serves through eth1, and it is on the CPU3, but the ide0 is on
> the
> > > CPU0.
> >
> > I'd say your NBD based XFS filesystem is having trouble.
> >
> > > > Are you using XFS on a NBD?
> > >
> > > Yes, on the 3. source.
> >
> > Ok, I've never heard of a problem like this before and you are doing
> > something that very few ppl are doing (i.e. XFS on NBD). I'd start
> > Hence  I'd start by suspecting a bug in the NBD driver.
> 
> Ok, if you have right, this also can be in context with the following issue:
> 
> http://download.netcenter.hu/bughunt/20061217/messages.txt   (10KB)

Which appears to be a crash in wake_up_process() when doing memory
reclaim (waking the xfsbufd).

> > > > > Dec 16 12:08:36 dy-base RSP: 0018:ffff81011fdedbc0  EFLAGS: 00010002
> > > > > Dec 16 12:08:36 dy-base RAX: 0000000000000033 RBX: 6b6b6b6b6b6b6b6b
> RCX:
> > > >                                                      ^^^^^^^^^^^^^^^^
> > > > Anyone recognise that pattern?

Ok, I've found this pattern:

#define POISON_FREE 0x6b

Can you confirm that you are running with CONFIG_DEBUG_SLAB=y?

If so, we have a use after free occurring here and it would also
explain why no-one has reported it before.

FWIW, can you turn on CONFIG_XFS_DEBUG=y and see if that triggers
a different bug check prior to the above dump?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
