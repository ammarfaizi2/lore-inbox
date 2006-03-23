Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWCWT6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWCWT6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWCWT6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:58:31 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:19332 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751490AbWCWT6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:58:30 -0500
Date: Thu, 23 Mar 2006 14:57:52 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 0/10] 64 bit resources
Message-ID: <20060323195752.GD7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an attempt to implement support for 64 bit resources. This will
enable memory more than 4G to be exported through /proc/iomem, which is used
by kexec/kdump to determine the physical memory layout of the system.

As suggested in the last week's discussion, I picked up greg's patch and
made changes on top of that.

http://www.kernel.org/pub/linux/kernel/people/gregkh/pci/2.6/2.6.11-rc3/bk-resource-2.6.11-rc3-mm1.patch

Last discussion witnessed a divided opinion upon whether to use u64 or
something like dma_addr_t as data type. The argument is usage of dma_addr_t
will reduce code size bloat for the people who don't want to use 64 bit
resources on 32 bit platforms. But probably name dma_addr_t is not very
appropriate for usage at various places.

Implementing u64 seems to be simpler and code bloat might not be significant.

This implementation is based on u64 and I have measured code bloat on i386.

- Greg's patch already had core changes. We have maninly fixed the warnings.
  Most of them originating from printk's().

- This patch does not try to modify the users of resources who think
  that on 32 bit platforms resources can be 32 bit only. They will continue
  to work as usual as they will silently truncate the 64 bit value to 32bit.

- We did the compilation for i386, arm, sparc, sparc64, x86_64 and ppc64
  platforms and fixed the warnings.

Test Results:
------------

We used "make allyesconfig" with CONFIG_DEBUG_INFO=n on 2.6.16-mm1.

i386
----

vmlinux size without patch: 40191425
vmlinux size with path: 40244677
vmlinux size bloat: 52K (.13%)

x86_64
------

vmlinux size without patch: 42387898
vmlinux size with path: 42387945
vmlinux size bloat: 47 bytes

Thanks
Vivek
