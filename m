Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVBAO0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVBAO0C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 09:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVBAO0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 09:26:02 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:12704 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262025AbVBAOZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 09:25:45 -0500
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
	crashdumps.
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <m1r7k5e1ql.fsf@ebiederm.dsl.xmission.com>
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
Content-Type: text/plain
Organization: 
Message-Id: <1107271039.15652.839.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Feb 2005 20:47:19 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, trying to put the already discussed ideas together.  I was
planning to work on following design. Please comment.

Crashed Kernel <-->Capture Kernel(or User Space) Interface:
----------------------------------------------------------

The whole idea is that Crash image is represented in ELF Core format.
These ELF Headers are prepared by kexec-tools user space and put in one
segment. Address of start of image is passed to the capture kernel(or
user space) using one command line (eg. crashimage=). Now either kernel
space or user space can parse the elf headers and extract required
information and export final kernel elf core image.


> ebiederm@xmission.com wrote: 
> If we were using an ELF header I would include one PT_NOTE program 
> header per cpu (Giving each cpu it's own area to mess around in).
> And I would use one PT_LOAD segment per possible memory zone.
> So in the worst case (current sgi altix) (MAX_NUMNODES=256,
> MAX_NR_ZONES=3, MAX_NR_CPUS=1024) 256*3+1024 = 1792 program
> headers.   At 56 bytes per 64bit program header that is 100352 bytes
> or 98KiB.  A little bit expensive.  A tuned data structure with
> 64bit base and size would only consume 1792*16 = 28672 or 28KiB.

If I prepare One elf header for each physical contiguous memory area (as
obtained from /proc/iomem) instead of per zone, then number of elf
headers will come down significantly. I don't have any idea on number of
actual physically contiguous regions present per machine, but roughly
assuming it to be 1 per node, it will lead to 256 + 1024 = 1280 program
headers.At 56 bytes per 64 bit program header this will amount to 70KB. 

This is worst case estimate and on lower end machines this will require
much less a space. On machines as big as 1024 cpus, this should not be a
concern, as big machines come with big RAMs.

Eric, do you still think that ELF headers are inappropriate to be passed
across interface boundary.

ELF headers can be prepared by kexec-tools in advance and put into one
of the data segments. This requires following information to be
available to user space.

- Starting address of space reserved by kernel for notes section
(crash_notes[]). Probably can be obtained from /proc/kallsysms?

- NR_CPUS. May be sysconf(_SC_NPROCESSORS_CONF) should be sufficient.

- Size of memory reserved per cpu. No clue how to get that? Any
suggestions? 
	May be hard-coding like 1K area per cpu should be to address the
	future needs ?


Regarding Backup Region
-----------------------

- Kexec user space does the reservation for backup region segment.
- Purgatory copies the backup data to backup region. (Already
implemented)
- A separate elf header is prepared to represent backed up memory
region. And "offset" field of this program header can contain the actual
physical address where backup contents are stored. 


Thanks
Vivek



