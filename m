Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263879AbUEMHtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbUEMHtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUEMHtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:49:23 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:16 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263879AbUEMHtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:49:21 -0400
Date: Thu, 13 May 2004 08:49:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513084903.B6631@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Adam Litke <agl@us.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040513055520.GF27403@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040513055520.GF27403@zax>; from david@gibson.dropbear.id.au on Thu, May 13, 2004 at 03:55:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 03:55:20PM +1000, David Gibson wrote:
> Andrew, please apply:
> 
> At present, getting a block of (quasi-) anonymous memory mapping with
> hugepages is a slightly convoluted process, involving creating a dummy
> file in a hugetlbfs filesystem.  In particular that means finding
> where such a filesystem is mounted, for which there is no standard
> mechanism.  Getting hugepage SysV shm segments is easier, just requing
> the SHM_HUGETLB flag.  This patch adds an analagous MAP_HUGETLB mmap()
> flag to easily request that a block of anonymous memory come from
> hugepages.
> 
> [The MAP_HUGETLB flag has the side effect that MAP_SHARED semantics
> will apply, even if MAP_PRIVATE is specific - but that's no different
> to explicitly mapping hugetlbfs].

Please don't do this.  It's messing all over sensitive codepathes in the
kernel, creating special cases and bloat of what you could with simple a
simpe hugetlb_mmap() wrapper ala (pseudocode)

hugetlb_mmap()
{
	fd = open(file in hugetlbfs)

	mmap(.., fd, ...)
	close(fd)
}

in some library.  The hugetlbfs implementation was chosen exactly because
if kept the impact of hugetlb pages down to normal kernel codepathes.

