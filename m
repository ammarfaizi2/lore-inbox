Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317759AbSGZPBR>; Fri, 26 Jul 2002 11:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317760AbSGZPBR>; Fri, 26 Jul 2002 11:01:17 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:40652 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317759AbSGZPBQ>; Fri, 26 Jul 2002 11:01:16 -0400
Message-ID: <3D416603.2000107@snapgear.com>
Date: Sat, 27 Jul 2002 01:08:51 +1000
From: gerg <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28
References: <3D40A3E4.9050703@snapgear.com>  <3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com> <9143.1027671559@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> gerg@snapgear.com said:
>> You may have noticed some MAGIC_ROM_PTR patches in the mtd driver
>>code in this patch. This is to allow XIP for applications. We have
>>been support XIP for quite some time on uClinux, it works really well.
> 
>>A problem we have experienced with MTD is that the nature of
>>asynchronous writing to FLASH does not play nice with apps runing XIP.
>> Any thoughts on how to deal with this?
> 
> Other than burying my head in the sand and hoping that someone starts 
> making dual-port flash? Sort of...

:-)


> XIP of the kernel makes it harder, of course -- writing to the chip you're
> running the _kernel_ from turns your entire text segment into status words,
> so really I can't see any alternative but to copy the flash manipulation
> routines into RAM, disable all interrupts, and get on with it. 

Not at all unresonable. I don't think there is any other real
alternative if you want your kernel running from flash, and
you want to write to flash.


> If we're talking about XIP of just userspace pages, I have a vague plan for 
> that which may be slightly more feasible. If it holds up to the cold light 
> of day, perhaps you can help adjust it to work with uClinux.
> 
> The plan is to hand out pages to be mapped into userspace (or indeed kernel 
> space -- JFFS2 can speed up mounts this way too), but which get marked 
> absent when the flash driver talks to the chip. If your applications then 
> take a page fault, you can either suspend the operation or just make them 
> wait till it's complete.
> 
> The actual implementation of this should be relatively simple. We can 
> provide a generic_mtd_vm_ops and the chip drivers just need to know about 
> an extra state for 'mapped' and have a method to enter that state, and a 
> callback for when they want to _leave_ that state. Oh, and a way to get the 
> raw physical address for a given range of flash.

The MAGIC_ROM_PTR support in the uClinux patch adds a field to
the block_device_operations and file_operations structures that
allows getting at the physical address in flash.



> It occurs to me that this doesn't work too well without an MMU though. Got 
> any better ideas? Could we disable entire processes when one of their pages 
> is inaccessible?

Disabling processes that are known to be running direct from flash
sounds workable. (There is no real notion of separating pages under
uClinux - it is an all or nothing mapping. The text, data, bss, etc
are always a single contiguous region in the address space).

More generous lock that really required for general VM linux, but at
least the whole process model works for both VM and non-VM linux.
I would expect this avoids any potential loop/deadlock with pages
(going on the discussion in follow up emails anyway).

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

