Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWCVXyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWCVXyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWCVXyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:54:46 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:20484 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932069AbWCVXyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:54:45 -0500
Message-ID: <4421E3C4.2060808@vmware.com>
Date: Wed, 22 Mar 2006 15:54:44 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation II
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <200603222239.46604.ak@suse.de> <4421D379.3090405@vmware.com> <200603222338.44919.ak@suse.de>
In-Reply-To: <200603222338.44919.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 22 March 2006 23:45, Zachary Amsden wrote:
>
>   
>> I propose an entirely different approach - use segmentation. 
>>     
>
> That would require a lot of changes to save/restore the segmentation
> register at kernel entry/exit since there is no swapgs on i386. 
> And will be likely slower there too and also even slow down the 
> VMI-kernel-no-hypervisor.
>   

There are no changes required to the kernel entry / exit paths.  With 
save/restore segment support in the VMI, reserving one segment for the 
hypervisor data area is easy.

I take it back.  There is one required change:

kernel_entry:
     hypervisor_entry_hook
     sti
     .... kernel code

This hypervisor_entry_hook can be a nop on native hardware, and the 
following for Xen:

push %gs
mov CPU_HYPER_SEL, %gs
pop %gs:SAVED_USER_GS

You already have the IRET / SYSEXIT hooks to restore it on the way 
back.  And now you have a segment reserved that allows you to deal with 
16-bit stack segments during the IRET.

> Still might be the best option.
>
> How did that rumoured Xenolinux-over-VMI implementation solve that problem?
>   

!CONFIG_SMP  -- as I believe I saw in the latest Xen patches sent out as 
well?
