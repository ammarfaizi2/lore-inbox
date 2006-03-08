Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWCHJ0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWCHJ0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWCHJ0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:26:04 -0500
Received: from fmr19.intel.com ([134.134.136.18]:17038 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932144AbWCHJ0D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:26:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: hugepage: Strict page reservation for hugepage inodes
Date: Wed, 8 Mar 2006 17:25:16 +0800
Message-ID: <117E3EB5059E4E48ADFF2822933287A44D3206@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: hugepage: Strict page reservation for hugepage inodes
Thread-Index: AcY8v/RET9WAl86oTcOAJe5UDFnMcgF0DZgw
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: "Andrew Morton" <akpm@osdl.org>, "William Lee Irwin" <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-OriginalArrivalTime: 08 Mar 2006 09:25:17.0316 (UTC) FILETIME=[36787440:01C64292]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: David Gibson [mailto:david@gibson.dropbear.id.au]
>>Sent: 2006Äê3ÔÂ1ÈÕ 7:36
>>To: Zhang, Yanmin
>>Cc: Andrew Morton; William Lee Irwin; linux-kernel@vger.kernel.org
>>Subject: Re: hugepage: Strict page reservation for hugepage inodes
>>
>>hugepage: Strict page reservation for hugepage inodes
>>
>>These days, hugepages are demand-allocated at first fault time.
>>There's a somewhat dubious (and racy) heuristic when making a new
>>mmap() to check if there are enough available hugepages to fully
>>satisfy that mapping.
>>
>>A particularly obvious case where the heuristic breaks down is where a
>>process maps its hugepages not as a single chunk, but as a bunch of
>>individually mmap()ed (or shmat()ed) blocks without touching and
>>instantiating the pages in between allocations.  In this case the size
>>of each block is compared against the total number of available
>>hugepages.  It's thus easy for the process to become overcommitted,
>>because each block mapping will succeed, although the total number of
>>hugepages required by all blocks exceeds the number available.  In
>>particular, this defeats such a program which will detect a mapping
>>failure and adjust its hugepage usage downward accordingly.
>>
>>The patch below addresses this problem, by strictly reserving a number
>>of physical hugepages for hugepage inodes which have been mapped, but
>>not instatiated.
The patch reserves a number of physical hugepages for hugepage inodes
which have been mapped into address spaces, but it doesn't just reserve the
pages what it needed. It reserves all huge pages from 0 to inode->i_size. For example,

	fd = open("/mnt/hugepages/file1", O_CREAT|O_RDWR, 0755);
 	*addr = mmap(NULL, HUGEPAGE_SIZE*3, PROT_NONE, MAP_SHARED, fd, HUGEPAGE_SIZE*5);

The patch would reserve 8 huge pages instead of 3 pages. I know that shmget/shmat
have no such problem. But mmap has it and the patch looks not perfect.

I have an idea. How about to record all the start/end address of huge page mmaping of the inode?
Long long ago, there was a patch at http://marc.theaimsgroup.com/?l=lse-tech&m=108187931924134&w=2.
Of course, we need port it to the latest kernel if this idea is better.

Yanmin

