Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271717AbRIJVEe>; Mon, 10 Sep 2001 17:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271718AbRIJVEY>; Mon, 10 Sep 2001 17:04:24 -0400
Received: from mout1.freenet.de ([194.97.50.132]:7580 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S271717AbRIJVEI>;
	Mon, 10 Sep 2001 17:04:08 -0400
Date: Mon, 10 Sep 2001 23:03:27 +0200
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New SCSI subsystem in 2.4, and scsi idle patch
Message-ID: <20010910230327.B690@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Phillip Susi <psusi@cfl.rr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200109092229.f89MT3M07627@smtp-server2.tampabay.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <200109092229.f89MT3M07627@smtp-server2.tampabay.rr.com>; from psusi@cfl.rr.com on Sun, Sep 09, 2001 at 06:21:13PM +0000
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 06:21:13PM +0000, Phillip Susi wrote:
> I'm trying to get my 2.4.9 system to spin down my scsi disk(s) when idle.  
> Aparently, this is supported on IDE disks, but not SCSI.  I found an old 
> patch to add support for this to the 2.0.34 kernel, and have been trying to 
> use it as a guide to fixing the 2.4.9 kernel.  It seems that major changes 
> have been done to the scsi layer, so I'm a little confused.  Any help is 
> appreciated.  Here is my current status:

I had played around with scsi spinup a couple of months ago but then had to
give away my scsi system, so the patch remained unfinished. Let me dig in the
dust...

Trying to trap NOT_READY was fine, but I believe the tricky part was one
should avoid to allocate a new request for the spinup command. The number
of requests in the queue is limited, so an additional request issued from
an incomplete request might deadlock. So you have to piggyback the spinup
on the original command, catch it when it completes, and re-issue the
command. Some of the error handlers do similar stuff, but clobber a few
entries from the original command. I therefore added new backup fields to
Scsi_Cmnd in scsi.h. The other changes were local to scsi_lib.c, IIRC.

> P.S.  I'd like to use a user mode daemon to detect disk idle, and issue the 
> existing ioctl code to spin the disk down, and rely on the kernel to spin it 
> back up as needed.

As already suggested elsewhere in this thread, please have a look at noflushd
(http://noflushd.sourceforge.net). It implements all the user level features
you describe. The scsi code is disabled by default, however, because of the
lack of spinup support in the standard kernel. The lastest scsi spinup patch
shipped with noflushd applies to kernel 2.3.28. If you cook up a patch that
works with recent kernels, please let me know!

Regards,

Daniel.

-- 
	GNU/Linux Audio Mechanics - http://www.glame.de
	      Cutting Edge Office - http://www.c10a02.de
	      GPG Key ID 89BF7E2B - http://www.keyserver.net
