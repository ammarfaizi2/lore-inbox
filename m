Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWCVWqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWCVWqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbWCVWpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:45:31 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:45828 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964822AbWCVWpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:45:17 -0500
Message-ID: <4421D379.3090405@vmware.com>
Date: Wed, 22 Mar 2006 14:45:13 -0800
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
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <200603222105.58912.ak@suse.de> <200603222239.46604.ak@suse.de>
In-Reply-To: <200603222239.46604.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> There was one other point I wanted to make but I forgot it now @)
>>     
>
> Ah yes the point was that since most of the implementations of the hypercalls
> likely need fast access to some per CPU state. How would you plan
> to implement that? Should it be covered in the specification?
>   

Probably.  We don't have that issue currently, as we have a private 
mapping of CPU state for each VCPU at a fixed address.  Seeing as that 
is not so feasible under Xen, I would say we need to put something in 
the spec.

The way Xen deals with this is rather gruesome today.  It needs 
callbacks into the kernel to disable preemption so that it can 
atomically compute the address of the VCPU area, just so that it can 
disable interrupts on the VCPU.  These contortions make backbending look 
easy.

I propose an entirely different approach - use segmentation.  This needs 
to be in the spec, as we now need to add VMI hook points for saving and 
restoring user segments.  But in the end it wins, even if you can't 
support per-cpu mappings using paging, you can do it with segmentation.  
You'll likely get even better performance.  And you don't have to worry 
about these unclean callbacks into the guest kernel that really make the 
interface between Xen and XenoLinux completely enmeshed.  And you can 
disable interrupts in one instruction:

movb $0, %gs:hypervisor_intFlags

Zach
