Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292956AbSBVTTC>; Fri, 22 Feb 2002 14:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSBVTSw>; Fri, 22 Feb 2002 14:18:52 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:9516 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S292956AbSBVTSg>; Fri, 22 Feb 2002 14:18:36 -0500
Date: Fri, 22 Feb 2002 19:20:57 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 64GB (i386) kernel config + PAGE_OFFSET change
In-Reply-To: <200202221809.g1MI9n109591@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.21.0202221857540.1856-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Badari Pulavarty wrote:
> 
> I am trying to boot a 2.4.17 (i386) kernel with 64GB kernel config
> and PAGE_OFFSET changed to 3.5 GB (0xE0000000) and it does not boot.
> 
> I was wondering why ? I have 8GB on my machine (P-III). I looked 
> at Andrea's 3.5 GB user-virtual patch. It does not support 3.5GB 
> for 64GB kernel either ? I can't boot even with forcing mem=1G either.

With NOHIGHMEM or HIGHMEM4G, there are 2 levels of page table:
1024 entries in pgd, (1 entry per pmd,) 1024 entries per pt.

With HIGHMEM64G (PAE: 8-byte pte), there are 3 levels of page table:
4 entries in pgd, 512 entries per pmd, 512 entries per pt.

The current code only works if PAGE_OFFSET is a multiple of PGDIR_SIZE:
any multiple of 0x00400000 if NOHIGHMEM or HIGHMEM4G, but the more
limiting multiple of 0x40000000 if HIGHMEM64G: so 3.5 GB not allowed.

I expect the CONFIG_X86_PAE get_pgd_slow() could quite easily be
extended to copy kernel entries at pmd level as well as at pgd level
if necessary, but so far nobody has wanted it enough to make the change.

Hugh

