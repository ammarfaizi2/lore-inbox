Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbTFUIPW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 04:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTFUIPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 04:15:22 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:32166 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265091AbTFUIPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 04:15:16 -0400
Message-ID: <3EF41759.2060008@colorfullife.com>
Date: Sat, 21 Jun 2003 10:29:13 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org
CC: Neil Moore <neil@s-z.org>, linux-kernel@vger.kernel.org
Subject: Re: Unix code in Linux
References: <3EF30C59.1070206@colorfullife.com>
In-Reply-To: <3EF30C59.1070206@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

atealloc is even worse than I noticed immediately:

* it allocates a semaphore, just in case. Never used.
* it allocates a spinlock and stores the pointer to the spinlock
  in .m_size of the 2nd map entry.
* then defines and one-line wrapper functions to obfuscate
  what's going on:
	pcibr_ate_alloc is a wrapper around rmalloc.
	rmalloc is a #define to atealloc
	atealloc is the map allocator.
* it seems the author never heared of include files - the 
  function prototypes are scattered around in the .c files,
  instead of including <asm/sn/ate_utils.h>

The actual users are in arch/ia64/sn/io/sn2/

There are 2 users:
*********
win_map: It seems to be used for locating io port and memory ranges for pci device initialization.

* creation: in pciio.c:
  - new maps are allocated with pciio_device_win_map_new().
    They are initially empty.
  - The maps are filled with pciio_device_win_populated().
  - they are destroyed with pciio_device_win_map_free().
* use:
  - allocation with pciio_device_win_alloc().
  - free with pciio_device_win_free().

Users are in pcibr/pcibr_{slot,dvr}.c: pcibr_bus_addr_alloc and pcibr_bus_addr_free.

*********
bs_ext_ate_map and bs_int_ate_map: management of address translation entries (ATE).

* creation: created inside pcibr_attach2, destroyed in pcrbr_detach.
	pcibr/pcibr_dvr.c
* use: in pcibr/pcibr_ate.c
	pcibr_ate_alloc, pcibr_ate_free.

The real user is pcibr_dmamap_alloc.
*********

What about deleting ate_utils.c and adding a rmalloc implementation (textbook or bsd) to linux/lib?
Any volunteers?
--
	Manfred
P.S.: I'd propose that the GPL rule that a change must be tagged with the name of the person who changes (or adds) a file is enforced - atealloc.c is only tagged with "SGI", thus I don't know who should be shot for writing that.


