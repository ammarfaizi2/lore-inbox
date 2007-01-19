Return-Path: <linux-kernel-owner+w=401wt.eu-S932472AbXASRCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbXASRCW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbXASRCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:02:22 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:5842 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472AbXASRCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:02:21 -0500
X-AuditID: d80ac287-9e09dbb0000026f2-ca-45b0fb3e5133 
Date: Fri, 19 Jan 2007 17:02:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Franck Bui-Huu <fbuihuu@gmail.com>
cc: Nadia Derbey <Nadia.Derbey@bull.net>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: unable to mmap /dev/kmem
In-Reply-To: <61ec3ea90701190331y459ad373n21a610157df03282@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701191634070.6398@blonde.wat.veritas.com>
References: <45AFA490.5000508@bull.net>  <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
 <61ec3ea90701190331y459ad373n21a610157df03282@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Jan 2007 17:02:20.0538 (UTC) FILETIME=[94EECDA0:01C73BEB]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Franck Bui-Huu wrote:
> Hugh Dickins wrote:
> >
> > Please revert the offending patch below, and then maybe Franck
> > can come up with a patch which preserves the original behaviour
> > on architectures which used to work (e.g. i386), while fixing
> > it for those architectures (which are they?) that did not.
> >
> 
> I've been confused by 'vma->vm_pgoff' meaning. I assumed that it was
> an offset relatif to the start of the kernel address space
> (PAGE_OFFSET) as the commit message I submitted explains. So doing:
> 
> 	fd = open("/dev/kmem", O_RDONLY);
> 	kmem = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 4 * 4096);
> 
> actually asks for a kernel space mapping which start 4 pages after the
> begining of the kernel memory space.

I agree that the name "kmem" lends itself to that interpretation
(and the 2.4 through 2.6.11 history shows that's not a wild idea);
but read and write of /dev/kmem have always used the kernel virtual
address as offset, so mmap of /dev/kmem should be doing the same.

> 
> So yes, if the 'offset' expected by 'mmap(/dev/kmem, ..., offset)'
> usage is actually a kernel virtual address the patch I submitted is
> wrong. The offending line should have been something like:
> 
> 	pfn = PFN_DOWN(virt_to_phys((void *)(vma->vm_pgoff << PAGE_SHIFT)));
> 
> and in this case 'vma->vm_pgoff' has no sense to me. My apologizes for
> this mess.

Apology surely accepted, it's a confusing area (inevitably: in a driver
for mem, the distinction between addresses and offsets become blurred).

But please note, the worst of it was, that your patch comment gave no
hint that you were knowingly changing its behaviour on the "main"
architectures: it reads as if you were simply fixing it up on a
few less popular architectures where an anomaly had been missed.

> > I guess it's reassuring to know that not many are actually
> > using mmap of /dev/kmem, so you're the first to notice: thanks.
> 
> yes it doesn't seems to be used. In my case, I was just playing with
> it when I submitted the patch but have no real usages.

Have I got it right, that actually the problem you thought you were
fixing does not even exist?  __pa was already doing the right thing on
all architectures, wasn't it?  So we can simply ask Linus to revert your
patch?  I don't think your PFN_DOWN or virt_to_phys were improvements:
though mem.c happens to live in drivers/char/, imagine it under mm/.

Hugh
