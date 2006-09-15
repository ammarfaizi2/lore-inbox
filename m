Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWIOVIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWIOVIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWIOVIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:08:09 -0400
Received: from gw.goop.org ([64.81.55.164]:58778 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932266AbWIOVII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:08:08 -0400
Message-ID: <450B1631.40307@goop.org>
Date: Fri, 15 Sep 2006 14:08:01 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: How does the handover from boot allocator to real allocator work
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I'm digging around trying to work out how the handover from the 
boot-time allocator to the real memory management works. 

I'm missing something important though:  bootmem.c:free_all_bootmem() 
seems to end up just putting all low memory on the freelists.  How does 
this not put the kernel text+data pages on the freelists?  Also, 
presumably things allocated in the bootmem allocator remain allocated 
for the life of the running kernel?

I'm having a problem in my Xen kernel, in which free_init_pages() ends 
up getting a bad_page() warning because pfn 1024 has the PG_buddy bit 
set on it, which was unexpected (this page ends up being in the middle 
of the initdata section).  Page 1024 gets PF_buddy set by 
free_all_bootmem_core(), and it becomes an order 10 page.

I presume this is broken because free_all_bootmem_core() shouldn't be 
putting the kernel text+data into the freelists, but I don't see how 
this is prevented in the normal i386 case.  I'm guessing it's done by 
something like reserve_bootmem(), but I don't see such a call which 
would reserve the kernel itself.

What am I missing?

Thanks,
    J
