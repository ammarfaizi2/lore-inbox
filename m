Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTE2Mv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 08:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTE2Mv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 08:51:58 -0400
Received: from dyn-ctb-203-221-73-2.webone.com.au ([203.221.73.2]:36363 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262013AbTE2Mv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 08:51:56 -0400
Message-ID: <3ED60574.3080308@cyberone.com.au>
Date: Thu, 29 May 2003 23:04:52 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Kevin Jacobs <jacobs@penguin.theopalgroup.com>
CC: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: Ext3 meta-data performance
References: <Pine.LNX.4.44.0305290819370.11990-100000@penguin.theopalgroup.com>
In-Reply-To: <Pine.LNX.4.44.0305290819370.11990-100000@penguin.theopalgroup.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kevin Jacobs wrote:

>I've recently upgraded our company rsync/backup server and have been running
>into performance slowdowns.  The old system was a dual processor Pentium III
>(Coppermine) 866MHz running Redhat 7.3 with IDE disks (ext2 filesystems). 
>We have since upgraded it to Redhat 9, added a 3Ware 7500-8 RAID controller
>and more disks (w/ ext3 filesystems + external journal).
>
>The primary use for this system is to provide live rsync snapshots of
>several of our primary servers.  For each system we maintain a "current"
>snapshot, from which a hard-linked image is taken after each rsync update.
>i.e., we rsync and then 'cp -Rl current snapshot-$DATE'.  After the update
>to Redhat 9, the rsync itself was faster, but the time to make the
>hard-links became an order of magnitude slower (~4min -> ~50min for a tree
>with 500,000 files).  Not only was it slower, but it destroyed system
>interactivity for minutes at a time.
>
>Since these rsync backups are done in addition to traditional daily tape
>backups, we've taken the system out of production use and opened the door
>for experimentation.  So, the next logical step was to try a 2.5 kernel. 
>After some work, I've gotten 2.5.70-mm2 booting and it is _much_ better than
>the Redhat 2.4 kernels, and the system interactivity is flawless.  However,
>the speed of creating hard-links is still three and a half times slower than
>with the old 2.2 kernel.  It now takes ~14 minutes to create the links, and
>from what I can tell, the bottlenecks is not the CPU or the disk-throughput. 
>
Its probably seek bound.
Provide some more information about your disk/partition setup, and external
journals, and data= mode. Remember ext3 will generally always have to do
more work than ext2.

If you want to play with the scheduler, try set
/sys/block/blockdev*/queue/nr_requests = 8192
then try
/sys/block/blockdev*/queue/iosched/antic_expire = 0

Try the above combinations with and without a big TCQ depth. You should
be able to set them on the fly and see what happens to throughput during
the operation. Let me know what you see.

Nice to see interactivity is good though.

