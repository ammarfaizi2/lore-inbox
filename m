Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVBAP3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVBAP3B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVBAP3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:29:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37865 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262039AbVBAP2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:28:24 -0500
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Feb 2005 08:26:24 -0700
In-Reply-To: <1107271039.15652.839.camel@2fwv946.in.ibm.com>
Message-ID: <m13bwgb8tb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Well, trying to put the already discussed ideas together.  I was
> planning to work on following design. Please comment.
> 
> Crashed Kernel <-->Capture Kernel(or User Space) Interface:
> ----------------------------------------------------------
> 
> The whole idea is that Crash image is represented in ELF Core format.
> These ELF Headers are prepared by kexec-tools user space and put in one
> segment. Address of start of image is passed to the capture kernel(or
> user space) using one command line (eg. crashimage=). Now either kernel
> space or user space can parse the elf headers and extract required
> information and export final kernel elf core image.

Sounds sane.  We need to make certain there is a checksum of that
region but putting it in a separate segment should ensure that.

I also think we need to look at the name crashimage= and see if we
can find something more descriptive.  But that is minor.  Possibly
elfcorehdr=  We have a little while to think about that one before we
are stuck.

> > ebiederm@xmission.com wrote: 
> > If we were using an ELF header I would include one PT_NOTE program 
> > header per cpu (Giving each cpu it's own area to mess around in).
> > And I would use one PT_LOAD segment per possible memory zone.
> > So in the worst case (current sgi altix) (MAX_NUMNODES=256,
> > MAX_NR_ZONES=3, MAX_NR_CPUS=1024) 256*3+1024 = 1792 program
> > headers.   At 56 bytes per 64bit program header that is 100352 bytes
> > or 98KiB.  A little bit expensive.  A tuned data structure with
> > 64bit base and size would only consume 1792*16 = 28672 or 28KiB.
> 
> If I prepare One elf header for each physical contiguous memory area (as
> obtained from /proc/iomem) instead of per zone, then number of elf
> headers will come down significantly. 

A clarification on terminology we are talking about struct Elf64_Phdr
here.  There is only one Elf header.  That seems to be clear farther
down.

> I don't have any idea on number of
> actual physically contiguous regions present per machine, but roughly
> assuming it to be 1 per node, it will lead to 256 + 1024 = 1280 program
> headers.At 56 bytes per 64 bit program header this will amount to 70KB. 
> 
> This is worst case estimate and on lower end machines this will require
> much less a space. On machines as big as 1024 cpus, this should not be a
> concern, as big machines come with big RAMs.

Agreed.  Size is not the primary issue.  There is some clear waste
but that is a secondary concern.  Not performing a 1-1 mapping
to the kernel data structures also seems to be a win, as the concepts
are noticeably different.
 
> Eric, do you still think that ELF headers are inappropriate to be passed
> across interface boundary.

I have serious concerns about the kernel generating the ELF headers
and only delivering them after the kernel has crashed.  Because
then we run into questions of what information can be trusted.  If we
avoid that issue I am not too concerned.
 
> ELF headers can be prepared by kexec-tools in advance and put into one
> of the data segments. This requires following information to be
> available to user space.

For a first round doing it in user space sounds sane.  Obtaining
the information at the time of load is much more robust.

> - Starting address of space reserved by kernel for notes section
> (crash_notes[]). Probably can be obtained from /proc/kallsysms?

At least for a start.
 
> - NR_CPUS. May be sysconf(_SC_NPROCESSORS_CONF) should be
> sufficient.

Either that or /proc/cpuinfo.  But the sysconf approach looks more
robust at this point.

> - Size of memory reserved per cpu. No clue how to get that? Any
> suggestions? 
> 	May be hard-coding like 1K area per cpu should be to address the
> 	future needs ?

The nice thing about doing this in user space is that we can hack
something together and get each side of the interface sorted
out independently.  i.e. We can hard code it for now.  Sort out
the users and then come back and make certain we have the information
exported cleanly. 1K per cpu currently matches the kernel code so
it is a good place to start :)

It does look like getting the size of each array element is a problem,
so the current kernel code certainly needs to be revisited.  And
there are quite a few other things pieces of how we are obtaining
the information that can be fixed as well.

> Regarding Backup Region
> -----------------------
> 
> - Kexec user space does the reservation for backup region segment.
> - Purgatory copies the backup data to backup region. (Already
> implemented)
> - A separate elf header is prepared to represent backed up memory
> region. And "offset" field of this program header can contain the actual
> physical address where backup contents are stored. 

I like that.  I was thinking a virtual versus physical address
separation.  But using the offset field is much more appropriate,
and it leaves us the potential of doing something nice like specifying
the kernels virtual address later on.  Looking exclusively at the
offset field to know which memory addresses to dump sounds good.
For now we should have virtual==physical==offset except for the
backup region.

This sounds like a good place to start.

Eric
