Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267841AbTBVHyC>; Sat, 22 Feb 2003 02:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267842AbTBVHyC>; Sat, 22 Feb 2003 02:54:02 -0500
Received: from packet.digeo.com ([12.110.80.53]:4491 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267841AbTBVHyB>;
	Sat, 22 Feb 2003 02:54:01 -0500
Date: Sat, 22 Feb 2003 00:04:10 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange performance change 59 -> 61/62
Message-Id: <20030222000410.11a46e03.akpm@digeo.com>
In-Reply-To: <22560000.1045899976@[10.10.2.4]>
References: <32720000.1045671824@[10.10.2.4]>
	<20030219101957.05088aa1.akpm@digeo.com>
	<17280000.1045811967@[10.10.2.4]>
	<17930000.1045812486@[10.10.2.4]>
	<20030220234522.185f3f6c.akpm@digeo.com>
	<11870000.1045848448@[10.10.2.4]>
	<20030221122024.040055a0.akpm@digeo.com>
	<22560000.1045899976@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Feb 2003 08:04:00.0322 (UTC) FILETIME=[F507BA20:01C2DA48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > mark_inode_dirty() tends to be called _very_ frequently.  Too frequently.
> > 
> > Could you try remounting all filesystems noatime with
> > 
> > 	mount /mnt/point -o remount,noatime
> > 
> > and the below patch will prevent us calling the barrier-happy
> > current_kernel_time() for noatime mounts.
> 
> Cool, that works nicely - thanks.
> 
> 2.5.59-mjb6:             84 __mark_inode_dirty
> 2.5.61-mjb1:            594 __mark_inode_dirty
> 2.5.61-mjb1-no_mb:       74 __mark_inode_dirty
> 2.5.61-mjb1-noatime:     65 __mark_inode_dirty
> 

OK.  We used to only run mark_inode_dirty() for atime updates just when it
had actually changed.  ie: once per second.  But for reasons which remain
obscure that was taken out.

This probably explains your ext3 woes.  Poor old ext3 has to do a ton of work
in ext3_mark_inode_dirty(), yet on 99% of the calls, nothing has even
changed.  Which is why I suggested that you retest ext3 with noatime.

I shall fix it up.

