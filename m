Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVHFALN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVHFALN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVHFALM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:11:12 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:42512 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262091AbVHFALF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:11:05 -0400
Message-ID: <42F3FFBA.3040009@vmware.com>
Date: Fri, 05 Aug 2005 17:09:30 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: Re: [PATCH, experimental] i386 Allow the fixmap to be relocated at
 boot time
References: <42F3F61F.30305@vmware.com> <20050805234655.GY7762@shell0.pdx.osdl.net>
In-Reply-To: <20050805234655.GY7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Aug 2005 00:09:33.0375 (UTC) FILETIME=[1F8854F0:01C59A1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* Zachary Amsden (zach@vmware.com) wrote:
>  
>
>>This most curious patch allows the fixmap on i386 to be unfixed.  The 
>>result is that we can create a dynamically sizable hole at the top of 
>>kernel linear address space.  I know at least some virtualization 
>>developers are interested in being able to achieve this to achieve 
>>run-time sizing of a hole in which a hypervisor can live, or at least to 
>>test out the performance characteristics of different sized holes.
>>    
>>
>
>I've done it simpler with keeping it fixed but defined by the subarch.
>Patch is stupid simple (and untested).  Do you think there's a huge gain
>for dynamically sizing?
>

Your patch looks good, although the minimal change to subarch is to 
merely have __FIXADDR_TOP defined by the sub-architecture.  Is there any 
additional benefit to moving the fixmaps into the subarch - i.e. moving 
subarch-specific pieces out of mach-default?

I guess there is.  For example include/asm-i386/mach-visws/mach_fixmap.h 
could do this:

#define SUBARCH_FIXMAPS \
        FIX_CO_CPU,     /* Cobalt timer */ \
        FIX_CO_APIC,    /* Cobalt APIC Redirection Table */ \
        FIX_LI_PCIA,    /* Lithium PCI Bridge A */ \
        FIX_LI_PCIB,    /* Lithium PCI Bridge B */

Then include/asm-i386/fixmap.h includes <mach_fixmap.h>, for which the 
default is an empty define for SUBARCH_FIXMAPS.

And then you don't have to maintain the list of common fixmaps across 
the sub-architecture layer or uglify the top level fixmaps with SGI 
Visual Workstation support.

Also, it seems reasonable that people may want to poke holes in high 
linear space for other hypervisor projects, research, or performance 
reasons without having to build a custom sub-architecture just for 
that.  So I think there is some benefit to making the hole size a 
general configurable option (with defaults depending on the sub-arch you 
select).

I have no idea if the dynamic sizing has any performance impact yet, but 
it may be a big win in terms of flexibility.  I would be curious to hear 
more from the Xen core team (I know Ian mentioned he would like to try 
this out at one point in time).

Zach
