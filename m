Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271701AbTHMQx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275254AbTHMQx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:53:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28681 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S271701AbTHMQx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:53:27 -0400
Date: Wed, 13 Aug 2003 17:53:11 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Paul Dickson <dickson@permanentmail.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deep call trace from PCMCIA CF eject
Message-ID: <20030813175311.B20676@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Dickson <dickson@permanentmail.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
References: <20030813072456.35d62460.dickson@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030813072456.35d62460.dickson@permanentmail.com>; from dickson@permanentmail.com on Wed, Aug 13, 2003 at 07:24:56AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 07:24:56AM -0700, Paul Dickson wrote:
> Besides the minor concern about the trace itself, a bigger concern on my
> part is how deep the call trace is (60+ levels).  How's it doing for stack
> space?

Not all those functions listed were involved - never, ever believe an
x86 call trace as being the absolute truth. 8)

The real calltrace is much closer to:

> Aug 13 06:57:59 violet cardmgr[1559]: executing: './ide check hde'
> Aug 13 06:58:00 violet cardmgr[1559]: executing: './ide stop hde'
> Aug 13 06:58:01 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug 13 06:58:01 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
> Aug 13 06:58:01 violet kernel: hde: Write Cache FAILED Flushing!
> Aug 13 06:58:01 violet cardmgr[1559]: + /dev/hde1 umounted
> Aug 13 06:58:01 violet kernel: updfstab: numerical sysctl 1 23 is obsolete.
> Aug 13 06:58:02 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug 13 06:58:02 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
> Aug 13 06:58:02 violet kernel: hde: Write Cache FAILED Flushing!
> Aug 13 06:58:02 violet kernel: Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
> Aug 13 06:58:02 violet kernel: Call Trace:
> Aug 13 06:58:02 violet kernel:  [<c011bc81>] __might_sleep+0x61/0x80
> Aug 13 06:58:02 violet kernel:  [<c02376dc>] unlink+0x3c/0xa0
> Aug 13 06:58:02 violet kernel:  [<c0267a32>] kobj_unmap+0x62/0x110
> Aug 13 06:58:02 violet kernel:  [<c026cf62>] blk_unregister_region+0x22/0x30
> Aug 13 06:58:02 violet kernel:  [<c0287eb3>] ide_unregister+0x2f3/0x8d0
> Aug 13 06:58:02 violet kernel:  [<d096cba4>] ide_release+0x94/0x130 [ide_cs]
> Aug 13 06:58:02 violet kernel:  [<d096c1fc>] ide_detach+0xac/0xc0 [ide_cs]
> Aug 13 06:58:02 violet kernel:  [<d09727e2>] unbind_request+0xd2/0xe0 [ds]
> Aug 13 06:58:02 violet kernel:  [<d0972fa1>] ds_ioctl+0x441/0x770 [ds]
> Aug 13 06:58:02 violet kernel:  [<c01652b0>] sys_ioctl+0x100/0x290
> Aug 13 06:58:02 violet kernel:  [<c010b1f9>] sysenter_past_esp+0x52/0x71

The problem is IDE - ide_unregister() does the following:

        spin_lock_irq(&ide_lock);
...
        blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);

Since blk_unregister_region is sleepy, and sleeping with a spinlock
held is a big NO NO, it's an IDE problem not a PCMCIA problem.  It
should be calling blk_unregister_region with a spinlock held.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

