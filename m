Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVC1QSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVC1QSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 11:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVC1QSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 11:18:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:23514 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261938AbVC1QSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 11:18:23 -0500
Subject: Re: [RFC] Obtaining memory information for kexec/kdump
From: Dave Hansen <haveblue@us.ibm.com>
To: "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Matthew E Tolentino <matthew.e.tolentino@intel.com>
In-Reply-To: <4247FFE6.5060500@in.ibm.com>
References: <424254E0.6060003@in.ibm.com>
	 <1111650644.9881.43.camel@localhost>  <4242941A.3050501@in.ibm.com>
	 <1111678371.9881.46.camel@localhost>  <4247FFE6.5060500@in.ibm.com>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 08:18:05 -0800
Message-Id: <1112026685.9691.128.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 18:30 +0530, Hariprasad Nellitheertha wrote:
> Dave Hansen wrote:
> > On Thu, 2005-03-24 at 15:49 +0530, Hariprasad Nellitheertha wrote:
> > The code reuse is nice, but the expanded use of /proc is not.  
> > 
> >>Also, we were wondering if it is appropriate to 
> >>put in multiple values in a single file in sysfs.
> > 
> > Why would you need to do that?
> 
> Because we are putting the starting address, end address and 
> the memory type against each entry (just like in 
> /proc/iomem). Of course, we can figure out the ending 
> address knowing the starting address and the section size.

That sounds like what you *want* and not what you need :)

> > http://www.sr71.net/patches/2.6.12/2.6.12-rc1-mhp1/broken-out/L0-sysfs-memory-class.patch
> 
> In addition to this, I also needed to pull-in the 
> J-zone_resize_sem.patch to get it to compile.
> 
> Would it be possible to make this a separate patch-set so 
> that it does not depend on memory hotplug.

Yes, it's quite possible.  However, I've already done this for the
page-migration patches, and I'm not looking forward to doing it again.
If it was as simple as you describe, is there a real reason to break it
out? 

> I tested this on my PIII 256M machine. 
> /sys/devices/system/memory showed 4 memory sections each of 
> size 64MB. There are a couple of issues that we noticed. We 
> will not be able to spot those physical memory areas which 
> the OS does not use (such as the region between 640k and 
> 1MB). Also, when I booted the system with the mem=100M 
> option, two entries (memory0 and memory1) turned up. With 
> block_size_bytes being 64M, this turns out equivalent to a 
> system with 128M memory.

This turns out to be a minor issue for memory hotplug systems as well,
because it means that you can't add back that last 28MB of memory,
either.  

> If block_size_bytes was per-directory, it would be easier in 
> such situations.

First of all, I think there are lots of solutions to the problem, not
just changing the scope of "block_size_bytes".  We could also present a
value inside of each file that represents which pages in that memory
section area actually online and real RAM.  That could be generated from
(slowly) from hardware information like the e820 table.  It could be
very slow because the only users would be swsusp and kexec, which aren't
performance-critical.

Also, having variably-sized sysfs objects presents some serious
obstacles for hotplug memory.  A memory remove could involve splitting
existing memory areas, and lots of small additions could involve merging
memory ares, just like VMAs.  

We haven't implemented either of these things yet, because it hasn't
been necessary, and we don't want to bloat the code.  However, if
there's another user, it's a reason to go do it now.  Also, it may be a
good idea to move block_size_bytes into the memoryXX directory now, just
in case we need to change it later.

-- Dave

