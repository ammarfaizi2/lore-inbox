Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVA0Mzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVA0Mzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 07:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVA0Mzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 07:55:48 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:46778 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262604AbVA0Mxu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 07:53:50 -0500
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
	crashdumps.
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	 <1106294155.26219.26.camel@2fwv946.in.ibm.com>
	 <m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	 <1106305073.26219.46.camel@2fwv946.in.ibm.com>
	 <m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
	 <1106475280.26219.125.camel@2fwv946.in.ibm.com>
	 <m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: 
Message-Id: <1106833527.15652.146.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jan 2005 19:15:27 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

It looks like we are looking at things a little differently. I
see a portion of the picture in your mind, but obviously not 
entirely.

Perhaps, we need to step back and iron out in specific terms what 
the interface between the two kernels should be in the crash dump
case, and the distribution of responsibility between kernel, user space
and the user. 

[BTW, the patch was intended as a step in development up for
comment early enough to be able to get agreement on the interface
and think issues through to more completeness before going 
too far. Sorry, if that wasn't apparent.]

When you say "evil intermingling", I'm guessing you mean the
"crashbackup=" boot parameter ? If so, then yes, I agree it'd
be nice to find a way around it that doesn't push hardcoding
elsewhere.

Let me explain the interface/approach I was looking at.

1.First kernel reserves some area of memory for crash/capture kernel as
specified by crashkernel=X@Y boot time parameter.

2.First kernel marks the top 640K of this area as backup area. (If
architecture needs it.) This is sort of a hardcoding and probably this
space reservation can be managed from user space as well as mentioned by
you in this mail below.

3. Location of backup region is exported through /proc/iomem which can
be read by user space utility to pass this information to purgatory code
to determine where to copy the first 640K.

Note that we do not make any additional reservation for the 
backup region. We carve this out from the top of the already 
reserved region and export it through /proc/iomem so that 
the user space code and the capture kernel code need not 
make any assumptions about where this region is located.

4. Once the capture kernel boots, it needs to know the location of
backup region for two purposes.
        
a. It should not overwrite the backup region.

b. There needs to be a way for the capture tool to access the original
   contents of the backed up region

Boot time parameter crashbackup=A@B has been provided to pass this
information to capture kernel. This parameter is valid only for capture
kernel and becomes effective only if CONFIG_CRASH_DUMP is enabled.


> What is wrong with user space doing all of the extra space
> reservation?

Just for clarity, are you suggesting kexec-tools creating an additional
segment for the backup region and pass the information to kernel.

There is no problem in doing reservation from user space except
one. How does the user and in-turn capture kernel come to know the
location of backup region, assuming that the user is going to provide
the exactmap for capture kernel to boot into.

Just a thought, is it  a good idea for kexec-tools to be creating and
passing memmap parameters doing appropriate adjustment for backup
region.

I had another question. How is the starting location of elf headers 
communicated to capture tool? Is parameter segment a good idea? or 
some hardcoding? 

Another approach can be that backup area information is encoded in elf
headers and capture kernel is booted with modified memmap (User gets
backup region information from /proc/iomem) and capture tool can
extract backup area information from elf headers as stored by first
kernel.

Could you please elaborate a little more on what aspect of your view
differs from the above.

Thanks
Vivek

