Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWAYK20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWAYK20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 05:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWAYK20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 05:28:26 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:30711 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751107AbWAYK2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 05:28:25 -0500
Message-ID: <43D752C1.40205@sirrix.de>
Date: Wed, 25 Jan 2006 11:28:17 +0100
From: Oskar Senft <osk-lkml@sirrix.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Use of "high_memory" in iounmap
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:701b7ca108cfd083b467aa547eda228f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While using Linux in a virtualization environment (L4), I found a
strange inconsistency in "iounmap" regarding the use of the
"high_memory" variable.

According to [1]: "high_memory is the virtual address where high memory
begins", so high_memory contains the first address in high memory.

Accordingly, also linux-source/mm/memory.c, ca. line 72 says:
"A number of key systems in x86 including ioremap() rely on the
assumption that high_memory defines the upper bound on direct map
memory, then end of ZONE_NORMAL. Under CONFIG_DISCONTIG this means that
max_low_pfn and highstart_pfn must be the same; there must be no gap
between ZONE_NORMAL and ZONE_HIGHMEM."

(BTW: CONFIG_DISCONTIG is no longer existent / has been renamed).

Obviously, this is applied correctly, for example in
linux-source/arch/i386/mm/ioremap.c in function "__ioremap":
  /*
   * Don't allow anybody to remap normal RAM that we're using..
   */
  if (phys_addr <= virt_to_phys(high_memory - 1))

However, in linux-source/arch/i386/mm/ioremap.c in "iounmap" oviously
the meaning of "high_memory" is understood differently:
  if ((void __force *)addr <= high_memory) return;


In that case (by means of <=) we could not unmap again the "first"
mapping in high memory: the first mapping usually is being mapped to the
start of the high memory and thus is addr == high_memory in the iounmap
call. (This was the case in which we found the inconsistency).

For this reason in my opinion it rather should be:
  if ((void __force *)addr < high_memory) return;

What do you think?

Regards,
Oskar.

[1] Mel Gorman, Code Commentary On The Linux Virtual Memory Manager
    p. 24, http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/code.pdf

