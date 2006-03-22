Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932890AbWCVWn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbWCVWn5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbWCVWnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:43:33 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:772 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932910AbWCVWnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:43:13 -0500
Message-ID: <4421D2FC.7000903@vmware.com>
Date: Wed, 22 Mar 2006 14:43:08 -0800
From: Daniel Arai <arai@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Zachary Amsden <zach@vmware.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>There was one other point I wanted to make but I forgot it now @)
> 
> 
> Ah yes the point was that since most of the implementations of the hypercalls
> likely need fast access to some per CPU state. How would you plan
> to implement that? Should it be covered in the specification?

I can explain how it works, but it's deliberately not part of the specification.

The whole point of the ROM layer is that it abstracts away the actual hypercall 
mechanism for the guest, and the hypervisor can implement whatever is 
appropriate for it.  This layer allows a VMI guest to run on VMware's 
hypervisor, as well as on top of Xen.

We reserve the top 64MB of linear address space for the hypervisor.

Part of this reserved space contains data structures that are shared by the VMI 
ROM layer and the hypervisor.  Simple VMI interface calls like "read CR 2" are 
implemented by reading or writing data from this shared data structure, and 
don't require a privilege level change.  Things like page table updates go into 
a queue in the shared area, so they can easily be batched and processed with 
only one actual call into the hypervisor.

Because the guest can manipulate this data page directly, the hypervisor has to 
treat any information in it as untrusted.  This is similar to how the kernel has 
to treat syscall arguments.  Guest user code can't touch the shared area, so it 
doesn't introduce any new kernel security holes.  The guest kernel could 
deliberately mess up the shared area contents, but guest kernel code could 
corrupt any arbitrary (virtual) machine state anyway.

Because this level of interface is hidden from the guest, we can (and do) make 
changes to it without changing VMI itself, or needing to recompile the guest. 
We deliberately do not document it.  A guest that adheres to the VMI interface 
can move to new versions of the ROM/hypervisor interface (that implement the 
same VMI interface) without changes.

Dan.
