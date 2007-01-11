Return-Path: <linux-kernel-owner+w=401wt.eu-S1030212AbXAKILS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbXAKILS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbXAKILS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:11:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:20671 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030212AbXAKILS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:11:18 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D8/D7WgOmNvsMxOvU40ZO1LRv4w47jXui7xGh6tEjjgO1/32Vb48pY24QQlHFUhPKpZuAZTdHU6uQ6bKgRm+VNsp854G8dqoAKJvw7bxZdT8OogNZ2m5iBnCc1PEC3mFvN1X+CiaiyreS/zY5cLx1/sw+5N0q3hkPraJQ9BHhiI=
Message-ID: <4df04b840701110011p153c6d14t8d5f0ca584af9516@mail.gmail.com>
Date: Thu, 11 Jan 2007 16:11:16 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: "Rik van Riel" <riel@redhat.com>
Subject: Re: [PATCH 2.6.16.29 1/1] MM: enhance Linux swap subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45A5DE7C.3030108@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840701101935i2083da21t26785bc6c00057a7@mail.gmail.com>
	 <45A5DE7C.3030108@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2007/1/11, Rik van Riel <riel@redhat.com>:
>
> Have you actually measured this?
>
> If your measurements saw any performance gains, with what kind
> of workload did they happen, how big were they and how do you
> explain those performance gains?
>
> How do you balance scanning the private memory with taking
> pages off the per-zone page lists?
>
> How do you deal with systems where some zones are really
> large and other zones are really small, eg. a 32 bit system
> with one 880MB zone and one 15.1GB zone?
>

You didn't mention another problem, a VMA maybe residents on multiple zones. To
multiple address space, multiple memory inode architecture, we can introduce
a new core object -- section which has several features
1) Section is used as the atomic unit to contain the pages of a VMA residing in
  the memory inode of the section.
2) When page migration occurs among different memory inodes, new secion should
  be set up to trace the pages.
3) Section can be scanned by the SwapDaemon of its memory inode directely.
4) All sections of a VMA are excluded with each other not overlayed.
5) VMA is made up of sections totally, but its section objects scatter on memory
  inodes.
So to the architecture, we can deploy swap subsystem on an
architecture-independent layer by section and scan pages batchly.

> If the benefits come mostly from better IO clustering, would
> it not be safer/less invasive to add swapout clustering of the
> same style that the BSD kernels have?
>

You mean add a new swap file/partition? I scan every UserSpaces by
init_mm::mmlist which has already been used by swap subsystem, and I've patched
in mm/swapfile.c.

> For your reference, the BSD kernels do swapout clustering like this:
> 1) select a page off the end of the pageout list
> 2) then scan the page table the page is in, to find
>     nearby pages that are also eligable for pageout
> 3) page them all out with one disk I/O operation
>
> The same could also be done for files.
>
> With peterz's dirty tracking (and possible dirty limiting)
> code in the kernel, this can be done without the kind of
> deadlocks that would have plagued earlier kernels, when
> trying to do IO trickery from the pageout path...
>

I've noticed FreeBSD maybe has a similar design as I mentioned, I'm reading
their code to whether they have another two features -- UnmappedPTE and dftlb in
my Documentation/vm_pps.txt.
