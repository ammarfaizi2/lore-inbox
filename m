Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268298AbTBMVGa>; Thu, 13 Feb 2003 16:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268299AbTBMVGa>; Thu, 13 Feb 2003 16:06:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:57256 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268298AbTBMVFR>;
	Thu, 13 Feb 2003 16:05:17 -0500
Date: Thu, 13 Feb 2003 13:13:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 and current bk oops in file_ra_state_init
Message-Id: <20030213131344.086e154e.akpm@digeo.com>
In-Reply-To: <20030213120445.A15070@beaverton.ibm.com>
References: <20030213120445.A15070@beaverton.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2003 21:15:02.0683 (UTC) FILETIME=[F91586B0:01C2D3A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield <patmans@us.ibm.com> wrote:
>
> Hi -
> 
> Using the scsi-misc-2.5 (2.5.60 plus a few changes), or the current
> bk (as of this morning) I'm hitting an oops in file_ra_state_init.

Oh lovely.  Looks like the blockdev/gendisk refcounting has gone wrong and a
request queue was freed under your app's feet.

> I was trying to run a bunch of raw IO's (/dev/raw/rawN) at once to several
> (well 25) disks, trying to maximize IO's/second by repeatedly reading the
> same block of a disk, and got the following oops. I hit this both on a
> netfinity and NUMAQ box.

Was this test frequently opening and closing device nodes, or does it just
open them once and hold them?

Can you please prepare a testcase which I can use to reproduce this?

Be aware that there are some fairly significant problems with direct I/O at
present - direct-io can cause multiple outstanding requests against the same
sector, and that makes the IO scheduler keel over.  But it would be strange
for that to be related to this failure.

BTW, you don't need to use the raw driver any more.  Just open /dev/sda1 with
O_DIRECT.  In fact, I'd be interested in seeing if this change makes the oops
go away.

Thanks.
