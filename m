Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264138AbRFGO7r>; Thu, 7 Jun 2001 10:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263418AbRFGO7j>; Thu, 7 Jun 2001 10:59:39 -0400
Received: from zeus.kernel.org ([209.10.41.242]:48564 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263625AbRFGO7b>;
	Thu, 7 Jun 2001 10:59:31 -0400
From: COTTE@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C1256A64.0040C10D.00@d12mta11.de.ibm.com>
Date: Thu, 7 Jun 2001 13:44:56 +0200
Subject: BUG: race-cond with partition-check and ll_rw_blk (all platforms,
	 2.4.*!)
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=gByRxgghfeKtwg9JLuDAzCI7MZSQfLqSUbZPCLvOPdG8fxYFPqIkRQyb"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=gByRxgghfeKtwg9JLuDAzCI7MZSQfLqSUbZPCLvOPdG8fxYFPqIkRQyb
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



Hi kernel-list-readers!

We just had a problem when running some formatting-utils on
a large amount of disks synchronously: We got a NULL-pointer
violation when accessig blk_size[major] for our major number.
Further research showed, that grok_partitions was running at
that time, which has been called by register_disk, which our
device driver issues after a disk has been formatted.
Grok_partitions first initializes blk_size[major] with a NULL
pointer, detects the partitions and then assigns the original
value to blk_size[major] again.
Here's the interresting code from these functions, I cut some
irrelevant things out:
>From grok_paritions:
     blk_size[dev->major] = NULL;
     check_partition(dev, MKDEV(dev->major, first_minor), 1 + first_minor);
     if (dev->sizes != NULL) {
          blk_size[dev->major] = dev->sizes;
     };
>From generic_make_request:
     if (blk_size[major]) {
               if (blk_size[major][MINOR(bh->b_rdev)]) {
                    printk(KERN_INFO
                           "attempt to access beyond end of device\n");
                    printk(KERN_INFO "%s: rw=%d, want=%ld, limit=%d\n",
                           kdevname(bh->b_rdev), rw,
                           (sector + count)>>1,
                           blk_size[major][MINOR(bh->b_rdev)]);
               }

Can anyone explain to me, why grok_partitions has to clear
this pointer? Why is this all done without any lock which causes
race conditions all over the block-device layer (for example
generic_make_request() in ll_rw_blk.c first checks if the pointer
is set and afterwards accesses the array behind the pointer)?

mit freundlichem Gru
--0__=gByRxgghfeKtwg9JLuDAzCI7MZSQfLqSUbZPCLvOPdG8fxYFPqIkRQyb
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable


=DF / with kind regards
Carsten Otte

IBM Deutschland Entwicklung GmbH
Linux for 390/zSeries Development - Device Driver Team
Phone: +49/07031/16-4076
IBM internal phone: *120-4076
--
We are Linux.
Resistance indicates that you're missing the point!
=

--0__=gByRxgghfeKtwg9JLuDAzCI7MZSQfLqSUbZPCLvOPdG8fxYFPqIkRQyb--

