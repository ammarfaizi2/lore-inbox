Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268348AbTBNJsb>; Fri, 14 Feb 2003 04:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268361AbTBNJsb>; Fri, 14 Feb 2003 04:48:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:21456 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268348AbTBNJrv>;
	Fri, 14 Feb 2003 04:47:51 -0500
Date: Fri, 14 Feb 2003 01:58:02 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.60-mm2
Message-Id: <20030214015802.66800166.akpm@digeo.com>
In-Reply-To: <20030214093856.GC13845@codemonkey.org.uk>
References: <20030214013144.2d94a9c5.akpm@digeo.com>
	<20030214093856.GC13845@codemonkey.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2003 09:57:38.0458 (UTC) FILETIME=[81A6B7A0:01C2D40F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Fri, Feb 14, 2003 at 01:31:44AM -0800, Andrew Morton wrote:
> 
>  > . Considerable poking at the NFS MAP_SHARED OOM lockup.  It is limping
>  >   along now, but writeout bandwidth is poor and it is still struggling. 
>  >   Needs work.
>  > 
>  > . There's a one-liner which removes an O(n^2) search in the NFS writeback
>  >   path.  It increases writeout bandwidth by 4x and decreases CPU load from
>  >   100% to 3%.  Needs work.
> 
> I'm puzzled that you've had NFS stable enough to test these.

This was just writing out a single 400 megabyte file with `dd'.  I didn't try
anything fancier.

> How much testing has this stuff had? Here 2.5.60+bk clients fall over under
> moderate NFS load. (And go splat quickly under high load).
> 
> Trying to run things like dbench causes lockups, fsx/fstress made it
> reboot, plus the odd 'cheating' errors reported yesterday.

I have not tried pushing NFS with complex access patterns recently.


BTW, there's a little patch in there from Trond which I forgot to mention: it
implements sendfile for NFS, so loop-on-NFS works again.


But we have a refcounting bug somewhere:

# mount server:/dir /mnt/point
# losetup /dev/loop0 /mnt/point/file
# mount /dev/loop0 /mnt/loop0
# umount /mnt/loop0
# losetup -d /dev/loop0 
# umount /mnt/point
umount: /mnt/point: device is busy

