Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVGLIYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVGLIYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVGLIYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:24:55 -0400
Received: from totor.bouissou.net ([82.67.27.165]:60099 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261256AbVGLIYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:24:49 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: MD-RAID + EVMS parallel / sequential resync issue
Date: Tue, 12 Jul 2005 10:24:45 +0200
User-Agent: KMail/1.7.2
Cc: mingo@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507121024.45358@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

(The reported problem has been noticed on several machines, with different 
hardware, and different 2.6.x kernels, up to 2.6.12)

I use EVMS with MD-RAID based storage, usually buiding several RAID-sets out 
of partitions from the same physical disks, for example (just an example):

1 MD RAID-1 set for a /boot made with 2 partitions out of 2 disks

1 MD RAID-1 set for a / (root fs) made with 2 partitions out of the 2 same 
disks

1 MD RAID-1 set for a swap made with 2 partitions out of the 2 same disks

1 MD RAID-1 set for a LVM containg different other volumes made with 2 
partitions out of the 2 same disks

Using EVMS, the RAID-sets are actually built from dm-managed devices.


Using a 2.4 series kernel, I noticed the following :
---------------------------------------------------------------

1/ When starting RAID-sets, MD usually issued a warning such as:

<< md1: WARNING: [dev fe:01] appears to be on the same physical disk as [dev 
fe:00]. True protection against single-disk failure might be compromised. >>

The dm devices were actually NOT on the same physical disk, so this warning 
was of no consequences.

2/ When RAID-sets went ouf of sync and had to resync, MD resynced them one at 
a time, each in turn, which was a correct behaviour.


Using a 2.6 series kernel, I noticed the following :
---------------------------------------------------------------

1/ When starting RAID-sets, MD doesn't complain about devices "being on the 
same physical disks" anymore.

2/ When RAID-sets get ouf of sync and have to resync, MD now resyncs them all 
in parallel, at the same time, which results in resyncing several RAID-sets 
made from the same disks at the same time.

=> This seems to slow down resyncing very much for all RAIDs, and also 
probably causes huge disks arms/heads movements (my ears tell me about 
this ;-)


Regarding resync speed, even when one single RAID-array is resyncing :

With 2.4 kernel : With a mostly idle system, RAID resync speed usually goes as 
high as /proc/sys/dev/raid/speed_limit_max allows, unless other system 
activity slows it down.

With 2.6 kernel : Even with a mostly idle system, RAID resync speed seems to 
always stick to /proc/sys/dev/raid/speed_limit_min, and never goes much 
higher.

So it seems that the behaviour of the 2.4 MD regarding this is much closer to 
what is desired, compared to the behaviour of the 2.6 kernels. (Comparison 
done on the same system with the same overall configuration and activity).

Any idea about how this could be improved ?

(Please copy me on answers, as I'm not subscribed to the linux-kernel ML)

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
