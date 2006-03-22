Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWCVW5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWCVW5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWCVW5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:57:55 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:4371 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751421AbWCVW5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:57:54 -0500
Message-ID: <4421D64F.6040907@vmware.com>
Date: Wed, 22 Mar 2006 14:57:19 -0800
From: Dan Hecht <dhecht@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 07/35] Make LOAD_OFFSET defined by subarch
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063746.389133000@sorel.sous-sol.org>
In-Reply-To: <20060322063746.389133000@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2006 22:57:19.0241 (UTC) FILETIME=[F8C8B790:01C64E03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> Change LOAD_OFFSET so that the kernel has virtual addresses in the elf header fields.
> 
> Unlike bare metal kernels, Xen kernels start with virtual address
> management turned on and thus the addresses to load to should be
> virtual addresses.
> 

Rather than changing LOAD_OFFSET in Linux, why not leave this alone and 
change the Xen domain builder to properly interpret the ELF program 
header fields?

i.e. with this change, we'd have

p_paddr = __PAGE_OFFSET + segment_offset
p_vaddr = __PAGE_OFFSET + segment_offset
VIRT_BASE = __PAGE_OFFSET

where, the VA mapping p_paddr -> (p_paddr-VIRT_BASE) is established by 
the domain builder.

Instead, why not drop this patch, and the VIRT_BASE portion of the 
__xen_guest section, and instead change Xen's domain builder to treat 
p_paddr and p_vaddr in a more standard way?  Since Xen starts the domain 
with virtual address management enabled, it makes sense for it to use 
p_vaddr to determine the virtual address to load the kernel to.  Then, 
p_paddr could be used to determine which pseudo-physical pages back that 
virtual address range.

i.e. use, just like vanilla linux:

p_paddr = segment_offset
p_vaddr = __PAGE_OFFSET + segment_offset

so these two fields directly indicate the same mapping as before, but 
now in terms of p_vaddr -> p_paddr, which makes sense, and no need for 
the extra VIRT_BASE attribute in the __xen_guest section.

Dan
