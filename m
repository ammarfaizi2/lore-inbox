Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVHXVSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVHXVSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHXVSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:18:44 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:46084 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932239AbVHXVSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:18:43 -0400
Message-ID: <430CE428.3000605@vmware.com>
Date: Wed, 24 Aug 2005 14:18:32 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>
Subject: Re: [PATCH 5/5] Create a hole in high linear address space
References: <200508241845.j7OIjIeM001900@zach-dev.vmware.com> <20050824201920.GN7762@shell0.pdx.osdl.net>
In-Reply-To: <20050824201920.GN7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2005 21:18:32.0929 (UTC) FILETIME=[61ADC510:01C5A8F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* Zachary Amsden (zach@vmware.com) wrote:
>  
>
>>Allow compile time creation of a hole at the high end of linear address space.
>>This makes accomodating a hypervisor a much more tractable problem by giving
>>it ample playground to live in.  Currently, the hole size is fixed at config
>>time; I have experimented with dynamically sized holes, and have a later
>>patch that developes this potential, but it becomes much more useful once
>>the exact negotiation of linear address space with the hypervisor is defined.
>>
>>The fixed compile time solution is sufficient for now.
>>    
>>
>
>Xen moves __FIXADDR_TOP like this:
>
>#ifdef CONFIG_X86_PAE
># define HYPERVISOR_VIRT_START (0xF5800000UL)
>#else
># define HYPERVISOR_VIRT_START (0xFC000000UL)
>#endif
>
>and
>
>#define __FIXADDR_TOP  (HYPERVISOR_VIRT_START - 2 * PAGE_SIZE)
>
>and also adds bits to fixmap.
>
>So this proposed mechanism isn't quite good enough.
>  
>

Hmm.  I was thinking it would be compile time variable with defaults -- like

config MEMORY_HOLE
       int "Create hole at top of memory (0-512 MB)"
       range 0 512
       default "0"
       default 168 if (CONFIG_X86_PAE && CONFIG_X86_HYPERVISOR)
       default 64 if (!CONFIG_X86_PAE && CONFIG_X86_HYPERVISOR)
       help
          Useful for creating a hole in the top of memory when running
          inside of a virtual machine monitor.

Adding things to the fixmap is a separate concept, thus a separate patch ;)

Zach
