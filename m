Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVBAIHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVBAIHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVBAIHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:07:04 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:39886 "HELO
	ns.intellilink.co.jp") by vger.kernel.org with SMTP id S261836AbVBAICt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:02:49 -0500
Message-ID: <41FF381B.4080904@intellilink.co.jp>
Date: Tue, 01 Feb 2005 17:04:43 +0900
From: Koichi Suzuki <koichi@intellilink.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: ebiederm@xmission.com, Andrew Morton <akpm@osdl.org>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based	crashdumps.
References: <overview-11061198973484@ebiederm.dsl.xmission.com>	 <1106294155.26219.26.camel@2fwv946.in.ibm.com>	 <m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>	 <1106305073.26219.46.camel@2fwv946.in.ibm.com>	 <m17jm72fy1.fsf@ebiederm.dsl.xmission.com>	 <1106475280.26219.125.camel@2fwv946.in.ibm.com>	 <m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>	 <1106833527.15652.146.camel@2fwv946.in.ibm.com> <m1zmyueh4c.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1zmyueh4c.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hook in panic code is very good idea and is useful in various scenes. 
It could be used to kick RAM dump code, obviously, and also kick the 
code to initiate failover, etc.   Various use could be possible so I 
believe that this hook should be prepared for wider use.

--
Koichi Suzuki
NTT DATA Intellilink Corp.

ebiederm@xmission.com wrote:
> For the guys on ppc, and other architectures that have all of their
> cpu memory behind an iommu.  I propose we create a /proc/cpumem
> which is the subset of /proc/iomem that deals with RAM.  In any event
> as something like that is straight forward to implement I will
> assume the existence of the functionality and we can attack the
> details when we do the merge the first of those architectures
> into the kernel.
> 
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> 
>>Hi Eric,
>>
>>It looks like we are looking at things a little differently. I
>>see a portion of the picture in your mind, but obviously not 
>>entirely.
>>
>>Perhaps, we need to step back and iron out in specific terms what 
>>the interface between the two kernels should be in the crash dump
>>case, and the distribution of responsibility between kernel, user space
>>and the user. 
>>
>>[BTW, the patch was intended as a step in development up for
>>comment early enough to be able to get agreement on the interface
>>and think issues through to more completeness before going 
>>too far. Sorry, if that wasn't apparent.]
> 
> 
> It wasn't quite, and the fact that Andrew picked it up added
> to the confusion.
> 
> 
>>When you say "evil intermingling", I'm guessing you mean the
>>"crashbackup=" boot parameter ? If so, then yes, I agree it'd
>>be nice to find a way around it that doesn't push hardcoding
>>elsewhere.
> 
> 
> I believe there are some alternatives to crashbackup= in the 
> crashdump capture kernel.  But as long as that code is running
> in the kernel we can't do a lot better.
> 
> However for the primary kernel it has no need to know that we
> even have a backup region, nor does it need to know about the
> size of the backup region.  That can all be handled with the single
> reservation, we have now.  
> 
> /sbin/kexec which makes the backup needs to know about it and it needs
> to pass that information on.  But the primary kernel does not. 
> 
> The largest reason I am sensitive to this issue is that if you are not
> booting an SMP kernel I don't believe we need a backup region on x86
> at all.  If we can remove that dependency I want the freedom to do
> that without having to modify the primary kernel.  Or if we discover
> we need to preserve other things like the ACPI, mp and pirq tables
> I don't want to require patching the kernel just so I can copy those
> and preserve them.
>  
> 
>>Let me explain the interface/approach I was looking at.
>>
>>1.First kernel reserves some area of memory for crash/capture kernel as
>>specified by crashkernel=X@Y boot time parameter.
>>
>>2.First kernel marks the top 640K of this area as backup area. (If
>>architecture needs it.) This is sort of a hardcoding and probably this
>>space reservation can be managed from user space as well as mentioned by
>>you in this mail below.
>>
>>3. Location of backup region is exported through /proc/iomem which can
>>be read by user space utility to pass this information to purgatory code
>>to determine where to copy the first 640K.
> 
> 
> And 1-3 can be done in /sbin/kexec.  And if it is done there we can
> increase our freedom of implementation in the crashdump capture process
> quite a bit.
> 
> 
>>Note that we do not make any additional reservation for the 
>>backup region. We carve this out from the top of the already 
>>reserved region and export it through /proc/iomem so that 
>>the user space code and the capture kernel code need not 
>>make any assumptions about where this region is located.
>>
>>4. Once the capture kernel boots, it needs to know the location of
>>backup region for two purposes.
>>        
>>a. It should not overwrite the backup region.
>>
>>b. There needs to be a way for the capture tool to access the original
>>   contents of the backed up region
>>
>>Boot time parameter crashbackup=A@B has been provided to pass this
>>information to capture kernel. This parameter is valid only for capture
>>kernel and becomes effective only if CONFIG_CRASH_DUMP is enabled.
> 
> 
> But that is not what you implemented.  crashbackup= was an alternative
> to the carving out of 640K in parts 1-3.
> 
> 
>>>What is wrong with user space doing all of the extra space
>>>reservation?
>>
>>Just for clarity, are you suggesting kexec-tools creating an additional
>>segment for the backup region and pass the information to kernel.
> 
> 
> Yes, having kexec create a bss segment for the backup region would
> be a good idea.  It will keep us from stomping on the kernel trampoline
> (think the identity mapped x86_64 page tables here) by accident.
>  
> 
>>There is no problem in doing reservation from user space except
>>one. How does the user and in-turn capture kernel come to know the
>>location of backup region, assuming that the user is going to provide
>>the exactmap for capture kernel to boot into.
>>
>>Just a thought, is it  a good idea for kexec-tools to be creating and
>>passing memmap parameters doing appropriate adjustment for backup
>>region.
> 
> 
> Exactly.  Having /sbin/kexec do this instead of the user doing this
> manually is a much simpler solution than we have now.
> 
> 
>>I had another question. How is the starting location of elf headers 
>>communicated to capture tool? Is parameter segment a good idea? or 
>>some hardcoding? 
> 
> 
> I recognize the need for that information.  But I do not recognize
> the need for it to be an ELF header (we do need something
> conceptually close).  If we don't have regions of the memory map
> appearing and disappearing dynamically we can get this information
> from /proc/iomem, before the crash and store it in one of the data
> segments that we checksum.
>  
> 
>>Another approach can be that backup area information is encoded in elf
>>headers and capture kernel is booted with modified memmap (User gets
>>backup region information from /proc/iomem) and capture tool can
>>extract backup area information from elf headers as stored by first
>>kernel.
>>
>>Could you please elaborate a little more on what aspect of your view
>>differs from the above.
> 
> 
> See above.
> 
> The direction I would take if I was to take to implementing this 
> the crashdump functionality is something different.
> 
> Instead of patching crashdump functionality into the kernel,
> I would create a subdirectory in kexec-tools called crashdump
> and put in the source for a user-space program that could run as
> init.  In addition I would but in the code to generate and
> initramfs cpio.gz archive of that program.  And I would build
> the program against uclibc, klibc or one of the other libc variants
> that actually allows building static binaries.  Unless something
> has changed recently glibc does not all for truly static binaries
> as it dynamically open /lib/libnss*
> 
> Given the pain of building against an external library that is not
> widely distributed I would probably take a snapshot of the code and
> place it in crashdump/libc in the kexec-tools source.  Taking a
> snapshot of frequently used libraries is commonly done with the
> gnu toolchain and is wonderfully effective in resolving painful
> dependencies.
> 
> The crashdump /init would just mmap /dev/mem to read the raw memory.
>>From there it would generate the core file.
> 
> When kexec'ing a panic kernel I would simply have /sbin/kexec
> unconditionally load that cpio.gz as the initrd and things
> would work.
> 
> The large advantage of doing all of this in user space
> is that it moves all of the crashdump policy into user space
> and into one source tree, for simplified maintenance.
> 
> However as long as we gracefully handle the interface
> between the primary kernel and the capture kernel we can
> switch mechanisms for actually taking the crash dump,
> kernel based or user space as seems most sane.
> 
> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

