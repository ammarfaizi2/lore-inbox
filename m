Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVBCHK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVBCHK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 02:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVBCHK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 02:10:57 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:18668 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262569AbVBCHKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 02:10:11 -0500
Date: Thu, 03 Feb 2005 16:02:52 +0900 (JST)
Message-Id: <20050203.160252.104031714.taka@valinux.co.jp>
To: vgoyal@in.ibm.com
Cc: ebiederm@xmission.com, akpm@osdl.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com, hari@in.ibm.com,
       suparna@in.ibm.com
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
 crashdumps.
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <1106833527.15652.146.camel@2fwv946.in.ibm.com>
References: <1106475280.26219.125.camel@2fwv946.in.ibm.com>
	<m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
	<1106833527.15652.146.camel@2fwv946.in.ibm.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek and Eric,

IMHO, why don't we swap not only the contents of the top 640K
but also kernel working memory for kdump kernel?

I guess this approach has some good points.

 1.Preallocating reserved area is not mandatory at boot time.
   And the reserved area can be distributed in small pieces
   like original kexec does.

 2.Special linking is not required for kdump kernel.
   Each kdump kernel can be linked in the same way,
   where the original kernel exists.

Am I missing something?


 physical memory
   +-------+
   | 640K  ------------+
   |.......|           |
   |       |         copy
   +-------+           |
   |       |           |
   |original<-----+    |
   |kernel |      |    |
   |       |      |    |
   |.......|      |    |
   |       |      |    |
   |       |      |    |
   |       |     swap  |
   |       |      |    |
   +-------+      |    |
   |reserved<----------+
   |area   |      |
   |       |      |
   |kdump  |<-----+
   |kernel |
   +-------+
   |       |
   |       |
   |       |
   +-------+



> Hi Eric,
> 
> It looks like we are looking at things a little differently. I
> see a portion of the picture in your mind, but obviously not 
> entirely.
> 
> Perhaps, we need to step back and iron out in specific terms what 
> the interface between the two kernels should be in the crash dump
> case, and the distribution of responsibility between kernel, user space
> and the user. 
> 
> [BTW, the patch was intended as a step in development up for
> comment early enough to be able to get agreement on the interface
> and think issues through to more completeness before going 
> too far. Sorry, if that wasn't apparent.]
> 
> When you say "evil intermingling", I'm guessing you mean the
> "crashbackup=" boot parameter ? If so, then yes, I agree it'd
> be nice to find a way around it that doesn't push hardcoding
> elsewhere.
> 
> Let me explain the interface/approach I was looking at.
> 
> 1.First kernel reserves some area of memory for crash/capture kernel as
> specified by crashkernel=X@Y boot time parameter.
> 
> 2.First kernel marks the top 640K of this area as backup area. (If
> architecture needs it.) This is sort of a hardcoding and probably this
> space reservation can be managed from user space as well as mentioned by
> you in this mail below.
> 
> 3. Location of backup region is exported through /proc/iomem which can
> be read by user space utility to pass this information to purgatory code
> to determine where to copy the first 640K.
> 
> Note that we do not make any additional reservation for the 
> backup region. We carve this out from the top of the already 
> reserved region and export it through /proc/iomem so that 
> the user space code and the capture kernel code need not 
> make any assumptions about where this region is located.
> 
> 4. Once the capture kernel boots, it needs to know the location of
> backup region for two purposes.
>         
> a. It should not overwrite the backup region.
> 
> b. There needs to be a way for the capture tool to access the original
>    contents of the backed up region
> 
> Boot time parameter crashbackup=A@B has been provided to pass this
> information to capture kernel. This parameter is valid only for capture
> kernel and becomes effective only if CONFIG_CRASH_DUMP is enabled.
> 
> 
> > What is wrong with user space doing all of the extra space
> > reservation?
> 
> Just for clarity, are you suggesting kexec-tools creating an additional
> segment for the backup region and pass the information to kernel.
> 
> There is no problem in doing reservation from user space except
> one. How does the user and in-turn capture kernel come to know the
> location of backup region, assuming that the user is going to provide
> the exactmap for capture kernel to boot into.
> 
> Just a thought, is it  a good idea for kexec-tools to be creating and
> passing memmap parameters doing appropriate adjustment for backup
> region.
> 
> I had another question. How is the starting location of elf headers 
> communicated to capture tool? Is parameter segment a good idea? or 
> some hardcoding? 
> 
> Another approach can be that backup area information is encoded in elf
> headers and capture kernel is booted with modified memmap (User gets
> backup region information from /proc/iomem) and capture tool can
> extract backup area information from elf headers as stored by first
> kernel.
> 
> Could you please elaborate a little more on what aspect of your view
> differs from the above.
> 
> Thanks
> Vivek

Thaks,
Hirokazu Takahashi.

