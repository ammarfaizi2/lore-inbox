Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVBBJQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVBBJQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 04:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVBBJQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 04:16:57 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:7861 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262221AbVBBJQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 04:16:49 -0500
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
	crashdumps.
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <m13bwgb8tb.fsf@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	 <1106294155.26219.26.camel@2fwv946.in.ibm.com>
	 <m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	 <1106305073.26219.46.camel@2fwv946.in.ibm.com>
	 <m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
	 <1106475280.26219.125.camel@2fwv946.in.ibm.com>
	 <m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
	 <1106833527.15652.146.camel@2fwv946.in.ibm.com>
	 <m1zmyueh4c.fsf@ebiederm.dsl.xmission.com>
	 <1106917583.15652.234.camel@2fwv946.in.ibm.com>
	 <m1r7k5e1ql.fsf@ebiederm.dsl.xmission.com>
	 <1107271039.15652.839.camel@2fwv946.in.ibm.com>
	 <m13bwgb8tb.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: 
Message-Id: <1107338864.11609.35.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Feb 2005 15:37:44 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 20:56, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > Well, trying to put the already discussed ideas together.  I was
> > planning to work on following design. Please comment.
> > 
> > Crashed Kernel <-->Capture Kernel(or User Space) Interface:
> > ----------------------------------------------------------
> > 
> > The whole idea is that Crash image is represented in ELF Core format.
> > These ELF Headers are prepared by kexec-tools user space and put in one
> > segment. Address of start of image is passed to the capture kernel(or
> > user space) using one command line (eg. crashimage=). Now either kernel
> > space or user space can parse the elf headers and extract required
> > information and export final kernel elf core image.
> 
> Sounds sane.  We need to make certain there is a checksum of that
> region but putting it in a separate segment should ensure that.
> 
> I also think we need to look at the name crashimage= and see if we
> can find something more descriptive.  But that is minor.  Possibly
> elfcorehdr=  We have a little while to think about that one before we
> are stuck.

"elfcorehdr=" also looks good.

> 
> > > ebiederm@xmission.com wrote: 
> > > If we were using an ELF header I would include one PT_NOTE program 
> > > header per cpu (Giving each cpu it's own area to mess around in).
> > > And I would use one PT_LOAD segment per possible memory zone.
> > > So in the worst case (current sgi altix) (MAX_NUMNODES=256,
> > > MAX_NR_ZONES=3, MAX_NR_CPUS=1024) 256*3+1024 = 1792 program
> > > headers.   At 56 bytes per 64bit program header that is 100352 bytes
> > > or 98KiB.  A little bit expensive.  A tuned data structure with
> > > 64bit base and size would only consume 1792*16 = 28672 or 28KiB.
> > 
> > If I prepare One elf header for each physical contiguous memory area (as
> > obtained from /proc/iomem) instead of per zone, then number of elf
> > headers will come down significantly. 
> 
> A clarification on terminology we are talking about struct Elf64_Phdr
> here.  There is only one Elf header.  That seems to be clear farther
> down.
> 


Exactly. There shall be one Elf header for whole of the image. In
addition there will be one struct Elf64_Phdr, per contiguous physical
memory area. One Elf64_Phdr of PT_NOTE type for notes section and one
Elf64_Phdr for backup region.


> > I don't have any idea on number of
> > actual physically contiguous regions present per machine, but roughly
> > assuming it to be 1 per node, it will lead to 256 + 1024 = 1280 program
> > headers.At 56 bytes per 64 bit program header this will amount to 70KB. 
> > 
> > This is worst case estimate and on lower end machines this will require
> > much less a space. On machines as big as 1024 cpus, this should not be a
> > concern, as big machines come with big RAMs.
> 
> Agreed.  Size is not the primary issue.  There is some clear waste
> but that is a secondary concern.  Not performing a 1-1 mapping
> to the kernel data structures also seems to be a win, as the concepts
> are noticeably different.
>  
> > Eric, do you still think that ELF headers are inappropriate to be passed
> > across interface boundary.
> 
> I have serious concerns about the kernel generating the ELF headers
> and only delivering them after the kernel has crashed.  Because
> then we run into questions of what information can be trusted.  If we
> avoid that issue I am not too concerned.


I hope, all elf headers once prepared by kexec-tools need not to change
later (Cannot think of any piece of information which shall change
later). These shall be put in separate segment. And SHA-256 shall take
care of authenticity of information after crash.


>  
> > Regarding Backup Region
> > -----------------------
> > 
> > - Kexec user space does the reservation for backup region segment.
> > - Purgatory copies the backup data to backup region. (Already
> > implemented)
> > - A separate elf header is prepared to represent backed up memory
> > region. And "offset" field of this program header can contain the actual
> > physical address where backup contents are stored. 
> 
> I like that.  I was thinking a virtual versus physical address
> separation.  But using the offset field is much more appropriate,
> and it leaves us the potential of doing something nice like specifying
> the kernels virtual address later on.  Looking exclusively at the
> offset field to know which memory addresses to dump sounds good.
> For now we should have virtual==physical==offset except for the
> backup region.


For notes section program header, virtual = physical = 0 and "offset"
shall point to crash_notes[], so that notes can directly be read by the
capture kernel (or user space).

Thanks
Vivek

