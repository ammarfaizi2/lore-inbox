Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbSJQE5X>; Thu, 17 Oct 2002 00:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbSJQE5X>; Thu, 17 Oct 2002 00:57:23 -0400
Received: from [203.117.131.12] ([203.117.131.12]:57490 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261789AbSJQE5W>; Thu, 17 Oct 2002 00:57:22 -0400
Message-ID: <3DAE448E.1080900@metaparadigm.com>
Date: Thu, 17 Oct 2002 13:03:10 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>
Cc: Simon Roscic <simon.roscic@chello.at>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <200210152120.13666.simon.roscic@chello.at>	 <200210152153.08603.simon.roscic@chello.at>	 <3DACD41F.2050405@metaparadigm.com>	 <200210161828.18985.simon.roscic@chello.at>	 <3DAD988B.40704@metaparadigm.com> <1034824350.26.33.camel@localhost>	 <3DAE3465.6060006@metaparadigm.com> <1034827683.26.76.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/02 12:08, GrandMasterLee wrote:
> On Wed, 2002-10-16 at 22:54, Michael Clark wrote:
> 
>>On 10/17/02 11:12, GrandMasterLee wrote:
>>
>>>On Wed, 2002-10-16 at 11:49, Michael Clark wrote:
>>>
>>>>Seems to be the correlation so far. qlogic driver without lvm works okay.
>>>>qlogic driver with lvm, oopsorama.
>>>
>>>
>>>Michael, what exactly do your servers do? Are they DB servers with ~1Tb
>>>connected, or file-servers with hundreds of gigs, etc?
>>
>>My customer currently has about 400Gb on this particular 4 node Application
>>cluster (actually 2 x 2 node clusters using kimberlite HA software).
>>
>>It has 11 logical hosts (services) spread over the 4 nodes with services such
>>as Oracle 8.1.7, Oracle Financials (11i), a busy openldap server, and busy
>>netatalk AppleShare Servers, Cyrus IMAP server. All are on ext3 partitions
>>and were previously using LVM to slice up the storage.
> 
> 
> On each of the Nodes, correct?

We had originally planned to split up the storage in the RAID head
using individual luns for each cluster logical host - so we could use SCSI
reservations - but we encountered problems with the RAID heads device queue.

The RAID head has a global queue depth of 64 and to alleviate
queue problems with the RAID heading locking up, we needed to minimise
the number of luns, so late in the piece we added LVM to split up the storage.

We are using LVM in a clustered fashion. ie. we export most of the array
as one big lun, and slice it into lvs, each one associated with a logical host.
All lvs are accessible from all 4 physical hosts in the cluster. Care and
application locking ensures only 1 physical host mounts any lv/partition at
the same time (except for cluster quorum partitions which need to be accessed
concurrently from 2 nodes - and for these we have seperate quorum disks in
the array).

lvm metadata changes are made from one node while the others are down
(or just have volumes deactivated, unmounted, then lvm-mod removed)
to avoid screwing our metadata because lvm is not cluster aware.

We are not using mutlipath put have the cluster arranged in a topology
such that the HA RAID Head has 2 controllers with each side of the cluster
hanging of a different one ie. L and R. If we have a path failure, we will
just loose CPU capacity (25-50% depending). The logical hosts will automatically
move onto a physical node which still has connectivity to the RAID head
(by the cluster software checking of connectivity to the quorum paritions).
This gives us a good level of redundancy without the added cost of 2 paths
from each host. ie. after a path failure we run with degraded performance only.

We are using vanilla 2300's.

~mc

