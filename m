Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293708AbSCAUJI>; Fri, 1 Mar 2002 15:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293705AbSCAUI7>; Fri, 1 Mar 2002 15:08:59 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:59800 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S293700AbSCAUIs>; Fri, 1 Mar 2002 15:08:48 -0500
Date: Fri, 1 Mar 2002 13:22:54 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: queue_nr_requests needs to be selective
Message-ID: <20020301132254.A11528@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus/Alan/Linux,

Performance numbers can be increased dramatically (> 300 MB/S) 
by increasing queue_nr_requests in ll_rw_blk.c on large RAID 
controllers that are hosting a lot of drives.  

We have noticed that with the defaults of 64/128 for queue_nr_requests,
2.4.18 performance hits a wall at 230 MB/S system wide.  We have gotten 
this number to approach 300 MB/S across 4 adapters (for short periods
during cache flushing)
by putting 2 cards on the 33 Mhz bus and 2 cards on the 66 Mhx bus 
in a Serverworks configuration running Dolphin's SCI adapters as 
the interconnect to connect the adapters to an SCI clustering
fabric.  

With queue_nr_requests set to 64/128, we have noticed via profile=2 
that a lot of time is spent needlessly going to sleep in 
__get_request_wait() with calling threads sleeping way more than is 
needed.  Since SCI does direct memory DMA,s we are at present pushing 
238 MB/S from an SCI adapter into local cache and the cache is bursting
writes to the 3Ware adapters at very high data rates > 300 MB/S, but 
only after I have hard coded 1024 into queue_nr_requests for the 
disk queues in 2.4.18.  We are at 34% utilization on a single 
processor (no SMP) moving data at these rates with SCI.

What is really needed here is to allow queue_nr_requests to be 
configurable on a per adapter/device basis for these high end 
raid cards like 3Ware since in a RAID 0 configuration, 8 drives
are in essence a terabyte (1.3 terrabytes in our configuration) 
and each adapter is showing up as a 1.3 TB device.  64/128
requests are simply not enough to get the full spectrum of 
performance atainable with these cards.

These number needs to be increased.  I cannot get any 2.4.18 
system to get above 230 MB/S with 3ware RAID adapters with 
the numbers set to 64/128 on these big devices.  An array 
of 8 x 160BG disks eats up these request queue free lists,
then the feeding threads spend most of their time asleep.

Respectfully submitted,

Jeff Merkey







