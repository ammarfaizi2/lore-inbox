Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUDHFXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 01:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUDHFXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 01:23:13 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:21456 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261597AbUDHFXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 01:23:10 -0400
Message-ID: <4074E1B3.2050602@colorfullife.com>
Date: Thu, 08 Apr 2004 07:22:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Libor Michalek <libor@topspin.com>
CC: Roland Dreier <roland@topspin.com>, Eli Cohen <mlxk@mellanox.co.il>,
       linux-kernel@vger.kernel.org
Subject: Re: locking user space memory in kernel
References: <20040407174559.E11135@topspin.com>
In-Reply-To: <20040407174559.E11135@topspin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Libor Michalek wrote:

>----- Forwarded message from Manfred Spraul <manfred@colorfullife.com> -----
>  
>
>>Date:	Sun, 21 Mar 2004 12:31:59 +0100
>>From: Manfred Spraul <manfred@colorfullife.com>
>>To: Eli Cohen <mlxk@mellanox.co.il>
>>Cc: linux-kernel@vger.kernel.org
>>Subject: Re: locking user space memory in kernel
>>
>>Hi Eli,
>>
>>I think just get_user_pages() should be sufficient: the pages won't be 
>>swapped out. You don't need to set VM_LOCKED in vma->vm_flags to prevent 
>>the swap out. In the worst case, the pte is cleared a that will cause a 
>>soft page fault, but the physical address won't change. Multiple 
>>get_user_pages() calls on overlapping regions are ok, the page count is 
>>an atomic_t, at least 24-bit large.
>>    
>>
>
>  The soft page fault is a problem if the device is going to write data 
>into the buffer and then notify the user that the buffer now contains 
>valid data. If the soft page fault occurs before the device has written
>to the page list, once the user is notified of the write and reads the 
>buffer, it will no longer be the same pages as the ones to which the 
>device wrote.
>
No. The physical addresses do not change due to a soft page fault.
A soft fault means that the page table entry is cleared, but that the 
physical page is still in the system memory. do_swap_page does a swap 
cache lookup and finds the original physical page in memory and maps it 
back to the virtual address. The physical page can't be dropped from the 
swap cache because your driver still holds one reference to the page - 
no swapout.

But fork() is a problem for get_user_pages(): You probably have to write 
an improved function (create_user_mapping/destroy_user_mapping) that 
handles fork correctly.
And add arch hooks into the new function - they are required for archs 
with incoherent cpu caches. Right now O_DIRECT doesn't flush the cpu 
caches, because it's impossible to implement it with get_user_pages(). 
It works, because the data cache is usually coherent and noone loads 
libraries with O_DIRECT.

--
    Manfred


