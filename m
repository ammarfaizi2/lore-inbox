Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbSLFAwr>; Thu, 5 Dec 2002 19:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbSLFAwr>; Thu, 5 Dec 2002 19:52:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:36517 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267467AbSLFAwq>;
	Thu, 5 Dec 2002 19:52:46 -0500
Message-ID: <3DEFF69F.481AB823@digeo.com>
Date: Thu, 05 Dec 2002 17:00:15 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Norman Gaywood <norm@turing.une.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
References: <20021206111326.B7232@turing.une.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 01:00:15.0484 (UTC) FILETIME=[D66CD3C0:01C29CC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Gaywood wrote:
> 
> I think I have a trigger for a VM bug in the RH kernel-bigmem-2.4.18-18
> 
> 16GB
> ...
>    tar cf /dev/tape .
> 

This machine will die due to buffer_heads which are attached
to highmem pagecache, and due to inodes which are pinned by
highmem pagecache.

> ...
> while [ `expr $COUNT - 1` != 0 ]
> do
>    date
>    # 2000 by 1_000_000 seems to be a 1.8G process
>    perl -e '$i=2000;while ($i--){ $a[$i]="x"x1_000_000; }' &
> ...

This will evict the highmem pagecache.  That frees the buffer_heads
and unpins the inodes.

> So what do I do now?

I guess talk to Red Hat.  These are well-known problems and there
should be fixes for them in a "bigmem" kernel.

Otherwise, the -aa kernels have patches to address these problems.
One option would be to roll your own kernel, based on a kernel.org
kernel and a matching patch from
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/

> ...
> Anyone have some patches for me to
> try that won't take me too far from the RH 8.0 base system.

Hard.  The relevant patches are:

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/05_vm_16_active_free_zone_bhs-1
and
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/10_inode-highmem-2

The first one will not come vaguely close to applying to an
RH 2.4.18 kernel.

The second one may well apply, and will probably fix the problem.
