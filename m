Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQKBEL2>; Wed, 1 Nov 2000 23:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129207AbQKBELS>; Wed, 1 Nov 2000 23:11:18 -0500
Received: from nvgate.nvidia.com ([140.174.105.2]:4947 "EHLO
	hygelac.nvidia.com") by vger.kernel.org with ESMTP
	id <S129199AbQKBELF>; Wed, 1 Nov 2000 23:11:05 -0500
Date: Wed, 1 Nov 2000 20:04:34 -0800
From: Terence Ripperda <ripperda@nvidia.com>
To: linux-kernel@vger.kernel.org
Subject: overflow bugs in virtual memory routines?
Message-ID: <20001101200434.A12936@hygelac>
Reply-To: Terence Ripperda <ripperda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Accept-Language: en
X-Operating-System: Linux hygelac 2.2.16 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I believe I've found some corner-case overflow bugs in the virtual memory routines of the kernel. 

I'm tracking down some bugs with our driver on a 1 Gig system. This forces the kernel's VMALLOC_AREA into very high memory, exactly where based on the VMALLOC_RESERVE value, but roughly 0xfc000000-0xffffe000 or 0xf8000000-0xffffe000. As virtual memory is allocated, and the addresses come closer to 0xffffe000, it appears some of the macros/tests in the virtual memory layer overflow and fail.

The first is in vmalloc.c:163, in the function get_vm_area():

161:        addr = VMALLOC_START;
162:        for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {
163:                if (size + addr < (unsigned long) tmp->addr)

If size is large enough, size + addr can overflow, and fulfill this condition when it shouldn't. The new allocation will continue and overwrite some number of page tables. The specific example I've seen is when the first virtual allocation (tmp->addr) is 0xfc000000, and an ioremap of 64 Megs is tried. Since addr also starts off as 0xfc000000, size + addr (0x4000000 + 0xfc000000) overflows to 0x0, and the remapping overwrites previous allocations.


Perhaps this would work (without too big a performance hit?):

163:                if ( (size + addr < (unsigned long) tmp->addr) && (size + addr > addr) )


The second is in vmalloc.c:135, in the function vmalloc_area_pages():

133:        dir = pgd_offset_k(address);
134:        flush_cache_all();      
135:        while (address < end) {
...
146:                address = (address + PGDIR_SIZE) & PGDIR_MASK;
147:                dir++;
148:        }

If I do an allocation that fits exactly into the last bit of virtual address space, this logic fails. My allocation ends up with a kernel virtual address of 0xffa090000, with a size of 0x500000.

This allocation *should* span the last two page directories, 0xc0101ff8 & 0xc0101ffc, and therefor make 2 passes through this loop, getting kicked out by the test at 135.

What ends up happening is that line 146 masks the address as so:

    1st pass: (0xffa09000 + 0x400000) & 0xffc00000   =>  0xffc00000
    2nd pass: (0xffc00000 + 0x400000) & 0xffc00000   =>  0x0

We start a 3rd with a pgd of 0xc0102000, which is the start of pg0. Obviously, very bad things start happening when you rewrite those page tables, and the system shortly reboots itself.

Perhaps something like this would work:

            unsigned int start = address;
135:        while ( (address < end) && (address > start) ) {


I'm more than happy to provide more details or test possible patches.

Thanks,
Terence Ripperda
NVIDIA
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
