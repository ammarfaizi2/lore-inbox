Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbRDWWMt>; Mon, 23 Apr 2001 18:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbRDWWLE>; Mon, 23 Apr 2001 18:11:04 -0400
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:10500 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S132359AbRDWWKn>; Mon, 23 Apr 2001 18:10:43 -0400
Date: Mon, 23 Apr 2001 23:42:39 +0200
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: MO drives (2048 byte block vfat fs) in lk 2.4
Message-ID: <20010423234239.A3590@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Douglas Gilbert <dougg@torque.net>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <3AE39A86.8AB3FB30@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <3AE39A86.8AB3FB30@torque.net>; from dougg@torque.net on Sun, Apr 22, 2001 at 10:59:18PM -0400
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 10:59:18PM -0400, Douglas Gilbert wrote:
> One error report stated that a MO drive with a vfat
> fs based on 2048 byte sectors can be mounted and read

Read? I don't think so. bread, yes, but read follows a NULL pointer and
was never seen again.

> but any significant write causes a system lockup. I
> have been able to replicate this behaviour. Luckily
> Alt-SysRq-P did work. Pressing this sequence multiple
> times gave similar addresses. Rebooting the machine
> and rerunning the experiment multiple time gave 
> addresses in the same area.

bigblock_fat_bread() in fs/fat/buffer.c kmalloc()s 2k dummy bhs for each
512 byte buffer but only partly initialise them. This works as long as those
bogus bhs don't leave the fat realm. Unfortunately, generic_file_write and
friends call into the generic block layer that wants to do such evil things
on bhs as using their wait_queues or checking their state for BH_Locked.
None of which are initialised, and while I haven't checked in detail,
certainly lead the way into deadlock country. But even if these minor
disturbances magically didn't screw you yet, the fat layer will hand out
a buffer address calculated for 512 byte buffers for your 2k buffer, and your
data goes bye, bye.

The preferred fix seems to be to teach the loop device about reblocking and
rip all of the bigblock support from fat. I've spent this weekend to cure
my utter and complete ignorance of the blkdev layer, in order to be able to
implement a working set up at least. Please allow me another couple of days
to spare a little hacking time. I'll take care of the issue. Promised.

Regards,

Daniel.

-- 
	GNU/Linux Audio Mechanics - http://www.glame.de
	      Cutting Edge Office - http://www.c10a02.de
	      GPG Key ID 89BF7E2B - http://www.keyserver.net
