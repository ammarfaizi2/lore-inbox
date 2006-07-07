Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWGGJfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWGGJfu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWGGJfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:35:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932089AbWGGJft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:35:49 -0400
Date: Fri, 7 Jul 2006 02:35:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, neilb@suse.de
Subject: Re: 2.6.17-mm6
Message-Id: <20060707023518.f621bcf2.akpm@osdl.org>
In-Reply-To: <44AE268F.7080409@reub.net>
References: <20060703030355.420c7155.akpm@osdl.org>
	<44AE268F.7080409@reub.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2006 21:17:03 +1200
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> 
> 
> On 3/07/2006 10:03 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> > 
> > 
> > - A major update to the e1000 driver.
> > 
> > - 1394 updates
> 
> This release has been working quite well after some initial hiccups (see -mm 
> hotfix), but a couple of hours ago another bad thing (tm) happened.
> 
> At the time I was moving 100G of data from one partition on a non-raid partition 
> to a new RAID-1 md that I had created earlier.  Both are ext3 partitions.
> 
> The word "barrier" of course comes to mind again, I'm not sure NeilB is the 
> culprit this time either but I've cc'd him in just in case.
> 
> The file copy went on happily for quite a while (maybe 10 mins or so) under very 
> high IO load before blowing up as below.  The terminal was spewing out constant 
> traces but hopefully the right ones are here as these are the first few (if not, 
> I have copied a bit more).
> 

Yes, the very first oops is by far the most important to capture.

You can add pause_on_oops=100000 to the kernel boot command line to make
the machine freeze after outputting the first oops.  That'll certainly
prevent the oops messages from getting to the log files, but it will also
prevent it from scolling away or swamping your log device.


> sh-3.1# mv /store-old/* /store/
> Unable to handle kernel paging request at ffff81043e345490 RIP:
>   [<ffffffff802620f2>] memcpy+0x12/0xb0
> PGD 8063 PUD 0
> Oops: 0000 [1] SMP
> last sysfs file: /kernel/uevent_seqnum
> CPU 1
> Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
> Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
> RIP: 0010:[<ffffffff802620f2>]  [<ffffffff802620f2>] memcpy+0x12/0xb0
> RSP: 0018:ffff81003ed31828  EFLAGS: 00010002
> RAX: ffff810001faec18 RBX: 0000000000000010 RCX: 0000000000000001
> RDX: 0000000000000080 RSI: ffff81043e345490 RDI: ffff810001faec18
> RBP: ffff81003ed31898 R08: ffff81003f66a800 R09: 0000000000000000
> R10: ffff810029b364b0 R11: 0000000000000000 R12: ffff810001faec00
> R13: ffff81003f6ff140 R14: ffff81003f6ea240 R15: 0000000000000010
> FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: ffff81043e345490 CR3: 000000003dc32000 CR4: 00000000000006e0
> Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
> Stack:  0000000000000010 ffffffff8025e9f0 ffff81003f66a800 0001120000000000
>   0000000000011200 000112003f650080 ffff81003eca39f0 ffff81003ed318c8
>   ffff81003ed31898 0000000000000246 ffff81003f6ff140 0000000000011200
> Call Trace:
>   [<ffffffff8025e9f0>] cache_alloc_refill+0xc9/0x538
>   [<ffffffff802b96c6>] __kmalloc+0x86/0x96
>   [<ffffffff802ae460>] __kzalloc+0xf/0x2f
>   [<ffffffff8041d598>] r1bio_pool_alloc+0x21/0x3a
>   [<ffffffff802230e4>] mempool_alloc+0x44/0xfb

The core slab data structures were wrecked.  For kmalloc(), no less. 
Something secretly destroyed your kernel, and it could be anything.  Nice.

