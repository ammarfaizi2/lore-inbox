Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130450AbRCWJxL>; Fri, 23 Mar 2001 04:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbRCWJxA>; Fri, 23 Mar 2001 04:53:00 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:59811 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130450AbRCWJws>; Fri, 23 Mar 2001 04:52:48 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 23 Mar 2001 01:52:07 -0800
Message-Id: <200103230952.BAA06705@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3-pre6: agpart.o causes arch/i386/mm/ioremap.c hang
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

>	Under linux-2.4.3-pre6 compiled for SMP, loading agpgart.o
>hangs the system in remap_area_pages (arch/i386/mm/ioremap.c) at
>the call to spin_lock(&init_mm.page_table_lock), which is not in 2.4.2.
[...]
>	agp_backend_initialize
>	agp_generic_create_gatt_table
>	io_remap_nocache
>	__ioremap
>	remap_area_pages
[...]


>	I'm rebuilding the kernel now with a modified spin_lock()
>routine that should tell me who acquired the lock previously [...]

	 In case anyone is interested, the conflicting lock of
init_mm.page_table_lock was acquired in line 1318 of mm/memory.c,
in pte_alloc.

	One way that this might be happening is that it looks like
no page_table_lock is every acquired by vmalloc, which results in
the following call graph:

	vmalloc
	__vmalloc
	vmalloc_area_pages
	alloc_area_pmd
	pte_alloc ...which assumes (here incorrectly) that
		mm->page_table_lock is held, and sometimes releases
		and reacquires mm->page_table_lock.

	I will attempt to analyze this further tomorrow if nobody
beats me to it.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
