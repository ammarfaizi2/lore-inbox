Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbRE2T3Q>; Tue, 29 May 2001 15:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261577AbRE2T3G>; Tue, 29 May 2001 15:29:06 -0400
Received: from t2.redhat.com ([199.183.24.243]:21756 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261576AbRE2T2y>; Tue, 29 May 2001 15:28:54 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <CA256A5B.00548719.00@d73mta01.au.ibm.com> 
In-Reply-To: <CA256A5B.00548719.00@d73mta01.au.ibm.com> 
To: mdaljeet@in.ibm.com
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: query regarding 'map_user_kiobuf' 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 May 2001 20:28:17 +0100
Message-ID: <2332.991164497@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mdaljeet@in.ibm.com said:
> After using the 'map_user_kiobuf', I observed the followiing:
> 
> 1. 'kiobuf->maplist[0]->virtual' contains a different virtual address than
> the user space buffer address
> 2. But these two addresses are mapped as when i write something using the
> address 'kiobuf->maplist[0]->virtual' inside the kernel, I see the same
> data in the user space buffer in my application.
> 3. I use the 'virt_to_phys' operation to the virtual address
> 'kiobuf->maplist[0]->virtual' to get the physical address.
> 4. I use this physical address for DMA operations.
> 
> Now, using this information I do a DMA from card to system memory. What I
> have noticed is that DMA happens somewhere else in the system memory. I am
> not able to execute most of the commands (ls, chmod, cat, clear etc) after
> my user program exits.
> 
> Am I doing the steps 3 and 4 above right?

After calling map_user_kiobuf(), I believe you should be locking the pages
in memory by calling lock_kiovec(). Otherwise, nothing prevents them from 
being paged out again.

Also, the pages may be in high memory and not directly accessible. You should
use kmap() before touching them from the kernel rather than just using 
page->virtual, and obviously kunmap() afterwards.

The PCI DMA interface is more complex than simply using virt_to_phys() too, 
if you want to deal correctly with the highmem case. I'm sure others will 
give you the details or pointers to the documentation.

--
dwmw2


