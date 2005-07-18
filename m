Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVGRIxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVGRIxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 04:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVGRIxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 04:53:41 -0400
Received: from totor.bouissou.net ([82.67.27.165]:10186 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261309AbVGRIxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 04:53:41 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: evms-devel@lists.sourceforge.net
Subject: Re: MD sequential / parallel resync issue with DM devices
Date: Mon, 18 Jul 2005 10:53:37 +0200
User-Agent: KMail/1.7.2
References: <1121660733.3462.5.camel@fortocent.comodo.net> <1121674883.8392.22.camel@fortocent.comodo.net> <200507181037.01855@totor.bouissou.net>
In-Reply-To: <200507181037.01855@totor.bouissou.net>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, neilb@cse.unsw.edu.au
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507181053.37538@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 18 Juillet 2005 10:37, I wrote (on the evms-devel ML) :
>
> In kernel 2.4, MD thinks that all DM devices are "on the same physical
> disk" (and issues a dummy warning about this), and it resyncs them
> sequentially, which may or may not be optimal, but at least doesn't cause
> any problem.
>
> In kernel 2.6, MD does not issue any such warning, so it probably thinks
> that none of the DM devices are on the same physical disks (even though
> they may be), that's probably why it resyncs all of them in parallel.
>
> Actually, performing parallel resync is a good idea when RAID sets members
> reside on separate disks, but of course it is a very bad idea when they are
> on the same disks.
> The MD driver is confused about this by the DM layer, hence the problem.

And this is probably because the MD driver doesn't seem to see DM devices with 
the same names in 2.4 or in 2.6.

On my system, a typical "cat /proc/mdstat" with kernel 2.4 showed:

Personalities : [raid1] [raid5]
read_ahead 1024 sectors
md2 : active raid1 [dev fe:2e][2] [dev fe:2d][1] [dev fe:2c][0]
      1048704 blocks [2/2] [UU]

md3 : active raid5 [dev fe:1c][2] [dev fe:1b][1] [dev fe:1a][0]
      151556992 blocks level 5, 64k chunk, algorithm 2 [3/3] [UUU]

md0 : active raid1 [dev fe:18][2] [dev fe:17][1] [dev fe:16][0]
      261952 blocks [2/2] [UU]

md1 : active raid1 [dev fe:02][2] [dev fe:01][1] [dev fe:00][0]
      1048704 blocks [2/2] [UU]

unused devices: <none>


Where on the same system, in 2.6, it shows :

Personalities : [raid1] [raid5]
md3 : active raid5 dm-28[2] dm-27[1] dm-26[0]
      151556992 blocks level 5, 64k chunk, algorithm 2 [3/3] [UUU]

md2 : active raid1 dm-46[2] dm-45[1] dm-44[0]
      1048704 blocks [2/2] [UU]

md1 : active raid1 dm-2[2] dm-1[1] dm-0[0]
      1048704 blocks [2/2] [UU]

md0 : active raid1 dm-24[2] dm-23[1] dm-22[0]
      261952 blocks [2/2] [UU]

unused devices: <none>


As you can see, in kernel 2.4, MD sees DM devices all called "fe:<number>", 
and it may interpret all these "fe:<number>" as being the same physical 
device (fe).

In 2.6, MD sees DM devices as called "dm-<number>", and it may interpret all 
these "dm-<number>" as being all different physical devices.

It may have something to do with the way the MD driver parses/understands the 
devices names/numbers, the ":" or "-", etc.

But this is just a supposition, some kernel-knowledgeable folk should probably 
take a look at the DM code to understand this better.

(I'll be on travel for the week and may or may not have access to my email ;-)

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
