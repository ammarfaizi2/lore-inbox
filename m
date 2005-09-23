Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVIWTAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVIWTAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVIWTAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:00:24 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:14597 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751152AbVIWTAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:00:23 -0400
Message-ID: <433450C4.2080104@vmware.com>
Date: Fri, 23 Sep 2005 12:00:20 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] Gdt page isolation
References: <200509220749.j8M7nINV001001@zach-dev.vmware.com> <20050922131714.GA97170@muc.de>
In-Reply-To: <20050922131714.GA97170@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2005 19:00:21.0307 (UTC) FILETIME=[0BE128B0:01C5C071]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>> 	 * This grunge runs the startup process for
>> 	 * the targeted processor.
>> 	 */
>>+	cpu_gdt_descr[cpu].address = __get_free_page(GFP_KERNEL|__GFP_ZERO);
>>    
>>
>
>I can see why don't check it for NULL, but it's a ugly reason
>and would be better fixed. It at least needs a comment.
>
>-Andi (who would still prefer just going back to the array
>in head.S - would work as well and waste less memory) 
>  
>

The array in head.S does waste more memory if you compile for NR_CPUS >> 
actual cpus.  But the primary reason for allocating on individual pages 
is to preserve the hypervisor GDT entries for Xen.  Xen relies on a GDT 
virtualization technique which uses descriptors in the high part of the 
GDT.  Keep in mind, the GDT is a paged data structure.  So here is what 
they do:

Linear address space:

+---------------------------+  4GB
|                           | 
|  Xen code, heap           |
|                           |
|                           |
+---------------------------+
|                           |  GDT virtual mapping
|  Xen per-domain mappings  |==(page 15)====> hypervisor physical page
|                           |==(page 1-14)==> zeroed pages
|  GDT (16 pages)           |==(page 0)==+
+---------------------------+  -168 ? MB |
|                           |            |
|  MPT tables               |            |
|                           |            |
|                           |            |
+---------------------------+            |
|                           |            |
|  Guest kernel             |            |
|                           |            |
|                           |            |
|                           |            |
|                           |            |
|  GDT 256 bytes, read-only |============+==> guest physical page
|                           |
+---------------------------+  3GB


So, the GDT mapping which is live in the hypervisor consists of guest 
GDT pages following by blank pages, followed by a page which is reserved 
for Xen private GDT mappings.  The guest pages are mapped into the 
guest, read-only.

This imposes a strict requirement on the guest regarding sharing of data 
on the GDT pages; it is impossible to share arbitrary data, even if it 
is read-only.  All data on thes pages must conform to the rules for 
valid guest GDT descriptors, which only GDT and LDT entries are forced 
to do.

So while it is technically possible to share the per-cpu GDTs on the 
same set of pages, the entire thing must be padded, page-aligned, and 
zeroed of any unused data.  Unless you go to a complicated scheme where 
per-cpu GDTs are colored and shared, you have an arbitrary limit (240) 
on the number of virtual CPUs.

So for now, the approach Xen is currently using appears to be simplest 
and most flexible to implement in terms of one page per CPU for the GDT.

Zach
