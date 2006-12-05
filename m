Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967995AbWLEBda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967995AbWLEBda (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 20:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967999AbWLEBda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 20:33:30 -0500
Received: from ns.suse.de ([195.135.220.2]:49367 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967995AbWLEBd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 20:33:29 -0500
From: Neil Brown <neilb@suse.de>
To: Jiri Kosina <jikos@jikos.cz>
Date: Tue, 5 Dec 2006 12:33:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17780.52337.767875.963882@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm2
In-Reply-To: message from Jiri Kosina on Wednesday November 29
References: <20061128020246.47e481eb.akpm@osdl.org>
	<Pine.LNX.4.64.0611290147400.28502@twin.jikos.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 29, jikos@jikos.cz wrote:
> On Tue, 28 Nov 2006, Andrew Morton wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/
> 
> md-change-lifetime-rules-for-md-devices.patch gives me the following early 
> during boot (first WARNING() inside __mutex_lock_slowpath(), then BUG at 
> __mutex_lock_slowpath(), just after that slab corruption).
> 
> When I revert md-change-lifetime-rules-for-md-devices.patch, everything 
> seems to go fine (this machine does use neither LVM nor RAID, but the 
> kernel has DM compiled in).
> 
> Config is at http://www.jikos.cz/jikos/junk/.config_md
> 
>  WARNING at kernel/mutex.c:132 __mutex_lock_common()
>   [<c0103d70>] dump_trace+0x68/0x1b5
>   [<c0103ed5>] show_trace_log_lvl+0x18/0x2c
>   [<c010445b>] show_trace+0xf/0x11
>   [<c01044cd>] dump_stack+0x12/0x14
>   [<c036e6ba>] __mutex_lock_slowpath+0xa1/0x213
>   [<c0197c7d>] create_dir+0x24/0x1ba
>   [<c0198317>] sysfs_create_dir+0x45/0x5f
>   [<c01ed1fb>] kobject_add+0xce/0x185
>   [<c01ed3c3>] kobject_register+0x19/0x30
>   [<c02e10c6>] md_probe+0x11a/0x124

Very odd.

md_probe is registering a kobject presenting md specific stuff and
that creates a directory called 'md' inside the block device. e.g.
   /sys/block/md0/md
The inode for /sys/block/md0 appear to be non-existent at this point,
which as you are seeing poisoned memory where the inode should be.
This shouldn't happen and I cannot reproduce it.

I notice it says:
                     |
                     v
>  090: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  Single bit error detected. Probably bad RAM.
>  Run memtest86+ or a similar memory test tool.

Have you tried running memtest86 ??

NeilBrown
