Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWCASHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWCASHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWCASHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:07:17 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:53188 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S932445AbWCASHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:07:16 -0500
Date: Wed, 1 Mar 2006 13:07:14 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Andi Kleen <ak@suse.de>
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: AMD64 X2 lost ticks on PM timer
Message-ID: <20060301180714.GD20092@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200602280022.40769.darkray@ic3man.com> <200603011556.10139.ak@suse.de> <20060301154313.GC20092@ti64.telemetry-investments.com> <200603011647.34516.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603011647.34516.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 04:47:33PM +0100, Andi Kleen wrote:
> > My guess is the sata_nv driver, as it happens during heavy local file read.
> > The machines all have 2-4 SATA WD Raptors connected to the mobo.
> 
> Are you accessing all these disks in parallel with that cpio? If 
> yes could you try it with only a single disk? 
 
Yes, all of the hosts are LVM2 over MD RAID1.  The PostgreSQL 
LV has striping over the two MD RAID1 PVs.

> My box only has a single SATA disk. Maybe there is some 
> corner case in that SATA driver that leaks interrupt state
> and it's only turned on later by idle or softirq then.

Good call!  Stressing one disk results in no lost ticks.

I stuck a spare disk in one of the workstations that has its system
partitions on Ext3/LVM2/MD-RAID1, and then copied the 9GB /usr to
a raw Ext3 partition on the new disk:

    find usr | cpio -pdum /opt

That resulted in:

Mar  1 11:39:27 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:39:41 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:40:37 ti94 kernel: time.c: Lost 3 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:40:40 ti94 kernel: time.c: Lost 6 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:40:41 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:40:42 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:40:50 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:40:54 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:40:57 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:01 ti94 kernel: time.c: Lost 2 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:06 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:12 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:17 ti94 kernel: time.c: Lost 2 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:21 ti94 kernel: time.c: Lost 3 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:27 ti94 kernel: time.c: Lost 4 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:27 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:29 ti94 kernel: time.c: Lost 3 timer tick(s)! rip _spin_unlock_irqrestore+0xb/0xd)
Mar  1 11:41:42 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:43 ti94 kernel: time.c: Lost 2 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:43 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:46 ti94 kernel: time.c: Lost 2 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:55 ti94 kernel: time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
Mar  1 11:41:55 ti94 kernel: time.c: Lost 2 timer tick(s)! rip default_idle+0x37/0x7a)
Mar  1 11:41:57 ti94 kernel: time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)
Mar  1 11:41:57 ti94 kernel: time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)
Mar  1 11:42:00 ti94 kernel: time.c: Lost 2 timer tick(s)! rip default_idle+0x37/0x7a)
Mar  1 11:42:00 ti94 kernel: time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)
Mar  1 11:42:00 ti94 kernel: time.c: Lost 2 timer tick(s)! rip default_idle+0x37/0x7a)
...

After a umount/mount on /opt, I did

   find /opt | cpio -o > /dev/null

and got no lost ticks in the log.  My "nice --10 ./trtc" gave me:

rugolsky@ti94: tail +10 one-disk | grep -v '=125'
1141232738:578610: rtc 448 int 124 0 (=124)
1141232807:67036: rtc 464 int 0 124 (=124)
1141232875:557669: rtc 448 int 0 124 (=124)

I converted the raw EXT3 partition to a degraded MD RAID1, and again
got no lost ticks.  Then I created a PV/VG/LV/Ext3 on top of the degraded MD RAID1,
populated it, and re-read it; once again, there were no lost ticks on the
single-disk read.

Time to instrument sata_nv, I suppose.  Many thanks for helping to narrow this
down.

	-Bill
