Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWAJX0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWAJX0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWAJX0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:26:05 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:2796 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751345AbWAJX0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:26:04 -0500
Subject: [PATCH 0/5] multiple block allocation to current ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: hch@lst.de, pbadari@us.ibm.com, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1114715665.18996.29.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
	 <1114659912.16933.5.camel@mindpipe>
	 <1114715665.18996.29.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 10 Jan 2006 15:26:01 -0800
Message-Id: <1136935562.4901.41.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ext3_get_block() only map or allocate one block at a time.
This is quite inefficient for sequential IO workload. 

I have posted a early implements a simply multiple block map and
allocation with current ext3.  The basic idea is allocating the 1st
block in the existing way, and attempting to allocate the next adjacent
blocks on a  best effort basis. More description about the
implementation could be found here:
http://marc.theaimsgroup.com/?l=ext2-devel&m=112162230003522&w=2

The following the latest version of the patch: break the original patch
into 5 patches, re-worked some logicals, and fixed some bugs. The break
ups are:

[patch 1] Adding map multiple blocks at a time in ext3_get_blocks()
[patch 2] Extend ext3_get_blocks() to support multiple block allocation
[patch 3] Implement multiple block allocation in ext3-try-to-allocate
(called via ext3_new_block()).
[patch 4] Proper accounting updates in ext3_new_blocks() 
[patch 5] Adjust reservation window size properly (by the given number
of blocks to allocate) before block allocation to increase the
possibility of allocating multiple blocks in a single call.

Tests done so far includes fsx,tiobench and dbench. The following
numbers collected from Direct IO tests (1G file creation/read)  shows
the system time have been greatly reduced (more than 50% on my 8 cpu
system) with the patches.

1G file DIO write:
	2.6.15		2.6.15+patches
real    0m31.275s	0m31.161s
user    0m0.000s	0m0.000s
sys     0m3.384s	0m0.564s 


1G file DIO read:
	2.6.15		2.6.15+patches
real    0m30.733s	0m30.624s
user    0m0.000s	0m0.004s
sys     0m0.748s	0m0.380s

Some previous test we did on buffered IO with using multiple blocks
allocation and delayed allocation shows noticeable improvement on
throughput and system time.

Patches against 2.6.15. Please consider to add to mm tree. 

Thanks!

Mingming

