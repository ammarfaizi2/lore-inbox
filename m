Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVA1MOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVA1MOz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 07:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVA1MOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 07:14:55 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:43240 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261297AbVA1MOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 07:14:48 -0500
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
	crashdumps.
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <m1zmyueh4c.fsf@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	 <1106294155.26219.26.camel@2fwv946.in.ibm.com>
	 <m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	 <1106305073.26219.46.camel@2fwv946.in.ibm.com>
	 <m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
	 <1106475280.26219.125.camel@2fwv946.in.ibm.com>
	 <m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
	 <1106833527.15652.146.camel@2fwv946.in.ibm.com>
	 <m1zmyueh4c.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: 
Message-Id: <1106917583.15652.234.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jan 2005 18:36:23 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,


However for the primary kernel it has no need to know that we
> even have a backup region, nor does it need to know about the
> size of the backup region.  That can all be handled with the single
> reservation, we have now.  
> 
> /sbin/kexec which makes the backup needs to know about it and it needs
> to pass that information on.  But the primary kernel does not. 


Agreed. Primary kernel need not to be aware of backup region and 
reservation of this region can be better managed from user space.


> > Boot time parameter crashbackup=A@B has been provided to pass this
> > information to capture kernel. This parameter is valid only for capture
> > kernel and becomes effective only if CONFIG_CRASH_DUMP is enabled.
> 
> But that is not what you implemented.  crashbackup= was an alternative
> to the carving out of 640K in parts 1-3.


Not really. crashbackup= is not being used for carving out backup
region. It is just used for passing the address of this region to second
kernel. That's why it has been put under CONFIG_CRASH_DUMP.


> > > What is wrong with user space doing all of the extra space
> > > reservation?
> > 
> > Just for clarity, are you suggesting kexec-tools creating an additional
> > segment for the backup region and pass the information to kernel.
> 
> Yes, having kexec create a bss segment for the backup region would
> be a good idea.  It will keep us from stomping on the kernel trampoline
> (think the identity mapped x86_64 page tables here) by accident.
>  
> > There is no problem in doing reservation from user space except
> > one. How does the user and in-turn capture kernel come to know the
> > location of backup region, assuming that the user is going to provide
> > the exactmap for capture kernel to boot into.
> >
> > Just a thought, is it  a good idea for kexec-tools to be creating and
> > passing memmap parameters doing appropriate adjustment for backup
> > region.
> 
> Exactly.  Having /sbin/kexec do this instead of the user doing this
> manually is a much simpler solution than we have now.
> 
> > I had another question. How is the starting location of elf headers 
> > communicated to capture tool? Is parameter segment a good idea? or 
> > some hardcoding? 
> 
> I recognize the need for that information.  But I do not recognize
> the need for it to be an ELF header (we do need something
> conceptually close).  If we don't have regions of the memory map
> appearing and disappearing dynamically we can get this information
> from /proc/iomem, before the crash and store it in one of the data
> segments that we checksum.
>  


This looks good. So memory regions are parsed from /proc/iomem and this
information is put in one data segment and stored in reserved region
during panic kernel load time.

But I am unable to co-relate as to how the capture tool (even if its all
in user space) gets to know the address of this segment (or for that
matter, the bss segment created for backup region). Am I missing
something obvious.


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
> >From there it would generate the core file.
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


This seems to be a good direction.


Thanks 
Vivek


