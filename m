Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbUCYQvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUCYQvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:51:36 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:43785 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263376AbUCYQvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:51:23 -0500
Date: Thu, 25 Mar 2004 16:54:32 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
cc: Andi Kleen <ak@suse.de>, raybry@sgi.com, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the latest incarnation of my hugetlb patches.  Rediffed
against 2.6.5-rc2-bk4.  With the addition of
080-mem_acctdom_hugetlb_sysctl which generalises the sysctl 
support and uses it for hugetlb.

The overall problem is described below.  Feedback and testing
appreciated.

Cheers.

-apw


HUGETLB Overcommit Handling
---------------------------
When building mappings the kernel tracks committed but not yet
allocated pages against available memory and swap preventing memory
allocation problems later.  The introduction of hugetlb pages has
has significant ramifications for this accounting as the pages used
to back them are already removed from the available memory pool.
Currently mapping involving these pages are still accounted against
the small page pool leading to either over commitment of the normal
page pool, or incorrectly failed hugetlb allocations in the case
where hugetlb memory exceeds the remaining normal pool.  Also as
there is no commitment tracking on hugetlb pages it is not possible
to safely fault them on demand which is a problem for large segments
where the prefault and clear times are excessive.

This patch set attempts to addresses of these issues and provide a
platform for fixing the remainder.  Firstly, by removing the hugetlb
allocations from the normal page pool.  Secondly, by introducing a
general mechanism for accounting for multiple page pools.  Thirdly,
by implmenting and enforcing hugetlb commitments via these pools.

050-mem_acctdom_core:		core changes to create two accounting domains
055-mem_acctdom_arch:		architecture specific changes for above
060-mem_acctdom_commitments:	splits vm_committed into a per domain count
070-mem_acctdom_hugetlb: 	use vm_committed to track HUGETLB usage
075-mem_acctdom_hugetlb_arch:	architecture specific changes for above
080-mem_acctdom_hugetlb_sysctl: generalise sysctl parameters and add hugetlb

These first two patches introduce the concept of a split between
the default and hugetlb memory pools and stop the hugtlb pool
being accounted at all.  This is not as clean as I would like,
particularly the need to check against VM_AD_DEFAULT in a few places.

The third patch splits the vm_committed count into a per domain
count and exposes the domain in the interface.

The fourth and fifth patches convert hugetlb to use the vm_commitment
interfaces exposed above.

The sixth patch generalises the overcommit mode and rations to all
domains and adds support for controlling the hugetlb domain with it.

Below is a transcript of a test showing the commitments being
applied.  The test attempts to make 3 400x2MB page shared memory
segments, 850 pages are available.  The main things to note are
the commitment against the pages at shmget() time.  This is a
prerequisite for reliable accounting under fault driven page
instantiation.

    [root@kite apw]# ./tester
    kernel.shmmax = 2147483648
    kernel.shmall = 2147483648
    vm.nr_hugepages = 850
    === FIRST ===
    === before shmget ===
    HugePages_Total:   850
    HugePages_Free:    850
    Hugepagesize:     2048 kB
    HugeCommited_AS:        0 kB
    === before shmat ===
    HugePages_Total:   850
    HugePages_Free:    850
    Hugepagesize:     2048 kB
    HugeCommited_AS:   819200 kB
    test: shmat smp=42200000
    === after shmat ===
    HugePages_Total:   850
    HugePages_Free:    450
    Hugepagesize:     2048 kB
    HugeCommited_AS:   819200 kB
    === SECOND ===
    === before shmget ===
    HugePages_Total:   850
    HugePages_Free:    450
    Hugepagesize:     2048 kB
    HugeCommited_AS:   819200 kB
    === before shmat ===
    HugePages_Total:   850
    HugePages_Free:    450
    Hugepagesize:     2048 kB
    HugeCommited_AS:  1638400 kB
    test: shmat smp=42200000
    === after shmat ===
    HugePages_Total:   850
    HugePages_Free:     50
    Hugepagesize:     2048 kB
    HugeCommited_AS:  1638400 kB
    === THIRD ===
    === before shmget ===
    HugePages_Total:   850
    HugePages_Free:     50
    Hugepagesize:     2048 kB
    HugeCommited_AS:  1638400 kB
    test: shmget failed - errno=12
    === before ipcrm -M 0xdead0000 ===
    HugePages_Total:   850
    HugePages_Free:     50
    Hugepagesize:     2048 kB
    HugeCommited_AS:  1638400 kB
    === before ipcrm -M 0xdead0001 ===
    HugePages_Total:   850
    HugePages_Free:    450
    Hugepagesize:     2048 kB
    HugeCommited_AS:   819200 kB
    === before ipcrm -M 0xdead0002 ===
    HugePages_Total:   850
    HugePages_Free:    850
    Hugepagesize:     2048 kB
    HugeCommited_AS:        0 kB
    ipcrm: invalid key (0xdead0002)
    === after ===
    HugePages_Total:   850
    HugePages_Free:    850
    Hugepagesize:     2048 kB
    HugeCommited_AS:        0 kB
    vm.nr_hugepages = 0

