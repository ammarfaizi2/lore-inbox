Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVC1NCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVC1NCf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVC1NCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:02:35 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:35201 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261724AbVC1NA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:00:58 -0500
Message-ID: <4247FFE6.5060500@in.ibm.com>
Date: Mon, 28 Mar 2005 18:30:22 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Obtaining memory information for kexec/kdump
References: <424254E0.6060003@in.ibm.com>	 <1111650644.9881.43.camel@localhost>  <4242941A.3050501@in.ibm.com> <1111678371.9881.46.camel@localhost>
In-Reply-To: <1111678371.9881.46.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Thu, 2005-03-24 at 15:49 +0530, Hariprasad Nellitheertha wrote:
> 
>>Dave Hansen wrote:
>>
>>>I think there's likely a lot of commonality with the needs of memory
>>>hotplug systems here.  We effectively dump out the physical layout of
>>>the system, but in sysfs.  We do this mostly because any memory hotplug
>>>changes generate hotplug events, just like all other hardware.  If you
>>>do this in /proc, it's another thing that memory hotplug will have to
>>>update.  
>>
>>We put it in /proc primarily because what we wanted was 
>>similar in many ways to /proc/iomem and so we (re)use a bit 
>>of the code.
> 
> 
> The code reuse is nice, but the expanded use of /proc is not.  
> 
> 
>>Also, we were wondering if it is appropriate to 
>>put in multiple values in a single file in sysfs.
> 
> 
> Why would you need to do that?

Because we are putting the starting address, end address and 
the memory type against each entry (just like in 
/proc/iomem). Of course, we can figure out the ending 
address knowing the starting address and the section size.

> 
>>  I've attached a document I started writing a couple days ago
>>
>>>about the sysfs layout and the call paths for hotplug.  It's horribly
>>>incomplete, but not a bad start.
>>>
>>>If you want to see some more details of the layout, please check out
>>>this patch set:
>>>
>>>http://www.sr71.net/patches/2.6.12/2.6.12-rc1-mhp1/patch-2.6.12-rc1-mhp1.gz
>>
>>This does not have the sysfs related code. Is there a 
>>separate patch for adding the sysfs entries?
> 
> 
> Hmmm.  I think my rollup script broke.  Try this:
> 
> http://www.sr71.net/patches/2.6.12/2.6.12-rc1-mhp1/broken-out/L0-sysfs-memory-class.patch

In addition to this, I also needed to pull-in the 
J-zone_resize_sem.patch to get it to compile.

Would it be possible to make this a separate patch-set so 
that it does not depend on memory hotplug.

> 
> 
>>>block_size_bytes:  The size of each memory section (in hex)
>>
>>This value is per memoryXXXX directory, right?
> 
> 
> No, it's global.  However, we have discussed doing it per-section in the
> future to collapse some of the contiguous areas into a single directory.

I tested this on my PIII 256M machine. 
/sys/devices/system/memory showed 4 memory sections each of 
size 64MB. There are a couple of issues that we noticed. We 
will not be able to spot those physical memory areas which 
the OS does not use (such as the region between 640k and 
1MB). Also, when I booted the system with the mem=100M 
option, two entries (memory0 and memory1) turned up. With 
block_size_bytes being 64M, this turns out equivalent to a 
system with 128M memory.

If block_size_bytes was per-directory, it would be easier in 
such situations.

Regards, Hari
