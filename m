Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbULUXOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbULUXOB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbULUXOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:14:01 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:62396 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261890AbULUXN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:13:59 -0500
Date: Wed, 22 Dec 2004 10:13:37 +1100
From: Nathan Scott <nathans@sgi.com>
To: Joerg Sommrey <jo175@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.6.9-ac16: xfs, dm and md may be involved
Message-ID: <20041222101337.C674830@wobbly.melbourne.sgi.com>
References: <20041221185754.GA28356@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041221185754.GA28356@sommrey.de>; from jo175@sommrey.de on Tue, Dec 21, 2004 at 07:57:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 07:57:54PM +0100, Joerg Sommrey wrote:
> Hello,
> 
> last night my box died with a kernel oops.  There was a backup
> running at that time. The setup:
> - 2 SATA disks + 1 SCSI disk
> - SATA partitions build up md-raid-arrays (level 0 and 1)
> - md-raid-devices and SCSI partitions are physical volumes for dm
> - dm logical volumes are used for xfs filesystems
> - backup is done on dm-snapshots of those filesystems
> ...
> syslog:
> Dec 21 03:28:09 bear kernel: Unable to handle kernel paging request at virtual address 6b6b6b73

Hmm, looks like a memory poisoning pattern there.

> Dec 21 03:28:10 bear kernel: EIP:    0060:[__origin_write+112/608]    Tainted: P   VLI
> Dec 21 03:28:10 bear kernel: EFLAGS: 00010217   (2.6.9-ac16) 
> Dec 21 03:28:10 bear kernel: EIP is at __origin_write+0x70/0x260
> Dec 21 03:28:10 bear kernel: eax: 6b6b6b4b   ebx: ccd2f888   ecx: f0f55190   edx: ffffffff
> Dec 21 03:28:10 bear kernel: esi: 6b6b6b4b   edi: dc1eebd8   ebp: c4593920   esp: f7487d74
> Dec 21 03:28:10 bear kernel: ds: 007b   es: 007b   ss: 0068
> Dec 21 03:28:10 bear kernel: Process xfsbufd (pid: 849, threadinfo=f7486000 task=c1b9e070)

>From XFS's point of view, we are in the middle of submitting
a delayed metadata write down to the driver.  Something seems
to have gone wrong inside "__origin_write" (dm-snap.c), which
looks like its doing snapshot stuff inside device mapper?

cheers.

-- 
Nathan
